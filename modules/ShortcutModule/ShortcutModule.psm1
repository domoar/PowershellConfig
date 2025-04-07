# =================================================
# PowerShell Module to use shortcuts for navigation
# =================================================

<#
.SYNOPSIS
Navigates to the user's default source/repos (VisualStudio) directory.
#>
function Go-To-Repos {
    $Username = $env:USERNAME
    $Path = "C:\Users\$Username\source\repos"
    Set-Location $Path
}
Set-Alias -Name repos -Value Go-To-Repos

<#
.SYNOPSIS
Navigates to the user's home directory. (=> cd)
#>
function Go-To-Home {
    $HomePath = $home
    Set-Location $HomePath
}
Set-Alias -Name home -Value Go-To-Home

<#
.SYNOPSIS
Opens the current directory in File Explorer.
#>
function Open-In-FileExplorer {
    Start-Process explorer.exe -ArgumentList $PWD
}
Set-Alias -Name fe -Value Open-In-FileExplorer
