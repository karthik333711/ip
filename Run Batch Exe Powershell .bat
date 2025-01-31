@echo off
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope Process; Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"

powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '-Command Start-Sleep -Seconds 1; Exit'"

-------------------------------------------------------

timeout /t 1 && exit

cd /d "%~dp0"

powershell -Command "Start-Process PowerShell -ArgumentList '-File ""%~dp01.ps1""' -Verb RunAs"
----------------------------------------------------------------------------------------

cd /d "%~dp0"

powershell -Command "Start-Process PowerShell -ArgumentList '-File ""%~dp01.ps1""' -Verb RunAs -Wait"

-------------------------------------------------------------------------


cd /d "%~dp0"

if exist "%~dp01.ps1" (
    powershell -Command "Start-Process PowerShell -ArgumentList '-File ""%~dp01.ps1""' -Verb RunAs -Wait"
) else (
    echo PowerShell script not found, skipping...
)

------------------------------------------------------------------------------


timeout /t 10


cd /d "%~dp0"
start 3.bat
--------------------------------------------------------------------------
cd /d "%~dp0"

if exist "3.bat" (
    start 3.bat
) else (
    echo 3.bat not found, skipping...
)

-------------------------------------
cd /d "%~dp0"
call 3.bat

-------------------------------------

cd /d "%~dp0"
start /wait cmd /c 3.bat


-------------------------------------------------



cd /d "%~dp0"  :: Change to the directory where the batch file is located

if exist "3.bat" (
    start /wait cmd /c 3.bat  :: Run 3.bat if it exists
) else (
    echo 3.bat not found, adding file...  :: Print a message if 3.bat doesn't exist
    echo REM Creating 3.bat > 3.bat  :: Example of adding content to 3.bat
    echo echo This is a new 3.bat >> 3.bat  :: Add some content to the new 3.bat
)





-------------------------------------

@echo off
pushd "%~dp0"

if exist "RDP.exe" start /wait RDP.exe
popd
exit
-----------------------------------------------------------------------


REM Set paths
SET INSTALLER_PATH="D:\SOFTWARE\Xampp\Xampp.exe"

REM Run the silent installation
echo Starting XAMPP installation...
%INSTALLER_PATH%  --mode unattended --unattendedmodeui none

@echo off
REM Set paths
SET INSTALLER_PATH=D:\SOFTWARE\Xampp\Xampp.exe

REM Run the silent installation and wait for it to finish
echo Starting XAMPP installation...
start /wait "%INSTALLER_PATH%" --mode unattended --unattendedmodeui none

echo XAMPP installation completed.

----------------------------------------------------------------------------------------


REM Set the installer path
SET INSTALLER_PATH=%~dp0

REM Change to the installer directory
cd /d "%INSTALLER_PATH%"

REM Run the silent installation and wait for it to finish
echo Starting XAMPP installation...
start /wait "" "xampp.exe" --mode unattended --unattendedmodeui none

----------------------------------------------------------------


REM Set the installer path
SET INSTALLER_PATH=%~dp0

REM Change to the installer directory
cd /d "%INSTALLER_PATH%"

REM Check if the installer exists
if exist "xampp.exe" (
    REM Run the silent installation and wait for it to finish
    echo Starting XAMPP installation...
    start /wait "" "xampp.exe" --mode unattended --unattendedmodeui none
) else (
    echo XAMPP installer not found, skipping...
)




-------------------------------------------------------------------------------------------------------


@echo off
REM Set the installer path to the current script directory
SET INSTALLER_PATH=%~dp0

REM Change to the installer directory
cd /d "%INSTALLER_PATH%"

REM Run the silent installation and wait for it to finish
echo Starting XAMPP installation...
start /wait "" "%INSTALLER_PATH%xampp.exe" --mode unattended --unattendedmodeui none

echo XAMPP installation completed.



--------------------------------------------------------------------------------------------------

