@echo off
chcp 65001 >nul
title Creator Shortcut Desktop - Ollie
echo =========================================================
echo   🦦 Se creeaza scurtatura OLLIE pe Desktop-ul tau...
echo =========================================================
set "APP_DIR=%~dp0"
set "HTML_PATH=%APP_DIR%index.html"
set "ICO_PATH=%APP_DIR%ollie-icon.ico"
set "LAUNCHER_VBS=%APP_DIR%Launch-Ollie-Silent.vbs"

REM Cream un lansator invizibil ca sa nu apara nicio fereastra neagra CMD la pornire
echo Set WshShell = CreateObject("WScript.Shell") > "%LAUNCHER_VBS%"
echo On Error Resume Next >> "%LAUNCHER_VBS%"
echo WshShell.Run "msedge.exe --app=""file://" ^& Replace("%HTML_PATH%", "\", "/") ^& """", 1, False >> "%LAUNCHER_VBS%"
echo If Err.Number ^<^> 0 Then WshShell.Run """%HTML_PATH%""", 1, False >> "%LAUNCHER_VBS%"

REM Cream Shortcut-ul direct pe Desktop cu pictograma ollie-icon.ico
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws = New-Object -ComObject WScript.Shell; $desk = [Environment]::GetFolderPath('Desktop'); $s = $ws.CreateShortcut($desk + '\Ollie.lnk'); $s.TargetPath = 'wscript.exe'; $s.Arguments = '"' + '%LAUNCHER_VBS%' + '"'; $s.WorkingDirectory = '%APP_DIR%'; if (Test-Path '%ICO_PATH%') { $s.IconLocation = '%ICO_PATH%,0' }; $s.Description = 'Ollie - Personal Ocean Companion'; $s.Save()"

echo.
echo [OK] Scurtatura 'Ollie' cu pictograma vidrei a fost pusa pe Desktop!
echo Pornesc aplicatia Ollie acum...
wscript.exe "%LAUNCHER_VBS%"
timeout /t 2 >nul
exit