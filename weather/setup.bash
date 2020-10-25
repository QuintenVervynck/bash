#!/bin/bash

echo '# weather : script from "scripts_linux" repository' >> ~/.bashrc
echo 'alias weather="bash '$(pwd)'/weather.bash"' >> ~/.bashrc

echo "do you want to delete this setup file for the weather script? [y/n]"
read answer
if  [[ $answer == "y" ]]; then
        rm setup.bash
        echo "removed"
else
        echo "not removed"
fi

exit 0
