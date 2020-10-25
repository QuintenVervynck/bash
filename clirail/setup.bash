#!/bin/bash
sudo apt install python3
sudo apt install python3-pip
sudo pip3 install clirail
echo '# trein : script from "https://github.com/QuintenVervynck/bash" repository, but its just an alias for a python-module called clirail' >> ~/.bashrc
echo 'alias trein="clirail"' >> ~/.bashrc

echo "do you want to delete this setup file for the clirail script? [y/n]"
read answer
if  [[ $answer == "y" ]]; then
        rm setup.bash
        echo "removed"
else
        echo "not removed"
fi

exit 0
