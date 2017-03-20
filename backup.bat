@echo off
echo *****************backup script***********************

SET _options=/E /Z /R:1 /W:1 /LOG+:"c:\temp\%username% migration.txt" /TEE /NFL /NDL

:: /E   :: Copy Subfolders, including Empty Subfolders.
:: /Z   :: Copy files in restartable mode (survive network glitch).
:: /SEC :: Copy files with SECurity (equivalent to /COPY:DATS).
:: /XO  :: eXclude Older - if destination file exists and is the same date
:: /R:n :: number of Retries
:: /W:n :: Wait time between retries
:: /LOG :: Output log file
:: /NFL :: No file logging
:: /NDL :: No dir logging
:: /XD  :: eXclude Directories matching given names/paths. e.g. /XD c:\unwanted /S 
:: /TEE :: Output to console window, as well as the log file.
:: /S   :: Copy Subfolders.

:: excluded files.
SET _exclude=/XD "c:\users\%username%\Documents\My Music" "c:\users\%username%\Documents\My Pictures" "c:\users\%username%\Documents\My Videos" "c:\users\%username%\Documents\PGP" /S

:: _excludes 
:: My Music
:: My Pictures" 
:: My Videos"
:: PGP" 

:: Email settings
SET to=ITsupport@example.com
SET server=127.0.0.1
SET port=25
SET from=Migration.script@example.com
SET subject="Migration BACKUP"
SET year=%DATE:~6,4%
SET month=%DATE:~3,2%
SET day=%DATE:~0,2%
SET today=%year%-%month%-%day%


Robocopy "C:\documents and settings\%username%\application data\microsoft\signatures" h:\backup\%username%\signatures *.* %_options%
Robocopy "c:\documents and settings\%username%\application data\microsoft\Outlook" h:\backup\%username%\NK2 *.nk2 %_options%
Robocopy "c:\documents and settings\%username%\Documents\Outlook" h:\backup\%username%\PST *.pst %_options% 
Robocopy "c:\documents and settings\%username%\Documents\Outlook Files" h:\backup\%username%\PST *.pst %_options% 
Robocopy "C:\documents and settings\%username%\Desktop" h:\backup\%username%\Desktop *.* %_options%
Robocopy "C:\documents and settings\%username%\Favorites" h:\backup\%username%\Favorites *.* %_options%
Robocopy "c:\documents and settings\%username%\application data\microsoft\templates" h:\backup\%username%\templates normal.dot %_options%
Robocopy "c:\users\%username%\appData\Local\Microsoft\Office" h:\backup\%username%\Local *.Officeui %_options%
Robocopy "c:\users\%username%\appData\Roaming\Microsoft\Office" h:\backup\%username%\Roaming *.Officeui %_options%
Robocopy "c:\users\%username%\Pictures" h:\backup\%username%\Pictures *.* %_options%
regedit /e h:\backup\%username%\CustomDictionaries.reg "HKEY_CURRENT_USER\Software\Microsoft\Shared Tools\Proofing tools\Custom Dictionaries"
Robocopy "c:\users\%username%\Documents" h:\backup\%username%\Documents *.* %_options% %_exclude%

:: Background images
regedit /e h:\backup\%username%\CustomBackground.reg "HKEY_CURRENT_USER\Control Panel\Desktop\Wallpaper"
Robocopy "c:\users\%username%\appData\Roaming\Microsoft\Windows\Themes" h:\backup\%username%\backgrounds *.* %_options%
:: snagit images
Robocopy "c:\users\%username%\appData\Local\TechSmith\Snagit\DataStore" h:\backup\%username%\Pictures *.SNA* %_options%
Robocopy "c:\users\%username%\appData\Local\TechSmith\Snagit\DataStore" h:\backup\%username%\Videos *.MP4 %_options%

:: networked drives
regedit /e h:\backup\%username%\NetworkedDrives.reg "HKEY_CURRENT_USER\Network"

echo Done
type h:\backup\%username%\NetworkedDrives.reg >> "c:\temp\%username% migration.txt"
