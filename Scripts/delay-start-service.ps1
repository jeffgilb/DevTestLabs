
# Set a service to delayed start. 
Set-ItemProperty -Path "Registry::HKLM\System\CurrentControlSet\Services\<service name>" -Name "DelayedAutostart" -Value 1 -Type DWORD