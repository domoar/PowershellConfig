function GoToRepos {
    $Username = $env:USERNAME
    $Path = "C:\Users\$Username\source\repos"
    Set-Location $Path
}
Set-Alias -Name repos -Value GoToRepos

function GoToHome {
    $HomePath = $home
    Set-Location $HomePath
}
Set-Alias -Name home -Value GoToHome

function OpenInFileExplorer {
    Start-Process explorer.exe -ArgumentList $PWD
}
Set-Alias -Name fe -Value OpenInFileExplorer