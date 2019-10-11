# dotfiles
my dotfiles
[dotfilesLink](dotfilesLink.sh)

参考: [dotfilesをGitHubで管理](https://qiita.com/okamos/items/7f5461814e8ed8916870)

## 使い方

### Windows

管理者権限でコマンドプロンプトを開き、下記コマンドを実行する。
```
mklink  %HOMEPATH%\.vimrc %HOMEPATH%\dev\dotfiles\.vimrc
mklink  %HOMEPATH%\.minttyrc %HOMEPATH%\dev\dotfiles\.minttyrc
mklink  %HOMEPATH%\.bash_profile %HOMEPATH%\dev\dotfiles\.bash_profile
```

### Mac, Linux
`dotfilesLink.sh`を実行する。
