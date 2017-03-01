#Copy Bginfo exe and config files to new directory
New-Item C:\ProgramData\BGInfo -type directory
Copy-Item .\Bginfo.exe "C:\ProgramData\BGInfo\Bginfo.exe"
Copy-Item .\Bginfo.bgi "C:\ProgramData\BGInfo\Bginfo.bgi"

#Schedule Bginfo to run at logon
$taskname = "BGInfo"
$file2run = "C:\ProgramData\BGInfo\BGInfo.exe "
$argument = "C:\ProgramData\BGInfo\BGInfo.bgi /timer:0"

$action = New-ScheduledTaskAction –Execute $file2run -Argument $argument
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

Register-ScheduledTask -TaskName $taskname -Action $action -Trigger $trigger -RunLevel Highest -Settings $settings

Exit