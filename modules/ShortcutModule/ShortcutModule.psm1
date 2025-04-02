# =================================================
# PowerShell Module to use shortcuts for navigation
# =================================================


<#

#>
function Go-To-Repos {
    $Username = $env:USERNAME
    $Path = "C:\Users\$Username\source\repos"
    Set-Location $Path
}
Set-Alias -Name repos -Value Go-To-Repos

<#

#>
function Go-To-Home {
    $HomePath = $home
    Set-Location $HomePath
}
Set-Alias -Name home -Value Go-To-Home

<#

#>
function Open-In-FileExplorer {
    Start-Process explorer.exe -ArgumentList $PWD
}
Set-Alias -Name fe -Value Open-In-FileExplorer

<#

#>
function SlideToShutDown{
    C:\Windows\System32\SlideToShutDown.exe
    exit
}
New-Alias -Name conexit -Value SlideToShutDown