

#Set-Location -Path $home\Downloads
#wget https://github.com/mattiewae/update/blob/master/z420/faspex.zip?raw=true -OutFile .\faspex.zip
#Expand-Archive .\faspex.zip 
#Move-Item .\faspex\faspex.website $home\Desktop -Force

#Remove-Item .\faspex.zip -force
#Remove-Item .\faspex -Recurse
#Remove-Item "$home\Desktop\Aspera Faspex.website"
#Remove-Item "$home\Desktop\Aspera Faspex.URL"

#$Connect = Test-Connection 'www.google.com' -Quiet
#if($Connect = $true){
#    cup all -y 
#}
#else{
#    Start-Sleep -s 30
#    cup all -y
#}


Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\Public\Desktop\Avidemux*" -force
Remove-Item "C:\Users\ENG\Desktop\Mozilla*" -force
Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\Public\Desktop\Libre*" -force
Remove-Item "C:\Users\Public\Desktop\Chrome*" -force
Remove-Item "C:\Users\Public\Desktop\CCleaner*" -force
Remove-Item "C:\Users\Public\Desktop\VLC*" -force
Remove-Item "C:\Users\Public\Desktop\OBS*" -force


Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

#Clear-RecycleBin -Force

# Wachten op input voor af te sluiten
function Wait-KeyPress($prompt='Druk op een toets ...!') {
	Write-Host $prompt 	
	do {
		Start-Sleep -milliseconds 100
	} until ($Host.UI.RawUI.KeyAvailable)

	$Host.UI.RawUI.FlushInputBuffer()
}


#&("C:\Users\ENG\Desktop\Admin Tools\Scripts\ImageChecker.ps1")

#Wait-KeyPress


