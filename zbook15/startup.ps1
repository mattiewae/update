Set-ExecutionPolicy RemoteSigned
Set-Location -Path $home\Downloads
#wget https://github.com/mattiewae/update/blob/master/z420/faspex.zip?raw=true -OutFile .\faspex.zip
#wget https://github.com/mattiewae/update/blob/master/zbook15/Encoder.zip?raw=true -OutFile .\encoder.zip
 
#Expand-Archive .\faspex.zip 
#Expand-Archive .\encoder.zip

#Move-Item .\faspex\faspex.website $home\Desktop -force
#Move-Item .\encoder\encoder_V20.exe C:\encoder -force
#Move-Item .\encoder\encoder.lnk $home\Desktop -force

#Remove-Item .\encoder
#Remove-Item .\encoder.zip
#Remove-Item .\faspex.zip
#Remove-Item .\faspex
#Remove-Item "$home\Desktop\Aspera Faspex.website"
#Remove-Item "$home\Desktop\Encoder.exe"
#Remove-Item "C:\encoder\Encoder_V19.exe"

$Connect = Test-Connection 'www.google.com' -Quiet

if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 60
    cup all -y
}

Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\Public\Desktop\Avidemux*" -force
Remove-Item "C:\Users\Public\Desktop\Mozilla*" -force
Remove-Item "C:\Users\Public\Desktop\Libre*" -force
Remove-Item "C:\Users\Public\Desktop\Chrome*" -force
Remove-Item "C:\Users\Public\Desktop\ccleaner*" -force
Remove-Item "C:\Users\Public\Desktop\VLC*" -force


choco install tightvnc -y


Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"



