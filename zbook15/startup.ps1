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
	Set-Location C:\Users\ENG\AppData\Local\Temp
    
    try{
        Remove-Item "C:\Users\ENG\AppData\Local\Temp\LaadSettingsGUI.exe" -ErrorAction Ignore
        Remove-Item "C:\Users\ENG\Desktop\LaadSettingsGUI.exe" -ErrorAction Ignore
    }
    catch{
        $ErrorMessage = $_.Exception.Message
        Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
    }

    $FunctionID = Log-Message "SettingsGUI" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
	$SettingsGUI_TEMP = Test-Path "C:\Users\ENG\AppData\Local\Temp\LaadSettingsGUI_V2.exe"
    $SettingsGUI_DESKTOP = Test-Path "C:\Users\ENG\Desktop\LaadSettingsGUI_V2.exe"

	if($SettingsGUI_TEMP -eq $false){
        try{
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri https://github.com/mattiewae/update/blob/master/AdobePresets/LaadSettingsGUI_V2.exe?raw=true -OutFile LaadSettingsGUI_V2.exe -ErrorAction Stop
            Write-Host "GUI gedownload"
        }
        Catch{
            $ErrorMessage = $_.Exception.Message
            $FunctionID    
            Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
            }
        }
    elseif($SettingsGUI_DESKTOP -eq $false){
         try{
                Copy-Item LaadSettingsGUI_V2.exe -Destination C:\Users\ENG\desktop -ErrorAction Stop
                $FunctionID  
                Write-Host "Copy GUI naar Desktop"
                Log-Message "Copy GUI naar Desktop" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
            }
            Catch{
                $ErrorMessage = $_.Exception.Message
                $FunctionID    
                Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
                }
         }
         Else{
                Write-Host "GUI settings OK"
                Log-Message "GUI settings OK" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
         }
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

Remove-Item "C:\Users\ENG\Desktop\Skype*" -force
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

