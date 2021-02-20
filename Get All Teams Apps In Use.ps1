<#
.SYNOPSIS
Get all apps installed accross all Teams in your Tenant
.INPUTS
CSV Path
.OUTPUTS
Output of all Apps installed in Teams
.NOTES
    Version:            1.0
    Author:             Kyle Anderson
    Creation Date:      20 Sep 2020
    Required Module:    MicrosoftTeams
    Note:               This will include all default apps such as "Files" and "Chat"
#>

#Connect to Teams as admin
Connect-MicrosoftTeams 

#Get all the Teams that have not been archived.
$Teams = Get-Team -Archived $false

#Output number of Teams
Write-Host $Teams.Count

$CSVPath = "C:\Users\Desktop\TeamsAppsInUse.csv"
$AppData = @()
$ErrorPath = "C:\Users\Desktop\Errors_TeamsAppsInUse.csv"
$ErrorData = @()

foreach ($Team in $Teams) {
    Try {
        #Get all the apps installed on the Team
        $Apps = Get-TeamsAppInstallation -TeamId $Team.GroupID -ErrorAction Stop
        
        $BuildArray = $Apps
        $BuildArray | Add-Member -MemberType NoteProperty "TeamName" -Value $Team.DisplayName 
        $BuildArray | Add-Member -MemberType NoteProperty "TeamID" -Value $Team.GroupID
        $BuildArray | Add-Member -MemberType NoteProperty "TeamType" -Value $Team.Visibility

        $AppData += $BuildArray
    }
    catch {
        #Build error CSV
        $ErrorCollection = New-Object PSObject -Property ([Ordered] @{
                Team     = $Team.DisplayName
                TeamID   = $Team.GroupID
                TeamType = $Team.Visibility
            })

        $ErrorData += $ErrorCollection
    }
}

#Output list of Apps installed in Teams
if ($null -ne $AppData) {
    $AppData | Export-Csv -Force -NoTypeInformation -Path $CSVPath
    Write-host -f Green "CSV created and exported"
}

#Output list of Teams that errored
if ($null -ne $ErrorData) {
    $ErrorData | Export-Csv -Force -NoTypeInformation -Path $ErrorPath
    Write-host -f Red "Error CSV created and exported"
}

Disconnect-MicrosoftTeams