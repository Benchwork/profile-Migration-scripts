@echo off
echo ******************restore********************

Robocopy h:\backup\%username%\signatures "C:\documents and settings\%username%\application data\microsoft\signatures" *.* /e
Robocopy h:\backup\%username%\NK2 "c:\documents and settings\%username%\application data\microsoft\Outlook" *.* /e
Robocopy h:\backup\%username%\Desktop "C:\documents and settings\%username%\Desktop" *.* /e
Robocopy h:\backup\%username%\PST "c:\documents and settings\%username%\Documents\Outlook" *.pst
Robocopy h:\backup\%username%\Favorites "C:\documents and settings\%username%\Favorites" *.* /e
Robocopy h:\backup\%username%\Local "c:\users\%username%\appData\Local\Microsoft\Office" *.* /e
Robocopy h:\backup\%username%\Roaming "c:\users\%username%\appData\Roaming\Microsoft\Office" *.* /e
Robocopy h:\backup\%username%\Documents "c:\users\%username%\Documents" *.* /e
Robocopy h:\backup\%username%\Pictures "c:\users\%username%\Pictures" *.* /e
regedit /c /s h:\backup\%username%\CustomDictionaries.reg
regedit /c /s h:\backup\%username%\CustomBackground.reg
Robocopy h:\backup\%username%\backgrounds "c:\users\%username%\appData\Roaming\Microsoft\Windows\Themes" *.* /e




echo Done
pause
