#Remove Soft Galss

Clear-Host

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
    Exit 0
}

$Galss = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -match "Galss"}

if($Galss) {
    Write-Host "Galss en cours de desinstallation."
    $Galss.uninstall()
    Clear-Host
    Write-Host "Galss en cours de desinstallation."
    Write-Host "Galss supprime."
} else {
    Write-Host "Galss non present sur le poste." 
}

#Remove File Galss.ini

Write-Host "Suppression residu galss.ini."
Remove-Item -Path C:\Windows\* -Include galss.ini
Remove-Item -Path C:\* -Include galss

Write-Host "Fin du script."
Start-Sleep -Seconds 2