#!/bin/sh
cd `dirname $0`

# general
ln -sf ${PWD}/.vimrc ~/.vimrc
ln -sf ${PWD}/.alias ~/.alias
ln -sf ${PWD}/.wezterm.lua ~/.wezterm.lua
ln -sf ${PWD}/.tmux.conf ~/.tmux.conf

# shell
ln -sf ${PWD}/.bashrc ~/.bashrc
echo "source ~/.bashrc" >> ~/.bash_profile
ln -sf ${PWD}/.zshrc ~/.zshrc
ln -sf ${PWD}/.p10k.zsh ~/.p10k.zsh

# git
mkdir -p ~/.config/git
ln -sf ${PWD}/.config/git/ignore ~/.config/git/ignore

# bat
mkdir -p ~/.config/bat
ln -sf ${PWD}/.config/bat/config ~/.config/bat/config
