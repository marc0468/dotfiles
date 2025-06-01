$path = (Convert-Path .)

mkdir $HOME\.config\git
New-Item -ItemType SymbolicLink -Path $HOME\.config\git\ignore -Value $path\.config\git\ignore
