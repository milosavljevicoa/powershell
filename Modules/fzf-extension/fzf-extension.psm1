function Get-FzfLocation {
    param(
        [Parameter(Mandatory = $false)] [string] $Filter = "",
        [Parameter(Mandatory = $false)] [string] $Path = ".",
        [Parameter(Mandatory = $false)] [int] $Depth = 5,
        [switch] $Directory
    )

    if ($Directory) {
        Get-ChildItem -Recurse -Directory -Path $Path -Filter $Filter -Depth $Depth |
        Select-Object FullName -ExpandProperty FullName |
        fzf --reverse --border 
    } else {
        Get-ChildItem -Recurse -File -Path $Path -Filter $Filter -Depth $Depth |
        Select-Object FullName -ExpandProperty FullName |
        fzf --reverse --border --preview 'bat --style=numbers --color=always {} ' --preview-window down:50%:wrap --bind "ctrl-d:preview-down,ctrl-u:preview-up"
    }
}

function Set-FzfLocation {
    param(
        [Parameter(Mandatory = $false)] [string] $Filter = "",
        [Parameter(Mandatory = $false)] [string] $Path = ".",
        [Parameter(Mandatory = $false)] [int] $Depth = 5
    )

    Get-FzfLocation -Directory -Filter $Filter -Depth $Depth -Path $Path | Set-Location
}

function Get-FzfHistory {
    (Get-Content (Get-PSReadLineOption | Select-Object -ExpandProperty HistorySavePath)) | fzf --reverse --border
}

function Invoke-FzfHistory {
    Get-FzfHistory | Invoke-Expression
}

function Remove-Branch {
    param(
        [switch] $All,
        [switch] $Force
    )

    $selected_branches = git branch | ForEach-Object { $_.Trim() | Where-Object { $_ -Match "^(?!\*).*"} }
    if (!$All) {
        $selected_branches = $selected_branches | fzf --reverse --border
    }

    $deletionFlag = if ($Force) {"-D"} else {"-d"}
    $show_flag = $true;
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

function Set-FzfBranch {
    param(
        [switch] $Remote
    )
    
    if ($Remote) {
        git fetch

        $branch = git branch -r | ForEach-Object { $_.Trim() | Where-Object { $_ -Match ".*^(?!HEAD).*"} } | fzf --reverse --border
        if ($branch) {
            git checkout -b $branch.Replace("origin/", "") $branch
        }
    }
    else {
        $branches = git branch | ForEach-Object { $_.Trim() | Where-Object { $_ -Match "^(?!\*).*"} }
        $main_branch_name = "main"
        $master_branch_name = "master"
        $main_branch_index = $branches.Contains($main_branch_name)
        $master_branch_index = $branches.Contains($master_branch_name)
        if ($branches.Count -ge 2) {
            if ($main_branch_index -ge 0) {
                $branches[$main_branch_index] = $branches[0]
                $branches[0] = $main_branch_name
            } elseif ($master_branch_index -ge 0) {
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

# easily revert file to master
# git diff HEAD..master -- path/to/file.ext | git apply 

$languages = "javascript", "typescript", "go", "lua", "powershell", "css", "html", "python", "csharp", "cpp"
$commands =  "choco", "git", "git-worktree", "git-status", "git-commit", "git-rebase", , "fzf", "rg", "docker", "docker-compose"
function Get-ChtSh {
	$sel = ($languages +  $commands) | fzf --reverse --border
    if (!$sel) {
        return
    }

    $query = Read-Host "Enter Query"
    $url = "https://cht.sh"

    if ($languages.Contains($sel)) {
        $modified_query = $query.Trim().Replace(" ", "+")
        $url = "${url}/${sel}/${modified_query}"
    } else {
        $url = "${url}/${sel}~${query}"
    }

	Invoke-WebRequest -Uri $url |
        Select-Object -Expand Content | 
        Out-Host -Paging
}