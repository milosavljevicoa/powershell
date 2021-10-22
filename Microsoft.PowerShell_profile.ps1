# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Update to latest powershell with 
# choco upgrade powershell -y

# fish like autosuggestion
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Chord Ctrl-p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord Ctrl-n -Function HistorySearchForward

Set-PoshPrompt -Theme hotstick.minimal
Set-Alias -Name chtsh -Value Get-ChtSh

