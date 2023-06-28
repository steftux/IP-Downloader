# Azure IP filter and downloader script v1.2.0
# Author: Daniel Keer, Stefan Koch
# Author URI: https://thedxt.ca
# Script URI: https://github.com/thedxt/IP-Downloader
#
# DESCRIPTION
# grabs the JSON file for the Azure IP Ranges and Service Tags – Public Cloud
# script allows for flitering and downloads the ips into one big file
# it also makes a file just for IPv4 and IPv6

#save location
$exportlocation = "C:\temp\"

# function to check if save location exists if not create it
function exportloc-check{
if (-not (Test-Path $exportlocation))
{
New-Item -ItemType Directory $exportlocation | out-null
}
}

# run the function
exportloc-check

# add filter
$regionFilter = "westeurope"
$serviceFilter = "LogicApps"

#grab URI from txt file
$LocationURI = Invoke-WebRequest -uri "https://www.microsoft.com/en-us/download/confirmation.aspx?id=56519"
$DLURI = $LocationURI.Links | Where-Object {$_.InnerText -Like "click here to download manually" }

#download the JSON file from MS
$MSjsonDL = Invoke-WebRequest -Uri $DLURI.href

#getting date
$time = get-date -f yyyy_MMM_dd_hhmm_tt

#convert to PS object
$MSjsonOBJ = ConvertFrom-Json $MSjsonDL

#select the values
$properties = $MSjsonOBJ.values.properties

#filter to pick only specific region
$region = $properties | where-object { $_.region -match $regionFilter}

#save files using reg ex to filter ipv4 and ipv6 to their own files if needed
$region.addressPrefixes | out-file "$exportlocation\$($time)_region_$($regionFilter)_all_IPs.txt"
$region.addressPrefixes -match '\.' | out-file "$exportlocation\$($time)_region_$($regionFilter)_v4_IPs.txt"
$region.addressPrefixes -match '\:' | out-file "$exportlocation\$($time)_region_$($regionFilter)_v6_IPs.txt"

#filter to pick only specific regions and services
$regionAndService = $properties | where-object { $_.region -match $regionFilter}  | where-object { $_.systemService -match $serviceFilter} 

#save files using reg ex to filter ipv4 and ipv6 to their own files if needed
$regionAndService.addressPrefixes | out-file "$exportlocation\$($time)_region_$($regionFilter)_service_$($serviceFilter)_all_IPs.txt"
$regionAndService.addressPrefixes -match '\.' | out-file "$exportlocation\$($time)_region_$($regionFilter)_service_$($serviceFilter)_v4_IPs.txt"
$regionAndService.addressPrefixes -match '\:' | out-file "$exportlocation\$($time)_region_$($regionFilter)_service_$($serviceFilter)_v6_IPs.txt"