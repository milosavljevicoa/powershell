# Windows Powershell

Here are some of mine powershell modules.

To use this repo you have to install [fzf](https://github.com/junegunn/fzf)

## Available commands

- `Get-ChtSh` (or for shorter `cht-sh`) - calls [cht.sh](https://cht.sh`) with `:learn`
for the following `go, docker, lua, git, python` (WIP) 
![Get-ChtSh](https://user-images.githubusercontent.com/47518781/136328962-02437aed-c6e3-4acb-bd57-49cb039d7a64.gif)

- `Set-FzfLocation` (or for shorter `cd-fzf`) - searches directory changes location to the selected one. Note: the search is case sensitive
Here are the following paramters and their meaning
  - `Filter` - used to filter certain text, example `"*test*"` (can be used without quotes, but I like it with 😁).
  - `Path` - used to set starting path of the search, default value is current directory.
  - `Deth` - depth of recursive search, default value is 10.
  - Exapmle usage: 
![Set-FzfLocation](https://user-images.githubusercontent.com/47518781/136329039-24116dd2-be74-4796-815a-b7c7e015a0f4.gif)

- `Get-FzfLocation` - gets absolute path for certain directory or file.
  - `Filter` - used to filter certain text, example `"*test*"`.
  - `Path` - used to set starting path of the search, default value is current directory.
  - `Deth` - depth of recursive search, default value is 10.
  - `Directory` - used to specify only directory search.


