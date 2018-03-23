Set-ExecutionPolicy RemoteSigned

Write-Host "Update Startup"
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/update/master/z420/startup.ps1'))
