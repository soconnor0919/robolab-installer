#!/bin/bash
initsetup(){
	installprerequisites
}

installprerequisites(){
	sudo apt install git dialog expect -y -q=3 >/dev/null 2>&1
	welcomemsg
}

welcomemsg(){
	dialog --title "Welcome to the Robolab Uninstaller!" --msgbox "This script will automatically remove all Aldebaran software from your system.
You may be prompted for your password.

Press OK to continue." 20 70
	remove-software
}

remove-software() {
	sudo rm -rf /opt/robot_settings /opt/choregraphe /opt/Softbank\ Robotics /opt/SoftBank\ Robotics /opt/nao-flasher /opt/naoqi-python-sdk /opt/naoqi-cpp-sdk
	sudo rm -rf /usr/share/applications/nao-flasher.desktop
	sudo rm -rf /usr/share/applications/Robot\ Settings.desktop
	sudo rm -rf /usr/share/applications/NAO\ Documentation*.desktop
	sudo rm -rf /usr/share/applications/Monitor*.desktop
	sudo rm -rf /usr/share/applications/Memory\ Backup*.desktop
	sudo rm -rf /usr/share/applications/Choregraphe*.desktop
	sudo rm -rf /etc/Softbank\ Robotics
	sudo rm -rf /etc/SoftBank\ Robotics
	rm -rf ~/Desktop/NAO\ Documentation*.desktop
	rm -rf ~/Desktop/Monitor*.desktop
	rm -rf ~/Desktop/Memory\ Backup*.desktop
	rm -rf ~/Desktop/Choregraphe*.desktop
	rm -rf ~/.local/share/choregraphe*
	rm -rf ~/.local/share/SoftBank\ Robotics/
	rm -rf ~/.cache/SoftBank\ Robotics/
	rm -rf ~/.config/SoftBank\ Robotics/

	if grep -Fxq 'PATH=$PATH:$HOME/.local/bin' ~/.bashrc
        then
            sed -i '/PATH=$PATH:$HOME\/.local\/bin$/d' ~/.bashrc
        else
            continue
        fi
	if grep -Fxq 'export PYTHONPATH=${PYTHONPATH}:/opt/naoqi-python-sdk/lib/python2.7/site-packages' ~/.bashrc
        then
            sed -i '/\/opt\/naoqi-python-sdk/d' ~/.bashrc
        else
			continue
        fi
    if grep -Fxq 'export QI_SDK_PREFIX=/opt/naoqi-python-sdk' ~/.bashrc
        then
            sed -i '/\/opt\/naoqi-python-sdk/d' ~/.bashrc
        else
			continue
        fi
}

exitmsg() { \
	dialog --title Finished! --msgbox "The uninstaller has finished. Press OK to exit." 20 70
	clear
}

# Things that are executed (in order)
initsetup
exitmsg