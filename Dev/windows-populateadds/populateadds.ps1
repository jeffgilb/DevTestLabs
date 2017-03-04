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
# Create OU structure and populate with MS Press ficticious users       

# Create custom VM and cloud sync OUs
New-ADOrganizationalUnit -Name "Demo VMs" -Description "Demo Virtual Machines" -PassThru

# Create a cloud users OU to synchronize with Azure AD
New-ADOrganizationalUnit -Name "Cloud Users" -Description "Users to sync with AAD" -PassThru

# Get distinguished name of local domain (i.e. DC=corp,DC=jeffgilb,DC=com)
$LDAPPath = Get-ADDomain | select -ExpandProperty DistinguishedName    

$users = import-csv finance.csv -Delimiter "," -Header Name,FirstName,Password
foreach ($User in $Users)
{  
    New-ADOrganizationalUnit -Name Finance -Description "Finance Users" -PassThru
    $OU = "OU = Finance," + $LDAPPath  
    $Password = $User.password 
    $Detailedname = $User.firstname + " " + $User.name 
    $UserFirstname = $User.Firstname 
    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
    $SAM =  $FirstLetterFirstname + $User.name 
    $Description = "Finance user"
    $Department = "Finance"
    $Mobile = "123-456-7890"
    $Telephone = "123-456-7890"
    $Office = "Bldg 44"
    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
} 

$users = import-csv legal.csv -Delimiter "," -Header Name,FirstName,Password
foreach ($User in $Users)
{  
    New-ADOrganizationalUnit -Name Legal -Description "Legal Users" -PassThru
    $OU = "OU = Legal," + $LDAPPath  
    $Password = $User.password 
    $Detailedname = $User.firstname + " " + $User.name 
    $UserFirstname = $User.Firstname 
    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
    $SAM =  $FirstLetterFirstname + $User.name 
    $Description = "Legal user"
    $Department = "Legal"
    $Mobile = "123-456-7890"
    $Telephone = "123-456-7890"
    $Office = "Bldg 43"
    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
} 

$users = import-csv marketing.csv -Delimiter "," -Header Name,FirstName,Password
foreach ($User in $Users)
{  
    New-ADOrganizationalUnit -Name Marketing -Description "Marketing Users" -PassThru    
    $OU = "OU = Marketing," + $LDAPPath  
    $Password = $User.password 
    $Detailedname = $User.firstname + " " + $User.name 
    $UserFirstname = $User.Firstname 
    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
    $SAM =  $FirstLetterFirstname + $User.name 
    $Description = "Marketing user"
    $Department = "Marketing"
    $Mobile = "123-456-7890"
    $Telephone = "123-456-7890"
    $Office = "Bldg 3"
    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
} 

$users = import-csv sales.csv -Delimiter "," -Header Name,FirstName,Password
foreach ($User in $Users)
{  
    New-ADOrganizationalUnit -Name Sales -Description "Sales Users" -PassThru     
    $OU = "OU = Sales," + $LDAPPath 
    $Password = $User.password 
    $Detailedname = $User.firstname + " " + $User.name 
    $UserFirstname = $User.Firstname 
    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
    $SAM =  $FirstLetterFirstname + $User.name 
    $Description = "Sales user"
    $Department = "Sales"
    $Mobile = "123-456-7890"
    $Telephone = "123-456-7890"
    $Office = "Bldg 24"
    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
} 

$users = import-csv it.csv -Delimiter "," -Header Name,FirstName,Password
foreach ($User in $Users)
{  
    New-ADOrganizationalUnit -Name IT -Description "IT Users" -PassThru  
    $OU = "OU = IT," + $LDAPPath 
    $Password = $User.password 
    $Detailedname = $User.firstname + " " + $User.name 
    $UserFirstname = $User.Firstname 
    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
    $SAM =  $FirstLetterFirstname + $User.name 
    $Description = "IT user"
    $Department = "Corp IT"
    $Mobile = "123-456-7890"
    $Telephone = "123-456-7890"
    $Office = "Bldg 8"
    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
} 

$users = import-csv operations.csv -Delimiter "," -Header Name,FirstName,Password
foreach ($User in $Users)
{  
    New-ADOrganizationalUnit -Name Operations -Description "Operations Users" -PassThru  
    $OU = "OU = Operations," + $LDAPPath   
    $Password = $User.password 
    $Detailedname = $User.firstname + " " + $User.name 
    $UserFirstname = $User.Firstname 
    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
    $SAM =  $FirstLetterFirstname + $User.name 
    $Description = "Operations user"
    $Department = "Operations"
    $Mobile = "123-456-7890"
    $Telephone = "123-456-7890"
    $Office = "Bldg 5500"
    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
} 

$users = import-csv regional.csv -Delimiter "," -Header Name,FirstName,Password
foreach ($User in $Users)
{  
    New-ADOrganizationalUnit -Name Regional -Description "Regional Users" -PassThru  
    $OU = "OU = Regional," + $LDAPPath   
    $Password = $User.password 
    $Detailedname = $User.firstname + " " + $User.name 
    $UserFirstname = $User.Firstname 
    $FirstLetterFirstname = $UserFirstname.substring(0,1) 
    $SAM =  $FirstLetterFirstname + $User.name 
    $Description = "Regional user"
    $Department = "Regional"
    $Mobile = "123-456-7890"
    $Telephone = "123-456-7890"
    $Office = "Regional"
    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $user.firstname -Surname $user.name -Department $Department -Description $Description -Office $Office -mobile $Mobile -OfficePhone $Telephone -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU  
} 
finally
{
    popd
}