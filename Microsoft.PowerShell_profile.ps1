
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# fish like autosuggestion
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Chord Ctrl+f -Function ForwardWord

Set-PoshPrompt -Theme hotstick.minimal
Set-Alias -Name chtsh -Value Get-ChtSh

