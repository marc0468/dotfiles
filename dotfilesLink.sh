#!/bin/sh
# テーマの変更
ln -sf ${PWD}/.zpreztorc ~/.zpreztorc

ln -sf ${PWD}/.tmux.conf ~/.tmux.conf
ln -sf ${PWD}/.zshrc ~/.zshrc
ln -sf ${PWD}/.vimrc ~/.vimrc
# ln -sf ${PWD}/.config/starship.toml ~/.config/starship.toml
ln -sf ${PWD}/.tmux/bin/battery /usr/local/bin/battery
ln -sf ${PWD}/.tmux/bin/wifi /usr/local/bin/wifi
ln -sf ${PWD}/.gitignore_global ~/.gitignore_global
ln -sf ${PWD}/.gitconfig ~/.gitconfig