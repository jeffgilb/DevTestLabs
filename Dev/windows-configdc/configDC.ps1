# Turn off IE Enhanced Security Configuration
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
Stop-Process -Name Explorer

# Install Active Directory Users and Computers
Import-Module ServerManager
Add-WindowsFeature RSAT-ADDS-Tools

# Create a demo computers OU to add new lab VMs to
New-ADOrganizationalUnit -Name "Demo VMs" -Description "Demo Virtual Machines" -PassThru

# Create a cloud users OU to synchronize with Azure AD
New-ADOrganizationalUnit -Name "Cloud Users" -Description "Users to sync with AAD" -PassThru

Exit