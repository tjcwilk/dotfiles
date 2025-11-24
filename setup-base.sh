#!/usr/bin/env bash
# =============================================================================
# Setup Base
# =============================================================================
# This is the first, base instillation script that you should run.
# These are my core basic ubuntu configurations, that should work on
# either a work or personal computer. They should also work on 
# ubuntu server.
# =============================================================================

echo "========== Running base setup =========="

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# mark a point in the bashrc file, after which all customerizations will be added.
if ! grep -q "# My custom bashrc settings" ~/.bashrc; then
    echo "# My custom bashrc settings" >> ~/.bashrc
fi

set -e

echo "========== Updating and upgrading system =========="
sudo apt update && sudo apt full-upgrade -y


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
fc-cache -fv


# -----------------------------------------------------------------------------
# Install Starship prompt
# -----------------------------------------------------------------------------
echo "========== Installing Starship =========="
curl -sS https://starship.rs/install.sh | sh -s -- -y
if ! grep -q "starship init bash" ~/.bashrc; then
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi
# Symlink starship config
mkdir -p ~/.config
ln -sf "$DIR/starship/starship.toml" ~/.config/starship.toml


# -----------------------------------------------------------------------------
# Configure Neovim
# -----------------------------------------------------------------------------

echo "========== Installing LazyVim (Neovim configuration) =========="

# ensure nvim is available
if ! command -v nvim >/dev/null 2>&1; then
    echo "Installing Neovim (latest stable)..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz
    # Add to path if not already there (assuming /opt/nvim-linux64/bin needs to be in PATH, or symlink)
    # Easiest is to symlink the binary to /usr/local/bin
    sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
fi

# Now that nvim is installed (or was already there), setup LazyVim
echo "========== Installing LazyVim (Neovim configuration) =========="
mkdir -p "$HOME/.config"

# backup existing config if present
if [ -d "$HOME/.config/nvim" ] && [ "$(ls -A "$HOME/.config/nvim")" ]; then
    BACKUP="$HOME/.config/nvim.bak.$(date +%s)"
    echo "Backing up existing ~/.config/nvim to $BACKUP"
    mv "$HOME/.config/nvim" "$BACKUP"
fi

# clone LazyVim starter (shallow)
echo "Cloning LazyVim starter into ~/.config/nvim"
git clone --depth 1 https://github.com/LazyVim/starter ~/.config/nvim

# If this repo contains a custom nvim folder, merge it into the LazyVim config
if [ -d "$DIR/nvim" ]; then
    echo "Merging custom nvim files from $DIR/nvim into ~/.config/nvim"
    rsync -a --exclude='.git' "$DIR/nvim/" ~/.config/nvim/
fi

# Bootstrap plugins (headless). This will download and compile plugins.
echo "Bootstrapping LazyVim plugins (headless). This may take a while..."
nvim --headless -c 'Lazy! sync' -c 'qa' || echo "Warning: headless plugin sync failed; you can run 'nvim' manually to finish setup."


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





