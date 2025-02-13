#!/bin/bash

# Bootstrap a vanilla ubuntu machine

# Update the machine
echo "Updating machine"
sudo apt-get update -y
sudo apt-get upgrade -y

# Install core tools
echo "Installing tools"
sudo apt-get install -y vim git tree tmux

# configure git 
echo "Configuring git"
git config --global user.name "Toby W"
git config --global user.email "toby@null"
git config --global core.editor "vim"

echo "Sourcing files"
tmux source ~/.tmux.conf
source ~/.bashrc

echo "!! DONE !!"
# Now go into a tmux session, eg with 'tmux new -s main'
