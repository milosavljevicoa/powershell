
function Set-FzfLocation {
    param(
        [Parameter(Mandatory = $false)]
        [string]
        $DirName = ""
    )

    Get-ChildItem -Recurse -Directory -Filter $DirName |
     Select-Object FullName -ExpandProperty FullName |
      fzf |
      Set-Location
}

Set-Alias -Name cd-fzf -Value Set-FzfLocation