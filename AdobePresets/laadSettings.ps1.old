Set-Location C:\Users\ENG\Documents\AdobeUserSettings

#Remove-Item "C:\Users\ENG\Documents\Adobe\Premiere Pro\11.0\Profile-ENG\*" -Force -Recurse

# Maak lijst van settings 
#$list = Get-ChildItem -Path C:\Users\ENG\Documents\settings | Where-Object {$_.PSIsContainer} | Foreach-Object {$_.Name}
$list = @(Get-ChildItem | Where-Object { $_.PSIsContainer })
#$PremiereProPrefs = "C:\Users\ENG\Desktop\Admin Tools\Scripts\Adobe Premiere Pro Prefs";
$SequencePresets = "C:\Users\ENG\Desktop\Admin Tools\Scripts\Custom";
$AdobeSettings = "C:\Users\ENG\Documents\Adobe\Premiere Pro\11.0\Profile-ENG";

# Toon all settings
Write-Host 'User Settings:'
write-host "---------------"
write $list.name
write-host "`n"

$user = Read-Host 'Welke settings wil je laden?'

# Check of settings bestaan, indien ja kopieer settings. Indien niet, error settings niet gevonden. 
$checkfile = Test-Path $user

if($checkfile -eq 'true'){
    # Remove-Item $AdobeSettings\* -Recurse
    Remove-Item "C:\Users\ENG\Documents\Adobe\Premiere Pro\11.0\Profile-ENG\*" -Force -Recurse
    Copy-Item  $user\* $AdobeSettings -Recurse -Force -Verbose
    Write-Host "Gelukt! Settings zijn gekopieerd."
    Remove-Item 'C:\Users\ENG\Documents\Adobe\Premiere Pro\11.0\Profile-ENG\Settings\Custom' -Force -Recurse
    Copy-Item "C:\Users\ENG\Desktop\Admin Tools\Scripts\Presets\Custom\" 'C:\Users\ENG\Documents\Adobe\Premiere Pro\11.0\Profile-ENG\Settings\Custom' -Force -Recurse
}
else{
    write-host "`n"
    Write-Host "Settings niet gevonden, kopieer eerst je settings naar de map 'AdobeUserSettings' in mijn documenten"}




    
