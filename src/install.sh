#!/bin/bash

# Installation script for clouduploader.sh

# Check if $HOME/bin exists in the PATH
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo "Your PATH does not include \$HOME/bin, adding it now..."
    echo "export PATH=\$HOME/bin:\$PATH" >> $HOME/.bashrc
    source $HOME/.bashrc
    mkdir -p $HOME/bin
fi

# Copy the clouduploader.sh to $HOME/bin and make it executable
cp clouduploader.sh $HOME/bin/clouduploader
chmod +x $HOME/bin/clouduploader

echo "Installation completed. You can use clouduploader from anywhere in your terminal."
