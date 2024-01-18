$path = (Convert-Path .)

mkdir $HOME\Documents\PowerShell
New-Item -ItemType SymbolicLink -Path $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Value $path\PowerShell\Microsoft.PowerShell_profile.ps1
mkdir $HOME\.config
New-Item -ItemType SymbolicLink -Path $HOME\.config\starship.toml -Value $path\.config\starship.toml
mkdir $HOME\.config\git
New-Item -ItemType SymbolicLink -Path $HOME\.config\git\ignore -Value $path\.config\git\ignore
