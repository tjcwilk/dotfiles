#!/bin/sh

# Creates symbolic Links in your home folder, for the dotfiles in this repo

echo "Creating symbolic links"
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "-> .tmux.conf"
ln -sf $DIR/.tmux.conf ~/.tmux.conf

echo "-> home folder shortcuts"
ln -sf $DIR/cheatsheet.md ~/cheatsheet.md

echo "-> tmux new shortcut"
ln -sf $DIR/tmux-new.sh ~/tmux-new.sh

echo "-> tmux attach shortcut"
ln -sf $DIR/tmux-attach.sh ~/tmux-attach.sh
