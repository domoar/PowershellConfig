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

Set-AliasSafe -Name unpack -Value UnpackFileWith7Zip ErrorAction Stop  #TODO example for Aliases
Set-AliasSafe -Name pack -Value PackFileWith7Zip -ErrorAction Stop
Set-AliasSafe -Name vboxstop -Value Stop-VirtualBoxVM -ErrorAction Stop
Set-AliasSafe -Name vboxstart -Value Start-VirtualBoxVM -ErrorAction Stop
Set-AliasSafe -Name shred -Value Remove-FolderSafe -ErrorAction Stop
Set-AliasSafe -Name repos -Value Set-ReposDirectory -ErrorAction Stop
Set-AliasSafe -Name home -Value Set-HomeDirectory -ErrorAction Stop
Set-AliasSafe -Name conexit -Value Slide-ToShutDown -ErrorAction Stop
Set-AliasSafe -Name up -Value Go-Up-N-Directories -ErrorAction Stop
Set-AliasSafe -Name recent -Value GetFile-RecentCommands -ErrorAction Stop
Set-AliasSafe -Name dcu -Value Docker-Compose-Up -ErrorAction Stop
Set-AliasSafe -Name dcd -Value Docker-Compose-Down -ErrorAction Stop
Set-AliasSafe -Name ddstart -Value Docker-Desktop-Start -ErrorAction Stop
Set-AliasSafe -Name ddstop -Value Docker-Desktop-Stop -ErrorAction Stop
Set-AliasSafe -Name ddres -Value Docker-Desktop-Restart -ErrorAction Stop
Set-AliasSafe -Name <> -Value Git-DisplayLog -ErrorAction Stop
Set-AliasSafe -Name <> -Value Git-ForcePush -ErrorAction Stop
Set-AliasSafe -Name <> -Value Git-Cleanup -ErrorAction Stop
Set-AliasSafe -Name <> -Value Git-CreateAndCheckoutNewBranch -ErrorAction Stop
Set-AliasSafe -Name <> -Value Git-RevertLastCommit -ErrorAction Stop
Set-AliasSafe -Name <> -Value Git-CurrentBranch -ErrorAction Stop
Set-AliasSafe -Name <> -Value Git-UpdateBranch -ErrorAction Stop
Set-AliasSafe -Name <> -Value Git-AddAllAndCommit -ErrorAction Stop
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" | Invoke-Expression


Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

Set-PSReadlineOption -MaximumHistoryCount 100000

function ls_git { & '$env:GIT_HOME\usr\bin\ls' --color=auto -hF $args -l -a }
    Set-Alias -Name ls -Value ls_git