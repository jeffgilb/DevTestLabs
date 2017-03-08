Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module AzureRM 

$User="<AAD Admin Name>"
$Password="<Password>"
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object –TypeName System.Management.Automation.PSCredential ($User,$SecurePassword)

Login-AzureRmAccount -Credential $cred
write-host "Connected to Azure as $User."

# Register internal application to Azure AD
New-AzureRmADApplication -DisplayName "NewApplication" -HomePage "http://www.Contoso.com" -IdentifierUris "http://NewApplication" -verbose