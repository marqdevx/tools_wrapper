# Windows Tools installer
This script helps to install a collection of programs.


## How to Run
Paste this command into Powershell (admin):
```
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/marqdevx/tools_wrapper/main/tools_installer.ps1'))
```
Or, shorter:
```
iwr -useb https://raw.githubusercontent.com/marqdevx/tools_wrapper/main/tools_installer.ps1 | iex
```

Original script https://github.com/ChrisTitusTech/win10script