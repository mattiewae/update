#Set-ExecutionPolicy RemoteSigned

#Write-Host "Update Startup"
#iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mattiewae/update/master/zbook15/startup.ps1'))

Set-Location -Path $env:TEMP 

wget https://raw.githubusercontent.com/mattiewae/update/master/z420/startup.ps1 -OutFile update.ps1
