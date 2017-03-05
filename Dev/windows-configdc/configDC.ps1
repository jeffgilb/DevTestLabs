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
#Copy Bginfo config file to sysinternals directory & place shortcut in StartUp folder
Copy-Item .\Bginfo.bgi "C:\ProgramData\chocolatey\lib\sysinternals\tools\Bginfo.bgi"
Copy-Item .\Bginfo.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"

# Turn off IE Enhanced Security Configuration
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
# Stop-Process -Name Explorer

# Install Active Directory Users and Computers
Import-Module ServerManager
Add-WindowsFeature RSAT-ADDS-Tools

# Set AD Web Service to delayed start. 
# This avoids getting an error when trying to add directory objects: "This computer is now hosting the specified directory instance, but Active Directory Web Services could not service it. Active Directory Web Services will retry this operation periodically"
# Set-ItemProperty -Path "Registry::HKLM\System\CurrentControlSet\Services\ADWS" -Name "DelayedAutostart" -Value 1 -Type DWORD
}
finally
{
    popd
}
