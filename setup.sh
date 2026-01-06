#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# general
ln -sf "${SCRIPT_DIR}/.vimrc" "$HOME/.vimrc"
ln -sf "${SCRIPT_DIR}/.alias" "$HOME/.alias"

# shell
ln -sf "${SCRIPT_DIR}/.bashrc" "$HOME/.bashrc"
echo "source ~/.bashrc" >> "$HOME/.bash_profile"
ln -sf "${SCRIPT_DIR}/.zshrc" "$HOME/.zshrc"
ln -sf "${SCRIPT_DIR}/.p10k.zsh" "$HOME/.p10k.zsh"

# claude
mkdir -p ~/.claude
ln -sf "${SCRIPT_DIR}/.claude/settings.json" "$HOME/.claude/settings.json"

# codex
mkdir -p ~/.codex
ln -sf "${SCRIPT_DIR}/.codex/config.toml" "$HOME/.codex/config.toml"
ln -sf "${SCRIPT_DIR}/.codex/AGENTS.md" "$HOME/.codex/AGENTS.md"
ln -sfn "${SCRIPT_DIR}/.codex/prompts" "$HOME/.codex/prompts"

# gemini
mkdir -p ~/.gemini
ln -sf "${SCRIPT_DIR}/.gemini/GEMINI.md" "$HOME/.gemini/GEMINI.md"

# neovim
mkdir -p "$HOME/.config/nvim"
ln -sf "${SCRIPT_DIR}/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"

# .config dir
shopt -s nullglob dotglob

settings_list=(bat git mise tmux wezterm)
[[ $(uname) == Darwin ]] && settings_list+=(karabiner)

for setting in "${settings_list[@]}"; do
  mkdir -p "$HOME/.config/$setting"
  for file in "$SCRIPT_DIR/.config/$setting"/*; do
    [ -e "$file" ] || continue
    ln -sf "$file" "$HOME/.config/$setting/$(basename "$file")"
  done
done
