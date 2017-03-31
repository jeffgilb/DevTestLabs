param(
      [Parameter(valueFromPipeline=$true)]
	  [String] $upnSuffix
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
    exit -0
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
    # Create OU structure and populate with ficticious users       

    # Get distinguished name of local domain (i.e. DC=corp,DC=jeffgilb,DC=com)
	$LDAPPath = Get-ADDomain | select -ExpandProperty DistinguishedName    

    # Create the Accounting OU
	$BusUnit = "Accounting"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from accounting.csv and then put them all in the security group
	$users = import-csv accounting.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 41"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department 	$Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 

    # Create the Customer Service OU
	$BusUnit = "Customer Service"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from customerService.csv and then put them all in the security group
	$users = import-csv customerService.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 8"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 

    # Create the Finance OU
	$BusUnit = "Finance"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the Business Unit security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from finance.csv and then put them all in the security group
	$users = import-csv finance.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 33"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 

    # Create the Human Resources OU
	$BusUnit = "Human Resources"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from humanResources.csv and then put them all in the security group
	$users = import-csv humanResources.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 42"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 

    # Create the Information Technology OU
	$BusUnit = "Information Technology"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the Business Unit security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from informationTechnology.csv and then put them all in the security group
	$users = import-csv informationTechnology.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 7"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 

    # Create the Legal OU
	$BusUnit = "Legal"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the Business Unit security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from legal.csv and then put them all in the security group
	$users = import-csv legal.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 44"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 

    # Create the Manufacturing OU
	$BusUnit = "Manufacturing"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the Business Unit security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from manufacturing.csv and then put them all in the security group
	$users = import-csv manufacturing.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 25"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 

    # Create the Marketing OU
	$BusUnit = "Marketing"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the Business Unit security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from marketing.csv and then put them all in the security group
	$users = import-csv marketing.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 8"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 

    # Create the Pilot Users OU
	$BusUnit = "Pilot Users"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the Business Unit security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from pilotUsers.csv and then put them all in the security group
	$users = import-csv pilotUsers.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 92"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 

    # Create the Sales OU
	$BusUnit = "Sales"
	New-ADOrganizationalUnit -Name $BusUnit -Description "$BusUnit Users" -PassThru
	# Create the Business Unit security group
	New-ADGroup -Name $BusUnit -GroupScope DomainLocal -DisplayName "$BusUnit Users" -Description "Users from the $BusUnit department." -Path "OU=$BusUnit,$LDAPPath" -PassThru
	# Populate the new OU with users from sales.csv and then put them all in the security group
	$users = import-csv sales.csv -Delimiter "," -Header Name,FirstName,Password
	foreach ($User in $Users)
	{  
	    $OU = "OU = $BusUnit,$LDAPPath"
	    $Group = $BusUnit
	    $Password = $User.password 
	    $Detailedname = $User.firstname + " " + $User.name 
	    $UserFirstname = $User.Firstname 
	    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
	    $SAM =  $FirstLetterFirstname + $User.name 
	    $Description = "$BusUnit user"
	    $Department = $BusUnit
	    $Mobile = "123-456-7890"
	    $Telephone = "123-456-7890"
	    $Office = "Bldg 120"
	    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
	    Add-ADGroupMember $Group -Members $Sam -Server localhost
	} 
	write-host "$BusUnit OU, users, and group created and populated." 
    # Add a blank line after OUs and before UPN stuff
	write-host


    # Configure UPN suffix
    # Set parameters
    
    # Check for upnSuffix value
	if ($upnSuffix -ne ""){
    	    	Import-Module ActiveDirectory 
		$LDAPpath = Get-ADDomain | select -ExpandProperty DistinguishedName    
		$fqdn=Get-WMIObject Win32_ComputerSystem  | Select-Object -ExpandProperty Domain
	    # Add alternative upn suffix to domain 
	        Set-ADForest -Identity $fqdn -UPNSuffixes @{Add=$upnSuffix}
	    # Add alternative upn suffix to users and set as their email address
	        $users = Get-ADUser -Filter {UserPrincipalName -like '*'} -SearchBase $LDAPpath
	        foreach ($user in $users) { 
	        $userName = $user.UserPrincipalName.Split('@')[0] 
	        $UPN = $userName + "@" + $upnSuffix 
	        $user | Set-ADUser -UserPrincipalName $UPN
            	$user | Set-ADUser -EmailAddress $UPN
   	        }
            Write-Host Custom $upnSuffix UPN suffix applied to all users.
            } 
        else {
            # Add domain FQDN as UPN suffix to users and set as their email address
    	    	Import-Module ActiveDirectory 
		$LDAPpath = Get-ADDomain | select -ExpandProperty DistinguishedName    
		$fqdn=Get-WMIObject Win32_ComputerSystem  | Select-Object -ExpandProperty Domain
	    # Add alternative upn suffix to domain 
	        $users = Get-ADUser -Filter {UserPrincipalName -like '*'} -SearchBase $LDAPpath
	        foreach ($user in $users) { 
	        $userName = $user.UserPrincipalName.Split('@')[0] 
	        $UPN = $userName + "@" + $fqdn
	        $user | Set-ADUser -UserPrincipalName $UPN
            	$user | Set-ADUser -EmailAddress $UPN
   	        }
            Write-Host No alternate UPN suffix requested. Default domain FQDN applied.
            }

	write-host "AD DS populated successfully." 

}
finally
{
    popd
}