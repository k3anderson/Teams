<#
.SYNOPSIS
Assign policy to a Microsoft 365 or Security group - assignment to individuals via inheritance from group
Further details
https://docs.microsoft.com/en-us/powershell/module/teams/new-csgrouppolicyassignment?view=teams-ps
.INPUTS
GroupID
Policy Name
Rank of assignment
.OUTPUTS
All Teams Apps on your AppPermissions Policy - CSV
.NOTES
    Version:            1.0
    Author:             Kyle Anderson
    Creation Date:      26 Sep 2020
    Required Module:    MicrosoftTeams 
    Important:          When assigning policies, remember that "Global" is the absence of a policy
                        Policy Group limited to the following
                        1	 CallingLineIdentity (Caller ID policies)
                        2	 TeamsAppSetupPolicy (App Setup policies)
                        3	 TeamsCallingPolicy (Calling policies)
                        4	 TeamsCallParkPolicy (Call park policies)
                        5	 TeamsChannelsPolicy
                        6	 TeamsComplianceRecordingPolicy
                        7	 TenantDialPlan
                        8	 TeamsEducationAssignmentsAppPolicy
                        9	 TeamsMeetingBroadcastPolicy (Live Events policies)
                        10	 TeamsMeetingPolicy (Meeting policies)
                        11	 TeamsMessagingPolicy (Messaging policies)
                        12	 TeamsShiftsPolicy
                        13	 TeamsUpdateManagementPolicy.
#>

#Connect to Teams as admin
Connect-MicrosoftTeams

$GroupID = ""
$PolicyName = ""

#Assign Policy
New-CsGroupPolicyAssignment -GroupId $GroupID -PolicyType TeamsAppSetupPolicy -PolicyName $PolicyName -Rank 1

#Remove Policy
#Remove-CsGroupPolicyAssignment -GroupId $GroupID -PolicyType TeamsAppSetupPolicy

Disconnect-MicrosoftTeams