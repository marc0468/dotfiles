#!/bin/sh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# General
brew install --cask karabiner-elements
brew install --cask google-japanese-ime
brew install --cask dropbox
# Video
brew install --cask vlc
brew install ffmpeg
# Communication
brew install --cask wechatwork
brew install --cask wechat
brew install --cask zoom
# Editor
brew install --cask typora
brew install --cask coteditor
# Dev
brew install --cask android-studio
brew install --cask docker
brew install --cask wireshark
brew install --cask xquartz
brew install tmux
brew install cmake
brew install tree

# tmux
ln -sf ${PWD}/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ${PWD}/dotfiles/.tmux/bin/battery /usr/local/bin/battery
ln -sf ${PWD}/dotfiles/.tmux/bin/wifi /usr/local/bin/wifi

# zsh
ln -sf ${PWD}/dotfiles/.zshrc ~/.zshrc
ln -sf ${PWD}/dotfiles/.p10k.zsh ~/.p10k.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# vim
ln -sf ${PWD}/dotfiles/.vimrc ~/.vimrc

# git
ln -sf ${PWD}/dotfiles/.gitignore_global ~/.gitignore_global
echo '[core]' >>~/.gitconfig
echo '    excludesfile = ~/.gitignore_global' >>~/.gitconfig
