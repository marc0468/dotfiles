$path = (Convert-Path .)

mkdir $HOME\.config\git
New-Item -ItemType SymbolicLink -Path $HOME\.config\git\ignore -Value $path\.config\git\ignore

# wezterm
mkdir $HOME\.config\wezterm
New-Item -ItemType SymbolicLink -Path $HOME\.config\wezterm\wezterm.lua -Value $path\.config\wezterm\wezterm.lua
