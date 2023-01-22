#!/bin/bash
download-robotsettings(){
    URL="https://community-static.aldebaran.com/resources/2.8.6/robot-settings-2.8.6.23-linux64-setup.run"
    cd /tmp
    wget -O robot-settings.run "$URL" 2>&1 | \
    stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
    dialog --title "Downloading Robot Settings" --gauge "Please wait while Robot Settings downloads from Aldebaran. 
This will take a while. 

After download completes, the terminal may prompt for your password." 20 70 100
}

setup-robotsettings(){
    chmod +x robot-settings.run
    sudo rm -rf /opt/robot_settings
    dialog  --title "Installing Robot Settings" --msgbox "The Robot Settings installer will now launch. Please follow the prompts. After installation completes, please uncheck \"Run Robot Settings now.\"" 20 70
    ./robot-settings.run
    patchZlib
    rm -rf robot-settings.run
}

patchZlib() {
    cd /opt/robot_settings/lib/
    sudo mv libz.so.1 libz.so.1.old
    sudo ln -s /lib/x86_64-linux-gnu/libz.so.1
}

download-robotsettings
setup-robotsettings