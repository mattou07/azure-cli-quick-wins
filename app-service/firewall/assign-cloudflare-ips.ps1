#Fill out the variables below before using
$rg = "resource-group-name"
$sub = "subscription-id"
$app = "your-app-name"
#Set the inital value for the restriction priority
$initalPriority = 100
Invoke-WebRequest -Uri "https://www.cloudflare.com/ips-v4" -OutFile ".\ipv4.txt"
Invoke-WebRequest -Uri "https://www.cloudflare.com/ips-v6" -OutFile ".\ipv6.txt"
$i = 1

foreach($ip in Get-Content ".\ipv6.txt") {
    $name = "Cloudflare IP " + $i
    $initalPriority = $initalPriority + $i
    Write-Host "Adding Ipv6 Address $ip"
    az webapp config access-restriction add -g $rg -n $app --rule-name $name --action Allow --ip-address $ip --priority $initalPriority --subscription $sub
    $i++
}

foreach($ip in Get-Content ".\ipv4.txt") {
      $name = "Cloudflare IP " + $i
      $initalPriority = $initalPriority + $i
      Write-Host "Adding Ipv4 Address $ip"
      az webapp config access-restriction add -g $rg -n $app --rule-name $name --action Allow --ip-address $ip --priority $initalPriority --subscription $sub
      $i++
}

Remove-Item -Path ".\ipv4.txt"
Remove-Item -Path ".\ipv6.txt"