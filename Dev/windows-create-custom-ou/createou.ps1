 param(
      [Parameter(Mandatory = $True)][String] $OUName,
      [Parameter(Mandatory = $True][String] $OUDescription
      )

New-ADOrganizationalUnit -Name $OUname -Description $OUdescription -PassThru

Exit

 