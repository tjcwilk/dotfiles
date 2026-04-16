#!/usr/bin/env bash
set -euo pipefail

echo "==> Updating apt package index..."
sudo apt update

echo "==> Installing prerequisites..."
sudo apt install -y curl git unzip xclip ripgrep fd-find build-essential tar

echo "==> Removing old apt Neovim package if installed..."
sudo apt remove -y neovim || true

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cd "$TMP_DIR"

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64)
    NVIM_TARBALL="nvim-linux-x86_64.tar.gz"
    NVIM_DIR="nvim-linux-x86_64"
    ;;
  aarch64|arm64)
    NVIM_TARBALL="nvim-linux-arm64.tar.gz"
    NVIM_DIR="nvim-linux-arm64"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

echo "==> Downloading latest official Neovim release..."
curl -LO "https://github.com/neovim/neovim/releases/latest/download/${NVIM_TARBALL}"

echo "==> Installing Neovim to /opt/nvim..."
tar xzf "${NVIM_TARBALL}"
sudo rm -rf /opt/nvim
sudo mv "${NVIM_DIR}" /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

echo "==> Verifying Neovim version..."
nvim --version | head -n 5

echo "==> Backing up existing Neovim config (if present)..."
timestamp="$(date +%Y%m%d-%H%M%S)"
[ -d "$HOME/.config/nvim" ] && mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup-$timestamp"
[ -d "$HOME/.local/share/nvim" ] && mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim.backup-$timestamp"
[ -d "$HOME/.local/state/nvim" ] && mv "$HOME/.local/state/nvim" "$HOME/.local/state/nvim.backup-$timestamp"
[ -d "$HOME/.cache/nvim" ] && mv "$HOME/.cache/nvim" "$HOME/.cache/nvim.backup-$timestamp"

echo "==> Installing LazyVim starter config..."
git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"

echo ""
echo "========================================="
echo "Installation complete."
echo "Run: nvim"
echo "First launch will install LazyVim plugins."
echo "========================================="
