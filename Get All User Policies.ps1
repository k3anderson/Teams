<#
.SYNOPSIS
Get Teams Policies assigned to all enabled users
.INPUTS
CSV path
.OUTPUTS
CSV of all Policies
.NOTES
    Version:            1.0
    Author:             Kyle Anderson
    Creation Date:      24 Sep 2020
    Required Module:    MicrosoftTeams
    Note:               Blank/Null is "Global"
#>

#Connect to Teams as admin
Connect-MicrosoftTeams | Out-Null
#Create Skype connection
$Session = New-CsOnlineSession
Import-PSSession $Session -AllowClobber

$CSVPath = "C:\Users\Desktop\TeamsUserPolicies.csv"

#Get all assigned polcies - adjust to bring back what you need
$TeamsUsers = Get-CsOnlineUser -Filter { Enabled -eq $True } | Select-Object DisplayName, `
    UserPrincipalName, `
    SipAddress, `
    TeamsMeetingPolicy, `
    TeamsMessagingPolicy, `
    TeamsMeetingBroadcastPolicy, `
    TeamsAppPermissionPolicy, `
    TeamsAppSetupPolicy, `
    TeamsCallParkPolicy, `
    TeamsCallingPolicy, `
    CallerIdPolicy, `
    TeamsChannelsPolicy, `
    TeamsEmergencyCallingPolicy, `
    TeamsEmergencyCallRoutingPolicy, `
    TenantDialPlan, `
    TeamsUpgradePolicy

#Export CSV
$TeamsUsers | Export-Csv -Path:$CSVPath -NoTypeInformation

Disconnect-MicrosoftTeams
Remove-PSSession $Session
