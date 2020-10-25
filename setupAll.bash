#!/bin/bash

for dir in $(find . -maxdepth 1 -type d ! -name "." ! -name ".git" ! -name "installers");do
	cd $dir
	echo $(pwd)
	bash setup.bash
	cd ..
done
