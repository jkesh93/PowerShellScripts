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
else
{
    $groupMembers = Get-AzureADGroup -SearchString $groupName | Get-AzureADGroupMember;

    Write-Host -ForegroundColor Yellow 'Export to: $exportPath?';
    $input = Read-Host;

    if($input -eq 'y')
    {
        Add-Content -Path $exportPath -Value $groupMembers;
    }
    else
    {
        Write-Host -ForegroundColor Red "Operation Cancelled";
    }
}
