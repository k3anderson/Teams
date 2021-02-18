<#
.SYNOPSIS
Assign policy to a Microsoft 365 or Security group - assign direct policy as a one off
.INPUTS
GroupID
Policy Name
.OUTPUTS
None
.NOTES
    Version:            1.0
    Author:             Kyle Anderson
    Creation Date:      24 Sep 2020
    Required Module:    MicrosoftTeams and AzureAD
    Important:          When assigning policies, remember that "Global" is the absence of a policy - "Global" = $null
    Notes:              Commands for assigning direct policies
                            1)	Grant-CsTeamsAppPermissionPolicy -Identity $UserUPN -PolicyName $PolicyName
                            2)	Grant-CsTeamsCallingPolicy -Identity $UserUPN -PolicyName $PolicyName
                            3)	Grant-CsTeamsCallParkPolicy -Identity $UserUPN -PolicyName $PolicyName
                            4)	Grant-CsTeamsChannelsPolicy -Identity $UserUPN -PolicyName $PolicyName
                            5)	Grant-CsTeamsComplianceRecordingPolicy -Identity $UserUPN -PolicyName $PolicyName
                            6)	Grant-CsTeamsEmergencyCallingPolicy -Identity $UserUPN -PolicyName $PolicyName
                            7)	Grant-CsTeamsEmergencyCallingRoutingPolicy -Identity $UserUPN -PolicyName $PolicyName
                            8)	Grant-CsTeamsIPPhonePolicy -Identity $UserUPN -PolicyName $PolicyName
                            9)	Grant-CsTeamsMeetingBroadcastPolicy -Identity $UserUPN -PolicyName $PolicyName
                            10)	Grant-CsTeamsMeetingPolicy -Identity $UserUPN -PolicyName $PolicyName
                            11)	Grant-CsTeamsMessagingPolicy -Identity $UserUPN -PolicyName $PolicyName
                            12)	Grant-CsTeamsMobilityPolicy -Identity $UserUPN -PolicyName $PolicyName
                            13)	Grant-CsTeamsUpgradePolicy -Identity $UserUPN -PolicyName $PolicyName
                            14)	Grant-CsTeamsVideoInteropServicePolicy -Identity $UserUPN -PolicyName $PolicyName
#>

#Connect to Azure and Teams
Connect-AzureAD | Out-Null
Connect-MicrosoftTeams | Out-Null
#Establish Skype connection
$Session = New-CsOnlineSession
Import-PSSession $Session -AllowClobber

$GroupID = ""
$PolicyName = "" 

#All users from group - ignores nested groups
$Users = Get-AzureADGroupMember -ObjectId $GroupID -All $true | Where-Object { $_.ObjectType -eq "User" }

ForEach ($User in $Users) {

    $UserUPN = $User.UserPrincipalName

    Grant-CsTeamsAppPermissionPolicy -Identity $UserUPN  -PolicyName $PolicyName
}

Disconnect-MicrosoftTeams
Remove-PSSession -Session:$Session