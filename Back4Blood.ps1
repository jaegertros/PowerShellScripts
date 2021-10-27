#Requires -version 2 -RunAsAdministrator
<#
.SYNOPSIS
  <Overview of script>
.DESCRIPTION
  <Brief description of script>
.PARAMETER <Parameter_Name>
    <Brief description of parameter input required. Repeat this attribute if required>
.INPUTS
  <Inputs if any, otherwise state None>
.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
.NOTES
  Version:        1.0
  Author:         Caleb Waddell
  Creation Date:  2021-10-27
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

#Dot Source required Function Libraries
#. "C:\Scripts\Functions\Logging_Functions.ps1"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
#$sScriptVersion = "1.0"

#Log File Info
#$sLogPath = "C:\Windows\Temp"
#$sLogName = "<script_name>.log"
#$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#-----------------------------------------------------------[Functions]------------------------------------------------------------

<#
Function <FunctionName>{
  Param()
  
  Begin{
    Log-Write -LogPath $sLogFile -LineValue "<description of what is going on>..."
  }
  
  Process{
    Try{
      <code goes here>
    }
    
    Catch{
      Log-Error -LogPath $sLogFile -ErrorDesc $_.Exception -ExitGracefully $True
      Break
    }
  }
  
  End{
    If($?){
      Log-Write -LogPath $sLogFile -LineValue "Completed Successfully."
      Log-Write -LogPath $sLogFile -LineValue " "
    }
  }
}
#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Log-Start -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion
#Script Execution goes here
#Log-Finish -LogPath $sLogFile



Write-Host "Checking for elevated permissions..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
Write-Warning "Insufficient permissions to run this script. Opening the PowerShell console as an administrator and running this script again."
Start-Process Powershell -ArgumentList $PSCommandPath -Verb RunAs
Break
}
else {
Write-Host "Code is running as administrator — go on executing the script..." -ForegroundColor Green
}

$title    = 'Steam Firewall'
$question = 'Do you want to allow Steam through your firewall?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	New-NetFirewallRule -DisplayName "Steam Outbound-TCP" -Direction Outbound -LocalPort 27015,27036 -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Steam Inbound-TCP" -Direction Outbound -LocalPort 27015,27036 -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Steam Outbound-UDP" -Direction Outbound -LocalPort 27015,27031-27036 -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Steam Inbound-UDP" -Direction Outbound -LocalPort 27015,27031-27036 -Protocol UDP -Action Allow
} else {
    Write-Host 'Ignoring firwall rules for Steam.'
}

$title    = 'Steam EXE Firewall'
$question = 'Do you want to allow the Steam executable through your firewall? (select "No" if Steam is not installed in the default location)'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	New-NetFirewallRule -DisplayName "Steam EXE Outbound-TCP" -Direction Outbound -Program "C:\Program Files (x86)\Steam\steam.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Steam EXE Inbound-TCP" -Direction Inbound -Program "C:\Program Files (x86)\Steam\steam.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Steam EXE Outbound-UDP" -Direction Outbound -Program "C:\Program Files (x86)\Steam\steam.exe" -LocalPort Any -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Steam EXE Inbound-UDP" -Direction Inbound -Program "C:\Program Files (x86)\Steam\steam.exe" -LocalPort Any -Protocol UDP -Action Allow
} else {
    Write-Host 'Ignoring firwall rules for Steam EXE.'
}


$title    = 'Battle.net Firewall'
$question = 'Do you want to allow Battle.net through your firewall?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	New-NetFirewallRule -DisplayName "Battlenet Outbound-TCP" -Direction Outbound -LocalPort 1119 -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Battlenet Inbound-TCP" -Direction Inbound -LocalPort 1119 -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Battlenet Outbound-UDP" -Direction Outbound -LocalPort 1119 -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Battlenet Inbound-UDP" -Direction Inbound -LocalPort 1119 -Protocol UDP -Action Allow
} else {
    Write-Host 'Ignoring firwall rules for Battle.net.'
}

$title    = 'Battle.net EXE Firewall'
$question = 'Do you want to allow the Battle.net executable through your firewall? (select "No" if Battle.net is not installed in the default location)'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	New-NetFirewallRule -DisplayName "Battle.net EXE Outbound-TCP" -Direction Outbound -Program "C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Battle.net EXE Inbound-TCP" -Direction Inbound -Program "C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Battle.net EXE Outbound-UDP" -Direction Outbound -Program "C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe" -LocalPort Any -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Battle.net EXE Inbound-UDP" -Direction Inbound -Program "C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe" -LocalPort Any -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Battle.net EXE Outbound-TCP" -Direction Outbound -Program "C:\Program Files (x86)\Battle.net\Battle.net.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Battle.net EXE Inbound-TCP" -Direction Inbound -Program "C:\Program Files (x86)\Battle.net\Battle.net.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Battle.net EXE Outbound-UDP" -Direction Outbound -Program "C:\Program Files (x86)\Battle.net\Battle.net.exe" -LocalPort Any -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Battle.net EXE Inbound-UDP" -Direction Inbound -Program "C:\Program Files (x86)\Battle.net\Battle.net.exe" -LocalPort Any -Protocol UDP -Action Allow
} else {
    Write-Host 'Ignoring firwall rules for Battle.net EXE.'
}


