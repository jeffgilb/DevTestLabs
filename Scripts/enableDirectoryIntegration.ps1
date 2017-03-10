	
    $User = "name"
    $Password = "password"
    
    $SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
	$msolcred = New-Object –TypeName System.Management.Automation.PSCredential ($User,$SecurePassword)
	connect-msolservice -credential $msolcred
	write-host "Trying $User to connect to Azure AD."
	connect-msolservice -credential $msolcred
    
    Set-MsolDirSyncEnabled –EnableDirSync $true -Force