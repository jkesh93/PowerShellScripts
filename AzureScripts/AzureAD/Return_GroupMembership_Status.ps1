
# csvFile format: "User Principal Name,Group"
$csvFile = Import-Csv .\input.csv

function checkMembership($userPrincipalName,$groupName) 
{
Write-Host -ForegroundColor Yellow "Checking if $userPrincipalName is in $groupName"

    $group = Get-AzureADGroup -SearchString $groupName
    $groupObjId = $group.ObjectId

    $result = 'MISSING' 

    $members = Get-AzureADGroupMember -All $true -ObjectId $groupObjId

    foreach($member in $members) 

    { 

        $memberName = $member.UserPrincipalName
        $memberName

        If ($memberName -eq $userPrincipalName) { 

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
$upn = $line.'User Principal Name'
$group_name = $line.Group

$status = checkMembership -userPrincipalName $upn -groupName $group_name
$status
}
