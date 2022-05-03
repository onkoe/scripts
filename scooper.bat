@echo off
echo The script will now begin installing necessary programs and tools.


:: check if scoop is installed
where /q scoop
if ERRORLEVEL 1 (
	:: wasnt found :(
	echo Scoop is not installed. Please install it from https://scoop.sh.
	exit /b
) ELSE (
	:: was found :)
	echo Scoop was found successfully! Proceeding with installation. 
	call :installation
	:: exit /B %ERRORLEVEL%  
	call :setup_clink
	echo All programs and tools have been setup. 
	echo Script has completed program installation and setup. 
	exit /B %ERRORLEVEL%
)

:installation
:: add buckets 
cmd /C scoop bucket add extras 
cmd /C scoop bucket add nonportable 
echo Necessary buckets have been added.
:: install the stuff
cmd /C scoop install wezterm clink sioyek 7zip git deadbeef nextcloud sudo telegram tldr yt-dlp ffmpeg micro flameshot virtualbox-np vlc qview losslesscut gh
echo The installation script has finished successfully!
EXIT /B 0

:setup_clink
:: test for clink
where /q clink
if ERRORLEVEL 1 (
	echo Clink was not located on your system. Please restart, then run the script again. 
)

:: install it now 
cmd /C clink autorun install
EXIT /B 0
