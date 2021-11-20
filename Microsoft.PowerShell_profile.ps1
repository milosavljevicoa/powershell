# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


# fish like autosuggestion
Set-PSReadLineOption -PredictionSource History
#Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Chord Ctrl+f -Function ForwardWord
Set-PSReadLineKeyHandler -Chord Ctrl-p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord Ctrl-n -Function HistorySearchForward

Set-PoshPrompt -Theme wopian

Set-Alias -Name chtsh -Value Get-ChtSh
Set-Alias -Name b -Value Set-FzfBranch
Set-Alias -Name gs -Value Get-GitStatus -Force
Set-Alias -Name gl -Value Get-GitLog -Force
New-Alias -Name f -Value Get-GitFetch -Force
New-Alias -Name pr -Value Invoke-PushRemote -Force
New-Alias -Name gd -Value Get-GitDiff -Force
New-Alias -Name gst -Value Get-GitStash -Force

