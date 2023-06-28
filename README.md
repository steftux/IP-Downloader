# Azure IP filter and downloader script
Grabs the JSON file for the Azure IP Ranges and Service Tags – Public Cloud.

Script allows for flitering and downloads the IPs into one big file it also makes a file just for IPv4 and IPv6

The script grabs the json file directly from Microsoft (no more manual updating needed).

## How to use
mandatory parameters only: exportlocation: Save location (folder will be created if it does not exist)
* ./Azure-IP-Downloader.ps1 -exportlocation "./IPs" 

Optional parameters: Region and Service filters. If not passed, defaults will be used
* ./Azure-IP-Downloader.ps1 -exportlocation "./IPs" -regionFilter northeurope -serviceFilter LogicApps

## known issues
* If the account that is running the script doesn't have read write access to the specified save location it will fail.

## Release Notes
### Version 1.3.0
* added parameters and service filter
### Version 1.2.0
* deployed fix to no longer need manual updating of the Microsoft URI to download the JSON file. Thanks [@erikplekenpol](https://github.com/erikplekenpol) for the fix.
* deployed fix to auto create the save location if it doesn't exist.

### Version 1.1.0
* added DLURI which makes the script grab the MS JSON URI from a TXT file so the script doesn't need to be edited manually each week when MS release a new JSON file.

### Version 1.0.0
* Intial Release
