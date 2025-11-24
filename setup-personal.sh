#!/usr/bin/env bash

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
# Install Espanso text expander
# -----------------------------------------------------------------------------

echo "========== Installing Espanso =========="

if ! command -v espanso &> /dev/null
then
  echo "Espanso is not installed. Installing now..."

  if command -v snap &> /dev/null
  then
    sudo snap install espanso --classic
  else
    # Fallback to official installer script (runs as current user)
    curl -fsSL https://updates.espanso.org/install.sh | sh
  fi

  # Start espanso (user service); if systemd --user is available, use it
  if command -v systemctl &> /dev/null && systemctl --user >/dev/null 2>&1
  then
    espanso restart || espanso start || true
  else
    # Try starting without systemd (best-effort)
    espanso start >/dev/null 2>&1 || true
  fi

  echo "Espanso installation complete."
else
  echo "Espanso is already installed."
fi

echo "-> Espanso text expander"
ln -sf $DIR/espanso/match.yml ~/.config/espanso/match/match.yml


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

fc-cache -fv

echo "========== Installing Catpuccine theme for ubuntu terminal=========="
curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v1.0.0/install.py | python3 -


# -----------------------------------------------------------------------------
# Finished
# -----------------------------------------------------------------------------
echo "✅ Setup complete!"
