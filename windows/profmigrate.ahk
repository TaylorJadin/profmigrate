/*
Changelog:
V2.1 - Removed support for Windows XP, added argument that skips files that robocopy fails on, instead of retrying indefinitely.
V2 - rewritten for use with AutoHotkey to provide a basic GUI
V1
*/

MsgBox This script will copy files from the Desktop, Downloads, My Documents, My Pictures, My Videos, My Music, and Favorites folders as well as the application data for Chrome, Firefox, Stickies, and Thunderbird. `n`nWritten by Taylor Jadin (2016)
FileSelectFolder source,, 6, Select source profile:
FileSelectFolder destination,, 6, Select destination profile:
Msgbox, 4,, Source: `n %source% `n `n Destination: `n %destination% `n `n Ok to continue?
IfMsgBox No
	Exit

runwait robocopy "%source%\Desktop" "%destination%\Desktop" /s /r:0 /xf "*.lnk" "desktop.ini"
runwait robocopy "%source%\Documents" "%destination%\Documents" /s /r:0 /xf "*.lnk" "desktop.ini"
runwait robocopy "%source%\Music" "%destination%\Music" /s /r:0 /xf "desktop.ini"
runwait robocopy "%source%\Pictures" "%destination%\Pictures" /s /r:0 /xf "desktop.ini"
runwait robocopy "%source%\Videos" "%destination%\Videos" /s /r:0 /xf "desktop.ini"
runwait robocopy "%source%\Downloads" "%destination%\Downloads" /s /r:0 /xf "desktop.ini"
runwait robocopy "%source%\Favorites" "%destination%\Favorites" /s /r:0 /xf "desktop.ini"
runwait robocopy "%source%\AppData\Roaming\Mozilla\Firefox" "%destination%\AppData\Roaming\Mozilla\Firefox" /mir
runwait robocopy "%source%\AppData\Roaming\Thunderbird" "%destination%\AppData\Roaming\Thunderbird" /mir
runwait robocopy "%source%\AppData\Local\Google\Chrome" "%destination%\AppData\Local\Google\Chrome" /mir
runwait robocopy "%source%\AppData\Roaming"

Complete:
Msgbox Migration complete.
