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

Remove-Item C:\Users\ENG\Desktop\encoder_V2*

$encoder = Test-Path C:\encoder\encoder_V33_16CH.exe

function DHD{
    Remove-Item "C:\Users\ENG\Desktop\Allerlei nuttige dingen\DHD_config_instellingen1.pdf"
    Set-Location $env:TEMP

    $DHD = Test-Path "C:\Users\ENG\Desktop\Allerlei nuttige dingen\DHD_config_instellingen2.pdf"

    if($DHD -eq $true){
       Write-Host "DHD uitleg: OK"
    }
    else{
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri https://github.com/mattiewae/update/raw/master/z420/DHD_config_instellingen.pdf -OutFile "DHD_config_instellingen2.pdf"
    Move-Item "DHD_config_instellingen2.pdf" "C:\Users\ENG\Desktop\Allerlei nuttige dingen"
    }

}

function ReplaceLaadSettings{
    Set-Location $env:TEMP
    
    $montage = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\MONTAGE.sqpreset"
    $LaadSettings = Test-Path $env:TEMP\LaadSettings.ps1
    if($LaadSettings -and $montage -eq $true){
        Move-Item $env:TEMP\LaadSettings.ps1 'C:\Users\ENG\Desktop\Admin Tools\Scripts\LaadSettings.ps1' -Force 
        Write-Host 'Script replaced'
    }
    else{
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/AdobePresets/laadSettings.ps1 -OutFile LaadSettings.ps1
        Write-Host 'Settings downloaded'
    }
}

function UpdateEncoder{
    if($encoder -eq $true){
 
    Write-Host "encoder uptodate"

    }
else{
    Set-Location C:\Users\ENG\Downloads
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri https://github.com/mattiewae/update/blob/master/z420/Encoder_V33_16ch.exe?raw=true -OutFile Encoder_V33_16ch.exe
	Copy-Item Encoder_V33_16ch.exe C:\Users\ENG\Desktop
    Copy-Item Encoder_V33_16ch.exe 'C:\Users\ENG\Desktop\Admin Tools'
	Copy-Item Encoder_V33_16ch.exe 'C:\encoder\'
	Remove-Item Encoder_V33_16ch.exe
	Remove-Item C:\Users\ENG\Desktop\encoderV32*.exe 
}
}

function Presets{
    Set-Location $env:TEMP

        $montage = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\MONTAGE.sqpreset"
        $ruw = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\RUW.sqpreset"

            if($montage -and $ruw -eq $true){
            #do nothing
            Write-Host 'presets OK'
            }
            else{
                Set-Location $env:TEMP
	            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/Custom/MONTAGE.sqpreset -OutFile MONTAGE.sqpreset
                Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/Custom/RUW.sqpreset  -OutFile RUW.sqpreset
                New-Item -ItemType Directory "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom"
                Move-Item *.sqpreset "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom"
            }
}

function UpdateApps{
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
}

function Remove-DesktopItems{
    Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
    Remove-Item "C:\Users\Public\Desktop\Avidemux*" -force
    Remove-Item "C:\Users\ENG\Desktop\Mozilla*" -force
    Remove-Item "C:\Users\ENG\Desktop\Boxstarter*" -force
    Remove-Item "C:\Users\Public\Desktop\Libre*" -force
    Remove-Item "C:\Users\Public\Desktop\Chrome*" -force
    Remove-Item "C:\Users\Public\Desktop\Google*" -force
    Remove-Item "C:\Users\Public\Desktop\CCleaner*" -force
    Remove-Item "C:\Users\Public\Desktop\VLC*" -force
    Remove-Item "C:\Users\Public\Desktop\OBS*" -force
    Remove-Item "C:\Users\Public\Desktop\Mozilla*" -force
    Remove-Item "C:\Users\Public\Desktop\Firefox*" -force
    Remove-Item "C:\Users\Public\Desktop\Google*" -force
}

DHD

Presets

ReplaceLaadSettings

UpdateEncoder

UpdateApps

Remove-DesktopItems

Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Log-Message "Update Completed" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"