###################################################################################################

#
# PowerShell configurations
#

# NOTE: Because the $ErrorActionPreference is "Stop", this script will stop on first failure.
#       This is necessary to ensure we capture errors inside the try-catch-finally block.
$ErrorActionPreference = "Stop"

# Ensure we set the working directory to that of the script.
pushd $PSScriptRoot

###################################################################################################

#
# Functions used in this script.
#

function Handle-LastError
{
    [CmdletBinding()]
    param(
    )

    $message = $error[0].Exception.Message
    if ($message)
    {
        Write-Host -Object "ERROR: $message" -ForegroundColor Red
    }
    
    # IMPORTANT NOTE: Throwing a terminating error (using $ErrorActionPreference = "Stop") still
    # returns exit code zero from the PowerShell script when using -File. The workaround is to
    # NOT use -File when calling this script and leverage the try-catch-finally block and return
    # a non-zero exit code from the catch block.
    exit -1
}

###################################################################################################

#
# Handle all errors in this script.
#

trap
{
    # NOTE: This trap will handle all errors. There should be no need to use a catch below in this
    #       script, unless you want to ignore a specific error.
    Handle-LastError
}

###################################################################################################

#
# Main execution block.
#

try
{
    # Install Microsoft Online Services Sign-In Assistant for IT Professionals RTW from http://go.microsoft.com/fwlink/?LinkID=286152
    $Uri="https://www.microsoft.com/en-us/download/confirmation.aspx?id=41950"
    $Path="C:\Packages\msoidcli_64.msi"
    $TimeoutSec=30
    # Ensure the path is available.
    if (-not [System.IO.Path]::IsPathRooted($Path))
    {
        $Path = Join-Path $Env:Temp $Path
    }
    Write-Host "Ensuring local path $Path"
    New-Item -ItemType Directory -Force -Path (Split-Path -parent $Path) | Out-Null

    # Download requested file.
    Write-Host "Downloading Microsoft Online Services Sign-In Assistant for IT Professionals from $Uri to C:\Packages\."
    Invoke-WebRequest -Uri $Uri -OutFile $Path -TimeoutSec $TimeoutSec

   # Install Azure AD PowerShell cmdlets http://go.microsoft.com/fwlink/p/?linkid=236297
    $Uri="http://go.microsoft.com/fwlink/p/?linkid=236297"
    $Path="C:\Packages\AdministrationConfig-en.msi"
    $TimeoutSec=30
    # Ensure the path is available.
    if (-not [System.IO.Path]::IsPathRooted($Path))
    {
        $Path = Join-Path $Env:Temp $Path
    }
    Write-Host "Ensuring local path $Path"
    New-Item -ItemType Directory -Force -Path (Split-Path -parent $Path) | Out-Null

    # Download requested file.
    Write-Host "Downloading Azure AD PowerShell cmdlets from $Uri to C:\Packages\."
    Invoke-WebRequest -Uri $Uri -OutFile $Path -TimeoutSec $TimeoutSec

   # Kick off the installs for all users.
    C:\Packages\AdministrationConfig-en.msi /passive ALLUSERS=1
    Write-Host "Successfully installed Microsoft Online Services Sign-In Assistant."
    
    C:\Packages\AdministrationConfig-en.msi /passive ALLUSERS=1
    Write-Host "Successfully installed Azure AD PowerShell cmdlets."
}
finally
{
    popd
}
