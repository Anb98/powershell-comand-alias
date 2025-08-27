# =============================================================================
# PowerShell Profile - Custom Aliases & Functions
# =============================================================================
# This file contains custom aliases and helper functions to speed up
# the daily development workflow.

# -----------------------------------------------------------------------------
# Git Operations
# -----------------------------------------------------------------------------

# --- Function-based Aliases ---

# Pulls the latest changes from the remote repository.
function Invoke-GitPull { git pull }
Set-Alias -Name gpl -Value Invoke-GitPull -Option AllScope

# Pushes local commits to the remote repository.
function Invoke-GitPush { git push }
Set-Alias -Name gpsh -Value Invoke-GitPush -Option AllScope

# Shows the current status of the repository.
function Invoke-GitStatus { git status }
Set-Alias -Name gst -Value Invoke-GitStatus -Option AllScope

# Stashes changes that are not ready for a commit.
function Invoke-GitStashSave { git stash }
Set-Alias -Name gss -Value Invoke-GitStashSave -Option AllScope

# Applies the last stash and removes it from the list.
function Invoke-GitStashPop { git stash pop }
Set-Alias -Name gsp -Value Invoke-GitStashPop -Option AllScope

# Switches to a specific branch.
function Invoke-GitCheckout {
    param([string]$branchName)
    git checkout $branchName
}
Set-Alias -Name gco -Value Invoke-GitCheckout -Option AllScope

# Switches to the 'develop' branch.
function Invoke-GitCheckoutDevelop {
    Write-Host "🏃 Switching to 'develop' branch..." -ForegroundColor Cyan
    git checkout develop
}
Set-Alias -Name gcd -Value Invoke-GitCheckoutDevelop -Option AllScope

# Creates and switches to a new branch.
function Invoke-GitNewBranch {
    param([string]$branchName)
    git checkout -b $branchName
}
Set-Alias -Name gnb -Value Invoke-GitNewBranch -Option AllScope

# Syncs the current branch with the latest changes from 'develop'.
function Invoke-GitSyncWithDevelop {
    param([string]$currentBranch = (git rev-parse --abbrev-ref HEAD))
    Write-Host "🔄 Syncing with 'develop'..." -ForegroundColor Cyan
    git stash
    git checkout develop
    git pull
    Write-Host "Merging 'develop' into '$currentBranch'..." -ForegroundColor Cyan
    git checkout $currentBranch
    git merge develop
    git stash pop
}
Set-Alias -Name gsync -Value Invoke-GitSyncWithDevelop -Option AllScope

# Deletes all local branches except for protected ones.
function Invoke-GitPruneLocalBranches {
    $protectedBranches = @("main", "master", "develop", "staging")
    Write-Host "🧹 Searching for local branches to prune..." -ForegroundColor Yellow

    # Get and delete unprotected branches
    git branch | ForEach-Object { $_.Trim() } | Where-Object {
        $branchName = $_.Replace("* ", "") # Remove the asterisk from the current branch
        $protectedBranches -notcontains $branchName -and $branchName -ne ""
    } | ForEach-Object {
        Write-Host "❌ Deleting branch: $_" -ForegroundColor Red
        git branch -D $_
    }

    Write-Host "✅ Branch cleanup complete!" -ForegroundColor Green
}
Set-Alias -Name gprune -Value Invoke-GitPruneLocalBranches -Option AllScope

# -----------------------------------------------------------------------------
# Infisical Operations
# -----------------------------------------------------------------------------

# Runs a command using Infisical environment variables.
function Invoke-InfisicalRun {
    # The '--' separates Infisical's options from the command to be executed.
    infisical run -- $args
}
Set-Alias -Name irun -Value Invoke-InfisicalRun -Option AllScope

# Runs a command using the 'prod' environment in Infisical.
function Invoke-InfisicalRunProd {
    infisical run --env=prod -- $args
}
Set-Alias -Name irunp -Value Invoke-InfisicalRunProd -Option AllScope

# Runs a command using the 'staging' environment in Infisical.
function Invoke-InfisicalRunStaging {
    infisical run --env=staging -- $args
}
Set-Alias -Name iruns -Value Invoke-InfisicalRunStaging -Option AllScope

# -----------------------------------------------------------------------------
# Yarn Operations
# -----------------------------------------------------------------------------

# Base alias for yarn. Allows 'y add <package>'.
Set-Alias -Name y -Value yarn -Option AllScope

# Starts the development server.
function Invoke-YarnDev { yarn dev }
Set-Alias -Name yd -Value Invoke-YarnDev -Option AllScope

# Runs the start script.
function Invoke-YarnStart { yarn start }
Set-Alias -Name ys -Value Invoke-YarnStart -Option AllScope

# -----------------------------------------------------------------------------
# Directory Navigation
# -----------------------------------------------------------------------------

