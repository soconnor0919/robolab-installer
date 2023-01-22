#!/bin/bash
installvscode(){
    sudo snap install code --classic 2>&1 | dialog --title "Installing VS Code" --progressbox 20 70
    code --install-extension ms-python.python 2>&1 | dialog --title "Installing VS Code" --progressbox 20 70
}

getrequiredpackages(){
    sudo apt install python2.7 -y 2>&1 | dialog --title "Installing required packages" --progressbox 20 70
}

download-naoqi(){
    URL="https://community-static.aldebaran.com/resources/2.8.6/pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327.tar.gz"
    cd /tmp
    wget -O naoqi-python-sdk.tar.gz "$URL" 2>&1 | \
    stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
    dialog --title "Downloading NAOqi Python SDK" --gauge "Please wait while the NAOqi Python SDK downloads from Aldebaran. 
This will take a while. 

After download completes, the terminal may prompt for your password." 20 70 100
    sudo mkdir -p /opt/naoqi-python-sdk
    sudo tar -xvf /tmp/naoqi-python-sdk.tar.gz -C /opt/naoqi-python-sdk --strip-components=1 2>&1 | dialog --title "Extracting NAOqi Python SDK" --progressbox 20 70
    sudo rm -rf /tmp/naoqi-python-sdk.tar.gz
}

setup-naoqi(){
    if grep -Fxq 'export PYTHONPATH=${PYTHONPATH}:/opt/naoqi-python-sdk/lib/python2.7/site-packages' ~/.bashrc
        then
            continue
        else
            echo 'export PYTHONPATH=${PYTHONPATH}:/opt/naoqi-python-sdk/lib/python2.7/site-packages' >> ~/.bashrc 
            source ~/.bashrc
        fi
    if grep -Fxq 'export QI_SDK_PREFIX=/opt/naoqi-python-sdk' ~/.bashrc
        then
            continue
        else
            echo 'export QI_SDK_PREFIX=/opt/naoqi-python-sdk' >> ~/.bashrc 
            source ~/.bashrc
        fi
}

installvscode
getrequiredpackages
download-naoqi
setup-naoqi