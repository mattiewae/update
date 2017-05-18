#Set-Location -Path $home\Downloads
#wget https://github.com/mattiewae/update/blob/master/z420/faspex.zip?raw=true -OutFile .\faspex.zip
#Expand-Archive .\faspex.zip 
#Move-Item .\faspex\faspex.website $home\Desktop -Force

#Remove-Item .\faspex.zip -force
#Remove-Item .\faspex -Recurse
#Remove-Item "$home\Desktop\Aspera Faspex.website"
#Remove-Item "$home\Desktop\Aspera Faspex.URL"

if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 30
    cup all -y
}

Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"


Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\Public\Desktop\Avidemux*" -force
Remove-Item "C:\Users\Public\Desktop\Mozilla*" -force
Remove-Item "C:\Users\Public\Desktop\Libre*" -force
Remove-Item "C:\Users\Public\Desktop\Chrome*" -force
Remove-Item "C:\Users\Public\Desktop\CCleaner*" -force
Remove-Item "C:\Users\Public\Desktop\VLC*" -force

#choco install tightvnc -y

$Connect = Test-Connection 'www.google.com' -Quiet


