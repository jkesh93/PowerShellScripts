$csvFile = Import-Csv .\input.csv

function checkMembership($deviceName,$groupName) 
{
Write-Host -ForegroundColor Yellow "Checking if $deviceName is in $groupName"

    $group = Get-AzureADGroup -SearchString $groupName
    $groupObjId = $group.ObjectId

    $result = 'MISSING' 

    $members = Get-AzureADGroupMember -All $true -ObjectId $groupObjId

    foreach($member in $members) 

    { 

        $memberName = $member.DisplayName


        If ($memberName -eq $deviceName) { 

            $result = 'In group' 

            return $result 

        } 

        Else 

        { 

             

        } 

    } 

    return $result 

}

foreach($line in $csvFile)
{
$device = $line.'Device Name'
$group_name = $line.Group

$status = checkMembership -deviceName $device -groupName $group_name
$status
}
