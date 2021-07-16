#!/bin/sh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install --cask karabiner-elements google-japanese-ime dropbox  xmind \ # General
  vlc \ # Video
  wechatwork wechat zoom slack \ # Communication
  visual-studio-code typora coteditor \ # Editor
  android-studio docker wireshark xquartz visual-studio arduino \ # Dev
brew install ffmpeg tmux cmake tree

# tmux
ln -sf ${PWD}/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ${PWD}/dotfiles/.tmux/bin/battery /usr/local/bin/battery
ln -sf ${PWD}/dotfiles/.tmux/bin/wifi /usr/local/bin/wifi

# zsh
ln -sf ${PWD}/dotfiles/.zshrc ~/.zshrc
ln -sf ${PWD}/dotfiles/.p10k.zsh ~/.p10k.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zdharma/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting

# vim
ln -sf ${PWD}/dotfiles/.vimrc ~/.vimrc

# git
ln -sf ${PWD}/dotfiles/.gitignore_global ~/.gitignore_global
echo '[core]' >>~/.gitconfig
echo '    excludesfile = ~/.gitignore_global' >>~/.gitconfig
