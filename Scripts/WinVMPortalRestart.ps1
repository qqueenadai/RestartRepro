$VMMetadata=Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01"
$VMResourceId= $VMMetadata."compute"."resourceId"
$response = Invoke-WebRequest -UseBasicParsing -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' -Headers @{Metadata="true"}
$content =$response.Content | ConvertFrom-Json
$access_token = $content.access_token
Invoke-WebRequest -UseBasicParsing -Uri "https://management.azure.com$VMResourceId/restart?api-version=2022-11-01" -Method POST -Headers @{ Authorization ="Bearer $access_token"}
