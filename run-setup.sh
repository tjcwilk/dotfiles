#!/usr/bin/env bash
# =============================================================================
# Toby's Ubuntu 25.04 Setup Script
# =============================================================================
# This script sets up a brand new Ubuntu 25.04 system with all required tools,
# configurations, themes, and shortcuts as specified.
# =============================================================================

set -e

echo "========== Updating and upgrading system =========="
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y software-properties-common apt-transport-https ca-certificates curl wget git unzip zip build-essential


# -----------------------------------------------------------------------------
# Install essential tools
# -----------------------------------------------------------------------------
echo "========== Installing essential packages =========="
sudo apt install -y \
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
  software-properties-common \
  apt-transport-https \
  ca-certificates \
  curl \
  wget \
  git \
  build-essential\



# -----------------------------------------------------------------------------
# Install obsidian
# -----------------------------------------------------------------------------
echo "========== Installing Obsidian =========="
sudo snap install obsidian --classic


# -----------------------------------------------------------------------------
# Install VSCode
# -----------------------------------------------------------------------------
echo "========== Installing VSCode  =========="

# Check if VSCode is installed
if ! command -v code &> /dev/null
then
    echo "VSCode is not installed. Installing now..."

    # Update package list and install required dependencies
    sudo apt install -y software-properties-common apt-transport-https wget

    # Import Microsoft GPG key
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
    rm microsoft.gpg

    # Add VSCode repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

    # Update package list and install VSCode
    sudo apt update
    sudo apt install -y code

    echo "VSCode installation complete."
else
    echo "VSCode is already installed."
fi

# -----------------------------------------------------------------------------
# Install Tailscale
# -----------------------------------------------------------------------------
echo "========== Installing Tailscale =========="

# Check if tailscale is installed
if ! command -v tailscale &> /dev/null
then
    echo "Tailscale is not installed. Installing now..."

    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

    sudo apt-get update -y
    sudo apt-get install -y tailscale

    # sudo tailscale up

    echo "Tailscale installation complete."
else
    echo "Tailscale is already installed."
fi


# -----------------------------------------------------------------------------
# Install Brave Browser
# -----------------------------------------------------------------------------
echo "========== Installing Brave Browser =========="

if ! command -v brave-browser &> /dev/null
then
    echo "brave-browser is not installed. Installing now..."

    # Add Brave browser signing key
    curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg | sudo tee /usr/share/keyrings/brave-browser-archive-keyring.gpg > /dev/null

    # Add Brave repo to sources.list.d
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    # Update package list and install Brave
    sudo apt update
    sudo apt install -y brave-browser

    echo "Brave Browser installation complete."
else
    echo "Brave Browser is already installed."
fi


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
# Install Starship prompt
# -----------------------------------------------------------------------------
echo "========== Installing Starship =========="
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo 'eval "$(starship init bash)"' >> ~/.bashrc


# -----------------------------------------------------------------------------
# Mount network drives
# -----------------------------------------------------------------------------
echo "========== Configuring CIFS network drives =========="

if ! grep -q "apollo" /etc/hosts; then
  echo "192.168.86.56 apollo" | sudo tee -a /etc/hosts
fi

# Create credentials file if missing
if [ ! -f ~/.apollo-credentials ]; then
  cat << 'EOF' > ~/.apollo-credentials
username=your-username
password=your-password
EOF
  chmod 600 ~/.apollo-credentials
fi

# Create mount directories
sudo mkdir -p /mnt/apollo-media /mnt/apollo-toby

# Add fstab entries if missing
if ! grep -q "apollo-media" /etc/fstab; then
  echo "//apollo/media /mnt/apollo-media cifs credentials=/home/$USER/.apollo-credentials,iocharset=utf8,uid=$USER,gid=$USER,file_mode=0770,dir_mode=0770 0 0" | sudo tee -a /etc/fstab
fi

if ! grep -q "apollo-toby" /etc/fstab; then
  echo "//apollo/Toby /mnt/apollo-toby cifs credentials=/home/$USER/.apollo-credentials,iocharset=utf8,uid=$USER,gid=$USER,file_mode=0770,dir_mode=0770 0 0" | sudo tee -a /etc/fstab
fi

systemctl daemon-reload

sudo mount -a

ln -sf /mnt/apollo-media ~/apollo-media
ln -sf /mnt/apollo-toby ~/apollo-toby

# -----------------------------------------------------------------------------
# Fonts and Themes
# -----------------------------------------------------------------------------
echo "========== Installing NerdFonts =========="
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip -o CascadiaMono.zip && rm CascadiaMono.zip
fc-cache -fv

# -----------------------------------------------------------------------------
# Finished
# -----------------------------------------------------------------------------
echo "✅ Setup complete! Please log out and back in for all changes to take effect."
echo "Docker group and GNOME shortcuts will work after re-login."

