# Ubuntu

## アップデートと必須ソフトのインストール

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

## Ubuntuの自動アップデートを無効にする

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

## フォントのインストール

`RobotoMonoNerdFontMono-Regular`をインストールする。

```sh
mkdir temp_font
cd temp_font
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/RobotoMono.tar.xz
tar xvf RobotoMono.tar.xz
```

## Capsをctrlに変更

`/etc/default/keyboard`を編集する。

```/etc/default/keyboard
# 修正前
XKBOPTIONS=""
# 修正後
XKBOPTIONS="ctrl:nocaps"
```

## Docker

インストールは公式の手順に従う。
<https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository>

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

## CUDA

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
