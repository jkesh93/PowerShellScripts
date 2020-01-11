
######################
### What this does ###
######################
# Verifies access to the following Microsoft resources
# https://enterpriseregistration.windows.net
# https://login.microsoftonline.com
# https://device.login.microsoftonline.com
# https://autologon.microsoftazuread-sso.com (If you use or plan to use seamless SSO)

# Thank you to Sam Boutros for the script
# Find the original at https://powershell.org/forums/topic/how-to-get-the-url-status/

######################
###    Variables   ###
######################

[string[]]$sites = ( 
    "https://enterpriseregistration.windows.net",
    "https://login.microsoftonline.com",
    "https://device.login.microsoftonline.com",
    "https://autologon.microsoftazuread-sso.com"
)

$securepassword = ConvertTo-SecureString "Password" -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential("Username", $securepassword)

######################
###     Script     ###
######################

foreach ($site in $sites){
    try{
    $status = (Invoke-WebRequest -Uri $site).statuscode
    switch ($status) {
        200 { 
            "Status code $status for site $site"
            # further action/code specific to code 200 here 
        }
        404 { 
            "Status code $status for site $site"
            # further action/code specific to code 404 here 
        }
        503 { 
            "Status code $status for site $site"
            # further action/code specific to code 503 here 
        }
        default { 
            "Status code $status for site $site"
            # further action/code specific to 'other' here 
        }
    }
    }
    catch
    {
        Write-Host "Failed for $site"
    }

}
