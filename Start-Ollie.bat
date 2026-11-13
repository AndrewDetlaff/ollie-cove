@echo off
title Ollie Desktop Launcher
echo Pornesc aplicatia Ollie in mod Desktop...
start msedge --app="%~dp0index.html" || start chrome --app="%~dp0index.html" || start "" "%~dp0index.html"
exit