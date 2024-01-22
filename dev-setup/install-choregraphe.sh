#!/bin/bash

downloadChoregraphe(){
    URL="https://community-static.aldebaran.com/resources/2.8.8/choregraphe-2.8.8-ubuntu2204-installer.run"
    cd /tmp
    wget -O choregraphe-suite.run "$URL" 2>&1 | \
    stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
    dialog --title "Downloading Choregraphe" --gauge "Please wait while Choregraphe downloads from Aldebaran. 
This will take a while. 

After download completes, the terminal may prompt for your password." 20 70 100
}

installChoregraphe() {
    sudo mkdir -p /opt/choregraphe
    sudo chmod +x choregraphe-suite.run
    sudo ./choregraphe-suite.run --mode unattended --installdir /opt/choregraphe
    sudo rm -rf choregraphe-suite.run

    # Set .desktop launchers as trusted
    gio set ~/Desktop/Monitor*.desktop metadata::trusted true
    gio set ~/Desktop/NAO*.desktop metadata::trusted true
    gio set ~/Desktop/Choregraphe*.desktop metadata::trusted true
    gio set ~/Desktop/Memory*.desktop metadata::trusted true
}

patchZlib() {
    cd /opt/choregraphe/lib/
    sudo mv libz.so.1 libz.so.1.old
    sudo ln -s /lib/x86_64-linux-gnu/libz.so.1
}

downloadChoregraphe
installChoregraphe
patchZlib
