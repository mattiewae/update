Set-ExecutionPolicy RemoteSigned

Write-Host "Update Startup"
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/EncoderInstall/master/startup.ps1'))