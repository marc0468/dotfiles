#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

# general
ln -sf ${PWD}/.vimrc ~/.vimrc
ln -sf ${PWD}/.alias ~/.alias

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

# gemini
mkdir -p ~/.gemini
ln -sf ${PWD}/.gemini/GEMINI.md ~/.gemini/GEMINI.md

# neovim
mkdir -p ~/.config/nvim
ln -sf ${PWD}/.config/nvim/init.lua ~/.config/nvim/init.lua

# .config dir
shopt -s nullglob dotglob

settings_list=(bat git mise tmux wezterm)
[[ $(uname) == Darwin ]] && settings_list+=(karabiner)

for setting in "${settings_list[@]}"; do
  mkdir -p "$HOME/.config/$setting"
  for file in "$PWD/.config/$setting"/*; do
    [ -e "$file" ] || continue
    ln -sf "$file" "$HOME/.config/$setting/$(basename "$file")"
  done
done
