# =================================================
# PowerShell Module: Docker Shortcuts
# Requires Docker Desktop version 4.37 or higher
# <ref>https://docs.docker.com/desktop/features/desktop-cli/</ref>
# =================================================

<#
.SYNOPSIS
Checks whether Docker Desktop is currently running.
#>
function Test-DockerDesktopRunning {
    $statusOutput = docker desktop status 2>$null
    return ($statusOutput -match 'Status\s+running')
}

<#
.SYNOPSIS
Checks whether a docker-compose.yml or .yaml file exists in the current directory.
#>
function Test-DockerComposeFile {
    $composeFile = Get-ChildItem -Path . -Filter "docker-compose.y*ml" -ErrorAction SilentlyContinue
    return [bool]$composeFile
}

<#
.SYNOPSIS
Checks if the installed Docker Desktop version meets the minimum required version.
#>
function Test-DockerDesktopVersion {
    $requiredVersion = [version]"4.27.0"
    $installedVersion = docker version --format '{{.Server.Version}}' 2>$null

    if (-not $installedVersion) {
        Write-Warning "Docker is not installed or not available in PATH."
        return $false
    }

    try {
        $parsedVersion = [version]$installedVersion
    } catch {
        Write-Warning "Could not parse Docker version string: $installedVersion"
        return $false
    }

    return ($parsedVersion -ge $requiredVersion)
}

<#
.SYNOPSIS
Runs `docker compose up` if Docker Desktop is running and a compose file is present.
#>
function Docker-Compose-Up {
    if (-not (Test-DockerDesktopVersion)) {
        Write-Warning "[Abort] Docker Desktop version 4.27 or higher is required."
        return
    }

    if (-not (Test-DockerDesktopRunning)) {
        Write-Host "[Would run] Docker Desktop is not running. Would execute: docker desktop start"
    }

    if (-not (Test-DockerComposeFile)) {
        Write-Host "[Skip] No docker-compose.yml file found in the current directory."
        return
    }

    docker compose up
}
Set-Alias -Name dcu -Value Docker-Compose-Up

<#
.SYNOPSIS
Runs `docker compose down` if Docker Desktop is running and a compose file is present.
#>
function Docker-Compose-Down {
    if (-not (Test-DockerDesktopVersion)) {
        Write-Warning "[Abort] Docker Desktop version 4.27 or higher is required."
        return
    }

    if (-not (Test-DockerDesktopRunning)) {
        Write-Host "[Would skip] Docker Desktop is not running. No need to run docker compose down."
        return
    }

    if (-not (Test-DockerComposeFile)) {
        Write-Host "[Skip] No docker-compose.yml file found in the current directory."
        return
    }

    docker compose down
}
Set-Alias -Name dcd -Value Docker-Compose-Down

<#
.SYNOPSIS
Starts Docker Desktop if it is not already running.
#>
function Docker-Desktop-Start {
    if (-not (Test-DockerDesktopVersion)) {
        Write-Warning "[Abort] Docker Desktop version 4.27 or higher is required."
        return
    }

    if (Test-DockerDesktopRunning) {
        Write-Host "[Would skip] Docker Desktop is already running."
        return
    }

    docker desktop start
}
Set-Alias -Name dds -Value Docker-Desktop-Start

<#
.SYNOPSIS
Stops Docker Desktop if it is currently running.
#>
function Docker-Desktop-Stop {
    if (-not (Test-DockerDesktopVersion)) {
        Write-Warning "[Abort] Docker Desktop version 4.27 or higher is required."
        return
    }

    if (-not (Test-DockerDesktopRunning)) {
        Write-Host "[Would skip] Docker Desktop is not running."
        return
    }
    
    docker desktop stop
}
Set-Alias -Name ddstop -Value Docker-Desktop-Stop

<#
.SYNOPSIS
Restarts Docker Desktop if it is running, otherwise suggests starting it.
#>
function Docker-Desktop-Restart {
    if (-not (Test-DockerDesktopVersion)) {
        Write-Warning "[Abort] Docker Desktop version 4.27 or higher is required."
        return
    }

    if (Test-DockerDesktopRunning) {
        docker desktop restart
    } else {
        Write-Host "[Would run] Docker Desktop is not running. Would execute: docker desktop start"
    }
}
Set-Alias -Name ddres -Value Docker-Desktop-Restart
