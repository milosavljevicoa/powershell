function Get-GitStatus { & git status }
function Get-GitFetch { & git fetch $args }
function Get-GitPull { & git pull $args }
function Invoke-PushRemote { & git push -u origin HEAD }
function Get-GitDiff { 
  param(
    [int] $Lines = 10,
    [switch] $Staged,
    [switch] $SingleFile
  )
  $staged_suffix = if ($Staged) { "--staged" } else { "" }
  $file_to_diff = ""
  if ($SingleFile) {
    $file_to_diff = git status --short | fzf --ansi --reverse --border
    $file_to_diff = $file_to_diff.Trim()
    $file_to_diff = $file_to_diff.Substring($file_to_diff.IndexOf(" "), $file_to_diff.Length - 1).Trim()
  }
  git diff "-U$Lines" $staged_suffix "$file_to_diff"
}
function Get-GitLog {
  param(
    [int] $Lines,
    [string] $Grep = "",
    [switch] $OneLine,
    [int] $LastMonths = 1
  )
  $one_line = $OneLine ? '--pretty="format:%Cblue%h%Creset - %C(Yellow)%s%Creset - %C(cyan)<%ae>%Creset%n%C(magenta)%aD - %ar%Creset"' : ''
  $line_arg = ($Lines -eq 0) ? "" : "-U$Line"
  git log --grep="$Grep" $line_arg $one_line --color=always --since="last $LastMonths months"
}
function Get-GitShow {
  param(
    [int] $LastMonths = 1,
    [int] $Lines = 5,
    [string] $Grep = ""
  )
  $commit = git log --grep="$Grep" --pretty="format:%C(white)%h%Creset - %C(Yellow)%s%Creset - %C(cyan)<%ae>%Creset - %C(magenta)%ad" --since="last $LastMonths month" --color=always --date="short" 
  | fzf --ansi --reverse --border

  if ($commit) {
    git show $commit.Substring(0, $s.IndexOf(" ")) "-U$Lines"
  }
}

function Get-GitStash {
  param(
    [Parameter(Mandatory = $false)] [int] $Show = -1,
    [Parameter(Mandatory = $false)] [int] $Lines = 10,
    [Parameter(Mandatory = $false)] [int] $Apply = -1,
    [Parameter(Mandatory = $false)] [int] $Pop = -1,
    [Parameter(Mandatory = $false)] [int] $Drop = -1,
    [Parameter(Mandatory = $false)] [string] $SaveMessage = ""
  )
  if ($Show -ge 0) {
    git stash show stash@"{$Show}" -p "-U$Lines"
    return
  }
  if ($Apply -ge 0) {
    git stash apply stash@"{$Apply}"
    return
  }
  if ($Pop -ge 0) {
    git stash pop stash@"{$Pop}"
    return
  }
  if ($Drop -ge 0) {
    git stash drop stash@"{$Drop}"
    return
  }
  if ($SaveMessage) {
    git stash push -m $SaveMessage
    return
  }
  git stash list
}
function Set-FzfBranch {
  param(
    [switch] $Remote
  )
    
  if ($Remote) {
    git fetch

    $branch = git branch -r | ForEach-Object { $_.Trim() | Where-Object { $_ -Match ".*^(?!HEAD).*" } } | fzf --reverse --border
    if ($branch) {
      git checkout -b $branch.Replace("origin/", "") $branch
    }
  }
  else {
    $branches = git branch | ForEach-Object { $_.Trim() | Where-Object { $_ -Match "^(?!\*).*" } }
    $main_branch_name = "main"
    $master_branch_name = "master"
    $main_branch_index = $branches.IndexOf($main_branch_name)
    $master_branch_index = $branches.IndexOf($master_branch_name)
    if ($branches.Count -ge 2) {
      if ($main_branch_index -ge 0) {
        $branches[$main_branch_index] = $branches[0]
        $branches[0] = $main_branch_name
      }
      elseif ($master_branch_index -ge 0) {
        $branches[$master_branch_index] = $branches[0]
        $branches[0] = $master_branch_name
      }
    }
    $branch = $branches | fzf --reverse --border
    if ($branch) {
      git checkout $branch
    }
  }
}

function Remove-Branch {
  param(
    [switch] $All,
    [switch] $Force
  )

  $selected_branches = git branch | ForEach-Object { $_.Trim() | Where-Object { $_ -Match "^(?!\*).*" } }
  if (!$All) {
    $selected_branches = $selected_branches | fzf --reverse --border
  }

  $deletionFlag = if ($Force) { "-D" } else { "-d" }
  $show_flag = $All;
  $selected_branches | ForEach-Object {
    if ($show_flag) {
      $flag = ""
      do {
        Write-Output "Would you like to delete `"$_`"?"
        $flag = Read-Host "[a/A] - delete all branches, [y/Y] - delete this branch and [n/N] - skip this branch"

        if ($flag -eq "a") {
          $show_flag = $false
          break
        }
        elseif ($flag -eq "n") {
          return
        }
        elseif ($flag -eq "y") {
          break
        }
      } while ($true)
    }
    git branch $deletionFlag $_
    Write-Output "--------------------------------------"
  }
}

function Invoke-GitRestore {
  param(
    [switch] $All,
    [switch] $Hunk
  )

  if ($All) {
    Write-Output "Are you sure you want to restore all unstaged changes?"
    $flag = Read-Host "[y/Y] - yes [n/N] - no"

    if ($flag -eq "y") {
      git restore .
      return
    }
  } else {
    $file_to_restore = git status --short | fzf --ansi --reverse --border
    if (-Not $file_to_restore) {
      return
    }
    $file_to_restore = $file_to_restore.Trim()
    $file_to_restore = $file_to_restore.Substring($file_to_restore.IndexOf(" "), $file_to_restore.Length - 1).Trim()
    if ($Hunk) {
      git checkout -p $file_to_restore
      return
    }
    git restore $file_to_restore
  }
}

# easily revert file to master
# git diff HEAD..master -- path/to/file.ext | git apply 
