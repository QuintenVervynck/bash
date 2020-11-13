#!/bin/bash

echo 'installing the folowing packages: fortune cowsay lolcat figlet'
sudo apt install fortune cowsay lolcat figlet
echo '# terminal greeting : script from "https://github.com/QuintenVervynck/scripts" repository' >> ~/.bashrc
echo 'bash /home/quinten/scripts/startup/startup.bash' >> ~/.bashrc

echo "do you want to delete this setup file for the terminal greeting script? [y/n]"
read answer
if  [[ $answer == "y" ]]; then
        rm setup.bash
        echo "removed"
else
        echo "not removed"
fi

exit 0