function GoTo-WorkApp { cd E:\Work\vitee-app }
Set-Alias -Name work:app -Value GoTo-WorkApp -Option AllScope

function GoTo-WorkBackend { cd E:\Work\vitee-backend }
Set-Alias -Name work:be -Value GoTo-WorkBackend -Option AllScope

function GoTo-WorkBackoffice { cd E:\Work\vitee-backoffice }
Set-Alias -Name work:bo -Value GoTo-WorkBackoffice -Option AllScope

function GoTo-WorkAdminFE { cd E:\Work\vitee-admin-frontend }
Set-Alias -Name work:afe -Value GoTo-WorkAdminFE -Option AllScope

function GoTo-WorkAdminBE { cd E:\Work\vitee-admin-backend }
Set-Alias -Name work:abe -Value GoTo-WorkAdminBE -Option AllScope

# -----------------------------------------------------------------------------
# Repository Cloning
# -----------------------------------------------------------------------------

# Clones a repository from the 'workgit' remote.
function Invoke-GitCloneWork {
    param([string]$repoPath)
    git clone "workgit:$repoPath"
}
Set-Alias -Name gclonew -Value Invoke-GitCloneWork -Option AllScope

# Clones a repository from the 'personalgit' remote.
function Invoke-GitClonePersonal {
    param([string]$repoPath)
    git clone "personalgit:$repoPath"
}
Set-Alias -Name gclonep -Value Invoke-GitClonePersonal -Option AllScope


# Lists all custom aliases defined in this profile in a documentation-style table.
function Show-MyAliases {
    Write-Host "📜 Custom Aliases Defined in this Profile:" -ForegroundColor Green

    $aliasList = @(
        [PSCustomObject]@{Alias='gpl'; OriginalCommand='git pull'; Description='Downloads the latest changes from the remote repository.'},
        [PSCustomObject]@{Alias='gpsh'; OriginalCommand='git push'; Description='Pushes your local commits to the remote repository.'},
        [PSCustomObject]@{Alias='gst'; OriginalCommand='git status'; Description='Displays the current status of the repository.'},
        [PSCustomObject]@{Alias='gss'; OriginalCommand='git stash'; Description='Temporarily saves changes that are not ready for a commit.'},
        [PSCustomObject]@{Alias='gsp'; OriginalCommand='git stash pop'; Description='Applies the latest "stash" and removes it from the list.'},
        [PSCustomObject]@{Alias='gch'; OriginalCommand='git checkout <branch>'; Description='Switches to the specified branch.'},
        [PSCustomObject]@{Alias='gcd'; OriginalCommand='git checkout develop'; Description='Quickly switches to the `develop` branch.'},
        [PSCustomObject]@{Alias='gnb'; OriginalCommand='git checkout -b <branch>'; Description='Creates and switches to a new branch.'},
        [PSCustomObject]@{Alias='gsync'; OriginalCommand='Function'; Description='Synchronizes the current branch with the latest changes from `develop`.'},
        [PSCustomObject]@{Alias='gprune'; OriginalCommand='Function'; Description='Deletes all local branches except protected ones.'},
        [PSCustomObject]@{Alias='irun'; OriginalCommand='infisical run -- <command>'; Description='Runs a command using Infisical environment variables.'},
        [PSCustomObject]@{Alias='irunp'; OriginalCommand='infisical run --env=prod -- <command>'; Description='Runs a command with Infisical production environment.'},
        [PSCustomObject]@{Alias='iruns'; OriginalCommand='infisical run --env=staging -- <command>'; Description='Runs a command with Infisical staging environment.'},
        [PSCustomObject]@{Alias='y'; OriginalCommand='yarn'; Description='Base alias for yarn. Allows `y add <package>`.'},
        [PSCustomObject]@{Alias='yd'; OriginalCommand='yarn dev'; Description='Starts the development server.'},
        [PSCustomObject]@{Alias='ys'; OriginalCommand='yarn start'; Description='Runs the project `start` script.'},
        [PSCustomObject]@{Alias='gclonew'; OriginalCommand='git clone workgit:<repo>'; Description='Clones a repository from the work remote.'},
        [PSCustomObject]@{Alias='gclonep'; OriginalCommand='git clone personalgit:<repo>'; Description='Clones a repository from the personal remote.'},
        [PSCustomObject]@{Alias='lsa'; OriginalCommand='Function'; Description='Displays this list of custom aliases.'}
    )

    # Display the data in a formatted table with custom headers
    $aliasList | Sort-Object Alias | Format-Table -Property @{Name="Alias"; Expression={$_.Alias}}, @{Name="Original Command"; Expression={$_.OriginalCommand}}, @{Name="Description"; Expression={$_.Description}} -AutoSize
}
Set-Alias -Name lsa -Value Show-MyAliases -Option AllScope