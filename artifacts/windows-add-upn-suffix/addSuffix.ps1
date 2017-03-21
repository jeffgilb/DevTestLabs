param(
      [Parameter(valueFromPipeline=$true)]
	  [String] $upnSuffix
)

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
    # Set parameters
	Import-Module ActiveDirectory 
	$LDAPpath = Get-ADDomain | select -ExpandProperty DistinguishedName    
	$fqdn=Get-WMIObject Win32_ComputerSystem  | Select-Object -ExpandProperty Domain

    # Add alternative upn suffix to domain 
	Set-ADForest -Identity $fqdn -UPNSuffixes @{Add=$upnSuffix}

    # Add alternative upn suffix to users
	$users = Get-ADUser -Filter {UserPrincipalName -like '*'} -SearchBase $LDAPpath
	foreach ($user in $users) { 
	    $userName = $user.UserPrincipalName.Split('@')[0] 
	    $UPN = $userName + "@" + $upnSuffix 
	    $user | Set-ADUser -UserPrincipalName $UPN
            $user | Set-ADUser -EmailAddress $UPN
            Write-Host $user.Name" set to "$UPN 
    }

}
finally
{
    popd
}
