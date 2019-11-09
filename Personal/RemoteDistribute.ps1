
#Script to remotely copy desired files from a network location to multiple other machines.  


#Script run on each server
$mapDriveBlockContent={
#If (!(Test-Path L:))
#{
#New-PSDrive –Name “L” –PSProvider FileSystem –Root $args[0]
  #Deprecated way of mapping drive
  #(New-Object -ComObject WScript.Network).MapNetworkDrive(
    #  "L:", $args[0], $true, "uscorp\user", "password")

    #net use l: $args[0] /persistent:yes /user:uscorp\dylanr "TasoTacoSpring2017"
    #$siteInstall=$args[0]+"\NET CD Structure\Server\"

#}
#else {echo "The L: drive is already in use!"}

#Map to network drive
net use l: $args[0] /persistent:yes /user:uscorp\dylanr "TasoTacoSpring2017"
#Copy desired item to desired folder
Copy-Item $args[1] "C:\"
Copy-Item $args[2] "C:\"
Copy-Item $args[3] "C:\"
Copy-Item $args[4] "C:\"
Copy-Item $args[5] "C:\"
Copy-Item $args[6] "C:\"
Copy-Item $args[7] "C:\"
Copy-Item $args[8] "C:\"

}

#Map to UltiPro Installation Folder . 
Invoke-Command -ComputerName $SS01, $DB01, $AS01, $WB01, $TS01, $DP01, $SU01, $HBE1, $HBI -Args $connection,$siteInstallLocation,
$companyInstallLocation,$webServerInstallLocation,$applicationServerInstallLocation,$terminalServerInstallLocation,$DPMServerInstallLocation,
$superSiteInstallLocation,$hubExternalInstallLocation -ScriptBlock $mapDriveBlockContent