Set-Location -Path $home\Desktop
wget https://raw.githubusercontent.com/mattiewae/update/master/z420/faspex.website


$Connect = Test-Connection 'www.google.com' -Quiet

if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 30
    cup all -y
}
