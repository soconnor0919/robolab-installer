#!/bin/bash
initsetup(){
	installprerequisites
}

installprerequisites(){
	sudo apt install git dialog expect -y -q=3 >/dev/null 2>&1
	welcomemsg
}

welcomemsg(){
	dialog --title Welcome! --msgbox "This script can install / edit the following:
- Set Git username / email
- Install and set up the NAO6 Development Environment" 20 60
	selectoptions
}

selectoptions(){
	cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
	options=(1 "Set up Git username and email" off    # any option can be set to default to "on"
			2 "Set up NAO6 Development Environment" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices
	do
		case $choice in
			1)
				gitconfig
				;;
			2)
				choosedevenv
				;;
		esac
	done
}

choosedevenv(){
	cmd=(dialog --separate-output --checklist "Which development environment(s) would you like to install?:" 22 76 16)
	options=(1 "Choregraphe" off    # any option can be set to default to "on"
			2 "Python SDK" off
			3 "C++ SDK" off
			4 "Robot Settings" on)
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
				chmod +x dev-setup/cppsdk.sh
				bash dev-setup/install-cppsdk.sh
				;;
			4)
				chmod +x dev-setup/install-robotsettings.sh
				bash dev-setup/install-robotsettings.sh
				;;
		esac
	done
}

gitconfig() { 
	sudo rm -rf /home/"$USER"/.git
	gitusername=$(\
  		dialog --title "Configure Git" \
         --inputbox "Enter your full name:" 8 40 \
  		3>&1 1>&2 2>&3 3>&- \
		)
	gitemail=$(\
  		dialog --title "Configure Git" \
         --inputbox "Enter your email:" 8 40 \
  		3>&1 1>&2 2>&3 3>&- \
		)
	git config --global user.name "$gitusername"
	git config --global user.email "$gitemail"
	git config --global credential.helper store
}

exitmsg() { \
	dialog --title Finished! --msgbox "The installer has finished. Press OK to exit." 22 76
	clear
}

# Things that are executed (in order)
initsetup
exitmsg



