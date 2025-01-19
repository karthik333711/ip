# Prompt the user for the new computer name
$newComputerName = Read-Host -Prompt "Enter the new computer name"

# Rename the computer
Rename-Computer -NewName SCAS-351-$newComputerName -Force

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
