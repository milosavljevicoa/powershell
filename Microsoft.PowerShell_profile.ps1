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

# functions to alias
function Get-GitStatus { & git status }
Set-Alias -Name gs -Value Get-GitStatus -Force
function Get-GitLog {
    param(
        [switch] $Diff
    )
    if ($Diff) {
      git log -p $arg
    } else {
      git log $arg
    }
}
Set-Alias -Name gl -Value Get-GitLog -Force
function Get-GitFetch { & git fetch $args }
New-Alias -Name f -Value Get-GitFetch -Force
