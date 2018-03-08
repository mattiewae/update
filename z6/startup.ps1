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


$Connect = Test-Connection 'www.google.com' -Quiet
if($Connect -eq $true){
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

Log-Message "Apps Update" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"

Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\ENG\Desktop\Mozilla*" -force
Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\ENG\Desktop\Win*" -force

Remove-Item "C:\Users\Public\Desktop\Libre*" -force
Remove-Item "C:\Users\Public\Desktop\Chrome*" -force
Remove-Item "C:\Users\Public\Desktop\Google*" -force
Remove-Item "C:\Users\Public\Desktop\CCleaner*" -force
Remove-Item "C:\Users\Public\Desktop\VLC*" -force
Remove-Item "C:\Users\Public\Desktop\OBS*" -force
Remove-Item "C:\Users\Public\Desktop\Mozilla*" -force
Remove-Item "C:\Users\Public\Desktop\Firefox*"
Remove-Item "C:\Users\Public\Desktop\Google*"
Remove-Item "C:\Users\Public\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\Public\Desktop\Quick*" -force
Remove-Item "C:\Users\Public\Desktop\Avidemux*" -force

Log-Message "Remove Dekstop Items" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"

Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Log-Message "Windows Updates" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"

Log-Message "Update Completed" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"


