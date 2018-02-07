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

$PC = $env:COMPUTERNAME
New-PSDrive -Name "O" -PSProvider FileSystem -Root "\\$PC\OT" -Persist 

$Connect = Test-Connection 'www.google.com' -Quiet
if($Connect = $true){

    cinst wget -y
    cinst flashplayerplugin -y
    cinst flashplayeractivex -y
    cinst googlechromex64 -y 
    cinst firefox -y 
    cinst notepadplusplus.install -y
    cinst jre8 -y 
    cinst vlc -y
    cinst ccleaner -y
    cinst adobeair -y
    cinst windirstat -y
    cinst quicktime -y 
    cinst irfanview -y
    cinst 7zip.install -y
    cinst javaruntime -y
    cinst putty -y  
    cinst libreoffice -y
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
Remove-Item "C:\Users\Public\Desktop\Firefox.lnk"

Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Log-Message "Update Completed" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"


