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


