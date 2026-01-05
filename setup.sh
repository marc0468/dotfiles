#!/bin/bash
cd `dirname $0`

# general
ln -sf ${PWD}/.vimrc ~/.vimrc
ln -sf ${PWD}/.alias ~/.alias
ln -sf ${PWD}/.tmux.conf ~/.tmux.conf

# shell
ln -sf ${PWD}/.bashrc ~/.bashrc
echo "source ~/.bashrc" >> ~/.bash_profile
ln -sf ${PWD}/.zshrc ~/.zshrc
ln -sf ${PWD}/.p10k.zsh ~/.p10k.zsh

# claude
mkdir -p ~/.claude
ln -sf ${PWD}/.claude/settings.json ~/.claude/settings.json

# codex
mkdir -p ~/.codex
ln -sf ${PWD}/.codex/config.toml ~/.codex/config.toml
ln -sf ${PWD}/.codex/AGENTS.md ~/.codex/AGENTS.md
ln -sfn ${PWD}/.codex/prompts ~/.codex/prompts

# neovim
ln -sf ${PWD}/.config/nvim/init.lua ~/.config/nvim/init.lua

# .config dir
shopt -s nullglob

settings_list=(bat git mise wezterm)
[[ $(uname) == Darwin ]] && settings_list+=(karabiner)

for setting in "${settings_list[@]}"; do
  mkdir -p "$HOME/.config/$setting"
  ln -sf "$PWD/.config/$setting/"* "$HOME/.config/$setting/"
done
