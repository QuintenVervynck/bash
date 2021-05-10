#!/bin/bash

case $1 in
	-h | --help)
		echo "usage : weather [options] [arguments]"
		echo "options	long		argument	description"
		echo "-h	--help				shows help page"
		echo "-l	--location	location	specify location for weather"
		;;
	-l| --location)
		if [[ $# -eq 2 ]]; then
			curl https://wttr.in/$2
		else
			echo "the -l (--location) flag requires a 2nd argument with the location name"
			exit 1
		fi
		;;
	*)
		curl https://wttr.in
		;;
esac

exit 0
