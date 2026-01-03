# Setup Mac

## Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
# brew bundle dump
brew bundle
```

## OS settings

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

## 廃止予定

### tmux

```sh
sudo mkdir -p /usr/local/bin
sudo ln -sf ${PWD}/.tmux/bin/battery /usr/local/bin/battery
sudo ln -sf ${PWD}/.tmux/bin/wifi /usr/local/bin/wifi
```
