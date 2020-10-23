#!/bin/bash

dir=~/.data/todo

red=$'\e[1;31m'
yel=$'\e[1;93m'
grn=$'\e[1;92m'
blu=$'\e[1;34m'
end=$'\e[0m'

e="undefined"
d="undefined"
n="undefined"


########## get options ##########


while getopts ":he:d:n:" opt; do
	case $opt in
		h  )	# help
			echo "todo [-edn [ arg ] ]"
			echo " todo -e [regex] : edit todo-lists matching regex, edits all matched"
			echo " todo -d [regex] : delete todo-lists matching regex, asks confirmation before delete"
			echo " todo -n [name] : new todo-list with given name"
			echo "" 
			;;
		e  ) 	# optie -e (edit)
			e=$OPTARG
         		;;
    		d  ) 	# optie -d (done/completed/delete)
         		d=$OPTARG
        		;;
		n  ) 	# optie -n (new)
         		n=$OPTARG
        		;;
		: )	# optie zonder arg gegeven
			echo "Option requires argument" 1>&2
			exit 1
			;;
    		\? ) 	# invalid option
			echo "Unknown option '-$OPTARG'" 1>&2
         		exit 1
			;;
  		esac
	done
	shift $((OPTIND - 1))


########## printing functions ##########


printfile() {
	filename=$(echo $1 | egrep -o '[^/]+$')
	echo -e ${red}${filename}${end}
	while read line; do
		echo "  >  "${line}
	done < $1
}

printer() {
	for file in $(ls -rt $dir); do
		# print the file
		printfile $dir/$file
	done
}


########## options ##########

# edit
if [[ $e != "undefined" ]]; then
	file=$(find $dir -iname "*${e}*" )
	if [[ $file == "" ]];	then
		echo "Unknown todo-list" 1>&2
         	exit 1
	fi
	nano $file
	printfile $file
	exit 0
fi

# delete
if [[ $d != "undefined" ]]; then
	for file in $(find $dir -iname "*${d}*"); do
		filename=$(echo $file | egrep -o '[^/]+$')
		read -p "Delete todo-list '${filename}'? y/n:  " check
		if [[ $check == "y" ]]; then
			echo "Todo-list "${filename}" is deleted"
			rm $file
		else
			echo "Todo-list "${filename}" was not deleted"
		fi
	done
	printer
	exit 0
fi

# new
if [[ $n != "undefined" ]]; then
	nano $dir/$n
	printfile $dir/$n
	exit 0 
fi


########## printing all todo-lists ##########


if [[ $# -eq 0 ]]; then
	printer
	exit 0
fi


########## printing selected todo-lists ##########


if [[ $# > 1 ]]; then
	echo "I can only search todo-lists by one keyword" 1>&2
	exit 1
elif [[ $# -eq 1 ]]; then
	for file in $(find $dir -iname "*${1}*"); do
		printfile $file
	done
	exit 0
fi

