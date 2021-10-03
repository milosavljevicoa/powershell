# Useful Powershell Commands

If you want to easily go to this page, open `~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` and add the following commands:
- `Function Get-UsefulPowershellCommands {Start-Process https://github.com/milosavljevicoa/useful-powershell-commands/blob/main/README.md}`
- `Set-Alias -Name upc -Value Get-UsefulPowershellCommands`

then just simply reaload your powershell and enter 'upc', voila, your browser will open up with this page.

`gci -r -fi '*.*' | Select FullName` - seacrh for a file (from current worknig directory) by matching a pattern and display its absolute path
