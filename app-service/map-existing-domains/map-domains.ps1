# Takes a txt file filled with a list of new line separated domains and adds them to a web app you choose
# Fill in the variables below

$rg = "resource-group-name"
$sub = "subscription name or subscription id"
$app = "web app name"

foreach($hostname in Get-Content .\domains.txt) {
    Write-Host $hostname
    az webapp config hostname add --hostname $hostname  --resource-group $rg --subscription $sub  --webapp-name $app
}