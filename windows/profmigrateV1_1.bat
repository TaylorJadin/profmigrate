@ echo off

:: Creator: Taylor Jadin
:: Purpose: Streamline a Profile migration from a Windows XP installation to a Windows 7 installation
:: Description: Copies files from the Desktop, My Documents, My Pictures, My Videos, My Music, and Favorites folders.
::              Also copies the user profiles for Chrome, Firefox and Thunderbird.

cls
echo Windows XP to Windows 7 Profile Migration Tool
echo.
echo This script will copy files from the Desktop, Favorites,
echo My Documents, My Music, My Pictures, and My Videos folders.
echo It will also copy Firefox and Thunderbird profiles.
echo.
pause

cls

:sourceprompt
set /p source= Enter location of Windows XP profile: 
if not exist %source% echo Could not locate source profile
if not exist %source% goto :sourceprompt

:destinationprompt
set /p destination= Enter location of Windows 7 profile: 
if not exist %destination% echo Could not locate destination profile
if not exist %destination% goto :destinationprompt
echo.

echo Begin Profile Migration?
echo.
pause

robocopy "%source%\Desktop" "%destination%\Desktop" /s /xf "*.lnk" "desktop.ini"
robocopy "%source%\My Documents" "%destination%\Documents" /s /xd "My Music" "My Pictures" "My Videos" "Downloads" /xf "*.lnk" "desktop.ini"
robocopy "%source%\My Documents\My Music" "%destination%\Music" /s /xf "desktop.ini"
robocopy "%source%\My Documents\My Pictures" "%destination%\Pictures" /s /xf "desktop.ini"
robocopy "%source%\My Documents\My Videos" "%destination%\Videos" /s /xf "desktop.ini"
robocopy "%source%\My Documents\Downloads" "%destination%\Downloads" /s /xf "desktop.ini"
robocopy "%source%\Favorites" "%destination%\Favorites" /s /xf "desktop.ini"
robocopy "%source%\Application Data\Mozilla\Firefox" "%destination%\AppData\Roaming\Mozilla\Firefox" /mir
robocopy "%source%\Application Data\Thunderbird" "%destination%\AppData\Roaming\Thunderbird" /mir
robocopy "%source%\Local Settings\Application Data\Google\Chrome" "%destination%\AppData\Local\Google\Chrome" /mir

cls
echo Profile Migration Complete
echo.
pause