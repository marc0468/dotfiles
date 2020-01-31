@rem cmdプロンプトでchocolateyをインストール（要管理者権限）
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

@rem 一般ツール
choco install -y googlechrome
choco install -y mpc-hc
choco install -y 7zip.install

@rem 録画環境
choco install -y plexmediaserver
choco install -y k-litecodecpackfull
choco install -y nodejs-lts
choco install -y ffmpeg

@rem 開発環境
choco install -y winmerge
choco install -y git
choco install -y sakuraeditor
choco install -y vscode
choco install -y arduino
choco install -y androidstudio
choco install -y heroku-cli
