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
# Finished
# -----------------------------------------------------------------------------
echo "✅ Setup complete!"





