#!/bin/bash

case $1 in
	-h | --help)
		echo "usage : weather [options] [arguments]"
		echo "options	long		argument(s)	description"
		echo "-o	--open		keyword		opens the url for the given keyword"
		echo "-a	--add		keyword url	add a new keyword that refers to that url"
		echo "-r	--remove	keyword		removes the keyword+url"
		;;
	-o| --open)
		if [[ $# -eq 2 ]]; then
			google-chrome -o $(cat ~/.data/chrome/$2)
		else
			echo "the -o (--open) flag requires 1 argument, the keyword"
		fi
		;;
	-a| --add)
		if [[ $# -eq 3 ]]; then
			echo $3 > ~/.data/chrome/$2
		else
			echo "the -a (--add) flag requires 2 arguments, the keyword and the corresponding url"
			exit 1
		fi
		;;
	-r| --remove)
		if [[ $# -eq 2 ]]; then
			rm ~/.data/chrome/$2
		else
			echo "the -r (--remove) flag requires 1 argument, the keyword"
		fi
		;;
	*)
		google-chrome
		;;
esac

exit 0
