######################
### What this does ###
######################
# Connects to Azure AD
# Gets a Group
# Gets Group Members
# Assigns each user a role

######################
###    Variables   ###
######################
# SET GROUP NAME
$groupName = "TEST - Jay's Test Group";

# SET LOG EXPORT PATH
$exportPath = '.\roleAssignmentLog.csv';

# SET ROLE TO ASSIGN
$roleToAssign = 'Authentication Administrator';

# LOGGING ON/OFF: 0 for off, 1 for on
$loggingSwitch = 1;

######################
###     Script     ###
######################
# Create Log file...
Add-Content -Path $exportPath -Value "ObjectId,UserPrincipalName,UserType,Role";

Connect-AzureAD

# If $groupName is not set
if($groupName -eq '')
{
    Write-Host -ForegroundColor Yellow "Please enter a group name: ";
    $groupName = Read-Host;
}

if($roleToAssign -eq '')
{
    Write-Host -ForegroundColor Yellow "Please enter a role to assign: ";
    $roleToAssign = Read-Host;
}

# Get Azure AD Group Members
$group = Get-AzureADGroup -SearchString $groupName | Select-Object ObjectId;
$groupId = $group.ObjectId;
$groupMembers = Get-AzureADGroupMember -ObjectId $groupId;

# Fetch $roleToAssign role instance
$role = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq $roleToAssign};

# If role instance does not exist, cancel the operation...
if ($role -eq $null)
{
    Write-Host -ForegroundColor Yellow "Role does not exist. Cancelling...";
}
else
{
    # Foreach group member
    foreach($member in $groupMembers)
    {
        $oid = $member.ObjectId;
        $dn = $member.DisplayName;
        $upn = $member.UserPrincipalName;
        $ut = $member.UserType;

        # Add user to role
        try
        {
            Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId $oid;
        }
        catch
        {
            Write-Host -ForegroundColor Red "Unable to add user $dn";
        }

        # If logging, log...
        if($loggingSwitch -eq 1)
        {
            try
            {
                Add-Content -Path $exportPath -Value "$oid,$upn,$ut,$roleToAssign";
            }
            catch
            {
                Write-Host -ForegroundColor Red "Unable to write to log file for user $upn";
            }
        }
        else
        {
            # If logging is off, close
            Write-Host -ForegroundColor green "NOTE: Logging is off, script is complete.";
        }
    }
}