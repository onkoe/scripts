@echo off
echo The script will now begin installing necessary programs and tools.
call :check_scoop
exit /b 0


:check_scoop
:: check if scoop is installed
	where /q scoop
	if ERRORLEVEL 1 (
		:: wasnt found :(
		call :scoop_prompt
		exit /b
	) ELSE (
		:: was found :)
		echo Scoop was found successfully! Proceeding with installation. 
		call :scoop_found
		exit /b 0
	)
exit /B 0

:scoop_prompt
:: Prompt user if they'd like to install Scoop automatically
	echo Error: Scoop is not installed.
	echo Would you like to install it automatically? 
	cmd /C choice 
	if ERRORLEVEL 1 ( :: yes
		call :scoop_installer
	) else ( :: no (kicks u out lol)
		echo Fatal: Scoop is not installed. Please install it from https://scoop.sh.
	)
exit /B 0

:scoop_installer
	echo Installing Scoop...
	cmd /C powershell -command "& {Set-ExecutionPolicy RemoteSigned -Scope CurrentUser; iwr -useb get.scoop.sh | iex}"
exit /B 0

:scoop_found
	call :pkg_installation
	:: exit /B %ERRORLEVEL%  
	call :setup_clink
	echo All programs and tools have been setup. 
	echo Script has completed program installation and setup. 
	exit /B %ERRORLEVEL%
exit /B 0

:pkg_installation
:: add buckets 
	cmd /C scoop bucket add extras 
	cmd /C scoop bucket add nonportable 
	echo Necessary buckets have been added.
	echo Updating existing applications...
	cmd /C scoop update *
:: install the stuff
	cmd /C scoop install wezterm clink sioyek 7zip git deadbeef nextcloud sudo telegram tldr yt-dlp ffmpeg micro flameshot virtualbox-np vlc qview losslesscut gh gow
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
