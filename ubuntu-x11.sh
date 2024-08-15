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
        echo -e "${yellow}VERSION : 2.0"
        echo -e "${blue}"
        echo "################################################################"
        echo ""
}


pkgInstall(){
	echo -e "${yellow}[+] ${green}updating system${white}"
	echo ""
	pkg update -y
	echo -e "${yellow}[+] ${green}installing x11-repo${white}"
	echo ""
	pkg install x11-repo -y
	for i in proot-distro
	do
		echo -e "${yellow}[+] ${green}checking $i installed or not ${white}"
		echo ""
		sleep 2
		if command -v $i > /dev/null 2>&1
		then
			echo -e "${yellow}[+] ${green}$i is installed ${white}"
			echo ""
		else
			echo -e "${yellow}[+] ${green}installing $i ${white}"
			echo ""
                	pkg install $i -y
		fi
	done
	sleep 2
	echo -e "${yellow}[+] ${green}checking termux-x11 installed or not ${white}"
	echo ""
        sleep 2
	if command -v termux-x11 > /dev/null 2>&1
        then
		echo -e "${yellow}[+] ${green}termux-x11 is installed ${white}"
		echo ""
	else
                echo -e "${yellow}[+] ${green}installing termux-x11${white}"
		echo ""
                pkg install termux-x11-nightly -y
        fi
	sleep 2
}
distroInstaller(){
	echo -e "${yellow}[+] ${green}checking UBUNTU installed or not ${white}"
        echo ""
        sleep 2
        if [ -d /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu ]
        then
                echo -e "${yellow}[+] ${green}ubuntu is installed ${white}"
                echo ""
		sleep 2
        else
	echo -e "${yellow}[+] ${green}installing UBUNTU on your system${white}"
	echo ""
	sleep 2
	pd i ubuntu
	fi
	if [ -d /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root ]
	then
		sleep 3
	else
		echo -e "${red}[+] failed to install UBUNTU${white}"
		exit 1
	fi
}
allowExternal(){
	echo -e "${yellow}[+] ${green}enabeling termux external view${white}"
	sleep 2
	echo "allow-external-apps = true" >> $HOME/.termux/termux.properties
	sleep 4
}

