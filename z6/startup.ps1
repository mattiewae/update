function Log-Message{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$LogMessage
    )

    ("{0} - {1}" -f (Get-Date), $LogMessage)
}

Log-Message "Starting update" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"

choco install -y filezilla

function OT{
    Set-Location $env:TEMP
    $OT = Test-Path "C:\Users\ENG\Desktop\Allerlei nuttige dingen\OT.zip"
    $FunctionID = "DHD"

    if($OT -eq $true){
        try{
            Expand-Archive -Path "C:\Users\ENG\Desktop\Allerlei nuttige dingen\OT.zip" -DestinationPath "C:\Users\ENG\Desktop\Allerlei nuttige dingen\OT" -ErrorAction Stop
            }
        Catch{
            $ErrorMessage = $_.Exception.Message
            Write-host $FunctionID 'Unzip OT'    
            Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
            }
    }
    else{
        try{
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri https://github.com/mattiewae/update/raw/master/OT.zip -OutFile "OT.zip" -ErrorAction Stop
            Move-Item "OT.zip" "C:\Users\ENG\Desktop\Allerlei nuttige dingen" -ErrorAction Stop
            Write-Host "OT gedownload"
	        Log-Message "OT gedownload" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
        }
        catch{
            $ErrorMessage = $_.Exception.Message
            Write-host $FunctionID 'Probleem met download OTs, check UpdateLog.txt'   
            Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
        }
    
    }
}

function DHD{
    Set-Location $env:TEMP
    $DHD = Test-Path "C:\Users\ENG\Desktop\Allerlei nuttige dingen\DHD_config_instellingen3.pdf"
    $Versie = Get-ChildItem -Name "C:\Users\ENG\Desktop\Allerlei nuttige dingen\DHD_config_instellingen3.pdf"
    $FunctionID = "DHD"

    if($DHD -eq $true){
        try{
            Write-Host "DHD Documentatie:" $Versie
            Remove-Item "C:\Users\ENG\Desktop\Allerlei nuttige dingen\DHD_config_instellingen2.pdf" -ErrorAction Stop
            }
        Catch{
            $ErrorMessage = $_.Exception.Message
            Write-host $FunctionID 'oude versie PDF al verwijdert'    
            Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
            }
    }
    else{
        try{
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri https://github.com/mattiewae/update/raw/master/AdobePresets/DHD_config_instellingen3.pdf -OutFile "DHD_config_instellingen3.pdf" -ErrorAction Stop
            Move-Item "DHD_config_instellingen3.pdf" "C:\Users\ENG\Desktop\Allerlei nuttige dingen" -ErrorAction Stop
            Write-Host "DHD PDF gedownload"
	    Log-Message "DHD PDF gedownload" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
        }
        catch{
            $ErrorMessage = $_.Exception.Message
            Write-host $FunctionID 'Probleem met download DHD uitleg, check UpdateLog.txt'   
            Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
        }
    
    }
}

function ReplaceLaadSettings{
    Set-Location $env:TEMP
    	$acl = Get-Acl -Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Dagproject.ps1"
	
    $montage = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\MONTAGE.sqpreset"
    $LaadSettings = Test-Path $env:TEMP\LaadSettings.ps1
    if($LaadSettings -and $montage -eq $true){
        Copy-Item $env:TEMP\LaadSettings.ps1 "C:\Users\ENG\Desktop\Admin Tools\Scripts\" -Force 
	Set-Acl -Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\LaadSettings.ps1" -AclObject $acl
        Write-Host 'Script replaced'
    }
    else{
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/AdobePresets/LaadSettins.ps1 -OutFile LaadSettings.ps1
        Write-Host 'Settings downloaded'
    }
}

function ReplaceBackupSettings{
    Set-Location $env:TEMP
    $acl = Get-Acl -Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Dagproject.ps1"
        
    $BackupSettings = Test-Path C:\Users\ENG\AppData\Local\Temp\BackupSettings.ps1
    if($BackupSettings -eq $true){
        Copy-Item C:\Users\ENG\AppData\Local\Temp\BackupSettings.ps1 "C:\Users\ENG\Desktop\Admin Tools\Scripts\" -Force
        Set-Acl -Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\BackupSettings.ps1" -AclObject $acl
        Write-Host 'BackupSettings replaced' 
    }
    else{
        wget https://raw.githubusercontent.com/mattiewae/update/master/AdobePresets/BackupSettings.ps1 -OutFile BackupSettings.ps1
        Write-Host 'BackupSettings downloaded'
    }
}

