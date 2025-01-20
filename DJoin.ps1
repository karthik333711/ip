do {
    $newComputerName = Read-Host "Enter the new computer name"
} while (-not $newComputerName)

Write-Host "PC Number entered: $newComputerName"


# Ask for confirmation
$confirmation = Read-Host "  New computer Name Is : $newComputerName"

if ($confirmation -eq "") {
    Write-Host "Proceeding with the new computer name: $newComputerName"
} else {
    Write-Host "Aborted. No changes made."
}






# Rename the computer
Rename-Computer -NewName $newComputerName -Force

# Convert the password to a secure string
$securePassword = ConvertTo-SecureString '*171*&muru343' -AsPlainText -Force

# Create the credential object
$cred = New-Object System.Management.Automation.PSCredential ('lab\administrator', $securePassword)

# Define parameters for Add-Computer
$addComputerSplat = @{
    DomainName = 'lab.com'
    Credential = $cred
    Options = 'JoinWithNewName', 'AccountCreate'
}

# Join the computer to the domain
Add-Computer @addComputerSplat

# Restart the computer to apply changes
Restart-Computer


