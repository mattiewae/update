function Log-Message
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$LogMessage
    )

    ("{0} - {1}" -f (Get-Date), $LogMessage)
}

Log-Message "Starting update" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"

Set-Location -Path "C:\Users\ENG\Downloads"
wget https://raw.githubusercontent.com/mattiewae/update/master/zbook15/SaveSettings -Outfile .\LaadSettings.ps1
Remove-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\LaadSettings.ps1" -force 
Move-Item "C:\Users\ENG\Downloads\LaadSettings.ps1" "C:\Users\ENG\Desktop\Admin Tools\Scripts\" -force 
#wget https://github.com/mattiewae/update/blob/master/z420/faspex.zip?raw=true -OutFile .\faspex.zip
#Expand-Archive .\faspex.zip 
#Move-Item .\faspex\faspex.website $home\Desktop -Force

#Remove-Item .\faspex.zip -force
#Remove-Item .\faspex -Recurse
#Remove-Item "$home\Desktop\Aspera Faspex.website"
#Remove-Item "$home\Desktop\Aspera Faspex.URL"

$Connect = Test-Connection 'www.google.com' -Quiet
if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 30
    cup all -y
}


Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\Public\Desktop\Avidemux*" -force
Remove-Item "C:\Users\ENG\Desktop\Mozilla*" -force
Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\Public\Desktop\Libre*" -force
Remove-Item "C:\Users\Public\Desktop\Chrome*" -force
Remove-Item "C:\Users\Public\Desktop\CCleaner*" -force
Remove-Item "C:\Users\Public\Desktop\VLC*" -force
Remove-Item "C:\Users\Public\Desktop\OBS*" -force
Remove-Item "C:\Users\Public\Desktop\Mozilla*" -force

Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Log-Message "Update Completed" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"


