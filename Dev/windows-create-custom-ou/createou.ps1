param(
      [Parameter(Mandatory = $True,valueFromPipeline=$true)][String] $OUName,
      [Parameter(Mandatory = $True,valueFromPipeline=$true)][String] $OUDescription
      )

New-ADOrganizationalUnit -Name $OUname -Description $OUdescription -PassThru

Exit

 