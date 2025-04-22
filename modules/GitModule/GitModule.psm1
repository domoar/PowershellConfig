<#
.SYNOPSIS
.DESCRIPTION
.EXAMPLE
.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Git-DisplayLog {
    git log --oneline --graph --decorate --all
}

<#
.SYNOPSIS
.DESCRIPTION
.EXAMPLE
.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Git-ForcePush {
    $confirm = Read-Host "Force Push to branch? Type 'yes' to confirm"
    if ($confirm -eq 'yes') {
        git push --force
    } else {
        Write-Host "Aborted."
    }
}

<#
.SYNOPSIS
.DESCRIPTION
.EXAMPLE
.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Git-Cleanup {
    git remote prune origin
    git branch -vv | Where-Object { $_ -match '\[origin/.+\: gone\]' } |
    ForEach-Object {
        $branch = ($_ -split '\s+')[0]
        git branch -d $branch
    }
}

<#
.SYNOPSIS
.DESCRIPTION
.EXAMPLE
.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Git-CreateAndCheckoutNewBranch {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name
    )
    git checkout -b $Name
}

<#
.SYNOPSIS
.DESCRIPTION
.EXAMPLE
.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Git-RevertLastCommit {
    git reset --soft HEAD~1
}

<#
.SYNOPSIS
.DESCRIPTION
.EXAMPLE
.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Git-CurrentBranch {
    git rev-parse --abbrev-ref HEAD
}

<#
.SYNOPSIS
.DESCRIPTION
.EXAMPLE
.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Git-UpdateBranch {
    param (
        [string]$Branch = "main"
    )
    git checkout $Branch
    git pull origin $Branch
}

<#
.SYNOPSIS
.DESCRIPTION
.EXAMPLE
.NOTES
Author: Manuel Dausmann
Date: 2025-04-07
#>
function Git-AddAllAndCommit {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    git add .
    git commit -m "$Message"
}
