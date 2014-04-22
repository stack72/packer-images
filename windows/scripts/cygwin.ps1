
$TempCygDir="$env:temp\cygInstall"

if(!(Test-Path -Path $TempCygDir -PathType Container))
{
   $null = New-Item -Type Directory -Path $TempCygDir -Force
}

$is_64bit = [IntPtr]::size -eq 8

$client = new-object System.Net.WebClient

$client.DownloadFile("http://cygwin.com/setup-x86_64.exe", "$TempCygDir\setup-x86_64.exe" )

Start-Process -wait -FilePath "$TempCygDir\setup-x86_64.exe" -ArgumentList "-q -n -l $TempCygDir -s http://www.mirrorservice.org/sites/sourceware.org/pub/cygwin/ -R c:\Cygwin"

Start-Process -wait -FilePath "$TempCygDir\setup-x86_64.exe" -ArgumentList "-q -n -l $TempCygDir -s http://www.mirrorservice.org/sites/sourceware.org/pub/cygwin/ -R c:\Cygwin -P openssh"

NET USER cyg_server "cygPassword123" /ADD
NET LOCALGROUP Administrators cyg_server /ADD

$Env:Path = "$Env:Path;C:\Cygwin\bin"

C:\Cygwin\bin\bash.exe -c "mkpasswd -l -u cyg_server >> /etc/passwd"
C:\Cygwin\bin\bash.exe -c "ssh-host-config -y --user cyg_server --pwd cygPassword123"
C:\Cygwin\bin\bash.exe -c "chown cyg_server:root /etc/ssh_config"

New-Item -ItemType Directory -Force -Path "C:\Users\vagrant\.ssh"
C:\Windows\System32\icacls.exe "C:\Users\vagrant" /grant "vagrant:(OI)(CI)F"
$client.DownloadFile("https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub", "C:\Users\vagrant\.ssh\authorized_keys")

# configure firewall
Write-Host "Configuring firewall"
netsh firewall set opmode mode=disable


net start sshd