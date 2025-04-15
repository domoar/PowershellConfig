<#
.SYNOPSIS


.DESCRIPTION

.EXAMPLE

.EXAMPLE


.NOTES
Alias: none  
Requires: <>
Author: Manuel Dausmann  
Date: 2025-04-07
#>
function Set-AliasSafe {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)][string]$Value,
        [System.Management.Automation.ActionPreference]$ErrorAction = 'Stop'
    )

    try {
        if (-not (Get-Command -Name $Value -CommandType Function -ErrorAction SilentlyContinue)) {
            Write-Warning "Function '$Value' not found. Alias '$Name' was not set."
            return
        }

        $existing = Get-Alias -Name $Name -ErrorAction SilentlyContinue

        if (-not $existing) {
            Set-Alias -Name $Name -Value $Value -ErrorAction $ErrorAction
        }
        elseif ($existing.Definition -eq $Value) { }
        else {
            Write-Warning "Alias '$Name' already exists and points to '$($existing.Definition)', not '$Value'."
            # OVERRIDEIF: Set-Alias -Name $Name -Value $Value -Force -ErrorAction $ErrorAction
        }
    }
    catch {
        Write-Error "Failed to set alias '$Name': $_"
    }
}