userAdding(){
    banner
    echo -e "${yellow}[+] ${green}Installing basic packages on ubuntu ${white}"
    echo ""

    
        while ! pd sh ubuntu --shared-tmp -- /bin/bash -c "apt update -y && apt install -y sudo"; do
            echo -e "${red}[-] Failed to update and install sudo. Retrying...${white}"
            sleep 2
        done
        for i in wget apt-utils locales-all dialog tzdata sudo which
        do
            echo ""
            echo -e "${yellow}[+] ${green}Installing $i ${white}"
            echo ""
            while ! pd sh ubuntu --shared-tmp -- /bin/bash -c "apt install -y $i"; do
                echo -e "${red}[-] Failed to install $i. Retrying...${white}"
                sleep 2
            done
            echo -e "${green}[+] Successfully installed $i ${white}"
        done
        
    banner
    
    echo -e "${yellow}[+] ${green}Do you want to install additional packages (programming languages)? (y/N): \c"
    read opt1

    if [[ "$opt1" == "y" || "$opt1" == "Y" ]]; then
        for prg in php clang gcc python-is-python3 nodejs default-jdk
        do
            echo ""
            echo -e "${yellow}[+] ${green}Installing $prg${white}"
            echo ""
            while ! pd sh ubuntu --shared-tmp -- /bin/bash -c "apt install -y $i"; do
                echo -e "${red}[-] Failed to install $prg. Retrying...${white}"
                sleep 2
            done
            echo -e "${green}[+] Successfully installed $prg ${white}"
        done
        echo -e "${yellow}[+] ${cyan}Successfully installed additional packages${white}"
    elif [[ "$opt1" == "n" || "$opt1" == "N" ]]; then
        echo "Okay 🙁"
    else
        echo -e "${red}[-] Wrong option entered!${white}"
        exit 1
    fi

    echo -e "${yellow}[+] ${green}Do you want to install penetration testing tools (hacking tools)? (y/N): \c"
    read opt2

    if [[ "$opt2" == "y" || "$opt2" == "Y" ]]; then
        for tools in nmap nikto hydra hashcat sqlmap tor dirb john bettercap ncat crunch cupp
        do
            echo ""
            echo -e "${yellow}[+] ${green}Installing $tools${white}"
            echo ""
            while ! pd sh ubuntu --shared-tmp -- /bin/bash -c "apt install -y $tools"; do
                echo -e "${red}[-] Failed to install $tools. Retrying...${white}"
                sleep 2
            done
            echo -e "${green}[+] Successfully installed $tools ${white}"
        done
        echo -e "${yellow}[+] ${cyan}Successfully installed penetration testing tools${white}"
    elif [[ "$opt2" == "n" || "$opt2" == "N" ]]; then
        echo "Okay 🙁"
    else
        echo -e "${red}[-] Wrong option entered!${white}"
        exit 1
    fi
    
    banner
        pd sh ubuntu --shared-tmp -- /bin/bash -c '
    
    black="\033[1;30m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
magenta="\033[1;35m"
cyan="\033[1;36m"
white="\033[1;37m"

    
    
    echo -e "\033[1;36m"
    read -p "[+] enter username (lowercase) : " user
    echo -e "\033[1;31m"
    read -p "[+] enter password (lowercase) : " pass
    echo -e ""
    useradd -m -s $(which bash) ${user}
    usermod -aG sudo ${user}
    echo "${user}:${pass}" | chpasswd
    echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers 
    
    
    echo "#! /bin/bash" >> ubuntu
    echo "" >> ubuntu
    echo "termux-x11 :1 &" >> ubuntu
    echo "pd sh ubuntu --shared-tmp --user $user" >> ubuntu
    chmod 777 ubuntu
    mv ubuntu /data/data/com.termux/files/usr/bin/
    chmod 777 /data/data/com.termux/files/usr/bin/ubuntu 
    
   banner(){
    clear
    echo -e "${blue}################################################################"
    echo ""
    echo "  __  _____  __  ___  __________  __    _  ________"
    echo " / / / / _ \)/ / / / \|/ /_  __/ / / /___\| \|/_\<  \<  /"
    echo "/ /_/ / _  / /_/ /    / / / / /_/ /___/\>  \< / // / "
    echo "\____/____/\____/_/\|_/ /_/  \____/   /_/\|_\|/_//_/  "
    echo "                                                   "
    echo -e "${green}presented by : Anon404"
    echo "created by : William Steven"
    echo -e "${yellow}VERSION : 2.0"
    echo -e "${blue}"
    echo "################################################################"
    echo ""
}
pkgInstaller(){

    echo -e "${yellow}[+] ${green}installing desktop environment on ubuntu ${white}"
    echo ""
    
    for i in  wget apt-utils dialog tzdata gnupg2 dbus curl nano git xz-utils at-spi2-core xfce4 xfce4-goodies xfce4-terminal librsvg2-common inetutils-tools dbus-x11 gtk2-engines-murrine gtk2-engines-pixbuf apt-transport-https fish neofetch
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



note(){
   # creating x11-start file
   touch x11-start
   echo "#! /bin/bash" >> x11-start
   echo "export DISPLAY=:1" >> x11-start
   echo "xfce4-session > /dev/null 2&>1 " >> x11-start
   chmod 777 x11-start && mv x11-start /usr/bin
   
   echo "clear" >> /home/$user/.bashrc
   echo "neofetch" >> /home/$user/.bashrc
   echo "fish" >> /home/$user/.bashrc

   banner
   echo -e "${yellow}[+] ${green}exit your termux"
   echo ""
   echo -e "${yellow}[+] ${green}open again and type ${cyan}ubuntu${green} on termux"
   echo ""
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
     

     echo -e "${yellow}[+] ${green}installing and settingup themes icons wallpapers"
     wget https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/candy-icons-master.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/Sweet-Ambar-Blue-Dark-v40.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/01-WhiteSur.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/WhiteSur-Dark.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/Sweet-cursors.tar.xz https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/3fdc0e89e55c612da93893fd216253928423.png https://raw.githubusercontent.com/Anon-404/My-assets/main/whitesure/config_archive.tar.xz

     rm -rf /home/$user/.config
     tar -xvf Sweet-cursors.tar.xz -C "/usr/share/icons"
     tar -xvf Sweet-Ambar-Blue-Dark-v40.tar.xz -C "/usr/share/themes/"
     tar -xvf candy-icons-master.tar.xz -C "/usr/share/icons"
     tar -xvf WhiteSur-Dark.tar.xz -C "/usr/share/themes"
     tar -xvf 01-WhiteSur.tar.xz -C "/usr/share/icons"
     tar -xvf config_archive.tar.xz -C "/home/$user/"
     mv 3fdc0e89e55c612da93893fd216253928423.png /usr/share/backgrounds/
     sudo apt install ubuntu-wallpapers -y

     sleep 4
}

fixSound() {
	echo -e "${yellow}[+] ${green}Fixing sound${white}"
	echo "$(echo "bash ~/.sound" | cat - /data/data/com.termux/files/usr/bin/ubuntu)" >> /data/data/com.termux/files/usr/bin/ubuntu
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

main(){
    banner
    pkgInstaller
    #vscode
    #firefox
    envsetup
    fixSound
    cleanup
    note
}

main

'
}


main(){
    banner
    pkgInstall
    distroInstaller
    allowExternal
    userAdding
}

main