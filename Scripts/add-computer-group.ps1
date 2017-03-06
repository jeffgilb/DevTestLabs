#Add Domain Controller to Enterprise Admins security group
$LDAPPath = Get-ADDomain | select -ExpandProperty DistinguishedName 
$DomainDC = dsquery computer "ou=Domain Controllers,$LDAPPath"
$DomainGroup = “CN=Enterprise Admins,CN=Users,$LDAPPath"
dsmod group $DomainGroup -addmbr $DomainDC