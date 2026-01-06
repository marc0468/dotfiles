#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Xcode Command Line Tools
    if ! xcode-select -p &> /dev/null ; then
        echo "Xcode Command Line Toolsをinstallします..."
        xcode-select --install
    fi

    # homebrew
    if ! command -v brew &> /dev/null ; then
        echo "homebrewをinstallします..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Brewfile記載のパッケージをinstallします..."
    brew bundle --file="$SCRIPT_DIR/Brewfile"
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # apt packages linux
    sudo apt update && sudo env DEBIAN_FRONTEND=noninteractive apt upgrade -y
    sudo apt install -y \
    git \
    zsh \
    tmux \
    vim \
    curl \
    htop \
    nvtop \
    tree
fi

# mise
echo "miseをinstallします..."
curl https://mise.run | sh

# zsh
echo "zsh pluginsをinstallします..."
mkdir -p "$HOME/.zsh"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.zsh/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$HOME/.zsh/fast-syntax-highlighting"
chsh -s /bin/zsh
