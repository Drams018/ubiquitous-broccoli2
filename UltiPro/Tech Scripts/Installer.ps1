#Grab variables from config file
. (Join-Path $PSScriptRoot config.ps1)

#Set drive variable.  May move to config file.
$connection = "\\denver2\distribution\$version"
$siteInstallLocation="L:\NET CD Structure\Server\Site Server.msi"
$companyInstallLocation="L:\NET CD Structure\Server\Company Server.msi"
$webServerInstallLocation="L:\NET CD Structure\UltiProWeb\Web Server.msi"
$applicationServerInstallLocation="L:\NET CD Structure\Application Server\Application Server.msi"
$terminalServerInstallLocation="L:\NET CD Structure\Client\BackOffice Server.msi"
$DPMServerInstallLocation="L:\NET CD Structure\DPM\DPM Server.msi"
$superSiteInstallLocation="L:\NET CD Structure\Server\Super Site Server.msi"
$hubExternalInstallLocation="L:\Intersourcing\SuperSite\UltiPro Enterprise Server - Super Site Edition.msi"




#Enable persistent connections to desired servers
#$s = New-PSSession -ComputerName $SS01, $DB01, $AS01, $WB01, $TS01, $DP01, $SU01, $HBE1, $HBI


#Script block to map drive
$mapDriveBlockContent={
If (!(Test-Path L:))
{
#New-PSDrive –Name “L” –PSProvider FileSystem –Root $args[0]
  #Deprecated way of mapping drive
  #(New-Object -ComObject WScript.Network).MapNetworkDrive(
    #  "L:", $args[0], $true, "uscorp\user", "password")

    #net use l: $args[0] /persistent:yes /user:uscorp\dylanr "TasoTacoSpring2017"
    #$siteInstall=$args[0]+"\NET CD Structure\Server\"

}
else {echo "The L: drive is already in use!"}
net use l: $args[0] /persistent:yes /user:uscorp\dylanr "TasoTacoSpring2017"
Copy-Item $args[1] "C:\"
Copy-Item $args[2] "C:\"
Copy-Item $args[3] "C:\"
Copy-Item $args[4] "C:\"
Copy-Item $args[5] "C:\"
Copy-Item $args[6] "C:\"
Copy-Item $args[7] "C:\"
Copy-Item $args[8] "C:\"

net use n: "\\denver2\baselines\UTILITY MASTER\ULTI REGISTER" /persistent:yes /user:uscorp\dyanr "TasoTacoSpring2017"
Copy-Item "USG1000 ALL = 1.upr" "C:\"

Invoke-Sqlcmd -Query "EXEC XP_CMDSHELL 'net use Y: \\denver2\\baselines\UTILITY MASTER\UTILITY INSTALL SCRIPTS' "  -ServerInstance $args[0] 
Invoke-Sqlcmd -InputFile "1---AutoUpdate JOB + Update DeployDB.sql"   -ServerInstance $args[0]

Invoke-Sqlcmd -Query "EXEC XP_CMDSHELL 'net use Y: \\denver2\\baselines\UTILITY MASTER\UTILITY INSTALL SCRIPTS' "  -ServerInstance $args[1] 
Invoke-Sqlcmd -InputFile "1---AutoUpdate JOB + Update DeployDB.sql"   -ServerInstance $args[1]

#Copy-Item -Path "$args[0]\NET CD Structure\Server\Site Server.msi\" -Destination 'c:\Users'
}

