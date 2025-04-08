$customModulePath = "$HOME\Documents\PowerShell\CustomModules"
if (-not ($env:PSModulePath -split ";" | Where-Object { $_ -eq $customModulePath })) {
    $env:PSModulePath += ";$customModulePath"
}

Import-Module VirtualBoxModule -ErrorAction SilentlyContinue
Import-Module ShortcutModule -ErrorAction SilentlyContinue
Import-Module DockerModule -ErrorAction SilentlyContinue
Import-Module ZipModule -ErrorAction SilentlyContinue
Import-Module VimModule -ErrorAction SilentlyContinue
Import-Module UtilityModule -ErrorAction SilentlyContinue

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" | Invoke-Expression
