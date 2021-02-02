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
    cat > /usr/bin/usernew <<-END
    #!/bin/bash
    font="\e[0m"
    blue="\e[34m"
    red="\e[91m"
    white="\e[33m"
    
    read -p "Username : " Login
    read -p "Password : " Pass
    read -p "Expired (hari): " masaaktif
    IP=`dig +short myip.opendns.com @resolver1.opendns.com`
    useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
    exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
    echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
    echo -e ""
    echo -e "${white}Informasi SSH${font}"
    echo -e "=========-${white}account${font}-=========="
    echo -e "Host               : ${white}${IP}${font}"
    echo -e "Port OpenSSH       : ${white}22${font}"
    echo -e "Port Dropbear      : ${white}80${font}"
    echo -e "Port SSL           : ${white}443${font}"
    echo -e "Port UDPGW         : ${white}7200${font}"
    echo -e "Host Squid         : ${white}${IP}${font}"
    echo -e "Port Squid         : ${white}8080,8000${font}"
    echo -e "Username           : ${white}${Login}${font}"
    echo -e "Password           : ${white}${Pass}${font}"
    echo -e "Config Openvpn TCP : ${white}${IP}:81/client-tcp.ovpn${font}"
    echo -e "Config Openvpn UDP : \e[1;33;44m$IP:81/client-tcp.ovpn\e[0m"
    echo -e "==========================="
    echo -e "Script by ${white}Haqimsem;)${font}"
END
}
koman() {
    cat > /usr/bin/menu <<-END
    #!/bin/sh
    
    echo -e "  ${white}menu${font}    
    ${red}:  Menampilkan Menu Yang Ada${font}"
    echo -e "  ${white}1.${font}    
    ${red}:  Menambah Pengguna{font}
    echo -e "  ${white}2.${font}    
    ${red}:  Keluar${font}
    
    read -rp "${red}Sila${font} ${white}Memasukkan${font} ${red}Nombor Pilihan Anda${font}" nombor_menu
    case $nombor_menu in
    1)
        usernew
        ;;
    2)
        exit 1
        ;;
    *)
    echo -e "${red} Sila masukkan nombor yang betul ${font}"
    esac
    
    usernew() {
        usernew
    }
END
}

chmod() {
    chmod +x /usr/bin/menu/
    chmod +x /usr/bin/usernew
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
    case menu_num in
    1)
        usernew
        koman
        chmod
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
