#!/bin/bash

mkdir ~/.data 2> /dev/null
mkdir ~/.data/chrome
echo '# chrome : script from "https://github.com/QuintenVervynck/bash" repository' >> ~/.bashrc
echo 'alias chrome="bash '$(pwd)'/chrome.bash"' >> ~/.bashrc

echo "do you want to delete this setup file for the todo script? [y/n]"
read answer
if  [[ $answer == "y" ]]; then
        rm setup.bash
        echo "removed"
else
        echo "not removed"
fi

exit 0
