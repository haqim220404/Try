#!/bin/bash
#Made By Haqim

#Colour
font="\e[0m"
blue="\e[34m"
red="\e[91m"
white="\e[33m"


#Shortform Command
ins="apt-get install"

#Install All File
$ins net-tools

menu

#IP
MYIP=`ifconfig eth0 | awk 'NR==2 {print $2}'`
echo -e " ${blue}IPV4 : ${MYIP}${font}"

judge() {
    if [[ 0 -eq $? ]]; then
        echo -e "${OK} ${GreenBG} $1 Selesai ${Font}"
        sleep 1
    else
        echo -e "${Error} ${RedBG} $1 kegagalan ${Font}"
        exit 1
    fi
}

usernew() {
    cd /usr/bin
    wget https://raw.githubusercontent.com/haqim220404/Try/main/usernew
}
menuu() {
    cd /usr/bin
    wget https://raw.githubusercontent.com/haqim220404/Try/main/menu
}

akses() {
    chmod +x menu
    chmod +x usernew
    cd
}

list() {
    case $1 in
    tls_modify)
        tls_type
        ;;
    uninstall)
        uninstall_all
        ;;
    crontab_modify)
        acme_cron_update
        ;;
    boost)
        bbr_boost_sh
        ;;
    *)
        menu
        ;;
    esac
}

menu() {
    echo -e "$red Pemasangan Auto Script  $font"
    echo -e "${red}—————————————— Panduan Pemasangan —————————————— ${font}"
    echo -e "${red}1.  Pemasangan Semua${font}"
    echo -e "${red}2.  Pemasangan OpenVPN${font}"
    echo -e "${red}3.  Pemasangan OpenSSH${font}"
    echo -e "${red}4.  Pemasangan Dropbear${font}"
    echo -e "${red}5.  Pemasangan Stunnel${font}"
    echo -e "${red}6.  Pemasangan Squid${font}"
    echo -e "${red}7.  Keluar${font}"

    read -rp "Sila masukkan nombor：" menu_num
    case $menu_num in
    1)
        usernew
        menuu
        akses
        ;;
    2)
        exit 0
        ;;
    *)
        echo -e " Sila masukkan nombor yang betul "
        ;;
    esac
}
list "$1"
