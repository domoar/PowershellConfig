$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$modulesPath = Join-Path $scriptRoot "modules"

Get-ChildItem -Path $modulesPath -Directory | ForEach-Object {
    $moduleFolder = $_.FullName
    $moduleName = $_.Name

    $psm1Path = Join-Path $moduleFolder "$moduleName.psm1"
    $psd1Path = Join-Path $moduleFolder "$moduleName.psd1"

    if (-not (Test-Path $psd1Path)) {
        if (-not (Test-Path $psm1Path)) {
            Write-Warning "No .psm1 file found in module '$moduleName'. Manifest will not be created."
            return
        }

        Write-Host "Creating manifest for module '$moduleName'..."

        New-ModuleManifest `
            -Path $psd1Path `
            -RootModule "$moduleName.psm1" `
            -ModuleVersion "1.0.0" `
            -Author "domoar (Manuel Dausmann)" `
            -Description "manifest for $moduleName" `
            -PowerShellVersion "7.5"
            -PassThru
    }
    else {
        Write-Host "Manifest for '$moduleName' already exists."
    }
}
