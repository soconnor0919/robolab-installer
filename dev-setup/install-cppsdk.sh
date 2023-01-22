#!/bin/bash
installvscode(){
    sudo snap install code --classic 2>&1 | dialog --title "Installing VS Code" --progressbox 20 70
    code --install-extension ms-vscode.cpptools 2>&1 | dialog --title "Installing VS Code" --progressbox 20 70
}

getrequiredpackages(){
    sudo apt install cmake python3 python3-pip -y 2>&1 | dialog --title "Installing required packages" --progressbox 20 70
    pip3 install qibuild --user 2>&1 | dialog --title "Installing qibuild" --progressbox 20 70
}

setup-qibuild(){
    if grep -Fxq 'PATH=$PATH:$HOME/.local/bin' ~/.bashrc
        then
            continue
        else
            echo 'PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc 
            source ~/.bashrc
        fi
    ./dev-setup/cppsdk.exp
}

setup-worktree(){
	mkdir -p ~/Documents/naoqi-cpp
    cd ~/Documents/naoqi-cpp
    qibuild init
}

download-naoqi(){
    URL="https://community-static.aldebaran.com/resources/2.8.5/naoqi-cpp-sdk-2.8.5.10-linux64.tar.gz"
    cd /tmp
    wget -O naoqi-cpp-sdk.tar.gz "$URL" 2>&1 | \
    stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
    dialog --title "Downloading NAOqi C++ SDK" --gauge "Please wait while the NAOqi C++ SDK downloads from Aldebaran. 
This will take a while. 

After download completes, the terminal may prompt for your password." 20 70 100
    sudo mkdir -p /opt/naoqi-cpp-sdk
    sudo tar -xvf /tmp/naoqi-cpp-sdk.tar.gz -C /opt/naoqi-cpp-sdk --strip-components=1 2>&1 | dialog --title "Extracting NAOqi C++ SDK" --progressbox 20 70
    sudo rm -rf /tmp/naoqi-cpp-sdk.tar.gz
}

setup-naoqi() {
    cd ~/Documents/naoqi-cpp
    qitoolchain create mytoolchain /opt/naoqi-cpp-sdk/toolchain.xml
    qibuild add-config myconfig -t mytoolchain --default
}

installvscode
getrequiredpackages
setup-qibuild
setup-worktree
download-naoqi
setup-naoqi