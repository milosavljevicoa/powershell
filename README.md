# Windows Powershell

Here are some of mine powershell modules.

To use this repo you have to install [fzf](https://github.com/junegunn/fzf)

## Available commands

- `Get-ChtSh` (or for shorter `cht-sh`) - calls [cht.sh](https://cht.sh`) with `:learn`
for the following `go, docker, lua, git, python` (WIP) 
![Get-ChtSh](https://user-images.githubusercontent.com/47518781/136328962-02437aed-c6e3-4acb-bd57-49cb039d7a64.gif)


- `Set-FzfLocation` (or for shorter `cd-fzf`) searches directory from current and changes location to the selected one. You can add a folder name (or regex) to narrow down the search (it searher recursively). Note: the search is case sensitive
Exapmle usage: 
![Set-FzfLocation-dir-name](https://user-images.githubusercontent.com/47518781/136329027-5ea9e724-2d92-4a1b-bde9-15241f5202d6.gif)
![Set-FzfLocation](https://user-images.githubusercontent.com/47518781/136329039-24116dd2-be74-4796-815a-b7c7e015a0f4.gif)


