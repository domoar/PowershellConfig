# =================================================
# PowerShell Module: 7-Zip Archiving Utilities
# Requires: 7-Zip CLI (7z.exe) installed at default path
# TODO check custom Path?
# Author: Manuel Dausmann
# Created: 2025-04-07
# =================================================

<#
.SYNOPSIS
Unpacks a ZIP archive using 7-Zip CLI.

.DESCRIPTION
Extracts a `.zip` archive to a specified destination folder using the 7-Zip command-line tool.
If no destination is provided, a folder with the same name as the archive will be created
in the current directory.

.EXAMPLE
UnpackFileWith7Zip -ArchivePath "C:\Downloads\file.zip"
Unpacks file.zip to a folder named "file" in the current directory.

.EXAMPLE
UnpackFileWith7Zip -ArchivePath "C:\Downloads\file.zip" -DestinationPath "C:\Output"
Unpacks the contents of file.zip into C:\Output.

.NOTES
Requires: 7-Zip installed at "C:\Program Files\7-Zip\7z.exe"  
Author: Manuel Dausmann  
Date: 2025-04-07
#>
function UnpackFileWith7Zip {
    param (
        [Parameter(Mandatory)]
        [string]$ArchivePath,

        [Parameter(ValueFromPipeline)]
        [string]$DestinationPath
    )

    $zipPath = "C:\Program Files\7-Zip\7z.exe"
    
    if (!(Test-Path $ArchivePath)) {
        Write-Warning "File '$ArchivePath' not found."
        return
    }

    if (!($ArchivePath -match '\.zip$')) {
        Write-Warning "File '$ArchivePath' is not a valid zip file."
        return
    }

    if (-not $DestinationPath) {
        $DestinationPath = Get-Location
        $folderName = [System.IO.Path]::GetFileNameWithoutExtension($ArchivePath)
        $fullDestinationPath = Join-Path $DestinationPath $folderName
    }
    else {
        $fullDestinationPath = $DestinationPath
    }
    
    if (-not (Test-Path $fullDestinationPath)) {
        New-Item -Path $fullDestinationPath -ItemType Directory | Out-Null
    }

    & $zipPath x "$ArchivePath" -o"$fullDestinationPath" -aoa -r

    Write-Host "File unpacked to '$fullDestinationPath'."
}

<#
.SYNOPSIS
Packs a file or folder into a ZIP archive using 7-Zip CLI.

.DESCRIPTION
Uses the 7-Zip command-line interface to compress a file or folder into a `.zip` archive.
If no destination path is provided, the archive will be created in the current directory
using the base name of the source as the filename.

.EXAMPLE
PackFileWith7Zip -SourcePath "C:\Projects\MyApp"
Creates MyApp.zip in the current directory containing all contents of MyApp.

.EXAMPLE
PackFileWith7Zip -SourcePath "C:\Projects\MyApp" -DestinationPath "C:\Backups\MyAppBackup.zip"
Creates the archive at the specified destination.

.NOTES
Alias: pack  
Requires: 7-Zip installed at "C:\Program Files\7-Zip\7z.exe"  
Author: Manuel Dausmann  
Date: 2025-04-07
#>
function PackFileWith7Zip {
    param (
        [Parameter(Mandatory)]
        [string]$SourcePath,

        [string]$DestinationPath
    )

    if (-not $DestinationPath) {
        $fileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($SourcePath)
        $DestinationPath = Join-Path (Get-Location) -ChildPath "$fileNameWithoutExtension.zip"
    }

    $zipPath = "C:\Program Files\7-Zip\7z.exe"
    if (!(Test-Path $SourcePath)) {
        Write-Warning "Source path '$SourcePath' not found."
        return
    }

    & $zipPath a "$DestinationPath" "$SourcePath" -tzip

    Write-Host "File packed @ '$DestinationPath'."
}
