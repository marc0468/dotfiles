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

# 色を使用出来るようにする
autoload -U colors
colors

# alias
source ~/.alias

# tmux
tmux -V > /dev/null 2>&1
if [ $? = 0 ]; then
  if [ "${TERM_PROGRAM}" = "vscode" ]; then
    :
  elif [ "${TERM_PROGRAM}" = "WezTerm" ]; then
    :
  else
    if [[ ! -n $TMUX ]]; then
      # get the IDs
      ID="`tmux list-sessions`"
      if [[ -z "$ID" ]]; then
        tmux new-session
      fi
      ID="`echo $ID | $PERCOL | cut -d: -f1`"
      tmux attach-session -t "$ID"
    fi
  fi
fi

# テーマ
source ~/.powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh

# plugin
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# anyenv
PATH="$HOME/.anyenv/bin:$PATH"
if command -v anyenv 1>/dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# pyenv
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
  export PATH=${PYENV_ROOT}/shims:$PATH
  pyenv -V > /dev/null 2>&1
  if [ $? = 0 ]; then
    eval "$(pyenv init -)"
  fi
fi

# kubectl
if [[ $(command -v kubectl) ]]; then
  source <(kubectl completion zsh)
fi

export PATH="$HOME/.local/bin:$PATH"
