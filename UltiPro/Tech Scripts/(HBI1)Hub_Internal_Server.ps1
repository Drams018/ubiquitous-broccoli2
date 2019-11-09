. (Join-Path $PSScriptRoot config.ps1)

#Test new UltiPro Install
$IE=new-object -com internetexplorer.application
$IE.navigate2($dotNetWebUrl)
$IE.visible=$true