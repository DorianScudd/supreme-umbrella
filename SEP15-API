#Working through learning to authenticate and query Symantec REST API for Symantec 15

# Force TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

$baseURI = "usea1.r3.securitycloud.symantec.com"
$basePath = "https://${baseURI}/r3_epmp_i/"

$CIDCs = '<CI AND DC>'
$CIDCs64 = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($CIDCs))
$cToken = 'oauth2/tokens'
$bearer = 'Bearer'+$CIDCs64

$headers = @{
    'Accept' = 'application/json'
    'Authorization' = $bearer
    'Content-Type' = 'application/x-www-form-urlencoded'
    'grant_type' = 'client_credentials&scope=customer'
}

#$result = Invoke-RestMethod -Method Get -Uri $basePath$cToken -Headers $headers #-ContentType 'application/json' 

$result = Invoke-RestMethod -Method Get -Uri "https://usea1.r3.securitycloud.symantec.com/r3_epmp_i/oauth2/tokens" -Headers $headers
