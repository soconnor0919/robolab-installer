#!/bin/bash
initsetup(){
	installprerequisites
}

installprerequisites(){
	sudo apt install git dialog expect -y -q=3 >/dev/null 2>&1
	syscheck
	welcomemsg
}

syscheck(){
	arch=$(uname -i)
	if [[ $arch == i*86 ]]; then
		dialog --title "WARNING!" --msgbox "This script was built for x86_64 systems. You can still attempt an install, but things may not work." 20 70
		dpkg --add-architecture amd64
	elif  [[ $arch == arm* ]]; then
		dialog --title "WARNING!" --msgbox "This script was built for x86_64 systems. You can still attempt an install, but things may not work." 20 70
		dpkg --add-architecture amd64
	fi

	ver="$(lsb_release -sr)"
	if [[ $ver != '22.10' ]]; then
		dialog --title "WARNING!" --msgbox "This script was built for systems running Ubuntu 22.10. You can still attempt an install, but things may not work." 20 70
	fi
}

welcomemsg(){
	dialog --title "Welcome to the Robolab Installer!" --msgbox "This script will automatically download, install, and patch the following:
	
- Choregraphe Integrated Development Environment
- NAOqi Python Software Development Kit
- NAOqi C++ Software Development Kit
- NAO Flasher
- NAO Robot Settings

You will now be directed to choose what you would like to install." 20 70
	choose-software
}

choose-software(){
	cmd=(dialog --separate-output --checklist "Which software would you like to install?:" 20 70 16)
	options=(1 "Choregraphe IDE" off    # any option can be set to default to "on"
			2 "Python SDK" off
			3 "C++ SDK" off
			4 "NAO Flasher" off
			5 "Robot Settings" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices
	do
		case $choice in
			1)
				chmod +x dev-setup/install-choregraphe.sh
				bash dev-setup/install-choregraphe.sh
				;;
			2)
				chmod +x dev-setup/install-pythonsdk.sh
				bash dev-setup/install-pythonsdk.sh
				;;
			3)
				chmod +x dev-setup/install-cppsdk.sh
				chmod +x dev-setup/cppsdk.exp
				bash dev-setup/install-cppsdk.sh
				;;
			4)
				chmod +x dev-setup/install-flasher.sh
				bash dev-setup/install-flasher.sh
				;;
			5)
				chmod +x dev-setup/install-robotsettings.sh
				bash dev-setup/install-robotsettings.sh
				;;
		esac
	done
}

exitmsg() { \
	dialog --title Finished! --msgbox "The installer has finished. Press OK to exit." 20 70
	clear
}

# Things that are executed (in order)
initsetup
exitmsg