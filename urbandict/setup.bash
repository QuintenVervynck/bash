#!/bin/bash

echo '# urbandict : script from "https://github.com/QuintenVervynck/bash" repository' >> ~/.bashrc
echo 'alias urbandict="bash '$(pwd)'/urbandict.bash"' >> ~/.bashrc

echo "do you want to delete this setup file for the urbandict script? [y/n]"
read answer
if  [[ $answer == "y" ]]; then
        rm setup.bash
        echo "removed"
else
        echo "not removed"
fi

exit 0
