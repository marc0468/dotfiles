#!/bin/bash
cd "$(dirname "$0")"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Xcode Command Line Tools
    if ! xcode-select -p &> /dev/null ; then
        echo "Xcode Command Line Toolsをinstallします..."
        xcode-select --install
    fi

    # homebrew
    if ! type brew &> /dev/null ; then
        echo "homebrewをinstallします..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Brewfile記載のパッケージをinstallします..."
    brew bundle --file=Brewfile
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # apt packages linux
    sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade
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
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
chsh -s /bin/zsh
