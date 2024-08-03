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

msinstall(){
    echo ""
    echo -e "${yellow}[+] ${green}installing metasploit ${white}"
    echo ""
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
}


addpkginstaller(){
    echo -e "${yellow}[+] ${green}Do you want to install additional packages (programming languages)? (y/N): \c"
    read opt1

    if [[ "$opt1" == "y" || "$opt1" == "Y" ]]; then
        for prg in php clang gcc python-is-python3 nodejs default-jdk
        do
            echo ""
            echo -e "${yellow}[+] ${green}Installing $prg${white}"
            echo ""
            sudo apt install $prg -y
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
            sudo apt install $tools -y
        done
        sudo msinstall
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
        sudo yes | apt upgrade
        sudo yes | apt update



        echo -e "${yellow}[+] ${cyan}Successfully installed penetration testing tools${white}"
    elif [[ "$opt2" == "n" || "$opt2" == "N" ]]; then
        echo "Okay 🙁"
    else
        echo -e "${red}[-] Wrong option entered!${white}"
        exit 1
    fi
}



pkgInstaller(){
    echo ""
    echo -e "${yellow}[+] ${green}installing sudo ${white}"
    echo ""
    apt update -y && apt install sudo -y
    for i in wget curl fish neofetch git apt-utils locales-all dialog tzdata
    do
         echo ""
         echo -e "${yellow}[+] ${green}installing $i ${white}"
         echo ""
         sudo apt install $i -y
    done
}
usradd(){
    echo -e "${cyan}"
    read -p "[+] enter username (lowercase) : " user
    echo -e "${red}"
    read -p "[+] enter password (lowercase) : " pass
    echo -e ""
    useradd -m -s $(which bash) ${user}
    usermod -aG sudo ${user}
    echo "${user}:${pass}" | chpasswd
    echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
}
usr(){
    banner
    echo -e "${yellow}"
    usradd #user add function
    touch ubuntu
    echo "#! /bin/bash" >> ubuntu
    echo "termux-x11 :1 &" >> ubuntu
    echo "proot-distro login ubuntu --shared-tmp --user ${user}" >> ubuntu
    chmod 777 ubuntu && mv ubuntu /data/data/com.termux/files/usr/bin
    echo "clear && neofetch && fish" >> /home/$user/.bashrc
    mv desktop.sh /home/$user

    sleep 5

}
note(){
    banner
    echo -e "${yellow}[+] ${green}ubuntu installed successfully with a regular user"
    echo ""
    echo -e "${yellow}[+] ${green}exit termux and type ${cyan}ubuntu"
    echo ""
    echo -e "${yellow}[+] ${green}then type ${cyan}sudo bash desktop.sh"
}



banner
pkgInstaller
addpkginstaller
usr
note
