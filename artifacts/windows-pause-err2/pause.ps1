param(
      [Parameter(Mandatory = $true,valueFromPipeline=$true)]
	  [String] $Seconds
)

	Start-Sleeps -s "$Seconds"
