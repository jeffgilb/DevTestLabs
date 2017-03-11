    # Install MSOL sign in assistant
    #C:\Packages\msoidcli_64.msi /passive"
    
    # Install Azure AD PowerShell cmdlets http://go.microsoft.com/fwlink/p/?linkid=236297
    #"C:\Packages\AdministrationConfig-en.msi /passive"


    $User = "jeff@jeffgilb.com"
    $Password = "Rhubarb0"
    
    # Authenticate to Azure AD
	$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
	$msolcred = New-Object –TypeName System.Management.Automation.PSCredential ($User,$SecurePassword)
	connect-msolservice -credential $msolcred

    # Activate directory synchronization in Azure
	Set-MsolDirSyncEnabled –EnableDirSync $true -Force