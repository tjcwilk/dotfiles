#!/usr/bin/env bash
# =============================================================================
# update-bashrc.sh
# =============================================================================
# This script will update your bashrc file with tobys custome settings and
# bindings.
# =============================================================================
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if the marker exists and remove everything after it
if grep -q "# My custom bashrc settings" ~/.bashrc; then
    echo "Removing existing custom settings from ~/.bashrc..."
    sed -i '/# My custom bashrc settings/,$d' ~/.bashrc
fi

echo "Appending new custom settings..."
if [ -f "$DIR/bashrc_content.sh" ]; then
    cat "$DIR/bashrc_content.sh" >> ~/.bashrc
    echo "Successfully updated ~/.bashrc"
else
    echo "Error: bashrc_content.sh not found in $DIR"
    exit 1
fi