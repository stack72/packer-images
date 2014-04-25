net user vagrant vagrant /add
net localgroup Administrators vagrant /add
net accounts /maxpwage:unlimited

IF "%1%"=="win2003_64" (
  mkdir "C:\Documents and Settings\vagrant"
)

A:\install-cygwin-sshd.bat %1
A:\winrm.bat
timeout 5