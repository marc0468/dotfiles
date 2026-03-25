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

    # .DS_Store抑制
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
    # バッテリー
    defaults write com.apple.menuextra.battery ShowPercent -bool true
    # 時計
    defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm:ss'
    # タップクリック
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    # 拡張子表示
    defaults write -g AppleShowAllExtensions -bool true
    # キーリピート
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    # Dock
    defaults write com.apple.dock orientation -string "left"
    defaults write com.apple.dock tilesize -int 36
    defaults write com.apple.dock show-process-indicators -bool true
    defaults write com.apple.dock show-recents -bool false
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
    tree \
    bash-completion
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