function UpdateEncoder{
    $encoder = Test-Path C:\encoder\encoder_V33_16CH.exe

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
    $FunctionID = "Presets"
    Set-Location $env:TEMP
        $montage = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\MONTAGE.sqpreset"
        $ruw = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\RUW.sqpreset"

            if($montage -and $ruw -eq $true){
                try{
                    New-Item -ItemType Directory "C:\Users\ENG\Desktop\Allerlei nuttige dingen\Premiere Sequence Settings" -ErrorAction Stop
                    Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\*" -Recurse -Destination 'C:\Users\ENG\Desktop\Allerlei nuttige dingen\Premiere Sequence Settings' -Force -ErrorAction Stop                     
                    Write-Host 'presets OK'
                }
                Catch{
                    $ErrorMessage = $_.Exception.Message
                    $FunctionID    
                    Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
                }
            }
            else{
                try{
                    Set-Location $env:TEMP
	                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                    Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/Custom/MONTAGE.sqpreset -OutFile MONTAGE.sqpreset -ErrorAction Stop
                    Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/Custom/RUW.sqpreset  -OutFile RUW.sqpreset -ErrorAction Stop
                    New-Item -ItemType Directory "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom" -ErrorAction Stop
                    Move-Item *.sqpreset "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom" -ErrorAction Stop
                 
                }
                Catch{
                    $ErrorMessage = $_.Exception.Message
                    $FunctionID    
                    Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
                }
                
            }
}

function PresetsMediaEncoder{
    Set-Location $env:TEMP
    $FunctionID = "Presets"

        $zloudness = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\Faspex zonder loudness.epr"
        $loudness = Test-Path "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\Faspex met loudness.epr"

            if($loudness -and $zloudness -eq $true){
                Try{
                    Write-Host "Presets reeds gekopieerd"
                    Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\" -Recurse -Destination "C:\Users\ENG\Desktop\Allerlei nuttige dingen\" -ErrorAction Stop
                }
                Catch{
                    $ErrorMessage = $_.Exception.Message
                    Write-host $FunctionID 'Presets Media Encoder reeds gekopieerd'    
                    Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
                    }
                }
            else{
                Try{
                    Write-Host "Download Presets"
                     Set-Location $env:TEMP
	                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                    Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/FASPEX%20met%20loudness.epr -OutFile "Faspex met loudness.epr" -ErrorAction Stop
                    Invoke-WebRequest -Uri https://raw.githubusercontent.com/mattiewae/update/master/z420Stag/Presets/FASPEX%20zonder%20loudness.epr  -OutFile "Faspex zonder loudness.epr" -ErrorAction Stop
                    New-Item -ItemType Directory "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\" -ErrorAction ignore







































Move-Item *.epr "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Media Encoder Presets\" -ErrorAction Stop
                }
                Catch{
                    $ErrorMessage = $_.Exception.Message
                    Write-host $FunctionID 'Probleem bij Download Presets'    
                    Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
                    }
                }
            }  

function UpdateApps{
    Write-host "Update Windows Apps"
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
    Remove-Item "C:\Users\ENG\Desktop\Microsoft*" -force
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

function SettingsGUI{
	Set-Location $env:TEMP
    
    try{
        Remove-Item "$env:TEMP\LaadSettingsGUI.exe" -ErrorAction Ignore
        Remove-Item "$env:HOMEPATH\Desktop\LaadSettingsGUI.exe" -ErrorAction Ignore
    }
    catch{
        $ErrorMessage = $_.Exception.Message
        Log-Message $ErrorMessage | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
    }

    $FunctionID = Log-Message "SettingsGUI" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
	$SettingsGUI_TEMP = Test-Path "$env:TEMP\LaadSettingsGUI_V2.exe"
    $SettingsGUI_DESKTOP = Test-Path "$env:HOMEPATH\Desktop\LaadSettingsGUI_V2.exe"

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
                Copy-Item LaadSettingsGUI_V2.exe -Destination $env:HOMEPATH\desktop -ErrorAction Stop
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

function ClearAdobeMediaCache{
	$limit = (Get-Date).AddDays(-10)
	$MediaCache = "E:\media cache database\Media Cache"
		# Delete files older than the $limit.
		Get-ChildItem -Path $MediaCache -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force
		# Delete any empty directories left behind after deleting the old files.
		Get-ChildItem -Path $MediaCache -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse
    
    $CacheFiles = "E:\media cache\Media Cache Files"
        # Delete files older than the $limit.
		Get-ChildItem -Path $CacheFiles -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force
		# Delete any empty directories left behind after deleting the old files.
		Get-ChildItem -Path $CacheFiles -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse

    $PeakFiles = "E:\media cache\Peak Files"
        # Delete files older than the $limit.
		Get-ChildItem -Path $PeakFiles -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force
		# Delete any empty directories left behind after deleting the old files.
		Get-ChildItem -Path $PeakFiles -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse

    $P2 = "E:\P2"
        # Delete files older than the $limit.
		Get-ChildItem -Path $P2 -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force
		# Delete any empty directories left behind after deleting the old files.
		Get-ChildItem -Path $P2 -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse

    $AdobeImport = "E:\AdobeImport"
        # Delete files older than the $limit.
		Get-ChildItem -Path $AdobeImport -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force
		# Delete any empty directories left behind after deleting the old files.
		Get-ChildItem -Path $AdobeImport -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse
 }
	
	OT
    	ClearAdobeMediaCache
	SettingsGUI
	ClearAdobeExport
	PresetsMediaEncoder
	DHD
	Presets
	ReplaceLaadSettings
	ReplaceBackupSettings
	UpdateEncoder
	UpdateApps
	Remove-DesktopItems
	Install-WindowsUpdate -acceptEula -SuppressReboots -criteria "BrowseOnly=0 and IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'"

Log-Message "Update Completed" | Out-File -Append "C:\Users\ENG\Desktop\Admin Tools\UpdateLog.txt"
