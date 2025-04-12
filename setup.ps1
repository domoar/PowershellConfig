# Load the C# DLL
$libPath = Join-Path -Path $PSScriptRoot -ChildPath "../build/ToolsLibrary.dll"
Add-Type -Path $libPath

# Requires Administrator privileges
<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Install-LatestPowerShell {
$username = Read-Host "Enter your username"
$username = $username + "-tools"

$jsonPath = "C:\user_info.json"
$userData = @{ username = $username }
$userData | ConvertTo-Json | Set-Content -Path $jsonPath

$userFolder = "C:\$username"
if (-Not (Test-Path -Path $userFolder)) {
    New-Item -Path $userFolder -ItemType Directory | Out-Null
    Write-Host "Created folder: $userFolder"
}

$psInstallDir = "C:\$username\PowerShell\latest"
if (-Not (Test-Path -Path $psInstallDir)) {
    New-Item -Path $psInstallDir -ItemType Directory | Out-Null
    Write-Host "Created folder: $psInstallDir"
}

$latestReleaseUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
$releaseData = Invoke-RestMethod -Uri $latestReleaseUrl

$asset = $releaseData.assets | Where-Object { $_.name -like "*win-x64.zip" } | Select-Object -First 1
$zipUrl = $asset.browser_download_url
$zipPath = "$env:TEMP\powershell-latest.zip"

Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
Write-Host "Downloaded PowerShell ZIP to $zipPath"

Expand-Archive -Path $zipPath -DestinationPath $psInstallDir -Force
Write-Host "Extracted PowerShell to $psInstallDir"

$pwshExe = Get-ChildItem -Path $psInstallDir -Recurse -Filter pwsh.exe | Select-Object -First 1

if ($pwshExe) {
    $pwshPath = $pwshExe.DirectoryName

    # Update system PATH
    $envPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    if (-not ($envPath -split ";" | Where-Object { $_ -eq $pwshPath })) {
        [System.Environment]::SetEnvironmentVariable("Path", "$envPath;$pwshPath", [System.EnvironmentVariableTarget]::Machine)
        Write-Host "Updated system PATH to include $pwshPath"
    } else {
        Write-Host "PATH already includes $pwshPath"
    }

    $userData = @{
        username = $username
        tools = @{
            powershell = $psVersion
        }
    }

    # Save JSON
    $userData | ConvertTo-Json -Depth 3 | Set-Content -Path $jsonPath
    Write-Host "Saved user info with PowerShell version to $jsonPath"
} else {
    Write-Warning "pwsh.exe not found in $psInstallDir"
}

Remove-Item -Path $zipPath -Force
Write-Host "Deleted ZIP file: $zipPath"
}

# Requires Administrator privileges
<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Install-NiceShell {
# Step 1: Install Oh My Posh using winget
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

# Step 2: Install a default Nerd Font
<#
<ref>https://ohmyposh.dev/docs/installation/windows</ref>
<ref>https://www.nerdfonts.com/font-downloads</ref>
#>
oh-my-posh font install "JetBrainsMono"

# Step 3: Configure PowerShell profile to initialize Oh My Posh

# Define the path to the PowerShell profile
$PROFILE_PATH = $PROFILE

# Check if the profile exists; if not, create it
if (!(Test-Path -Path $PROFILE_PATH)) {
    New-Item -ItemType File -Path $PROFILE_PATH -Force
}

# Add Oh My Posh initialization to the profile
Add-Content -Path $PROFILE_PATH -Value 'oh-my-posh init pwsh | Invoke-Expression'

# Reload the profile to apply changes
. $PROFILE_PATH


# TODO rmdir CustomModules then mkdir and rewrite
}

#TODO nodejs, python, dockerdesktop, vscode, dotnet sdk, windows terminal