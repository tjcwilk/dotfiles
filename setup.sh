#!/bin/bash

# This setup script bootstraps a new ubuntu machine, with all
# the nice features, tools and software that I like.


###############################################################################
# Helper Functions
###############################################################################

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

symlinkDotFiles(){
    echo "Creating symbolic links"
    DIR="$(cd "$(dirname "$0")" && pwd)"

    echo "-> .vimrc"
    ln -sf $DIR/.vimrc ~/.vimrc

    echo "-> .tmux.conf"
    ln -sf $DIR/.tmux.conf ~/.tmux.conf

    echo "-> cheatsheet.md"
    ln -sf $DIR/cheatsheet.md ~/cheatsheet.md

    echo "-> tmux new shortcut"
    ln -sf $DIR/tmux-new.sh ~/tmux-new.sh

    echo "-> tmux attach shortcut"
    ln -sf $DIR/tmux-attach.sh ~/tmux-attach.sh
}


###############################################################################
# Install Functions
###############################################################################


installGit(){
    if command_exists git; then
      echo "git already installed"
      return
    fi

    echo "installing and configuring git"
    sudo apt install -y git
    git config --global user.name "Toby W"
    git config --global user.email "toby@null"
    git config --global core.editor "vim"
}


installStarship() {
    if command_exists starship; then
        echo "Starship already installed"
        return
    fi

    if ! curl -sS https://starship.rs/install.sh | sh; then
        echo "${RED}Something went wrong during starship install!${RC}"
        exit 1
    fi
}


installVimPlug(){
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}


##########################################################
# Run
##########################################################

# Update the machine
echo "Updating machine"
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y

# Install core tools
echo "Installing core tools"
sudo apt install -y vim \
    tree \
    tmux \
    neofetch \
    curl \
    multitail \
    unzip \
    htop \
    python3-pip\
    ncdu \
    duf \
    fzf \
    zoxide

# create dotfile symlinks
symlinkDotFiles

# Install functions
installGit
installStarship
installVimPlug

# Source files
echo "Sourcing files"
tmux source ~/.tmux.conf
source ~/.bashrc

echo "!! DONE !!"
echo "NEXT - consider running the bashrc update script"



# Now go into a tmux session, eg with 'tmux new -s main'
