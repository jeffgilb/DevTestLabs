<#
DESCRIPTION:
Download and install the Application Proxy connector to enable a secure connection between applications inside your network and the Application Proxy. Only one installation is necessary to service all your published applications; a second connector can be installed for high availability purposes.

More information:
https://docs.microsoft.com/en-us/azure/active-directory/active-directory-application-proxy-enable

Scripts from here:
# https://docs.microsoft.com/en-us/azure/active-directory/active-directory-application-proxy-silent-installation

#>

param(
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
    # Install Azure AD Application Proxy Connector
	.\AADApplicationProxyConnectorInstaller.exe REGISTERCONNECTOR="false" /q
	
    # Give the install a pause to complete and settle down
	start-sleep 30
	write-host "Installed Azure application proxy connector."

    # Get Azure AD tenant global admin credentials
	$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
	$cred = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $User, $SecurePassword
	#$cred = New-Object System.Management.Automation.PSCredential ($User,$SecurePassword)
	write-host "Trying $User to connect to Azure AD."

    # Register Azure AD Application Proxy Connector
	C:\"Program Files\Microsoft AAD App Proxy Connector"\RegisterConnector.ps1 -modulePath C:\"Program Files\Microsoft AAD App Proxy Connector"\Modules\ -moduleName AppProxyPSModule -Authenticationmode Credentials -Usercredentials $cred
	write-host "Registerd Azure AD Application Proxy Connector." 
}
finally
{
    popd
}