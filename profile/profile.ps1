$customModulePath = "$HOME\Documents\PowerShell\CustomModules"
if (-not ($env:PSModulePath -split ";" | Where-Object { $_ -eq $customModulePath })) {
    $env:PSModulePath += ";$customModulePath"
}

Import-Module VirtualBoxModule -Force -ErrorAction SilentlyContinue
Import-Module ShortcutModule -Force -ErrorAction SilentlyContinue
Import-Module DockerModule -Force -ErrorAction SilentlyContinue
Import-Module ZipModule -Force -ErrorAction SilentlyContinue
Import-Module VimModule -Force -ErrorAction SilentlyContinue
Import-Module UtilityModule -Force -ErrorAction SilentlyContinue

Set-AliasSafe -Name <> -Value <> -ErrorAction Stop  #TODO example for Aliases
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop
Set-AliasSafe -Name <> -Value <> -ErrorAction Stop

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" | Invoke-Expression
