Set-Location -Path $home\Downloads
wget https://github.com/mattiewae/EncoderInstall/blob/master/update.zip?raw=true -OutFile .\update.zip
Expand-Archive -Path .\update.zip
Move-Item .\update\update.lnk -Destination 'C:\Users\ENG\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup' -Force
Remove-Item .\update


$Connect = Test-Connection 'www.google.com' -Quiet

if($Connect = $true){
    choco install filezilla -y
    cup all -y 
}
else{
    Start-Sleep -s 30
    cup all -y
}