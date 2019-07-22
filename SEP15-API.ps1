# Force TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

# Get Authorization Token
$user = '<client_id>'
$pass = '<client_secret>'

$cred = [Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($user + ':' + $pass))

$uri = 'https://usea1.r3.securitycloud.symantec.com/r3_epmp_i'

$path = '/oauth2/tokens'
$params = '?grant_type=client_credentials'
$method = 'Post'

$headers = @{
'Authorization' = "Basic $cred";
'Accept' = 'application/json';
'Content-Type' = 'application/x-www-form-urlencoded';
}

$auth = Invoke-RestMethod -Uri $uri$path$params -Method $method -Headers $headers

# Export Events
$path = '/sccs/v1/events/export'
$params = ''
$method = 'Post'

$headers = @{
'Authorization' = $auth.access_token;
'Content-Type' = 'application/json';
'x-epmp-customer-id' = 'customer_id';
'x-epmp-domain-id' = '<domain_id';
'x-epmp-product' = 'SAEP';
}

$request_info = @{
'batchSize' = '10000';
#Different types of events to capture

#'type' = 'APP ISOLATION';
#'type' = 'EXPLOIT PROTECTION';
#'type' = 'FIREWALL';
'type' = 'MALWARE PROTECTION';
#'type' = 'NETWORK IPS';
#'type' = 'BEHAVIORAL ANALYSIS';
#'type' = 'APP CONTROL';
#'type' = 'DECEPTION';
'startDate' = '2019-07-21T00:00:00.000Z';
'endDate' = Get-Date -UFormat "%Y-%m-%dT%H:%M:%S.000Z";

#Per SEP: "You continually invoke the Events API command until an empty set is returned.
#   You use the same parameters. To increase the amount of data returned from a single command, 
#   change the value of the batchSize parameter."
}

$body = $request_info | ConvertTo-Json -Compress

echo $body

$events = Invoke-RestMethod -Uri $uri$path$params -Method $method -Headers $headers -Body $body

echo $events
