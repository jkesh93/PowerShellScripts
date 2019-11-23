######################
### What this does ###
######################
# Connects to Azure AD
# Gets Group Members
# Gets all owned devices
# Exports devices into CSV

######################
###    Variables   ###
######################
# SET GROUP NAME
$groupName = "";

# SET EXPORT PATH
$exportPath = ".\UserDevices.csv";

# LOGGING ON/OFF: 0 for off, 1 for on
$loggingSwitch = 0;

######################
###     Script     ###
######################
Connect-AzureAD

# If logging, log...
if($loggingSwitch -eq 1)
{
    Add-Content -Path $exportPath -Value "ObjectId,DeviceId,DisplayName,OwnerName,OwnerId";
}

if($groupName -eq '')
{
    Write-Host -ForegroundColor Yellow "Please enter a group name: ";
    $groupName = Read-Host;
}

$group = Get-AzureADGroup -SearchString $groupName | Select-Object ObjectId;
$groupId = $group.ObjectId;
$groupMembers = Get-AzureADGroupMember -ObjectId $groupId;

foreach($member in $groupMembers)
{
    $oid = $member.ObjectId;
    $dn = $member.DisplayName;
    $upn = $member.UserPrincipalName;
    $ut = $member.UserType;

    
        
    $ownedObjects = Get-AzureADUserOwnedDevice -ObjectId $oid;

    foreach($device in $ownedObjects)
    {
        # If logging, log...
        if($loggingSwitch -eq 1)
        {
            $dod = $device.ObjectId;
            $did = $device.DeviceId;
            $ddn = $device.DisplayName;
            Add-Content -Path $exportPath -Value "$dod,$did,$ddn,$upn,$oid";
        }
    }
    

}
