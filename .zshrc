# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# History
# History file
export HISTFILE=~/.zsh_history
# History size in memory
export HISTSIZE=10000
# The number of histsize
export SAVEHIST=1000000

# zsh autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# 補完機能
if [ -e ~/.zsh/completions ]; then
  fpath=(~/.zsh/completions $fpath)
fi
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
autoload -U compinit
compinit

# 色を使用出来るようにする
autoload -U colors
colors

# alias
alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias g='git'
alias ga='git add'
alias gc='git checkout'
alias gs='git status -sb'
alias gst='git status'

alias python="python3"
alias py="python3"

# tmux起動時処理
if [ "${TERM_PROGRAM}" = "vscode" ]; then
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
