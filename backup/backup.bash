#!/bin/bash


#################################################
# VARS

# locations
DIRS="
/home/quinten/.bashrc
/home/quinten/Desktop
/home/quinten/Documents
/home/quinten/Music/
/home/quinten/Public/
/home/quinten/scripts
/home/quinten/Templates
/home/quinten/Videos
/home/quinten/projects
/home/quinten/bash
/home/quinten/.data
"

BACKUP_LOCATION="/media/quinten/Samsung_T5/UBUNTU_BACKUP"

# colors
RED=$'\e[31m'
YEL=$'\e[93m'
GRN=$'\e[92m'
BLU=$'\e[34m'
CYA=$'\e[96m'
END=$'\e[0m'

# all files currently in the filesystem
CURR_DIRS=$(find $DIRS -not -path "*/.git/*" -not -path "*/.idea/*" -printf '%p;')

# indicates whether the backupsystem is connected, will be checked if needed
IS_CONNECTED="no"

# some counters
COUNT_MODIFIED=0
COUNT_NEW=0
#################################################
# FUNCTIONS


########################
# CHECK IF BACKUPLOCATION IS CONNECTED / EXISTS
check_backup_location () {
	if [[ -d $BACKUP_LOCATION ]]; then
	        IS_CONNECTED="yes"
	else
	        echo $CYA"BACKUP LOCATION DOES NOT EXIST OR IS NOT CONNECTED ("$BACKUP_LOCATION")"$END >&2
		exit 1
	fi
}


########################
# CREATE BACKUP LIST
create_backup_list () {
        find ${BACKUP_LOCATION}/home/quinten/ -exec stat --printf %Y {} \; -exec echo "#"{} \; > /home/quinten/scripts/backups/data.txt
        sed -i 's/\/media\/quinten\/Samsung_T5\/UBUNTU_BACKUP//g' /home/quinten/scripts/backups/data.txt
        cp /home/quinten/scripts/backups/data.txt $BACKUP_LOCATION/home/quinten/scripts/backups/data.txt
}


########################
# COMPARE CURRENT FILES WITH BACKUP LIST
comparator () {

        # the ifs fixes a newline problem
        OLD_IFS=$IFS
        export IFS=
        BACK=$(cat ~/.data/backup/data.txt)
        IFS=$OLD_IFS

        OLD_IFS=$IFS
        export IFS=";"
        for file in $CURR_DIRS; do
                # fix for empty dirs
                if echo $file | grep --quiet "/$" ; then
                        file=$(echo $file | sed 's/\/$//g')
                fi

                # corresponding file in backup
                bfile="${BACKUP_LOCATION}${file}"

                # not a dir
                if [[ ! -d $file ]];then

                        # time last modified
                        mtime=$(stat -c %Y "$(echo $file)")

                        # already in backup
                        if echo "$BACK" | grep --quiet "$file" ; then

                                # time last modified of the file int the backup
                                bmtime=$(echo "$BACK" | grep "$file$" | sed -E "s/^([0-9]+)#.*$/\1/")
                                bmtime=$(echo $bmtime  | sed -E 's/^([^ ]+) .*$/\1/')

                                # backup was later then last modification
                                if [[ $mtime -gt $bmtime ]]; then
                                        # check if it is not the data file for the backup script
                                        if [[ $file != "/home/quinten/scripts/backups/data.txt" ]]; then
                                                # backup needed
		                                # count
						COUNT_MODIFIED=$((COUNT_MODIFIED + 1))
                		                # print in terminal for user
						echo $YEL"modified:  "$file $END
                                        fi
                                fi

                        # not yet in backup, is new
                        else
                                # count
				COUNT_NEW=$((COUNT_NEW + 1))
                                # print in terminal for user
                                echo $RED"new:       "$file $END
                        fi

                # a dir, check if dir exists
                elif ! echo "$BACK" | grep --quiet "$file" ; then
                        echo $RED"new dir:   "$file $END
                fi

        done
        export IFS=$OLD_IFS
}


########################
# DO BACKUP
do_backup () {

        IN_BACKUP=$(find $BACKUP_LOCATION -printf '%p;')

        OLD_IFS=$IFS
        export IFS=";"
        # for each file in the system, in the dirs in BACKUP_DIRS
        for file in $CURR_DIRS; do

                # corresponding file in backup
                bfile="${BACKUP_LOCATION}${file}"

                # not a dir
                if [[ ! -d $file ]];then

                        # already in backup
                        if echo "$IN_BACKUP" | grep --quiet "$file" ; then
                                 # time last modified
                                mtime=$(stat -c %Y "$(echo $file)")
                                # time last modified of file in backup
                                bmtime=$(stat -c %Y "$(echo $bfile)")

                                # backup was later then last modification
                                if [[ $mtime -gt $bmtime ]]; then
                                        # new backup needed
                                        rm $bfile
                                        cp $file $bfile
                                        # count
					COUNT_MODIFIED=$((COUNT_MODIFIED + 1))
                                        # print in terminal for user
                                        echo $GRN"modified:  "$file $END
                                fi
                        # not yet in backup, is new
                        else
                                # backup needed
                                cp $file $bfile
                                # count
				COUNT_NEW=$((COUNT_NEW + 1))
                                # print in terminal for user
                                echo "new:       "$file
                        fi

                # a dir, check if dir exists
                elif [[ ! -d $bfile ]];then
                        mkdir $bfile
                        # print in terminal for user
                        echo $GRN"new dir:   "$file $END
                fi
        done
        export IFS=$OLD_IFS
}




#################################################
# MAIN

while getopts ":hl" opt; do
	case $opt in
		h  )	# help
			echo "backup [options] ]"
			echo "options:"
			echo " -h  : show this help page"
			echo " -l  : list the files that need a backup, doesn't need the backupdir to be present"
			echo ""
			exit 0
			;;
		l  ) 	# optie -l (list)
			echo $CYA"LISTING FILES THAT REQUIRE A BACKUP"$END
			comparator
			echo $CYA"NEW FILES: "$COUNT_NEW", MODIFIED FILES: "$COUNT_MODIFIED
			exit 0
         		;;
    		\? ) 	# invalid option
			echo $RED"Unknown option '-$OPTARG'"$END 1>&2
         		exit 1
			;;
  	esac
done
shift $((OPTIND - 1))

# we do a backup

# check if the backuplocation is present
check_backup_location
# do the backup
do_backup
# save the data of the files in the backup, so we can call the -l option even when the backuplocation is not present
create_backup_list
# some feedback
echo $CYA"NEW FILES: "$COUNT_NEW", MODIFIED FILES: "$COUNT_MODIFIED

exit 0
