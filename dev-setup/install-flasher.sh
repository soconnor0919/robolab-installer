#!/bin/bash
download-flasher(){
    URL="https://community-static.aldebaran.com/resources/2.1.0.19/flasher-2.1.0.19-linux64.tar.gz"
    cd /tmp
    wget -O flasher.tar.gz "$URL" 2>&1 | \
    stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
    dialog --title "Downloading NAO Flasher" --gauge "Please wait while NAO Flasher downloads from Aldebaran. 
This will take a while. 

After download completes, the terminal may prompt for your password." 20 70 100
    sudo mkdir -p /opt/nao-flasher
    sudo tar -xvf /tmp/flasher.tar.gz -C /opt/nao-flasher --strip-components=1 2>&1 | dialog --title "Extracting NAO Flasher" --progressbox 20 70
    sudo rm -rf /tmp/flasher.tar.gz
}

setup-flasher(){
    patchZlib
    sudo touch /usr/share/applications/nao-flasher.desktop
	sudo echo "[Desktop Entry]
Version=1.0
Name=NAO Flasher
GenericName=NAO Flasher
Comment=Launches NAO Flasher
Icon=/opt/robot_settings/share/bootconfig/icons/robot_settings.ico
Exec='/opt/nao-flasher/flasher'
Terminal=false
Type=Application
Categories=Development
Keywords=Robot;SoftBank Robotics" > /usr/share/applications/nao-flasher.desktop
}

patchZlib() {
    cd /opt/nao-flasher/lib/
    sudo mv libz.so.1 libz.so.1.old
    sudo ln -s /lib/x86_64-linux-gnu/libz.so.1
}

download-flasher
setup-flasher