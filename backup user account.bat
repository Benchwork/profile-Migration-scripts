@echo off
echo *****************backup script***********************




::   *****************Best viewed with Notepad++***********************
:: Email settings
SET to=ITsupport@example.com
SET server=127.0.0.1
SET port=25
SET from=Migration.script@example.com
SET subject="Migration BACKUP"
:: Date settings
SET year=%DATE:~10,4%
SET month=%DATE:~7,2%
SET day=%DATE:~4,2%
SET today=%year%-%month%-%day%

::destination settings
echo set destination drive like D:\ will got to D:\backups\%username% (if network, must be mapped)
SET /p _destination=
:: if you want to set a static destination add it after the equals sign.
::  the files will be under backups and the user account



:: Map destination Location
:: net use P: %_destination% /user:[usernameOfSource] [passwordOfSource]

:: output text logs 
SET _txtoutput="c:\temp\%username%.backups.%today%.txt"
:: Robocopy settings
SET _options=/E /Z /XO /R:1 /W:1 
::/LOG+:%_txtoutput% /TEE 
::/NFL /NDL
 
:: /E   :: Copy Subfolders, including Empty Subfolders.
:: /Z   :: Copy files in restartable mode (survive network glitch).
:: /XO  :: eXclude Older - if destination file exists and is the same date
:: /R:n :: number of Retries
:: /W:n :: Wait time between retries
:: /LOG :: Output log file
:: /TEE :: Output to console window, as well as the log file.
:: /NFL :: No file logging
:: /NDL :: No dir logging
:: /XD  :: eXclude Directories matching given names/paths. e.g. /XD c:\unwanted /S 
:: /S   :: Copy Subfolders.
:: /NS  :: No Size - don't log file sizes.
:: /NC  :: No Class - don't log file classes.
:: /NP  :: No Progress - don't display percentage copied.
:: /SEC :: Copy files with SECurity (equivalent to /COPY:DATS).

:: if you want to set a source drive and or directory 
SET _source="c:\users\%username%"
SET _source2="c:\users\Public"

::TBD find and set onedrive variable and add option to exclude it. 

:: excluded files.
SET _exclude=/XD "c:\users\%username%\Documents\My Music" "c:\users\%username%\Documents\My Pictures" "c:\users\%username%\Documents\My Videos" "c:\users\%username%\Documents\PGP" "c:\users\%username%\AppData\Local\Application Data" "c:\users\%username%\AppData\Local\Spotify" /S  /XF "c:\users\%username%\NTUSER.DAT" "c:\users\%username%\NTUSER.DAT.LOG1" "c:\users\%username%\NTUSER.DAT.LOG2" 

SET _exclude2=/XD "c:\users\%username%\Documents\My Music" "c:\users\%username%\Documents\My Pictures" "c:\users\%username%\Documents\My Videos" "c:\users\%username%\Documents\PGP" "c:\users\%username%\AppData\Local\Application Data" "c:\users\%username%\AppData\Local\Spotify" /S  /XF "c:\users\%username%\NTUSER.DAT" "c:\users\%username%\NTUSER.DAT.LOG1" "c:\users\%username%\NTUSER.DAT.LOG2" 

::
:: _excludes 
:: My Music
:: My Pictures" 
:: My Videos"
:: PGP" 

:: if you want to set a source drive and or directory 
SET _source="c:\users\%username%"
SET _source2="c:\users\Public"

:: Run the replication
::robocopy %_source% %_destination%  /NC /NS /NP /LOG+:%logfilelocation%
::if errorlevel 1 goto success
::if errorlevel 0 goto success
::goto fail 

:: copy public user data
Robocopy %_source2% %_destination%\backups\%username%\Public *.* %_options% %_exclude2%

:: User account
Robocopy %_source% %_destination%\backups\%username% *.* %_options% %_exclude%
