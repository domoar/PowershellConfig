# =================================================
# PowerShell Module: Docker Shortcuts
# Requires Docker Desktop version 4.27 or higher
# Reference: https://docs.docker.com/desktop/features/desktop-cli/
# Author: Manuel Dausmann
# Created: 2025-04-07
# =================================================

<#
.SYNOPSIS
Checks whether Docker Desktop is currently running.

.DESCRIPTION
Uses the Docker CLI to determine whether Docker Desktop is currently running
by evaluating the output of 'docker desktop status'.

.EXAMPLE
Test-DockerDesktopRunning
Returns $true if Docker Desktop is running, otherwise $false.

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Test-DockerDesktopRunning {
    $statusOutput = docker desktop status 2>$null
    return ($statusOutput -match 'Status\s+running')
}

<#
.SYNOPSIS
Checks whether a docker-compose file exists in the current directory.

.DESCRIPTION
Looks for a file named docker-compose.yml or docker-compose.yaml
in the current working directory.

.EXAMPLE
Test-DockerComposeFile
Returns $true if a compose file is found, otherwise $false.

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Test-DockerComposeFile {
    $composeFile = Get-ChildItem -Path . -Filter "docker-compose.y*ml" -ErrorAction SilentlyContinue
    return [bool]$composeFile
}

<#
.SYNOPSIS
Checks if Docker Desktop meets the required minimum version.

.DESCRIPTION
Ensures that the installed version of Docker Desktop is at least 4.27.0.
Parses the version returned by 'docker version' and compares it to the minimum.

.EXAMPLE
Test-DockerDesktopVersion
Returns $true if Docker is installed and meets the version requirement.

.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
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
Starts Docker Compose in the current directory.

.DESCRIPTION
Runs 'docker compose up' if Docker Desktop is running and a valid
docker-compose file is found in the current directory. Checks for
version and runtime prerequisites before execution.

.EXAMPLE
Docker-Compose-Up
Starts containers defined in the current directory's compose file.

.NOTES
Alias: dcu
Author: Manuel Dausmann
Date: 2025-04-07
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
Stops Docker Compose containers in the current directory.

.DESCRIPTION
Runs 'docker compose down' if Docker Desktop is running and a valid
docker-compose file is found in the current directory.

.EXAMPLE
Docker-Compose-Down
Stops and removes containers defined in the docker-compose file.

.NOTES
Alias: dcd
Author: Manuel Dausmann
Date: 2025-04-07
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
Starts Docker Desktop if it is not running.

.DESCRIPTION
Checks if Docker Desktop is running. If not, attempts to start it
using 'docker desktop start'. Requires Docker CLI access.

.EXAMPLE
Docker-Desktop-Start
Starts Docker Desktop from PowerShell.

.NOTES
Alias: dds
Author: Manuel Dausmann
Date: 2025-04-07
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
Stops Docker Desktop if it is running.

.DESCRIPTION
Checks if Docker Desktop is currently running and stops it if so.

.EXAMPLE
Docker-Desktop-Stop
Stops the Docker Desktop service.

.NOTES
Alias: ddstop
Author: Manuel Dausmann
Date: 2025-04-07
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
Restarts Docker Desktop if it is running.

.DESCRIPTION
If Docker Desktop is running, restarts the application. Otherwise,
informs the user that it is not running and suggests starting it.

.EXAMPLE
Docker-Desktop-Restart
Restarts Docker Desktop if it's active.

.NOTES
Alias: ddres
Author: Manuel Dausmann
Date: 2025-04-07
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
