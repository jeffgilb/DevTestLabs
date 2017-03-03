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

# Turn off IE Enhanced Security Configuration
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
Stop-Process -Name Explorer

#Copy Bginfo config file to sysinternals directory & place shortcut in StartUp folder
Copy-Item .\Bginfo.bgi "C:\ProgramData\chocolatey\lib\sysinternals\tools\Bginfo.bgi"
Copy-Item .\Bginfo.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"

# Install Active Directory Users and Computers
Import-Module ServerManager
Add-WindowsFeature RSAT-ADDS-Tools

Exit