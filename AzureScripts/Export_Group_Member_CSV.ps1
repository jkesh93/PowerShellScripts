######################
### What this does ###
######################
# Connects to Azure
# Gets Group Members
# Exports to CSV


######################
###    Variables   ###
######################
# SET GROUP NAME
$groupName = '';

# SET EXPORT PATH
$exportPath = '.\GroupMembers.csv'

######################
###     Script     ###
######################
Connect-AzureAD

if($groupName -eq '')
{
    Write-Host -ForegroundColor Yellow "Please enter a group name: ";
    $groupName = Read-Host;
}

$group = Get-AzureADGroup -SearchString $groupName | Select-Object ObjectId
$groupId = $group.ObjectId
$groupMembers = Get-AzureADGroupMember -ObjectId $groupId;

Write-Host -ForegroundColor Yellow "Export to: $exportPath ?";
$input = Read-Host;

if($input -eq 'y')
{
    
    Add-Content -Path $exportPath -Value "ObjectId,DisplayName,UserPrincipalName,UserType"
    foreach($member in $groupMembers)
    {
        $oid = $member.ObjectId
        $dn = $member.DisplayName
        $upn = $member.UserPrincipalName
        $ut = $member.UserType
        Add-Content -Path $exportPath -Value "$oid,$dn,$upn,$ut"
    }
}
else
{
    Write-Host -ForegroundColor Red "Operation Cancelled";
}
