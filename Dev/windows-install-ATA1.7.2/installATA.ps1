param(
      [Parameter(Mandatory = $true,valueFromPipeline=$true)]
	  [string] $CenterIpAddress,
      [Parameter(Mandatory = $true,valueFromPipeline=$true)]
	  [string] $CenterPort,
      [Parameter(Mandatory = $true,valueFromPipeline=$true)]
	  [string] $ConsoleIP,
      [Parameter(Mandatory = $true,valueFromPipeline=$true)]
	  [string] $ATAadmin
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
    $Path = "C:\Packages\Microsoft ATA Center Setup.exe"
    $Uri = "https://adevtestlabdev1569.blob.core.windows.net/files/Microsoft%20ATA%20Center%20Setup.exe"
    $TimeoutSec = 30

   # Ensure the path is available.
    if (-not [System.IO.Path]::IsPathRooted($Path))
    {
        $Path = Join-Path $Env:Temp $Path
    }
    Write-Host "Ensuring local path $Path"
    New-Item -ItemType Directory -Force -Path (Split-Path -parent $Path) | Out-Null

   # Download requested file.
	Invoke-WebRequest -Uri $Uri -OutFile $Path -TimeoutSec $TimeoutSec
	Write-Host "Downloaded ATA bits."

   # Install Microsoft ATA Center: ATA 1.7.2
	C:\Packages\"Microsoft ATA Center Setup.exe" /q --LicenseAccepted NetFrameworkCommandLineArguments="/q" CenterIpAddress=$CenterIpAddress CenterPort=$CenterPort ConsoleIpAddress=$ConsoleIP
	write-host "Completed Microsoft ATA Center Setup."
    
   # Give ATA Setup time to complete
	Start-Sleep -s 120

   # Add user to Microsoft Advanced Threat Analytics Administrators group.
	$DomainGroup = “Microsoft Advanced Threat Analytics Administrators"
	Add-ADGroupMember -Identity $DomainGroup -Members $ATAadmin
	write-host "Added $ATAadmin to Microsoft Advanced Threat Analytics Administrators group."

    # Add CNAME for ATA to DNS (this must be run on the server running DNS)
	$fzone = Get-ComputerInfo | select -ExpandProperty CsDomain
    	$hostname = Get-ComputerInfo | select -ExpandProperty CsDNSHostName
    	$server = "$hostname.$fzone"

	. .\new-dnsrecord -server $server -fzone $fzone -computer $server -alias "ata.$fzone" -cname
	write-host "Added CNAME record for ata.$fzone to point to $server."

}
finally
{
    popd
}
