Set-Location -Path $home\Downloads
wget https://github.com/mattiewae/update/blob/master/z420/faspex.zip?raw=true -OutFile .\faspex.zip
 
Expand-Archive .\faspex.zip -force

Move-Item .\faspex\faspex.website $home\Desktop 

Remove-Item .\faspex.zip
Remove-Item .\faspex
Remove-Item "$home\Desktop\Aspera Faspex.website"

$Connect = Test-Connection 'www.google.com' -Quiet

if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 60
    cup all -y
}
