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
    (Get-Content (Get-PSReadLineOption | select -ExpandProperty HistorySavePath)) | fzf --reverse --border
}

function Set-FzfHistory {
    Get-FzfHistory | Invoke-Expression
}

function Remove-Branch {
    param(
        [switch] $All,
        [switch] $Force
    )

    $branches = "test", "test1", "test2", "test12", "test22"
    if ($All) {
        # get all branches
    } else {
        # select single branch with fzf
    }

    $deletionFlag = if ($Force) {"-D"} else {"-d"}
    $show_flag = $true;
    $branches | ForEach-Object {
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

# easily revert file to master
# git diff HEAD..master -- path/to/file.ext | git apply 

$languages = "javascript", "typescript", "go", "lua", "powershell", "css", "html", "python", "csharp", "cpp"
$commands =  "choco", "git", "git-worktree", "git-status", "git-commit", "git-rebase", , "fzf", "rg", "docker", "docker-compose"
function Get-ChtSh {
	$sel = ($languages +  $commands) | fzf --reverse --border
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