#!/bin/bash

dest=$HOME/Documents/backup

read -p "Directory name (Only one): " dir_name

if [ ! -d $dir_name ]; then
    echo "Error: $dir_name does not exist"
    exit 1
else
    source=$dir_name
fi

#will create backup dir if it does not exist
if [ ! -d $HOME/Documents/backup  ]; then
    echo "Creating backup directory in $HOME/Documents"
    sleep 1
    mkdir $HOME/Documents/backup/
fi

#copying files from source to backup always
for file in $(find $source -printf "%P\n"); do
    if [ -a $dest/$file ]; then
        if [ $source/$file -nt $dest/$file ]; then
            echo "Newer file. Copying..."
            sleep 1
            cp -r $source/$file $dest/$file
        else
            echo "File: $file exists"
            sleep 1
        fi
    else
        echo "$file is being copied to $dest"
        cp -r $source/$file $dest/$file
        sleep 1
    fi
done

echo "Updated!"
