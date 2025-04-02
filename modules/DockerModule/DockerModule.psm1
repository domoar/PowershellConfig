# =================================================
# PowerShell Module: Docker Shortcuts
# =================================================

function Test-DockerDesktopRunning {
    $statusOutput = docker desktop status 2>$null
    return ($statusOutput -match 'Status\s+running')
}

function Test-DockerComposeFile {
    $composeFile = Get-ChildItem -Path . -Filter "docker-compose.y*ml" -ErrorAction SilentlyContinue
    if (-not $composeFile) {
        return $false
    }

    return $true
}

function Docker-Compose-Up {
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

function Docker-Compose-Down {
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

function Docker-Desktop-Start {
    if (Test-DockerDesktopRunning) {
        Write-Host "[Would skip] Docker Desktop is already running."
        return
    }
    docker desktop start
}
Set-Alias -Name dds -Value Docker-Desktop-Start

function Docker-Desktop-Stop {
    if (-not (Test-DockerDesktopRunning)) {
        Write-Host "[Would skip] Docker Desktop is not running."
        return
    }
    
    docker desktop stop
}
Set-Alias -Name ddstop -Value Docker-Desktop-Stop

function Docker-Desktop-Restart {
    if (Test-DockerDesktopRunning) {
        docker desktop restart
    } else {
        Write-Host "[Would run] Docker Desktop is not running. Would execute: docker desktop start"
    }
}
Set-Alias -Name ddres -Value Docker-Desktop-Restart
