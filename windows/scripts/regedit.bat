
%SystemRoot%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Powershell\1\ShellIds\Microsoft.Powershell /v ExecutionPolicy /t REG_SZ /d Unrestricted /f
%SystemRoot%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v !Setup /t REG_SZ /d "%SystemRoot%\System32\cmd.exe /c a:\runonce.bat win2003_64" /f
