#!/bin/bash
if [[ $# -eq 0 ]]; then
	google-chrome
	exit 0
fi

case $1 in
	-h | --help)
		echo "usage : chrome [options] [arguments]"
		echo "options	long		argument(s)	description"
		echo "			keyword		opens the url for the given keyword"
		echo "-a	--add		keyword url	add a new keyword that refers to that url"
		echo "-r	--remove	keyword		removes the keyword+url"
		;;
	-a| --add)
		if [[ $# -eq 3 ]]; then
			echo $3 > ~/.data/chrome/$2
		else
			echo "the -a (--add) flag requires 2 additional arguments, the keyword and the corresponding url"
			exit 1
		fi
		;;
	-r| --remove)
		if [[ $# -eq 2 ]]; then
			rm ~/.data/chrome/$2
		else
			echo "the -r (--remove) flag requires an additional argument, the keyword"
		fi
		;;
	*)
		google-chrome -o $(cat ~/.data/chrome/$1)
		;;
esac

exit 0
