<#
.SYNOPSIS
Get all members of Team
.INPUTS
CSV Path and Team ID
.OUTPUTS
All Team Members - CSV
 1) Object ID
 2) UPN
 3) Display Name
 4) Team Role
.NOTES
    Version:        1.0
    Author:         Kyle Anderson
    Creation Date:  18 Feb 2021
    Required Module: MicrosoftTeams
#>

$CSVPath = "C:\Users\Desktop\TeamMembers.csv"
$TeamId = ""

Connect-MicrosoftTeams
$OutputCSV = Get-TeamUser -GroupId $TeamId

$OutputCSV | Export-Csv -Force -NoTypeInformation -Path $CSVPath
Write-host -f Green "CSV created and exported"
