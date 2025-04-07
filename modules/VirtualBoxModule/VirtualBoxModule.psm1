# =================================================
# PowerShell Module: VirtualBox Instance Manager
# Description: Start or stop VirtualBox VMs from PowerShell
# Author: Manuel Dausmann
# Created: 2025-04-07
# =================================================

<#
.SYNOPSIS
Stops one or all running VirtualBox virtual machines using ACPI power button.

.DESCRIPTION
Uses the VBoxManage CLI to gracefully shut down a running VM by triggering
an ACPI power event. If a VM name is provided, only that machine is shut down.
If no name is specified, all currently running VMs are shut down.

.EXAMPLE
Stop-VirtualBoxVM -VMName "MyVM"
Sends the ACPI shutdown signal to the VM named "MyVM".

.EXAMPLE
Stop-VirtualBoxVM
Sends the ACPI shutdown signal to all currently running VirtualBox VMs.

.NOTES
Alias: vboxstop  
Author: Manuel Dausmann  
Date: 2025-04-07
#>
function Stop-VirtualBoxVM {
    param (
        [string]$VMName
    )

    if (-not (Get-Command "VBoxManage.exe" -ErrorAction SilentlyContinue)) {
        Write-Error "VBoxManage.exe not found. Make sure VirtualBox is installed and VBoxManage is in your PATH."
        return
    }

    if ($VMName) {
        Write-Output "Attempting to shut down VM '$VMName'..."
        VBoxManage controlvm "$VMName" acpipowerbutton
    } else {
        $runningVMs = VBoxManage list runningvms | ForEach-Object {
            if ($_ -match '"(.+?)"') { $matches[1] }
        }

        if ($runningVMs.Count -eq 0) {
            Write-Output "No running virtual machines found."
            return
        }

        foreach ($vm in $runningVMs) {
            Write-Output "Shutting down VM '$vm'..."
            VBoxManage controlvm "$vm" acpipowerbutton
        }
    }
}
Set-Alias -Name vboxstop -Value Stop-VirtualBoxVM

<#
.SYNOPSIS
Starts a VirtualBox virtual machine in headless mode.

.DESCRIPTION
Launches a specified VM using VirtualBox's headless mode (without GUI). Validates
the presence of the VM before attempting to start it.

.EXAMPLE
Start-VirtualBoxVM -VMName "MyVM"
Starts the VirtualBox VM named "MyVM" in headless mode.

.NOTES
Alias: vboxstart  
Author: Manuel Dausmann  
Date: 2025-04-07
#>
function Start-VirtualBoxVM {
    param (
        [Parameter(Mandatory = $true)]
        [string]$VMName
    )

    if (-not (Get-Command "VBoxManage.exe" -ErrorAction SilentlyContinue)) {
        Write-Error "VBoxManage.exe not found. Make sure VirtualBox is installed and VBoxManage is in your PATH."
        return
    }

    $allVMs = VBoxManage list vms | ForEach-Object {
        if ($_ -match '"(.+?)"') { $matches[1] }
    }

    if (-not ($allVMs -contains $VMName)) {
        Write-Error "VM '$VMName' does not exist."
        return
    }

    Write-Output "Starting VM '$VMName' in headless mode..."
    VBoxManage startvm "$VMName" --type headless
}
Set-Alias -Name vboxstart -Value Start-VirtualBoxVM
