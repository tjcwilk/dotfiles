#!/usr/bin/env bash
# =============================================================================
# Toby's Ubuntu Setup Script
# =============================================================================
# This script sets up a brand new Ubuntu system with all required tools,
# configurations, themes, and shortcuts as specified.
# =============================================================================

echo "========== Running base setup =========="

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# mark a point in the bashrc file, after which all customerizations will be added.
echo "# My custom bashrc settings" >> ~/.bashrc

set -e

echo "========== Updating and upgrading system =========="
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y 

# -----------------------------------------------------------------------------
# Install essential tools
# -----------------------------------------------------------------------------
echo "========== Installing essential packages =========="
sudo apt install -y \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    git \
    unzip \
    zip \
    build-essential \
    neovim \
    tmux \
    nmap \
    cifs-utils \
    python3 \
    python3-pip \
    nodejs \
    npm \
    golang-go \
    btop \
    fastfetch \
    syncthing \
    tree \
    multitail \
    unzip \
    zip \
    jq \
    ncdu \
    duf \
    fzf \
    zoxide \
    progress \
    unp \ 
    lsd


# -----------------------------------------------------------------------------
# Install Docker
# -----------------------------------------------------------------------------
echo "========== Installing Docker =========="
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker --now
sudo usermod -aG docker "$USER"


# -----------------------------------------------------------------------------
# Install lazygit & lazydocker
# -----------------------------------------------------------------------------
echo "========== Installing lazygit and lazydocker =========="
LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep tag_name | cut -d '"' -f 4)
LAZYDOCKER_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep tag_name | cut -d '"' -f 4)

# LazyGit
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_$(uname -s)_$(uname -m).tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit && rm lazygit.tar.gz

# LazyDocker
curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/download/${LAZYDOCKER_VERSION}/lazydocker_$(uname -s)_$(uname -m).tar.gz"
sudo tar xf lazydocker.tar.gz -C /usr/local/bin lazydocker && rm lazydocker.tar.gz


# -----------------------------------------------------------------------------
# Fonts and Themes
# -----------------------------------------------------------------------------

echo "========== Installing NerdFonts =========="
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip -o CascadiaMono.zip && rm CascadiaMono.zip


# -----------------------------------------------------------------------------
# Install Starship prompt
# -----------------------------------------------------------------------------
echo "========== Installing Starship =========="
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo 'eval "$(starship init bash)"' >> ~/.bashrc
echo "export STARSHIP_CONFIG='$DIR/starship/starship.toml'" >> ~/.bashrc


# -----------------------------------------------------------------------------
# Set up symlinks
# -----------------------------------------------------------------------------
echo "========== Symlink inputrc =========="
ln -sf $DIR/inputrc ~/.inputrc

echo "========== Symlink tmux conf =========="
echo "-> .tmux.conf"
ln -sf $DIR/.tmux.conf ~/.tmux.conf


# -----------------------------------------------------------------------------
# Finished
# -----------------------------------------------------------------------------
echo "✅ Setup complete!"





