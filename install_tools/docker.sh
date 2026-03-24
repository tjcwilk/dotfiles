# -----------------------------------------------------------------------------
# Install Docker
# -----------------------------------------------------------------------------
echo "========== Installing Docker =========="
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker --now
sudo usermod -aG docker "$USER"
