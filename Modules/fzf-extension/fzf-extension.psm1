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