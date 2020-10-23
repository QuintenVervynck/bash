#!/bin/bash
sudo apt install python3
sudo apt install python3-pip
sudo pip3 install clirail
echo '# trein : script from "scripts_linux" repository, but its just an alias for a python-module called clirail' >> ~/.bashrc
echo 'alias trein="clirail"' >> ~/.bashrc

echo "do you want to delete this setup file for the todo script? [y/n]"
read answer
if  [[ $answer == "y" ]]; then
        rm test.bash
        echo "removed"
else
        echo "not removed"
fi

exit 0
