#Copy Bginfo config file to sysinternals directory & place shortcut in StartUp folder
Copy-Item .\Bginfo.bgi "C:\ProgramData\chocolatey\lib\sysinternals\tools\Bginfo.bgi"
Copy-Item .\Bginfo.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
Exit