#!/bin/sh

#----プラグインのインストール----
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

#----Preztoのインストール----
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# 設定ファイルの作成
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
# テーマの変更
ln -sf ${PWD}/.zpreztorc ~/.zpreztorc

ln -sf ${PWD}/.tmux.conf ~/.tmux.conf
ln -sf ${PWD}/.zshrc ~/.zshrc
ln -sf ${PWD}/.vimrc ~/.vimrc
# ln -sf ${PWD}/.config/starship.toml ~/.config/starship.toml
ln -sf ${PWD}/.tmux/bin/battery /usr/local/bin/battery
ln -sf ${PWD}/.tmux/bin/wifi /usr/local/bin/wifi
ln -sf ${PWD}/.gitignore_global ~/.gitignore_global
ln -sf ${PWD}/.bash_profile ~/.bash_profile
ln -sf ${PWD}/.gitconfig ~/.gitconfig