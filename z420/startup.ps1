Set-Location -Path $home\Downloads
wget https://github.com/mattiewae/EncoderInstall/blob/master/update.zip?raw=true -OutFile .\update.zip
Expand-Archive -Path .\faspex.zip
Move-Item .\faspex\faspex.lnk -Destination 'C:\Users\ENG\Desktop' -Force
Remove-Item .\faspex


$Connect = Test-Connection 'www.google.com' -Quiet

if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 30
    cup all -y
}
