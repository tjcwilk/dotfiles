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
