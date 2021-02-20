<#
.SYNOPSIS
Get all owners of all Teams
.INPUTS
CSV Path for Teams owners and Ownerless Teams
.OUTPUTS
CSV of Teams Owners and Ownerless Teams
.NOTES
    Version:            1.0
    Author:             Kyle Anderson
    Creation Date:      24 Sep 2020
    Required Module:    MicrosoftTeams
#>

#Connect to Teams as admin
Connect-MicrosoftTeams

$CSVPath = "C:\Users\Desktop\TeamsOwners.csv"
$OwnerData = @()
$OwnerlessCSVPath = "C:\Users\Desktop\OwnerlessTeams.csv"
$OwnerlessOutputCSV = @()

$Teams = Get-Team -Archived $false

Foreach ($Team in $Teams) {
    
    $TeamName = $Team.DisplayName
    $TeamID = $Team.GroupID
    $TeamVis = $Team.Visibility
    
    $owners = Get-TeamUser -GroupId $TeamID -Role Owner 
    
    If ($null -ne $owners) {

        $BuildArray = $owners
        $BuildArray | Add-Member -MemberType NoteProperty "TeamName" -Value $TeamName
        $BuildArray | Add-Member -MemberType NoteProperty "TeamID" -Value $TeamID
        $BuildArray | Add-Member -MemberType NoteProperty "TeamType" -Value $TeamVis
    
        $OwnerData += $BuildArray 
    }
    else {
        
        Write-Host "Ownerless Team: $TeamName"
        $OwnerlessCollection = New-Object PSObject -Property ([Ordered] @{
                TeamID      = $TeamID
                DisplayName = $TeamName
                TeamType    = $TeamVis
            })

        $OwnerlessOutputCSV += $OwnerlessCollection
    }
}  

if ($null -ne $OwnerData) {
    $OwnerData | Export-Csv -Force -NoTypeInformation -Path $CSVPath
    Write-host -f Green "CSV created and exported"
}

if ($null -ne $OwnerlessOutputCSV) {
    $OwnerlessOutputCSV | Export-Csv -Force -NoTypeInformation -Path $OwnerlessCSVPath
    Write-host -f Red "Error CSV created and exported"
}
