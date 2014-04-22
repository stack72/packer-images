net user vagrant vagrant /add
net localgroup Administrators vagrant /add
net accounts /maxpwage:unlimited

A:\install-cygwin-sshd.bat "%1%"
timeout 5