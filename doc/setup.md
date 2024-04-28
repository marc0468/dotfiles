# Setup

## Common

### Git

```sh
git config --global user.name "Marco"
git config --global user.email "17253707+marc0468@users.noreply.github.com"
```

### zsh

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
```

### SSH

```sh
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

`.ssh/config`にmacOS特有設定を書く。

```.ssh/config
Host *
  UseKeychain yes
  AddKeysToAgent yes
```

### Python

#### pyenv

公式の手順: <https://github.com/pyenv/pyenv?tab=readme-ov-file#installation>

下記のようにデフォルトで使用するPythonを設定しておく。

```sh
pyenv install 3.xx
pyenv global 3.xx
```

#### poetry

公式の手順: <https://python-poetry.org/docs/#installation>

プロジェクトディレクトリ内に仮想環境を作成するように設定しておく。

```sh
poetry config virtualenvs.in-project true
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

### General

アップデートと必須ソフトのインストール。

```sh
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  git \
  zsh \
  tmux \
  ssh \
  vim \
  bat \
  eza
```

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

## Docker

公式の手順に従う。
<https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository>

ユーザーをdockerグループに追加する。

```sh
sudo gpasswd -a $USER docker
```

補完を有効にする。
bash-completionがインストールされていること。

```sh
# sudo apt install bash-completion
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
```

## Windows

```sh
winget export -o WingetApp.json
winget import -i WingetApp.json --accept-package-agreements --ignore-unavailable
```

cudaはwingetで入れるとパスも通してくれるので便利。

```sh
winget install -e --id Nvidia.CUDA -v 12.1
```

### SSH

`ssh-add`が「Error connecting to agent: No such file or directory」となる場合、管理者権限で以下を実行する。

```sh
Set-Service -Name ssh-agent -StartupType Manual
Start-Service ssh-agent
```

### WSL

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
