Param(
  # [string]$OUPath, 
  [string]$OUName, 
  [string]$OUDescription
)

New-ADOrganizationalUnit -Name $OUName -Description $OUDescription -PassThru

Exit

 