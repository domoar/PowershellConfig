# =================================================
# PowerShell Module: Shortcuts for Quick Navigation and Utilities
# Author: Manuel Dausmann
# Created: 2025-04-07
# =================================================

<#
.SYNOPSIS
Navigates to the current user's Visual Studio "source\repos" directory.

.DESCRIPTION
Changes the current working directory to the default Visual Studio
repository path located at "C:\Users\<Username>\source\repos".

.EXAMPLE
Go-To-Repos
Navigates to the default Visual Studio repositories folder.

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Set-ReposDirectory {
    $Username = $env:USERNAME
    $Path = "C:\Users\$Username\source\repos"
    Set-Location $Path
}
Set-Alias -Name repos -Value Set-ReposDirectory

<#
.SYNOPSIS
Navigates to the user's home directory.

.DESCRIPTION
Changes the current directory to the user's home folder. This is a shortcut
for quickly returning to the root personal directory (e.g., Documents, Downloads).

.EXAMPLE
Go-To-Home
Navigates to the user's home directory.

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Set-HomeDirectory {
    $HomePath = $home
    Set-Location $HomePath
}
Set-Alias -Name home -Value Set-HomeDirectory

<#
.SYNOPSIS
Opens the current directory in File Explorer.

.DESCRIPTION
Launches Windows File Explorer and opens it in the directory specified by
the current working location of the PowerShell session.

.EXAMPLE
Open-In-FileExplorer
Opens the folder where the command is executed in File Explorer.

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Open-In-FileExplorer {
    Start-Process explorer.exe -ArgumentList $PWD
}
Set-Alias -Name fe -Value Open-In-FileExplorer

<#
.SYNOPSIS
Starts the Windows Slide to Shutdown screen.

.DESCRIPTION
Executes the Windows SlideToShutDown feature, which provides a touch-friendly
interface to initiate shutdown. Suitable for tablets or touchscreen devices.

.EXAMPLE
SlideToShutDown
Launches the slide-to-shutdown screen and exits the current PowerShell session.

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function SlideToShutDown {
    C:\Windows\System32\SlideToShutDown.exe
    exit
}
New-Alias -Name conexit -Value SlideToShutDown

<#
.SYNOPSIS
Navigates -n directories up from the current working directory

.DESCRIPTION
Changes the current working directory to -n 

.EXAMPLE

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Go-Up-N-Directories{
    param([int]$levels = 1)
        for ($i = 0; $i -lt $levels; $i++) {
            Set-Location ..
        }
}
Set-Alias -Name up -Value Go-Up-N-Directories