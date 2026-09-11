# Setup Script

## Description

This script automates the setup process by updating the system, installing essential packages, setting up Oh My Zsh, and installing useful utilities and development tools.

---

## Script

```bash
#!/bin/bash
# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y build-essential curl git zsh fzf fd-find bat eza zoxide micro gh dnsutils python3 nodejs npm yazi

# Install Oh My Zsh
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set Zsh as default shell
chsh -s "$(which zsh)"

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Clone configuration repo
git clone https://github.com/niteshdk11/Lnx-config.git temp_folder

# Copy Zsh configuration
cp temp_folder/.zshrc ~/.zshrc

# Copy custom scripts
mkdir -p ~/.scripts
cp -r temp_folder/.scripts/. ~/.scripts/

# Copy Git configuration
cp temp_folder/.gitconfig ~/.gitconfig

# Set executable permissions for custom scripts
chmod +x ~/.scripts/*.sh 2>/dev/null || true

# Clean up temporary folder
rm -rf temp_folder

# Set default WSL user to lychee
sudo tee /etc/wsl.conf > /dev/null <<EOF
[user]
default=lychee
EOF
