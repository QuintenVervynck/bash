#!/bin/bash

mkdir ~/.data 2> /dev/null
mkdir ~/.data/backup
echo '# backup : script from "https://github.com/QuintenVervynck/bash" repository' >> ~/.bashrc
echo 'alias backup="bash '$(pwd)'/backup.bash"' >> ~/.bashrc

echo "do you want to delete this setup file for the backup script? [y/n]"
read answer
if  [[ $answer == "y" ]]; then
        rm setup.bash
        echo "removed"
else
        echo "not removed"
fi

exit 0
