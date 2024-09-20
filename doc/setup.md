# Setup

アップデートと必須ソフトのインストール。

```sh
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade
sudo apt install -y \
  git \
  zsh \
  tmux \
  vim \
  bat \
  curl \
  htop \
  nvtop \
  tree

# `apt`を使用して`bat`をインストールした場合、実行可能ファイルの名前が`bat`ではなく`batcat`になることがあります(他のパッケージとの名前衝突のため)。`bat -> batcat`のシンボリックリンクまたはエイリアスを設定することで、実行可能ファイル名が異なることによる問題の発生を防ぎ、他のディストリビューションと一貫性を保てます。<https://github.com/sharkdp/bat/blob/master/doc/README-ja.md#on-ubuntu-apt-%E3%82%92%E4%BD%BF%E7%94%A8>
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
```

Ubuntuの自動アップデートを無効にする場合は以下を設定する。

- `/etc/apt/apt.conf.d/10periodic`
- `/etc/apt/apt.conf.d/20auto-upgrades`
- `/etc/apt/apt.conf.d/50unattended-upgrades`

```sh
# パッケージリストの自動アップデート
APT::Periodic::Update-Package-Lists "1";
# パッケージの自動アップデート
APT::Periodic::Unattended-Upgrade "1";
```

参考:
- <https://qiita.com/ymbk990/items/cabfc383e1c5e35eb4f9>
- <https://skrum.co.jp/blog/ubuntu-automatic-application-of-security-updates/>

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

フォントのインストール

```sh
mkdir temp_font
cd temp_font
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/RobotoMono.tar.xz
tar xvf RobotoMono.tar.xz
```

Capsをctrlに変更

`/etc/default/keyboard`を編集する。

```/etc/default/keyboard
# 修正前
XKBOPTIONS=""
# 修正後
XKBOPTIONS="ctrl:nocaps"
```

## SSH

SSHサーバのインストール

```sh
sudo apt install openssh-server
```

SSHサーバーの設定`/etc/ssh/sshd_config`を編集。
よく言われる変更すべき設定項目。

* Port
  * SSHのポート番号（デフォルトは22）
* PermitRootLogin no
  * SSH経由でrootユーザーへのログインを許可しない
* PasswordAuthentication no
  * パスワードでのログインを許可しない
* ChallengeResponseAuthentication no
  * パスワードに毛が生えた程度のチャレンジレスポンス認証でのログインは許可しない
* PermitEmptyPasswords
  * パスワード未設定でも空パスワードでのログインは許可しない


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

pyenvとnodeenvのインストール。
anyenvを使う。
<https://github.com/anyenv/anyenv>

```sh
git clone https://github.com/anyenv/anyenv ~/.anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
anyenv install --init
anyenv install pyenv
anyenv install nodenv
```

### python

pyenvの設定。

```sh
# Pythonのビルドに必要なパッケージのインストール
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
# 下記のようにデフォルトで使用するPythonを設定しておく。
pyenv install 3.xx
pyenv global 3.xx
```

poetryの設定。
公式の手順: <https://python-poetry.org/docs/#installation>

```sh
curl -sSL https://install.python-poetry.org | python3 -
# export PATH="$HOME/.local/bin:$PATH"
# プロジェクトディレクトリ内に仮想環境を作成するように設定しておく。
poetry config virtualenvs.in-project true
poetry env use 3.xx
```

### Docker

公式の手順に従う。
<https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository>
Macの場合はrancherを使う。

```sh
# ユーザーをdockerグループに追加する。
sudo gpasswd -a $USER docker

# 補完を有効にする。
# bash-completionがインストールされていること。
# sudo apt install bash-completion
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
```

nvidia-dockerをインストール。
<https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html>
以下で`nvidia-smi`が成功すればOK。

```sh
docker run --rm --gpus all ubuntu nvidia-smi
```

### VS Code

```sh
curl -Lk 'https://update.code.visualstudio.com/{latest}/linux-deb-x64/stable' --output code.deb
# armの場合
curl -Lk 'https://update.code.visualstudio.com/latest/linux-deb-arm64/stable' --output code.deb
sudo apt install ./code.deb
```

```sh
code tunnel --accept-server-license-terms
code tunnel --no-sleep service install
systemctl --user status code-tunnel
systemctl --user enable code-tunnel.service
```

サービスを削除するときは以下のコマンド。

```sh
systemctl --user stop code-tunnel.service
systemctl --user disable code-tunnel.service
rm /etc/systemd/system/code-tunnel
rm /etc/systemd/system/code-tunnel symlinks that might be related
systemctl --user daemon-reload
systemctl --user reset-failed
```

## Mac

### Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
brew bundle
```

### OS settings

TODO: うまく機能していないものもある。

```sh
#ネットワークドライブ上への.DS_Storeファイルの作成抑制
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
#USB上への.DS_Storeファイルの作成抑制
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# バッテリー残量を％表記に
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
# 日付、曜日、時間の表記に
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm:ss'
# タップしたときクリック
defaults write -g com.apple.mouse.tapBehavior -int 1
# 全ての拡張子のファイルを表示する
defaults write -g AppleShowAllExtensions -bool true
# 三本指でドラッグ
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
# 三本指でドラッグ
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
# キーのリピート
defaults write NSGlobalDomain KeyRepeat -int 2
# リピート入力認識までの時間
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Spotlight検索を表示を無効化
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"
```

### Docker(rancher)

```sh
brew install --cask rancher
echo 'export PATH="$HOME/.rd/bin:$PATH"' >> ~/.zshenv
mkdir -p ~/.zsh/completion
curl https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o ~/.zsh/completion/_docker
```

### tmux

```sh
sudo mkdir -p /usr/local/bin
sudo ln -sf ${PWD}/.tmux/bin/battery /usr/local/bin/battery
sudo ln -sf ${PWD}/.tmux/bin/wifi /usr/local/bin/wifi
```

## Ubuntu

### GPU

<https://developer.nvidia.com/cuda-downloads>からCUDAをインストールする。

```sh
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda
```

この最後の`sudo apt-get -y install cuda`を

```sh
sudo apt-get -y install cuda-drivers
```

とすれば、最新のドライバだけが綺麗にインストールされます。

参考: <https://qiita.com/ksasaki/items/b20a785e1a0f610efa08>

## Windows

```sh
winget export -o WingetApp.json
winget import -i WingetApp.json --accept-package-agreements --ignore-unavailable
```

cudaはwingetで入れるとパスも通してくれるので便利。

```sh
winget install -e --id Nvidia.CUDA -v 12.1
```

## WSL

```sh
# GUIの文字化け対策
sudo apt install fonts-ipafont
```
