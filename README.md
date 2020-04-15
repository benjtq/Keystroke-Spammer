# Keystroke Spammer
Break down some text into a series of system-wide keystrokes.

## How to use (macOS only!)

1. Clone/download this repository to your Desktop.
2. Double-click the donwload to unzip.
3. Open the unzipped folder ('Keystroke-Spammer-master'), right click on the file 'keyspam' and click open. This allows macOS to run the file.
4. Close the terminal window that was just opened.
3. Open TextEdit or another text editor, and type in everything you want to spam people with. For example you could copy-and-paste the lyrics of Rap God.
4. Save that file to your desktop, named `words.txt`
5. Open the Terminal (/Applications/Utilities/Terminal.app)
6. Copy-and-paste this into the terminal window and press enter: `~/Desktop/Keystroke-Spammer-master/keyspam ~/Desktop/words.txt`
7. Accept any requests for permission. You may need to go to System Preferences and manually modify the Terminal's permissions.  
**IMPORTANT: Once you press enter you will have 4 seconds to click somewhere you would like things to be typed.** For example. the text field on Apple Messages, to spam your friends.
**Whilst things are being typed you will have zero control over your computer.** *Do not* attempt to do anything whilst the script is running. Just let things type and wait until its done.

If you need to stop the script mid-execution, the best way is to shut down your computer using the power button.


## Troubleshooting

#### If text doesn't appear onscreenn

This may be a permissions error. The Terminal needs to be able to control System Events.

- Go to System Preferences ➡️ Security & Privacy ➡️ Automation and tick 'System Events.app' under 'Terminal'.
- Go to System Preferences ➡️ Security & Privacy ➡️ Files and Folders and tick 'Desktop Folder' under 'Terminal'.

### If the Terminal gives you the error 'the file is not executable by this user'
- Copy-and-paste this into the Terminal: `sudo chmod +rwx ~/Desktop/Keystroke-Spammer-master/keyspam; sudo chmod +r ~/Desktop/words.txt` and try running keyspam again (step 6).
 
