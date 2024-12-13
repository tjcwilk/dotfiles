#!/bin/sh

# lsl short for ls -al
echo "alias lsl='ls -l'" >> ~/.bashrc
echo "alias pip=pip3" >> ~/.bashrc
echo "alias xclip='xclip -selection c'" >> ~/.bashrc
echo "eval '$(starship init bash)'" >> ~/.bashrc

