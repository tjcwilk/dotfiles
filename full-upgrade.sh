#!/usr/bin/env bash

# Ubuntu Full Update Script
# Saves time and updates packages + distro releases

set -e

echo "======================================"
echo " Ubuntu Full System Update Starting..."
echo "======================================"

# Refresh package lists
sudo apt update

# Upgrade installed packages
sudo apt upgrade -y

# Handle dependencies / package changes
sudo apt full-upgrade -y

# Remove old unused packages
sudo apt autoremove -y
sudo apt autoclean -y

# Check for new Ubuntu release upgrades
echo ""
echo "Checking for Ubuntu release upgrades..."
sudo do-release-upgrade -c || true

echo ""
echo "======================================"
echo " System update complete."
echo " If a new Ubuntu release is available,"
echo " run: sudo do-release-upgrade"
echo "======================================"
