# History
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
setopt hist_ignore_dups # 直前と同じコマンドラインはヒストリに追加しない
setopt EXTENDED_HISTORY

# 補完機能
if [ -e ~/.zsh/completion ]; then
  fpath=(~/.zsh/completion $fpath)
fi
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
fpath+=~/.zfunc
autoload -Uz compinit && compinit -i
setopt AUTO_CD

# 色を使用出来るようにする
autoload -U colors
colors

# テーマ
source ~/.powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh

# plugin
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

export PATH="$HOME/.local/bin:$PATH"

# mise
if [[ $(command -v mise) ]]; then
  eval "$(mise activate zsh)"
  # eval "$(mise activate --shims)"
fi
# uv
if [[ $(command -v uv) ]]; then
  # command completion for uv
  eval "$(uv generate-shell-completion zsh)"
fi

# kubectl
if [[ $(command -v kubectl) ]]; then
  source <(kubectl completion zsh)
fi

# alias
source ~/.alias
