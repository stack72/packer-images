:: vagrant public key
if not exist C:\Users\vagrant\.ssh (
  mkdir C:\Users\vagrant\.ssh
)

if exist a:\vagrant.pub (
  copy a:\vagrant.pub C:\Users\vagrant\.ssh\authorized_keys
) else (
  C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub', 'C:\Users\vagrant\.ssh\authorized_keys')" <NUL
)

cmd /c %SystemDrive%\cygwin\bin\bash -c 'PATH=/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin chown -R vagrant .ssh'