$SiteServerInstallBlock={


#msiexec.exe /i "Site Server.msi" /l*v "C:\Site Server.msi.log" /qn INSTALLDIR="C:\Windows\" US_LOCAL_SERVER=$LocalServer US_LOCAL_AUTHENTICATION="0" US_LOCAL_USERNAME="" US_GATEWAY_USERNAME=$GatewayUser US_DISPATCH_USERNAME=$DispatchUser
#US_SITEADMIN_USERNAME=$siteAdminUser US_UPR_FILE=$UPRFile US_CONTRACT_NUMBER=$UScontractNumberUS_SITETYPE=$USsiteType US_ALTERNATE_DOMAIN="" US_DOTNETWEB_URL=$dotNetWebUrl US_CLASSICWEB_URL=$classicWebUrl US_IEXROOTPATH="" US_COMPLUS_USERNAME=$complusUser US_LOCAL_PASSWORD="" US_GATEWAY_PASSWORD=$gatewayPass US_DISPATCH_PASSWORD=$dispatchPass US_SITEADMIN_PASSWORD=$siteAdminPass US_COMPLUS_PASSWORD=$complusPass ADDLOCAL="Hidden,KeyPairCreator,SiteServer"

msiexec.exe /i "Site Server.msi" /l*v "C:\Site Server.msi.log" /qn INSTALLDIR="C:\Windows\" US_LOCAL_SERVER=$args[0] US_LOCAL_AUTHENTICATION="0" US_LOCAL_USERNAME="" US_GATEWAY_USERNAME=$args[1] US_DISPATCH_USERNAME=$args[2] US_SITEADMIN_USERNAME=$args[3] US_UPR_FILE=$args[4] US_CONTRACT_NUMBER=$args[5] US_SITETYPE=$args[6] US_ALTERNATE_DOMAIN="" US_DOTNETWEB_URL=$args[7] US_CLASSICWEB_URL=$args[8] US_IEXROOTPATH="" US_COMPLUS_USERNAME=$args[9] US_LOCAL_PASSWORD="" US_GATEWAY_PASSWORD=$args[10] US_DISPATCH_PASSWORD=$args[11] US_SITEADMIN_PASSWORD=$args[12] US_COMPLUS_PASSWORD=$args[13] ADDLOCAL="Hidden,KeyPairCreator,SiteServer"


 }
