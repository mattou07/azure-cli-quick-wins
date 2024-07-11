# When using managed Identity auth there are two places to assign a managed identity on a web app.
# 1. In the Azure portal in Identity under User Assigned
# 2. A hidden section not accessbile via the portal. This script uses the Azure CLI to set this.

# IMPORTANT: Step one must be done first before we can set keyVaultReferenceIdentity on the web app

# This script can assign the keyVaultReferenceIdentity on both your web app and its slot if specified

#Fill out the variables below before using
$rg = ""
$sub = ""
$app = ""
$webappSlot = ""
$managedIdentityName = ""

$identityResourceId= az identity show --resource-group $rg --name $managedIdentityName --query id -o tsv --subscription $sub
az webapp update --resource-group $rg --name $app --set keyVaultReferenceIdentity=$identityResourceId --subscription $sub

if(![string]::IsNullOrEmpty($webappSlot)) {
    Write-Host "Setting keyVaultReferenceIdentity on slot $webappSlot"
    az webapp update --resource-group $rg --name $app --slot $webappSlot  --set keyVaultReferenceIdentity=$identityResourceId  --subscription $sub
}