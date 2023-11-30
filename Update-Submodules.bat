@echo off
setlocal enabledelayedexpansion

for /l %%i in (0, 1, 1) do (
    REM Use PowerShell to extract "name" and "version" from version.json
    for /f %%A in ('powershell -command "(Get-Content version.json | ConvertFrom-Json).repositories[%%i].name"') do set "name=%%A"
    for /f %%B in ('powershell -command "(Get-Content version.json | ConvertFrom-Json).repositories[%%i].version"') do set "version=%%B"

    REM Print the extracted information
    echo Name: !name!
    echo Version: !version!

    REM Check if the target directory exists, and delete it if it does
    if exist !name! (
        echo Deleting existing directory: !name!
        rmdir /s /q !name!
    )

    REM Clone the repository
    git clone --branch !version! https://github.com/HETONGAPP/!name!.git
)
endlocal
