###########
#VARIABLES#
###########
#Credentials for logging into server
$password="" | ConvertTo-SecureString -AsPlainText -Force
$username=""
$cred = New-Object -TypeName System.Management.Automation.PSCredential `
-argumentlist $username, $password

#Path for UltiPro Release Version 
$version="UltiPro 12.2.1 - 2017 R1 Release\24964 - M3"

#Installer variables
$LocalServer="d20up01ss01"
$dbServer="d20up01db01"
$UPRFile="C:\USG1000 ALL = 1.upr"
$UScontractNumber=”USG1000”
$USsiteType=”1”

#Gateway Account Info
$GatewayUser="context"
$gatewayPass=””
#Dispatch Account Info
$DispatchUser=”hrmsdispatch”
$dispatchPass=””
#SiteAdmin Account Info
$siteAdminUser=”hrmssite”
$siteAdminPass=”site”
#Service account info
$complusUser=”devcorp\svc.qa.mba”
$complusPass=””
#Xpt Account info
$xptUser=”xpt”
$xptPass=””

#dotNet URL info
$dotNetWebUrl=”http://d20up01wb01:80”
$dotNetWebPort=”80”
#classic web url Info
$classicWebUrl=”http://d20up01wb01:81”
$classicWebPort=”81”
$saltPass=”password”

$siteUser=”keyuser”
$sitePassword=””
$saKeyUser=”siteuser”
$saKeyPass=””
$superSiteServer="D20UP01SU01"
$HubExternalServer="D20UP01HBE1"

#HOSTNAMES
#Site Server Hostname
$SS01="D20UP01SS01"
#Database Server Hostname
$DB01="D20UP01DB01"
#Application Server Hostname
$AS01="D20UP01AS01"
#Web Server Hostname
$WB01="D20UP01WB01"
#Terminal Server Hostname
$TS01="D20UP01TS01"
#DPM Server Hostname
$DP01="D20UP01DP01"
#Super Site Server
$SU01="D20UP01SU01"
#Hub External Server
$HBE1="D20UP01HBE1"
#Hub Internal Server- Comment this out if not needed
$HBI="D20UP01HBI1"











