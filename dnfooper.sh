#!/bin/bash
echo "The script will now begin installing necessary programs and tools."
echo -e "Intended for use on Fedora Everything 35.\n"
# Check if system is Fedora and if DNF is installed
system_check() {
	# dnf
	if which dnf > /dev/null; then true
	else 
		echo "Fatal: unable to locate DNF on your system."
		exit
	fi
	# fedora
	if [[ $(cat /etc/system-release) == *"Fedora"* ]]; then true
	else
		echo "Fatal: user is not using Fedora Linux."
	fi
}

# Prompt users to install RPM Fusion
rpm_fusion() {
	# Update, then check if repos exist
	echo "Updating system..."
	sudo dnf update -y 
	
	echo "Checking for RPM Fusion repos..."
	if [[ $(dnf list) == *"Fusion"* ]]; then 
		echo "RPM Fusion is already installed!"
		return 0
	fi
	
	echo "Would you like to install RPM Fusion repos?"
	# cmonnnn gnu, choice is so cool 
	read -p "[Y/N]" yesno -r
	if [ "$yesno" = "y" ] || [ "$yesno" = "Y" ]; then true
	else 
		return 0
	fi 	

	# Install the repos :)
	sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

# help
help() {
	echo "fedsetup.sh help"
	echo "	-h		--help      Shows this help message."
	echo "	-n		--nosys	    Disables system compatibility checking. Dangerous!"
	echo "	-x		--norpm	    Disables RPM Fusion repo installation."
	echo "	-u    		--noupdate  Disables updating within the script."
	# why????
	echo "	-r		--rpm       Enables RPM Fusion repo installation."
	
}

# idk how to make it start at the top lmao
system_check
rpm_fusion
