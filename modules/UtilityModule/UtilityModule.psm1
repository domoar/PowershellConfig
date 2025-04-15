# =================================================
# PowerShell Module: Utility shortcuts
# Author: Manuel Dausmann
# Created: 2025-04-07
# =================================================

function Remove-FolderSafe {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -Path $Path -PathType Container)) {
        Write-Host "The folder '$Path' does not exist." -ForegroundColor Red
        return
    }

    $items = Get-ChildItem -Path $Path
    if ($items.Count -gt 0) {
        Write-Host "The folder contains files or subfolders." -ForegroundColor Yellow
        $confirm = Read-Host "Do you want to delete it? (y/n)"
        if ($confirm -eq 'y') {
            Remove-Item -Path $Path -Recurse -Force
            Write-Host "Folder has been deleted." -ForegroundColor Green
        }
        else {
            Write-Host "Operation cancelled." -ForegroundColor Yellow
        }
    }
    else {
        $confirm = Read-Host "The folder is empty. Do you still want to delete it? (y/n)"
        if ($confirm -eq 'y') {
            Remove-Item -Path $Path -Force
            Write-Host "Folder has been deleted." -ForegroundColor Green
        }
        else {
            Write-Host "Operation cancelled." -ForegroundColor Yellow
        }
    }
}