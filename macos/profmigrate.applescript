display dialog "ProfMigrate for Mac
Taylor Jadin 2015

This application will copy user data for a selected profile folder, and copy that folder to a destination folder. It excludes the ~/Library and ~/Applications folders, but does include Firefox, Chrome, Thunderbird, Stickies, and Address Book data. First you will need to select the user folder's current location, then you should select the destination folder."

-- Get source and destination paths for copying and set to variables
set source to quoted form of POSIX path of (choose folder)
set dest to quoted form of POSIX path of (choose folder)

-- Make path variables for Firefox, Chrome, Thunderbird, Address Book, and Stickies
set Firefox to quoted form of "Library/Application Support/Firefox/"
set Chrome to quoted form of "Library/Application Support/Google/"
set Thunderbird to quoted form of "Library/Thunderbird/"
set AddressBook to quoted form of "Library/Application Support/AddressBook/"
set Stickies to quoted form of "Library/StickiesDatabase"

-- Prompt user to authenticate and display confirmation dialog
set myUser to text returned of (display dialog Â
	"Enter your username to authenticate" default answer Â
	"" buttons {"Continue"} Â
	default button 1 Â
	with icon stop Â
	)
set myPass to text returned of (Â
	display dialog "Enter the password for " & myUser Â
		default answer Â
		"" buttons {"Continue"} Â
		default button 1 Â
		with icon stop Â
		with hidden answer)

-- Confirmation dialog
display dialog "About to copy contents of " & source & "to " & dest & ". Ok to continue?"

-- Authenticate with provided user credentials
tell application "Terminal"
	do script "su " & myUser
	activate
end tell
delay 1
tell application "System Events"
	keystroke myPass & return
	delay 1
end tell

tell application "Terminal"
	do script "sudo su" in front window
	activate
end tell
delay 1
tell application "System Events"
	keystroke myPass & return
	delay 1
end tell

-- Open Terminal and run rsync copy commands
tell application "Terminal"
	activate
	-- Run rsync commands to copy Firefox, Chrome, Thunderbird, Address Book, and Stickies data
	do script "mkdir " & dest & "Library" in front window
	do script "mkdir " & dest & "Library/Application\\ Support" in front window
	do script "rsync -aP --exclude '.Trash' --stats --human-readable " & source & Firefox & " " & dest & Firefox in front window
	do script "rsync -aP --exclude '.Trash' --stats --human-readable " & source & Chrome & " " & dest & Chrome in front window
	do script "rsync -aP --exclude '.Trash' --stats --human-readable " & source & Thunderbird & " " & dest & Thunderbird in front window
	do script "rsync -aP --exclude '.Trash' --stats --human-readable " & source & AddressBook & " " & dest & AddressBook in front window
	do script "rsync -aP --exclude '.Trash' --stats --human-readable " & source & Stickies & " " & dest & Stickies in front window
	-- Run an rsync command to copy the source profile to the destination profile
	do script "rsync -aP --exclude '.Trash' --exclude 'Library' --exclude 'Applications' --stats --human-readable " & source & " " & dest in front window
end tell
