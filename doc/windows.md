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
