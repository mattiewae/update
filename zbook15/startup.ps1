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

function SettingsGUI{
	Set-Location $env:TEMP
	$SettingsGUI = Test-Path "$env:HOMEPATH\desktop\LaadSettingsGUI.exe"
    	$SettingsGUI
	 if($SettingsGUI -eq $false){
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri https://github.com/mattiewae/update/blob/master/AdobePresets/LaadSettingsGUI.exe?raw=true -OutFile LaadSettingsGUI.exe
            Copy-Item LaadSettingsGUI.exe -Destination $env:HOMEPATH\desktop
            }
            else{
                # do nothing
            }
            Log-Message "SettingsGUI" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
}

SettingsGUI

$Connect = Test-Connection 'www.google.com' -Quiet
if($Connect = $true){
    cup all -y 
}
else{
    Start-Sleep -s 30
    cup all -y
}

Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
Remove-Item "C:\Users\ENG\Desktop\Windir*" -force
Remove-Item "C:\Users\ENG\Desktop\Google*" -force
Remove-Item "C:\Users\Public\Desktop\Avidemux*" -force
Remove-Item "C:\Users\Public\Desktop\Mozilla*" -force
Remove-Item "C:\Users\Public\Desktop\Libre*" -force
Remove-Item "C:\Users\Public\Desktop\Chrome*" -force
Remove-Item "C:\Users\Public\Desktop\ccleaner*" -force
Remove-Item "C:\Users\Public\Desktop\VLC*" -force
Remove-Item "C:\Users\Public\Desktop\Firefox*" -force
Remove-Item "C:\Users\Public\Desktop\Google*" -force
Remove-Item "C:\Users\Public\Desktop\Teamviewer*" -force
Remove-Item "C:\Users\Public\Desktop\Quicktime*" -force
Remove-Item "C:\Users\Public\Desktop\Box*" -force

Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Log-Message "Update Completed" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"

