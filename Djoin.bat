@echo off
:loop
ping DC01.LAB.COM  -n 1 | find "TTL=" > nul
if errorlevel 1 (
    echo Cannot Connect Server, retrying...
    timeout /t 1 > nul
    goto loop
) else (
    echo  Server Connected successfully!
    REM Go to A: drive
    goto A:
)

:A


@echo off
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope Process; Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"

powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '-Command Start-Sleep -Seconds 1; Exit'"


@echo off
cd /d "%~dp0"


powershell -Command "Start-Process PowerShell -ArgumentList '-File ""%~dp0DjoinClassou.ps1""' -Verb RunAs"


timeout /t 1 && exit

