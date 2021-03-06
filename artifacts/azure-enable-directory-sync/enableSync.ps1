﻿param(
      [Parameter(Mandatory = $true,valueFromPipeline=$true)]
	  [string] $User,
      [Parameter(Mandatory = $true,valueFromPipeline=$true)]
	  [string] $Password
)

###################################################################################################
# PowerShell configurations
# NOTE: Because the $ErrorActionPreference is "Stop", this script will stop on first failure.
#       This is necessary to ensure we capture errors inside the try-catch-finally block.
$ErrorActionPreference = "Stop"

# Ensure we set the working directory to that of the script.
pushd $PSScriptRoot
###################################################################################################
# Functions used in this script.
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
    # Authenticate to Azure AD as global admin
	$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
	$msolcred = New-Object –TypeName System.Management.Automation.PSCredential ($User,$SecurePassword)
	connect-msolservice -credential $msolcred
    	write-host "Connected to Azure AD as $User."

    # Enable directory sync
	Set-MsolDirSyncEnabled –EnableDirSync $true -Force
    	write-host "Directory integration enabled!"

}
finally
{
    popd
}