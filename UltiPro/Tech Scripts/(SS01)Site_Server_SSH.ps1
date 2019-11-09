. (Join-Path $PSScriptRoot config.ps1)
$connection = "//denver2/distribution/$version/"
echo $connection


$scriptBlockContent={
If (!(Test-Path L:))
{
New-PSDrive –Name “L” –PSProvider FileSystem –Root $args[0]
  #Deprecated way of mapping drive
  #(New-Object -ComObject WScript.Network).MapNetworkDrive(
  #    "K:", "\\denver2\distribution\$version\", $false
  #  )
}
else {echo "The L: drive is already in use!"}
}


Invoke-Command -ComputerName D20UP01HBI1 -Args $connection -ScriptBlock $scriptBlockContent

