# Useful Powershell Commands

If you want to easily go to this page add this to your `~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`, then reload your powershell and enter `upc` to see this page
`Function Get-UsefulPowershellCommands {Start-Process https://github.com/milosavljevicoa/useful-powershell-commands/blob/main/README.md}`

`Set-Alias -Name upc -Value Get-UsefulPowershellCommands`


`gci -r -fi '*.*' | Select FullName` - seacrh for a file (from current worknig directory) by matching a pattern and display its absolute path
