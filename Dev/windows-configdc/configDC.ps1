# Turn off IE Enhanced Security Configuration
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
Stop-Process -Name Explorer

# Install Active Directory Users and Computers
Import-Module ServerManager
Add-WindowsFeature RSAT-ADDS-Tools

#Copy Bginfo config file to sysinternals directory & place shortcut in StartUp folder
Copy-Item .\Bginfo.bgi "C:\ProgramData\chocolatey\lib\sysinternals\tools\Bginfo.bgi"
Copy-Item .\Bginfo.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"

Exit