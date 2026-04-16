echo "========== Setting up symlinks =========="

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set -e

# -----------------------------------------------------------------------------
# Set up symlinks
# -----------------------------------------------------------------------------
echo "--> .inputrc"
ln -sf $DIR/rcfiles/inputrc ~/.inputrc

echo "-> .tmux.conf"
ln -sf $DIR/.tmux.conf ~/.tmux.conf

echo "-> .config/starship.toml"
ln -sf $DIR/starship/starship.toml ~/.config/starship.toml
# -----------------------------------------------------------------------------
# Finished
# -----------------------------------------------------------------------------
echo "✅ Symlink complete!"





