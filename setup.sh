#!/bin/bash
cd `dirname $0`

# general
ln -sf ${PWD}/.vimrc ~/.vimrc
ln -sf ${PWD}/.alias ~/.alias

# shell
ln -sf ${PWD}/.bashrc ~/.bashrc
echo "source ~/.bashrc" >> ~/.bash_profile
ln -sf ${PWD}/.zshrc ~/.zshrc
ln -sf ${PWD}/.p10k.zsh ~/.p10k.zsh

# AI agent
## gemini
mkdir -p ~/.gemini
ln -sf ${PWD}/.codex/AGENTS.md ~/.gemini/GEMINI.md
## claude
mkdir -p ~/.claude
ln -sf ${PWD}/.claude/settings.json ~/.claude/settings.json
ln -sf ${PWD}/.claude/AGENTS.md ~/.claude/CLAUDE.md
## codex
mkdir -p ~/.codex
cp ${PWD}/.codex/config.toml ~/.codex/config.toml
ln -sf ${PWD}/.codex/AGENTS.md ~/.codex/AGENTS.md
ln -sfn ${PWD}/.codex/prompts ~/.codex/prompts

# neovim
ln -sf ${PWD}/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ${PWD}/.config/starship.toml ~/.config/starship.toml

# .config dir
shopt -s nullglob dotglob

settings_list=(bat git mise tmux wezterm ghostty)
[[ $(uname) == Darwin ]] && settings_list+=(karabiner)

for setting in "${settings_list[@]}"; do
  mkdir -p "$HOME/.config/$setting"
  for file in "$PWD/.config/$setting"/*; do
    [ -e "$file" ] || continue
    ln -sf "$file" "$HOME/.config/$setting/$(basename "$file")"
  done
done

ln -sf ${PWD}/bin/* ~/.local/bin/
