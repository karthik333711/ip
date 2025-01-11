Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Prompt the user to enter a message
$message = Read-Host "Enter the message you want to send to all PCs"

# Define the network range
$networkPrefix = "192.168.137."
$subnetSize = 254 # For a /24 subnet (255.255.255.0)

# Loop through the IP range
for ($i = 1; $i -le $subnetSize; $i++) {
    $ipAddress = $networkPrefix + $i

    # Send the message using msg command
    try {
        Start-Process -NoNewWindow -FilePath "msg" -ArgumentList "* /SERVER:$ipAddress $message"
    } catch {
        Write-Host "Failed to send message to $ipAddress"
    }
}


Exit

