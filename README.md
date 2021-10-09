# Windows Powershell

Here are some of mine powershell modules.

To use this repo you have to install [fzf](https://github.com/junegunn/fzf)

## Available commands

- `Get-ChtSh` - calls [cht.sh](https://cht.sh`) for the following techonlogy and its available queries (from cht.sh)
![Get-ChtSh](https://user-images.githubusercontent.com/47518781/136626734-88de3930-ee09-4946-a784-f19a1c7fe515.gif)


- `Set-FzfLocation` - searches directory changes location to the selected one. Note: the search is case sensitive
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
