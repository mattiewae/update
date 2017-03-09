$Connect = Test-Connection 'www.google.com' -Quiet

if($Connect = $true){
    choco install filezilla -y
    cup all -y 
}
else{
    Start-Sleep -s 30
    cup all -y
}