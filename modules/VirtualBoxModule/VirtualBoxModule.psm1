# =================================================
# PowerShell Module to manage Virtualbox instances
# =================================================


<#

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

