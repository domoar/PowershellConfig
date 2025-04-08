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