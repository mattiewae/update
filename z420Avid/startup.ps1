#Set-Location -Path $home\Downloads
#wget https://github.com/mattiewae/update/blob/master/z420/faspex.zip?raw=true -OutFile .\faspex.zip
#Expand-Archive .\faspex.zip 
#Move-Item .\faspex\faspex.website $home\Desktop -Force

#Remove-Item .\faspex.zip -force
#Remove-Item .\faspex -Recurse
#Remove-Item "$home\Desktop\Aspera Faspex.website"
#Remove-Item "$home\Desktop\Aspera Faspex.URL"

$Connect = Test-Connection 'www.google.com' -Quiet
if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 30
    cup all -y
}

#choco install obs-studio -y
#choco install win-youtube-dl -y
#
#Set-Location -Path $home\Downloads
#wget https://github.com/mattiewae/update/raw/master/z420Avid/obs-studio.zip -OutFile .\obs.zip
#Expand-Archive .\obs.zip 
#Move-Item .\obs\obs-studio $env:APPDATA -Force 
#
#Remove-Item .\obs.zip -force
#Remove-Item .\obs -Force -Recurse

function OBS
{
  $choco = choco list -lo

    if ($choco -like '*obs*') {
    Write-Host 'obs installed'
    }
    else{
    choco install -y obs-studio

    Set-Location -Path $home\Downloads
    wget https://github.com/mattiewae/update/raw/master/z420Avid/obs-studio.zip -OutFile .\obs.zip

    Expand-Archive .\obs.zip 

    Move-Item .\obs\obs-studio $env:APPDATA -Force 

    Remove-Item .\obs.zip -force
    Remove-Item .\obs -Force -Recurse
    }
}

function Youtube-dl
{
  $choco = choco list -lo

    if ($choco -like '*win-youtube-dl*') {
    Write-Host 'win-youtube-dl installed'
    }
    else{
    choco install -y win-youtube-dl
    }
}

function RemoveItems
{
    Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
    Remove-Item "C:\Users\Public\Desktop\Avidemux*" -force
    Remove-Item "C:\Users\Public\Desktop\Mozilla*" -force
    Remove-Item "C:\Users\Public\Desktop\Libre*" -force
    Remove-Item "C:\Users\Public\Desktop\Chrome*" -force
    Remove-Item "C:\Users\Public\Desktop\CCleaner*" -force
    Remove-Item "C:\Users\Public\Desktop\VLC*" -force
    Remove-Item "C:\Users\ENG\Desktop\WinDir*" -force
    Remove-Item "C:\Users\Public\Desktop\Boxstarter*" -force
}

#OBS

#Youtube-dl

RemoveItems

#Clear-RecycleBin -Force

Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"
