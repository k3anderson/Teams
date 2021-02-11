<#
.SYNOPSIS
Change the meeting recording storage location for a Meeting policy
.INPUTS
CSV Path and Meeting Policy name
.OUTPUTS
Meeting settings - CSV
.NOTES
    Version:        1.0
    Author:         Kyle Anderson
    Creation Date:  11 Feb 2020
    Required Module: MicrosoftTeams 1.1.6 or above.
#>

Connect-MicrosoftTeams
$Session = New-CsOnlineSession
Import-PSSession $Session -AllowClobber

$CSVPath = "C:\Users\Desktop\MeetingSettings.csv"
$Policy = "Global"

#Change the recording storage location
Set-CsTeamsMeetingPolicy -Identity $Policy -RecordingStorageMode "OneDriveForBusiness" #"Stream"

#Pull back all the meeting settings for the selected Policy
$MeetingSettings = Get-CsTeamsMeetingPolicy -Identity $Policy

#Export Meeting settings
$MeetingSettings | Export-Csv -Force -NoTypeInformation -Path $CSVPath

Remove-PSSession $Session
Disconnect-MicrosoftTeams