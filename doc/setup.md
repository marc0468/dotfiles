# Setup

Gitの設定。

```sh
git config --global user.name "Marco"
git config --global user.email "17253707+marc0468@users.noreply.github.com"
```

zshプラグインのインストール。

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
# シェルの変更
chsh -s /bin/zsh
```

## SSH

SSHサーバのインストール

```sh
sudo apt install openssh-server
```

SSHサーバーの設定`/etc/ssh/sshd_config`を編集。
よく言われる変更すべき設定項目。

- Port
  - SSHのポート番号（デフォルトは22）
- PermitRootLogin no
  - SSH経由でrootユーザーへのログインを許可しない
- PasswordAuthentication no
  - パスワードでのログインを許可しない
- ChallengeResponseAuthentication no
  - パスワードに毛が生えた程度のチャレンジレスポンス認証でのログインは許可しない
- PermitEmptyPasswords
  - パスワード未設定でも空パスワードでのログインは許可しない

```sh
# SSH鍵の生成
ssh-keygen -t ed25519
# 公開鍵を登録するファイルを作成する
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
# リモートホストに公開鍵を登録する
ssh-copy-id -i ~/.ssh/id_ed25519.pub <user_name>@<target_host>
# macは下記のコマンドで公開鍵をクリップボードにコピーできる
cat ~/.ssh/id_ed25519.pub | pbcopy
```

keychainに秘密鍵を登録する`-K`オプションを使い、再起動のたびに`ssh-add`する手間を省く。

```sh
ssh-add -K ~/.ssh/id_ed25519
# 再起動してもkeychainから呼び出す
echo "ssh-add --apple-load-keychain" >> ~/.zprofile
```

### tmux

tmuxの自動起動例

```sh
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
```

### Macの場合

`.ssh/config`にmacOS特有設定を書く。

```.ssh/config
Host *
  UseKeychain yes
  AddKeysToAgent yes
```

### Windowsの場合

`ssh-add`が「Error connecting to agent: No such file or directory」となる場合、管理者権限で以下を実行する。

```sh
Get-Service -Name ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
```

### WSLの場合

Windows（ホスト）のSSHキーを使う。
参考: <https://zenn.dev/keijiek/scraps/b03e1804d15f99>

```sh
sudo apt install -y keychain
```

`~/.bashrc`に下記を追記する。

```.bashrc
/usr/bin/keychain --quiet --nogui /mnt/c/Users/ユーザ名/.ssh/秘密鍵名
source $HOME/.keychain/`hostname`-sh
```

## 開発環境

### mise

<https://github.com/jdx/mise?tab=readme-ov-file#quickstart>

```sh
# Install
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshenv
```

`mise i`で[config.toml](.config/mise/config.toml)に記載されているパッケージをインストールできる。
