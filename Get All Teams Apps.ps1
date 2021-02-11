<#
.SYNOPSIS
Get all Teams Apps available in your Teams environment
.INPUTS
CSV Path and Meeting Policy name
.OUTPUTS
All Teams Apps on your AppPermissions Policy - CSV
.NOTES
    Version:        1.0
    Author:         Kyle Anderson
    Creation Date:  26 Sep 2020
    Required Module: MicrosoftTeams
    Important: You are only able to retrieve the apps that your account has been assigned through the AppPermissions Policy.
                If you run the script using an account with no Teams licensening, it will default to retrieve the apps available on the Global policy.
#>

Connect-MicrosoftTeams

$CSVPath = "C:\Users\Desktop\TeamsApps.csv"

$Apps = Get-TeamsApp | Select-Object DisplayName, `
    Id, `
    DistributionMethod

$Apps | Export-Csv -Path:$CSVPath -NoTypeInformation
Write-host -f Green "CSV created and exported"