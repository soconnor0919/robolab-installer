#!/bin/bash
installvscode(){
    sudo snap install code --classic 2>&1 | dialog --title "Installing VS Code" --progressbox 30 120
}

getrequiredpackages(){
    sudo apt install cmake python3 python3-pip -y 2>&1 | dialog --title "Installing required packages" --progressbox 30 120
    pip3 install qibuild --user 2>&1 | dialog --title "Installing qibuild" --progressbox 30 120
}

setup-qibuild(){
    echo 'PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc 
    source ~/.bashrc
    ./dev-setup/cppsdk.exp
}

setup-worktree(){
    worktreedir=$(\
  		dialog --title "Setup Worktree" \
         --inputbox "Choose a worktree directory:" 8 40 '~/Documents/my-worktree' \
  		3>&1 1>&2 2>&3 3>&- \
		)
	mkdir -p $worktreedir
    cd $worktreedir
    qibuild init
}

download-naoqi(){
    URL="https://community-static.aldebaran.com/resources/2.8.5/naoqi-sdk-2.8.5.10-linux64.tar.gz"
    cd /tmp
    wget -O naoqi-sdk.tar.gz "$URL" 2>&1 | \
    stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
    dialog --title "Downloading NAOqi SDK" --gauge "Please wait while the NAOqi C++ SDK downloads from Aldebaran. 
This will take a while. 

After download completes, the terminal will prompt for your password." 15 75 100
    sudo mkdir -p /opt/naoqi-sdk
    sudo tar -xvf /tmp/naoqi-sdk.tar.gz -C /opt/naoqi-sdk --strip-components=1 2>&1 | dialog --title "Extracting NAOqi SDK" --progressbox 30 120
    sudo rm -rf /tmp/naoqi-sdk.tar.gz
}

setup-naoqi() {
    cd $worktreedir
    qitoolchain create mytoolchain /opt/naoqi-sdk/toolchain.xml
    qibuild add-config myconfig -t mytoolchain --default
}

installvscode
getrequiredpackages
setup-qibuild
setup-worktree
download-naoqi
setup-naoqi