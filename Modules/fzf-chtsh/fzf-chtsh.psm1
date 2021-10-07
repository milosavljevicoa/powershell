$cht_sh_entries = "go", "docker", "lua", "git", "python"
function Get-ChtSh {
	$sel = $cht_sh_entries | fzf
	Invoke-WebRequest -Uri "https://cht.sh/$sel/:learn" |
        Select-Object -Expand Content
}

Set-Alias -Name fzf-chtsh -Value Get-ChtSh