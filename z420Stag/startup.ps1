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
    Invoke-WebRequest -Uri https://github.com/mattiewae/update/raw/master/z420Stag/DHD_config_instellingen2.pdf -OutFile "DHD_config_instellingen2.pdf"
    Move-Item "DHD_config_instellingen2.pdf" "C:\Users\ENG\Desktop\Allerlei nuttige dingen"
    }
}

function ReplaceLaadSettings{
    Set-Location $env:TEMP
    
    $montage = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\MONTAGE.sqpreset"
    $LaadSettings = Test-Path $env:TEMP\LaadSettings.ps1
    if($LaadSettings -and $montage -eq $true){
        Move-Item $env:TEMP\LaadSettings.ps1 "C:\Users\ENG\Desktop\Admin Tools\Scripts\" -Force 
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

        #$montage = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\MONTAGE.sqpreset"
        $ruw = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\RUW.sqpreset"

            if($montage -and $ruw -eq $true){
            #do nothing
            Write-Host 'presets OK'
            New-Item -ItemType Directory "C:\Users\ENG\Desktop\Allerlei nuttige dingen\Premiere Sequence Settings" -Force
            Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\*" -Recurse -Destination 'C:\Users\ENG\Desktop\Allerlei nuttige dingen\Premiere Sequence Settings' -Force
            }
            else{
                New-Item -ItemType Directory "C:\Users\ENG\Desktop\Allerlei nuttige dingen\Premiere Sequence Settings" -Force
                Set-Location $env:TEMP
	            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/Custom/MONTAGE.sqpreset -OutFile MONTAGE.sqpreset
                Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/Custom/RUW.sqpreset  -OutFile RUW.sqpreset
                New-Item -ItemType Directory "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom"
                Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\*" -Recurse -Destination 'C:\Users\ENG\Desktop\Allerlei nuttige dingen\Premiere Sequence Settings' -Force
                Move-Item *.sqpreset "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom" -Force
            }
}

function PresetsMediaEncoder{
    Set-Location $env:TEMP

        $zloudness = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\Faspex zonder loudness.epr"
        $loudness = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\Faspex met loudness.epr"

            if($loudness -and $zloudness -eq $true){
            Remove-Item "C:\Users\ENG\Documents\Adobe\Adobe Media Encoder\11.0\Presets\*" -Force
            Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\" -Recurse -Destination "C:\Users\ENG\Desktop\Allerlei nuttige dingen\" -Force
            Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\Faspex zonder loudness.epr" -Destination "C:\Users\ENG\Documents\Adobe\Adobe Media Encoder\11.0\Presets" -Force
            Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\Faspex met loudness.epr" -Destination "C:\Users\ENG\Documents\Adobe\Adobe Media Encoder\11.0\Presets" -Force
            }
            else{
                Set-Location $env:TEMP
	            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/FASPEX%20met%20loudness.epr -OutFile "Faspex met loudness.epr"
                Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/FASPEX%20zonder%20loudness.epr  -OutFile "Faspex zonder loudness.epr"
                New-Item -ItemType Directory "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\"
                Move-Item *.epr "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\"
                Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\Faspex zonder loudness.epr" -Destination "C:\Users\ENG\Documents\Adobe\Adobe Media Encoder\11.0\Presets" -Force
                Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\Faspex met loudness.epr" -Destination "C:\Users\ENG\Documents\Adobe\Adobe Media Encoder\11.0\Presets" -Force
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

function ClearAdobeExport{
	$limit = (Get-Date).AddDays(-10)
	$path = "E:\AdobeExport"
		# Delete files older than the $limit.
		Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force
		# Delete any empty directories left behind after deleting the old files.
		Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse
}

function BasisProject{
    Set-Location $env:TEMP
	            
    $basisProject = Test-Path "$env:TEMP\BasisProject.prproj"

    if($basisProject -eq $true){
        Copy-Item BasisProject.prproj -Destination "C:\Users\ENG\Desktop\Admin Tools\Scripts" -Force
    }
    else{
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri https://github.com/mattiewae/update/raw/master/z420Stag/BasisProject.prproj -OutFile BasisProject.prproj
    }
    
}

BasisProject

ClearAdobeExport

PresetsMediaEncoder

DHD

Presets

ReplaceLaadSettings

UpdateEncoder

UpdateApps

Remove-DesktopItems

Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Log-Message "Update Completed" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
