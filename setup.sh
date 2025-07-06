#!/bin/bash
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

# mise
mkdir -p ~/.config/mise
ln -sf ${PWD}/.config/mise/config.toml ~/.config/mise/config.toml

# karabiner Macのみ
if [ "$(uname)" == "Darwin" ]; then
    mkdir -p ~/.config/karabiner
    ln -sf ${PWD}/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
fi

# claude
mkdir -p ~/.claude
ln -sf ${PWD}/.claude/settings.json ~/.claude/settings.json
