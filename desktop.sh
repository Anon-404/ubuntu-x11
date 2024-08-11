#! /bin/bash
#
##########################################
#                                        #
#          presented : Anon404           #
#        Author : William Steven         #
#                                        #
##########################################
#____colors____
black='\033[1;30m'
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
magenta='\033[1;35m'
cyan='\033[1;36m'
white='\033[1;37m'

banner(){
clear
        echo -e "${blue}################################################################"
        echo ""
        echo "  __  _____  __  ___  __________  __    _  ________"
        echo " / / / / _ )/ / / / |/ /_  __/ / / /___| |/_<  <  /"
        echo "/ /_/ / _  / /_/ /    / / / / /_/ /___/>  < / // / "
        echo "\____/____/\____/_/|_/ /_/  \____/   /_/|_|/_//_/  "
        echo "                                                   "
        echo -e "${green}presented by : Anon404"
        echo "created by : William Steven"
        echo -e "${blue}"
        echo "################################################################"
        echo ""
}

pkgInstaller(){
    for i in  wget apt-utils dialog tzdata gnupg2 dbus curl nano git xz-utils at-spi2-core xfce4 xfce4-goodies xfce4-terminal librsvg2-common inetutils-tools dbus-x11 gtk2-engines-murrine gtk2-engines-pixbuf apt-transport-https
    do
         echo ""
         echo -e "${yellow}[+] ${green}installing $i ${white}"
         echo ""
         sudo apt install $i -y
    done
}
firefox(){
    echo -e "${yellow}[+] ${green}Checking if firefox is installed...${white}"
    if [ ! -f /usr/bin/firefox ]
    then
        echo -e "${yellow}[+] ${green}Installing firefox${white}"
        bash <(curl -fsSL "https://raw.githubusercontent.com/Anon-404/My-assets/main/firefox.sh")
    else
        echo -e "${yellow}[+] ${green}firefox is installed${white}"
	sleep 3
    fi
}

vscode(){
    echo -e "${yellow}[+] ${green}Checking if vscode is installed...${white}"
    echo ""
    sleep 2

    if [ -f /usr/bin/code ]
    then
        echo -e "${yellow}[+] ${green}vscode is installed${white}"
        echo ""
	sleep 3
    else
        echo -e "${yellow}[+] ${green}Installing vscode${white}"
        echo ""
        curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/packages.microsoft.gpg > /dev/null
        echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
        sudo apt update -y
        sudo apt install code -y
        echo -e "${yellow}[+] ${green}patching.......${white}"
        curl -fsSL https://raw.githubusercontent.com/Anon-404/My-assets/main/code.desktop > /usr/share/applications/code.desktop
        sleep 3
    fi
}

}

note(){
   # creating x11-start file
   touch x11-start
   echo "#! /bin/bash" >> x11-start
   echo "export DISPLAY=:1" >> x11-start
   echo "xfce4-session > /dev/null 2&>1 " >> x11-start
   chmod 777 x11-start && mv x11-start /usr/bin

   banner
   echo -e "${yellow}[+] ${green}install ${cyan}termux x11${green} app from github"
   echo ""
   echo -e "${yellow}[+] ${green}simply type ${cyan}x11-start ${green}to start desktop environment"
   echo ""
   echo -e "${yellow}[+] ${green}open ${cyan}termux x11 ${green}app and enjoy"
   echo ""
   echo -e "${yellow}[+] ${green}stop x11 service by ${cyan}CTRL + C"
   echo ""
}

envsetup(){
     banner

     echo -e "${yellow}[+] ${green}installing and settingup themes icons wallpapers"
     wget https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/candy-icons-master.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/Sweet-Ambar-Blue-Dark-v40.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/01-WhiteSur.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/WhiteSur-Dark.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/Sweet-cursors.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/3fdc0e89e55c612da93893fd216253928423.png https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/config_archive.tar.xz

     rm -rf .config
     tar -xvf Sweet-cursors.tar.xz -C "/usr/share/icons"
     tar -xvf Sweet-Ambar-Blue-Dark-v40.tar.xz -C "/usr/share/themes/"
     tar -xvf candy-icons-master.tar.xz -C "/usr/share/icons"
     tar -xvf WhiteSur-Dark.tar.xz -C "/usr/share/themes"
     tar -xvf 01-WhiteSur.tar.xz -C "/usr/share/icons"
     tar -xvf config_archive.tar.xz -C "./"
     mv 3fdc0e89e55c612da93893fd216253928423.png /usr/share/backgrounds/
     sudo apt install ubuntu-wallpapers -y

     sleep 4
}

fixSound() {
	echo -e "${yellow}[+] ${green}Fixing sound${white}"
	echo "$(echo "bash ~/.sound" | cat - /data/data/com.termux/files/usr/bin/ubuntu)" > /data/data/com.termux/files/usr/bin/ubuntu
	echo "export DISPLAY=":1"" >> /etc/profile
	echo "export PULSE_SERVER=127.0.0.1" >> /etc/profile 
	source /etc/profile
}
cleanup(){
     echo ""
     echo -e "${yellow}[+] ${green}refreshing system ${white}"
     echo ""
     rm -rf 01-WhiteSur.tar.xz WhiteSur-Dark.tar.xz candy-icons-master.tar.xz Sweet-cursors.tar.xz Sweet-Ambar-Blue-Dark-v40.tar.xz config_archive.tar.xz
     sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
     sudo yes | apt upgrade
     sudo yes | apt install gtk2-engines-murrine gtk2-engines-pixbuf sassc optipng inkscape libglib2.0-dev-bin
     sudo apt update -y
}

# call funcs

banner
pkgInstaller
vscode
firefox
envsetup
fixSound
cleanup
note
