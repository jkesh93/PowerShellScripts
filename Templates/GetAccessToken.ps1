# Declare variables for client_id, client_secret, and tenant_name
$clientID = "<clientId>"
$clientSecret = "<secret>"
$tenantName = "<tenant>"

# Function to get access token from Azure AD v2.0
function authO365(){
    # Create request body with grant_type, client_id, client_secret, and scope fields
    $reqTokenBody = @{
        Grant_Type = "client_credentials"
        client_Id = $clientID
        client_secret = $clientSecret
        Scope = "https://graph.microsoft.com/.default"
    }
    
    # Send POST request to Azure AD v2.0 token endpoint
    # to get access token
    return Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantName/oauth2/v2.0/token" -Method "POST" -Body $reqTokenBody
}

# Call the function to get access token
$token = authO365

$auth = $token.access_token
