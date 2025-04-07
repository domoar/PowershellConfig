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
        New-Item -Path $fullDestinationPath -ItemType Directory
    }

    & $zipPath x "$ArchivePath" -o"$fullDestinationPath" -aoa -r

    Write-Host "File unpacked to '$fullDestinationPath'."
}
Set-Alias unpack UnpackFileWith7Zip

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
Set-Alias -Name pack -Value PackFileWith7Zip