$title    = 'Epic Games Firewall'
$question = 'Do you want to allow Battle.net through your firewall?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
New-NetFirewallRule -DisplayName "Epic Games Outbound-TCP" -Direction Outbound -LocalPort 433,3478-3479,5060,5062,5222,6250,12000-65000 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Epic Games Inbound-TCP" -Direction Inbound -LocalPort 433,3478-3479,5060,5062,5222,6250,12000-65000 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Epic Games Outbound-UDP" -Direction Outbound -LocalPort 3478-3479,5060,5062,6250,12000-65000 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Epic Games Inbound-UDP" -Direction Inbound -LocalPort 3478-3479,5060,5062,6250,12000-65000 -Protocol UDP -Action Allow
} else {
    Write-Host 'Ignoring firwall rules for Epic Games.'
}

$title    = 'Epic Games EXE Firewall'
$question = 'Do you want to allow the Epic Games executable through your firewall? (select "No" if Epic Games is not installed in the default location)'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	New-NetFirewallRule -DisplayName "Epic Games EXE Outbound-TCP" -Direction Outbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\EpicGamesLauncher.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Inbound-TCP" -Direction Inbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\EpicGamesLauncher.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Outbound-UDP" -Direction Outbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\EpicGamesLauncher.exe" -LocalPort Any -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Inbound-UDP" -Direction Inbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\EpicGamesLauncher.exe" -LocalPort Any -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Outbound-TCP" -Direction Outbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win64\EpicGamesLauncher.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Inbound-TCP" -Direction Inbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win64\EpicGamesLauncher.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Outbound-UDP" -Direction Outbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win64\EpicGamesLauncher.exe" -LocalPort Any -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Inbound-UDP" -Direction Inbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win64\EpicGamesLauncher.exe" -LocalPort Any -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Outbound-TCP" -Direction Outbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Portal\Extras\Overlay\EOSOverlayRenderer-Win64-Shipping.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Inbound-TCP" -Direction Inbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Portal\Extras\Overlay\EOSOverlayRenderer-Win64-Shipping.exe" -LocalPort Any -Protocol TCP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Outbound-UDP" -Direction Outbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Portal\Extras\Overlay\EOSOverlayRenderer-Win64-Shipping.exe" -LocalPort Any -Protocol UDP -Action Allow
	New-NetFirewallRule -DisplayName "Epic Games EXE Inbound-UDP" -Direction Inbound -Program "C:\Program Files (x86)\Epic Games\Launcher\Portal\Extras\Overlay\EOSOverlayRenderer-Win64-Shipping.exe" -LocalPort Any -Protocol UDP -Action Allow
} else {
    Write-Host 'Ignoring firwall rules for Epic Games EXE.'
}


<#

STEAM

TCP: 27015,27036
UDP: 27015,27031-27036

C:\Program Files (x86)\Steam\steam.exe




Epic Games

C:\Program Files (x86)\Epic Games\Launcher\Portal\Extras\Overlay\EOSOverlayRenderer-Win64-Shipping.exe

Epic Games Launcher - PC
TCP: 433,3478-3479,5060,5062,5222,6250,12000-65000
UDP: 3478-3479,5060,5062,6250,12000-65000



Battle.net

Battle.net Desktop Application - PC
TCP: 1119
UDP: 1119



Microsoft Store - PC
TCP: 53,80,3074
UDP: 53,88,500,3074,3544,4500

Origin - PC
TCP: 1024-1124,3216,9960-9969,18000,18060,18120,27900,28910,29900
UDP: 1024-1124,18000,29900

Apex Legends - Steam
TCP: 1024-1124,3216,9960-9969,18000,18060,18120,27015,27036,27900,28910,29900
UDP: 1024-1124,18000,27015,27031-27036,29900,37000-40000


Apex Legends - PC
TCP: 1024-1124,3216,9960-9969,18000,18060,18120,27900,28910,29900
UDP: 1024-1124,18000,29900,37000-40000





Get-NetTCPConnection | Sort-Object OwningProcess


#>