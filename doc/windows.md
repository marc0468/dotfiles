# Windows

WSLのセットアップは[ubuntu.md](ubuntu.md)も参照すること

## 必要なソフトウェアのインストール

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

cudaのインストールは以下のリンクから行う。

<https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_network>

```sh
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-9

# CUDAのパスを通す
export PATH="/usr/local/cuda/bin:$PATH" >> ~/.zshenv
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH" >> ~/.zshenv
```