$companyInstallBlock={
msiexec.exe /i "Company Server.msi" /l*v "C:\Company Server.msi.log" /qn INSTALLDIR="C:\Program Files (x86)\US Group\" US_LOCAL_SERVER=$args[0] US_LOCAL_AUTHENTICATION="0" US_LOCAL_USERNAME="" US_SITE_SERVER=$args[1] US_SITE_AUTHENTICATION="0" US_SITE_USERNAME="" US_XPT_USERNAME=$args[2] US_COMPLUS_USERNAME="devcorp\svc.qa.mba" US_LOCAL_PASSWORD="" US_SITE_PASSWORD="" US_XPT_PASSWORD=$args[3] US_COMPLUS_PASSWORD=$args[4] ADDLOCAL="Hidden,Common,CompanyServer,CreateCompany,LockService,ReportServer,System,USGSOAPServer,UltiProForWindows"
}
$webServerInstallBlock={
msiexec.exe /i "Web Server.msi" /l*v "C:\Web Server.msi.log" /qn INSTALLDIR="C:\Program Files (x86)\US Group\" US_COMPLUS_USERNAME=$args[0] US_SITESERVER=$args[1] US_SITEUSER=$args[2] US_USE_SSL="" US_DOTNETWEB_URL="" US_DOTNETWEB_PORTNUMBER=$args[3] US_DOTNETWEB_SSL_PORTNUMBER="" US_DOTNETWEB_IPADDRESS="" US_CLASSICWEB_URL="" US_CLASSICWEB_PORTNUMBER=$args[4] US_CLASSICWEB_SSL_PORTNUMBER="" US_CLASSICWEB_IPADDRESS="" US_WEB_USERNAME=$args[0] US_CERTIFICATE="" US_CLASSICWEB_CERTIFICATE="" US_COMPLUS_PASSWORD=$args[5] US_SITEPASSWORD=$args[6] US_USSALT=$args[7] US_WEB_PASSWORD=$args[5] US_CERTIFICATE_PASSWORD="" US_CLASSICWEB_CERTIFICATE_PASSWORD="" ADDLOCAL="SystemFolder,Hidden,CommonFiles,ConnectASP,ConnectASP_DynamicFiles,ConnectASP_Files,UltiProNet,UltiProNet_Files"
}
$applicationServerInstallBlock={
msiexec.exe /i "Application Server.msi" /l*v "C:\Application Server.msi.log" /qn INSTALLDIR="C:\Program Files (x86)\US Group\" US_PORTNUMBER=$args[0] US_SITESERVER=$args[1] US_SERVICE_USERNAME=$args[2] US_REGKEY="" US_REGKEY_USERNAME="" US_COMPLUS_USERNAME=$args[2] US_UPLOADPORT="10500" US_DOWNLOADPORT="10500" US_SITEUSER=$args[3] US_SITE_ACCESS_KEY="" US_UTAEMPLOYEE_INTERVAL="10" US_UTASETUP_INTERVAL="10" US_UTATEAMHIERARCHY_INTERVAL="10" US_WEBSITE_SELECTOR="1" US_WEBSITE="" US_UTAPORTNUMBER=$args[4] US_SAKEY_USERNAME=$args[5] US_SERVICE_PASSWORD=$args[6] US_REGKEY_PASSWORD="" US_COMPLUS_PASSWORD=$args[6] US_SITEPASSWORD=$args[7] US_USSALT=$args[8] US_SAKEY_PASSWORD=$args[9] ADDLOCAL="ROE,Shared,AppServerCommon,UltiProPlugins,BatchNotifications,ClientFileCleanup,ConfigStoreUltiProComponents,UES,CoreFiles,DpmWorkflow,EmployeePhoto,FileManagement,FormsEngine,HRCompliance,MetaPlatform,OnboardingIntegrationUltiPro,PSTaxFiling,PartnerIntegration,PayrollServices,SSIV1Service,System,TalentIntegrationUltiPro,TalentManagement,TaxFilingUltiPro,TimeManagementUltiPro,UCNetwork,UltiProIntegrations,UltiProServices,Utilities,WcfRouter,WorkflowApproval,YearEndSite"
}
$terminalServerInstallBlock={
msiexec.exe /i "BackOffice Server.msi" /l*v "C:\BackOffice Server.msi.log" /qn INSTALLDIR="C:\Program Files (x86)\US Group\" US_COMPLUS_USERNAME=$args[0] US_SITESERVER=$args[1] US_SITEUSER=$args[2] US_COMPLUS_PASSWORD=$args[3] US_SITEPASSWORD=$args[4] US_USSALT=$args[5] ADDLOCAL="SMC,BackOffice,ApplicationFiles,Client,PlugIns,Common,CommonFilesFolder1,DelphiChromium,HelpFiles,LockManager,Novell,PAC,SMC_Files,SMC_Help,ServerManager,SystemFolder1,SystemFolder2"
}
$DPMServerInstallBlock={
msiexec.exe /i "DPM Server.msi" /l*v "C:\DPM Server.msi.log" /qn INSTALLDIR="C:\Program Files (x86)\US Group\" US_SITESERVER=$args[0] US_SERVICE_USERNAME=$args[1] US_COMPLUS_USERNAME=$args[1] US_SITEUSER=$args[2] US_SAKEY_USERNAME=$args[3] US_RUNLOGPATH="" US_DPSLOGPATH="" US_SERVICE_PASSWORD=$args[4] US_COMPLUS_PASSWORD=$args[4] US_SITEPASSWORD=$args[5] US_USSALT=$args[6] US_SAKEY_PASSWORD=$args[7] ADDLOCAL="DistributedProcessManager,Plugins,ApplicationFiles1,ProcessAutomation,ApplicationFiles2,DPMServer,Common,CommonFilesFolder0,CommonFilesFolder1,UltiProPlugins,ConfigStoreUltiProComponents,UES,CoreFiles,DPMRoutines,LogManager,ReportServices,SystemFolder1,SystemFolder2,UltiproForWindows"
}
$superSiteInstallBlock={
msiexec.exe /i "Super Site Server.msi" /l*v "C:\Super Site Server.msi.log" /qn INSTALLDIR="C:\Windows\" US_LOCAL_SERVER=$args[0] US_LOCAL_AUTHENTICATION="0" US_LOCAL_USERNAME="" US_LOCAL_PASSWORD="" ADDLOCAL="Hidden,SuperSite"
}
$hubExternalInstallBlock={
msiexec.exe /i "UltiPro Enterprise Server - Super Site Edition.msi" /l*v "C:\UltiPro Enterprise Server - Super Site Edition.msi.log" /qn INSTALLDIR="C:\Program Files (x86)\Ultimate Software\UltiPro Enterprise Server\" US_SERVICE_USERNAME=$args[0] US_SUPER_SITE_DATABASE_NAME=$args[1]  US_ROUTER_DNS= $args[2] US_ROUTER_TCP_PORT="55556" US_SERVICE_IS_LOAD_BALANCED="" US_LOAD_BALANCER_DNS="" US_CERTIFICATE_NAME="" US_ROUTER_TCP_PORT_SECURED="55555" US_W2_OFX_SERVERNAME="" US_SERVICE_PASSWORD=$args[3] ADDLOCAL="ARRRouting,UES,BIDataServices,Common,CoreFiles,SuperSite,OmServicesGeneratedComponents,SystemAlertComponents,TaxFilingComponents,TimeManagementComponents,iPhoneComponents"
}



