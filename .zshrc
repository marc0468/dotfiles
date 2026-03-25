# ZSH
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=vim
export VISUAL=vim

## History
export HISTFILE=~/.zsh/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# 古いコマンドと同じものは無視
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 保管時にヒストリを自動的に展開
setopt hist_expand

## その他
setopt interactivecomments # コメントを許可

### 補完機能
if [ -e ~/.zsh/completion ]; then
  fpath=(~/.zsh/completion $fpath)
fi
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
fpath+=~/.zfunc
autoload -Uz compinit && compinit -i
setopt AUTO_CD

### 色を使用出来るようにする
autoload -U colors
colors

### テーマ
# eval "$(starship init zsh)"
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh

### plugin
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

export PATH="$HOME/.local/bin:$PATH"

# mise
if [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

# uv
if [[ $(command -v uv) ]]; then
  eval "$(uv generate-shell-completion zsh)"
fi

# alias
source ~/.alias
