###################################################################################################
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
# Handle all errors in this script.
#
trap
{
    # NOTE: This trap will handle all errors. There should be no need to use a catch below in this
    #       script, unless you want to ignore a specific error.
    Handle-LastError
}
###################################################################################################
# Main execution block.
try
{
# More inforamtion: https://docs.microsoft.com/en-us/azure/active-directory/connect/active-directory-aadconnect
# The following is a list of components that Azure AD Connect installs on the server where Azure AD Connect is installed. This list is for a basic Express installation. If you choose to use a different SQL Server on the Install synchronization services page, then SQL Express LocalDB is not installed locally.+  
# • Azure AD Connect Health
# • Microsoft Online Services Sign-In Assistant for IT Professionals (installed but no dependency on it)
# • Microsoft SQL Server 2012 Command Line Utilities
# • Microsoft SQL Server 2012 Express LocalDB
# • Microsoft SQL Server 2012 Native Client
# • Microsoft Visual C++ 2013 Redistribution Package

    $Uri="https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi"
    $Path="C:\Packages\AzureADConnect.msi"
    
    # Ensure the path is available.
    if (-not [System.IO.Path]::IsPathRooted($Path))
    {
        $Path = Join-Path $Env:Temp $Path
    }
    Write-Host "Ensuring local path $Path"
    New-Item -ItemType Directory -Force -Path (Split-Path -parent $Path) | Out-Null

    # Download requested file.
    Write-Host "Downloading file from $Uri"
    Invoke-WebRequest -Uri $Uri -OutFile $Path -TimeoutSec $TimeoutSec

    $Path + " /passive"
}
finally
{
    popd
}