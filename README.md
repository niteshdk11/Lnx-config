# Setup Script

## Description
This script automates the setup process by updating the system, installing essential packages, setting up Oh My Zsh, Homebrew, and installing useful utilities and development tools.

---
## Script
```bash
#!/bin/bash

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y build-essential curl git zsh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Configure Homebrew in Zsh
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install GCC with Homebrew
brew install gcc

# Clone configuration repo and clean up Git directory
git clone https://github.com/nitesh11-dk/Lnx-config.git temp_folder
rm -rf temp_folder/.git

# Set executable permissions for custom script
chmod +x ~/.run_with_clear.sh

# Install additional utilities with Homebrew
brew install yazi micro node fzf fd bat git-delta eza tldr zoxide java

# Install Nodemon globally with npm
npm i -g nodemon

# Clean up temporary folder
rm -rf temp_folder

---

### setting this as root as lychee always

```jsx
cat > /etc/wsl.conf <<EOF
[user]
default=lychee
EOF
```

sudo apt update
sudo apt upgrade -y
