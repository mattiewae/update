Set-Location -Path $home\Downloads
wget https://github.com/mattiewae/update/blob/master/z420/faspex.zip?raw=true 


$Connect = Test-Connection 'www.google.com' -Quiet

if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 30
    cup all -y
}
