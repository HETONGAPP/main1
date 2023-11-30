@echo off
setlocal enabledelayedexpansion


REM Use PowerShell to extract "name" and "version" from version.json
for /f %%A in ('powershell -command "(Get-Content version.json | ConvertFrom-Json).repositories[0].name"') do set "name=%%A"
for /f %%B in ('powershell -command "(Get-Content version.json | ConvertFrom-Json).repositories[0].version"') do set "version=%%B"

REM Print the extracted information
echo Name: %name%
echo Version: %version%

REM Check if the target directory exists, and delete it if it does
if exist %name% (
    echo Deleting existing directory: %name%
    rmdir /s /q %name%
)

REM Clone the repository
git clone --branch %version% --single-branch https://github.com/HETONGAPP/%name%.git

pause
endlocal
