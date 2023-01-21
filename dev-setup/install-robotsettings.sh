#!/bin/bash
download-robotsettings(){
    URL="https://community-static.aldebaran.com/resources/2.8.6/robot-settings-2.8.6.23-linux64-setup.run"
    cd /tmp
    wget -O robot-settings.run "$URL" 2>&1 | \
    stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
    dialog --title "Downloading Robot Settings" --gauge "Please wait while Robot Settings downloads from Aldebaran. 
This will take a while. 

After download completes, the terminal will prompt for your password." 15 75 100
}

setup-robotsettings(){
    chmod +x robot-settings.run
    dialog --title Finished! --title "Installing Robot Settings" --msgbox "The Robot Settings installer will now launch. Please follow the prompts." 22 76
    ./robot-settings.run
    dialog --title Finished! --title "Installing Robot Settings" --msgbox "Press OK when the installer has finished." 22 76
    rm -rf robot-settings.run
}

download-robotsettings
setup-robotsettings