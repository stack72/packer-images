
set PS="C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

net user vagrant vagrant /add
net localgroup Administrators vagrant /add
net accounts /maxpwage:unlimited

%PS% a:\openssh.ps1
timeout 5