#Map to UltiPro Installation Folder . 
Invoke-Command -ComputerName $SS01, $DB01, $AS01, $WB01, $TS01, $DP01, $SU01, $HBE1, $HBI -Args $connection,$siteInstallLocation,
$companyInstallLocation,$webServerInstallLocation,$applicationServerInstallLocation,$terminalServerInstallLocation,$DPMServerInstallLocation,
$superSiteInstallLocation,$hubExternalInstallLocation -ScriptBlock $mapDriveBlockContent

#Install Site Server.msi
#Invoke-Command -ComputerName $SS01 -Args $SS01,$GatewayUser,$DispatchUser,$siteAdminUser,$UPRFile,
#$UScontractNumber,$USsiteType,$dotNetWebUrl,$classicWebUrl,$complusUser,$gatewayPass,$dispatchPass,$siteAdminPass,$complusPass -ScriptBlock $SiteServerInstallBlock

#Install Company Server.msi
#Invoke-Command -ComputerName $DB01 -Args $DB01,$LocalServer,$xptUser,$xptPass,$complusPass  -ScriptBlock $companyInstallBlock

#Install Web Server.msi
#Invoke-Command -ComputerName $WB01 -Args $complusUser,$SS01,$siteUser,$dotNetWebPort,$classicWebPort,$complusPass,$sitePassword,$saKeyPass -ScriptBlock $webServerInstallBlock

#Install Application Server.msi
#Invoke-Command -ComputerName $AS01 -Args $dotNetWebPort,$SS01,$complusUser,$siteUser,$classicWebPort, $saKeyUser, $complusPass,$sitePassword, $saltPass, $saKeyPass -ScriptBlock $applicationServerInstallBlock

#Install terminal server.msi
#Invoke-Command -ComputerName $TS01 -Args $complusUser,$SS01,$siteUser,$complusPass,$sitePassword,$saltPass  -ScriptBlock $terminalServerInstallBlock

#Install DPM Server
#Invoke-Command -ComputerName $DP01 -Args $SS01,$complusUser,$siteUser,$saKeyUser,$complusPass,$sitePassword,$saltPass,$saKeyPass  -ScriptBlock $DPMServernstallBlock

#Install Super Site .msi
#Invoke-Command -ComputerName $SU01 -Args $SS01 -ScriptBlock $superSiteInstallBlock

#Install hub externtal Block
#Invoke-Command -ComputerName $HBE1 -Args $complusUser,$SU01,$HBE1,$complusPass  -ScriptBlock $hubExternalInstallBlock



#Test new UltiPro Install
$IE=new-object -com internetexplorer.application
$IE.navigate2($dotNetWebUrl)
$IE.visible=$true