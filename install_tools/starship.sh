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
