# Windows Powershell

Here are some of mine powershell modules.

To use this repo you have to install [fzf](https://github.com/junegunn/fzf)

## Available commands

- `Get-ChtSh` - calls [cht.sh](https://cht.sh`) for the following techonlogy and its available queries (from cht.sh)
![Get-ChtSh](https://user-images.githubusercontent.com/47518781/136626734-88de3930-ee09-4946-a784-f19a1c7fe515.gif)


- `Set-FzfLocation` - list directories trough fzf and change location to the selected one. Note: the search is case sensitive
Here are the following paramters and their meaning
  - `Filter` - used to filter certain text, example `"*test*"` (can be used without quotes, but I like it with 😁).
  - `Path` - used to set starting path of the search, default value is current directory.
  - `Deth` - depth of recursive search, default value is 10.
  - Exapmle usage: 
![Set-FzfLocation](https://user-images.githubusercontent.com/47518781/136329039-24116dd2-be74-4796-815a-b7c7e015a0f4.gif)

- `Get-FzfLocation` - gets absolute path for certain directory or file trough fzf.
  - `Filter` - used to filter certain text, example `"*test*"`.
  - `Path` - used to set starting path of the search, default value is current directory.
  - `Deth` - depth of recursive search, default value is 10.
  - `Directory` - used to specify only directory search.

- `Get-FzfHistory` - gets history list of commands trough fzf and selected command will be passed as an output.
- `Invoke-FzfHistory` - executes a command from history list of commands (extension on `Get-FzfHistory` command). 

- `Remove-Branch` - removes only local branch (you can't delete current branch). Following parameters are available:
  - If `All` is ommited from command then fzf list will be shown with all local branches where you can choose single branch to delete. 
  - `All` - go through all branches and ask the following question: "[a/A] - delete all branches, [y/Y] - delete this branch and [n/N] - skip this branch" where an appropriate action will take place.
    - `a/A` - delete this branch and all local branches.
    - `y/Y` - delete this branch and move to the next one.
    - `n/N` - skip deleting this branch and move to the next one.
  - `Force` - force delete branches

- `Set-FzfBranch` - change selected branch through fzf. If there is main\master branch it will be displayed as top resault for easy switching between non-master/main branch to master/main bracnh
  - `Remote` - select from remote branches (`git fetch` is **not** called) trough fzf. 
