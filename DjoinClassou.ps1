# Predefined ClassRoom Name
$ClassRoom = "SCAS-351-"

do {
    $PcNumber = Read-Host "Enter the PC Number"
} while (-not $PcNumber)

Write-Host "PC Number Entered: $PcNumber"

# Construct the full computer name
$newComputerName = "$ClassRoom$PcNumber"
# Ask for confirmation
$confirmation = Read-Host "NEW PC NAME IS : $newComputerName"

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

# Define the OU path where the computer will be added
$ouPath = "OU=CLASSROOM 351,OU=CHN,OU=IN,OU=Countries,DC=lab,DC=com"

# Define parameters for Add-Computer
$addComputerSplat = @{
DomainName = 'lab.com'
Credential = $cred
OUPath = $ouPath
Options = 'JoinWithNewName', 'AccountCreate'
}

# Join the computer to the domain
Add-Computer @addComputerSplat

# Restart the computer to apply changes
Restart-Computer
