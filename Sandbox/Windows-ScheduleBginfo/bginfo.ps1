#Copy Bginfo config file to sysinternals directory
Copy-Item .\Bginfo.bgi "C:\ProgramData\chocolatey\lib\sysinternals\tools\Bginfo.bgi"

#Schedule Bginfo to run at logon
$taskname = "BGInfo"
$file2run = "C:\ProgramData\chocolatey\lib\sysinternals\tools\BGInfo.exe"
$argument = "C:\ProgramData\chocolatey\lib\sysinternals\tools\BGInfo.bgi /timer:0"

$action = New-ScheduledTaskAction –Execute $file2run -Argument $argument
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

Register-ScheduledTask -TaskName $taskname -Action $action -Trigger $trigger -RunLevel Highest -Settings $settings

Exit