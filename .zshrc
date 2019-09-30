# 履歴ファイルの読み込み
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# 補完機能
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
setopt AUTO_CD

# 色を使用出来るようにする
autoload -U colors
colors

# alias
alias ls='ls -G'
alias la='ls -a'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias d='docker'

alias g='git'
alias ga='git add'
alias gs='git status -sb'
alias gst='git status'

alias python="python3"
alias py="python3"
export PATH="$HOME/.pyenv/shims:$PATH"

# tmux起動時処理
if [ ${TERM_PROGRAM} = "vscode" ]; then
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

# Starshipの読み込み
eval "$(starship init zsh)"
export PATH=$HOME/.nodebrew/current/bin:$PATH
