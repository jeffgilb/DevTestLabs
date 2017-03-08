# Script from https://blogs.technet.microsoft.com/heyscriptingguy/2010/09/13/manage-dns-in-a-windows-environment-by-using-powershell/

function new-dnsrecord { 
param( 
    [string]$server,     # DNS Server FQDN
    [string]$fzone,      # Forward lookup zone
    [string]$rzone,      # Reverse lookup zone
    [string]$computer,   # Computer FQDN for which we are creating DNS entry
    [string]$address,    # Address of the computer
    [string]$alias,      # Alias of the computer
    [string]$maildomain, # Mail domain
    [int]$priority,      # Mail priority
    [switch]$arec,       # Create A record
    [switch]$ptr,        # Create PTR record
    [switch]$cname,      # Create Alias record
    [switch]$mx          # Create MX (mail server) record
) 
# Check to make sure DNS is running
    Get-Service -Name DNS

## check DNS server contactable 
    if (-not (Test-Connection -ComputerName $server)){Throw "DNS server not found"} 
## split the server fqdn and address 
    $srvr = $server -split "\." 
    $addr = $address -split "\."
    $rec = [WmiClass]"\\$($srvr[0])\root\MicrosoftDNS:MicrosoftDNS_ResourceRecord"  
## 
## create records 
##  
## A 
    if ($arec){ 
        $text = "$computer IN A $address"  
        $rec.CreateInstanceFromTextRepresentation($server, $fzone, $text)  
    } 
## CNAME 
    if ($cname){ 
        $text = "$alias IN CNAME $computer"  
        $rec.CreateInstanceFromTextRepresentation($server, $fzone, $text)  
    } 
## PTR 
    if ($ptr){ 
        $text = "$($addr[3]).$rzone IN PTR $computer"  
        $rec.CreateInstanceFromTextRepresentation($server, $rzone, $text)  
    } 
## MX 
    if ($mx){ 
        $text = "$maildomain IN MX $priority $computer"  
        $rec.CreateInstanceFromTextRepresentation($server, $fzone, $text)  
    } 
}

# Command line to run
    $fzone = Get-ComputerInfo | select -ExpandProperty CsDomain
    $hostname = Get-ComputerInfo | select -ExpandProperty CsDNSHostName
    $server = "$hostname.$fzone"
    $alias1 = "ata.$fzone"

    new-dnsrecord -server $server -fzone $fzone -computer $server -alias "ata.$fzone" -cname

<#

Examples command lines:

A record

    new-dnsrecord -server server02 -fzone ‘manticore.org’ -computer ‘test27.manticore.org’ -address 10.10.54.241 -arec 

PTR Record

    new-dnsrecord -server server02 -rzone ‘54.10.10.in-addr.arpa’ -computer ‘test27.manticore.org’ -address 10.10.54.241 -ptr 
    
Alias Record

    new-dnsrecord -server server02 -fzone ‘manticore.org’ -computer ‘test27.manticore.org’ -alias ‘mydnstest.manticore.org’ -cname

MX record

    new-dnsrecord -server server02 -fzone ‘manticore.org’ -computer ‘test27.manticore.org’ -maildomain ‘manticore.org’ -priority 10 -mx

Multiple records

new-dnsrecord -server server02 -fzone ‘manticore.org’ -rzone ‘54.10.10.in-addr.arpa’ -computer ‘test27.manticore.org’ -address 10.10.54.241 -alias ‘mydnstest.manticore.org’ -arec -cname -ptr

#>