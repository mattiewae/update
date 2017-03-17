Set-Location -Path $home\Downloads
wget https://github.com/mattiewae/update/blob/master/z420/faspex.zip?raw=true -OutFile .\faspex.zip
wget https://github.com/mattiewae/update/blob/master/zbook15/Encoder.zip?raw=true -OutFile .\encoder.zip
 
Expand-Archive .\faspex.zip 
Expand-Archive .\encoder.zip

Move-Item .\faspex\faspex.website $home\Desktop 
Move-Item .\encoder\encoder_V20.exe C:\encoder
Move-Item .\encoder\encoder.lnk $home\Desktop

Remove-Item .\encoder
Remove-Item .\encoder.zip
Remove-Item .\faspex.zip
Remove-Item .\faspex
Remove-Item "$home\Desktop\Aspera Faspex.website"
Remove-Item "$home\Desktop\Encoder.exe"
Remove-Item "C:\encoder\Encoder_V19.exe"

$Connect = Test-Connection 'www.google.com' -Quiet

if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 60
    cup all -y
}
