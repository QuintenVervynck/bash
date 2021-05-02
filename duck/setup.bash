#!/bin/bash

mkdir ~/.data 2> /dev/null
mkdir ~/.data/duck
echo '# duck script from "https://github.com/QuintenVervynck/scripts" repository' >> ~/.bashrc
echo 'alias duck="bash '$(pwd)'/duck.bash"' >> ~/.bashrc

echo "do you want to delete this setup file for the todo script? [y/n]"
read answer
if  [[ $answer == "y" ]]; then
        rm setup.bash
        echo "removed"
else
        echo "not removed"
fi

exit 0
