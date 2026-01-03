function git_color() {
  local git_info="$(__git_ps1 "%s")"
  if [[ $git_info == *"%"* ]] || [[ $git_info == *"*"* ]]; then
    echo '31'
  elif [[ $git_info == *"+"* ]]; then
    echo '32'
  else
    echo '33'
  fi
}

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=50000
HISTTIMEFORMAT='%F %T '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


if command -v __git_ps1 > /dev/null 2>&1; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM=auto
  PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[$(git_color)m\]$(__git_ps1 "(%s)")\[\033[35m\][\t]\n\[\033[00m\]$ '
else
  PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[33m\]\[\033[35m\][\t]\n\[\033[00m\]$ '
fi

# If this is an xterm set the title
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# タブ補完するときに大文字小文字を区別しない
bind 'set completion-ignore-case on'

if [ -f ~/.alias ]; then
    . ~/.alias
fi

# uv
if [[ $(command -v uv) ]]; then
  # command completion for uv
  eval "$(uv generate-shell-completion bash)"
fi

if [[ -f ~/.local/bin/mise ]]; then
  eval "$(~/.local/bin/mise activate bash)"
fi
