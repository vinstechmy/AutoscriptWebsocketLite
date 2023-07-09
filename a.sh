#!/bin/bash
R='\e[1;31m'
G='\e[0;32m'
P='\e[0;35m'
O='\e[0;33m'
NC='\e[0m'
MYIP=$(wget -qO- ipv4.icanhazip.com);

if [ -f "/etc/Vinstechmy" ]; then
clear
else
cd
mkdir -p /etc/Vinstechmy
fi

APIGIT=$(cat /etc/Vinstechmy/github/api)
EMAILGIT=$(cat /etc/Vinstechmy/github/email)
USERGIT=$(cat /etc/Vinstechmy/github/username)


function setapi(){
clear
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                REGISTER API                \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo ""
if [[ -f /etc/Vinstechmy/github/api && -f /etc/Vinstechmy/github/email && /etc/Vinstechmy/github/username ]]; then
   rec="OK"
else
    mkdir /etc/Vinstechmy/github > /dev/null 2>&1
fi
read -p " E-mail   : " EMAIL1
if [ -z $EMAIL1 ]; then
echo -e "  [${G}INFO${NC}] Please Insert Your Github Email Adress"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
fi

read -p " Username : " USERNAME1
if [ -z $USERNAME1 ]; then
echo -e "  [${G}INFO${NC}] Please Insert Your Github Username"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
fi

read -p " API      : " API1
if [ -z $API1 ]; then
echo -e "  [${G}INFO${NC}] Please Insert Your Github API"
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
regip
fi

sleep 2
echo "$EMAIL1" > /etc/Vinstechmy/github/email
echo "$USERNAME1" > /etc/Vinstechmy/github/username
echo "$API1" > /etc/Vinstechmy/github/api
echo "ON" > /etc/Vinstechmy/github/gitstat
clear
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                REGISTER API                \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo ""
echo -e "  [${G}INFO${NC}] Github Api Setup Successfully"
echo -e ""
echo -e "• Email : $EMAIL1"
echo -e "• User  : $USERNAME1"
echo -e "• API   : $API1"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
}

function viewapi(){
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 LIST API                  \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "• Email : $EMAILGIT"
echo -e "• User  : $USERGIT"
echo -e "• API   : $APIGIT"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
}

function add_ip(){
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                REGISTER IP                \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
rm -rf /root/IP-Multiport-Websocket
read -p "NEW IPVPS : " daftar
echo -e ""
echo -e "  [${G}INFO${NC}] Checking the IPVPS!"
sleep 1
REQIP=$(curl -sS https://raw.githubusercontent.com/${USERGIT}/IP-Multiport-Websocket/main/access | awk '{print $2}' | grep $daftar)
if [[ $daftar = $REQIP ]]; then
echo -e "  [${G}INFO${NC}] IP VPS Already Registered !"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
else
echo -e "  [${G}INFO${NC}] OK ! IP VPS is not Registered !"
echo -e "  [${G}INFO${NC}] Lets Register it !"
sleep 3
clear
fi
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                REGISTER IP                \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
read -p "Client Name   : " client
if [ -z $client ]; then
cd
echo -e "  [${G}INFO${NC}] Please Insert Client"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
fi

read -p "Expired Date  : " exp
if [ -z $exp ]; then
cd
echo -e "  [${G}INFO${NC}] Please Insert Exp Date"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
fi

exp=$(date -d "$exp days" +"%Y-%m-%d")
hariini=$(date -d "0 days" +"%Y-%m-%d")
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
git clone https://github.com/${USERGIT}/IP-Multiport-Websocket.git &> /dev/null
cd /root/IP-Multiport-Websocket/ &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
touch access &> /dev/null
echo "### $daftar $exp $client" >>/root/IP-Multiport-Websocket/access 
git add .
git commit -m register &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/IP-Multiport-Websocket.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/IP-Multiport-Websocket.git &> /dev/null
sleep 1
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                REGISTER IP                \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "Client IP Register Successfully"
echo -e ""
echo -e "Client Name   : $client"
echo -e "IP VPS        : $daftar"
echo -e "Register Date : $hariini"
echo -e "Expired Date  : $exp"
cd
rm -rf /root/IP-Multiport-Websocket
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
}
function delipvps(){
clear
rm -rf /root/IP-Multiport-Websocket &> /dev/null
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
git clone https://github.com/${USERGIT}/IP-Multiport-Websocket.git &> /dev/null
cd /root/IP-Multiport-Websocket/ &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
touch access &> /dev/null
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 DELETE IP                 \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
grep -E "^### " "/root/IP-Multiport-Websocket/access" | cut -d ' ' -f 2-4 | nl -s '. '
echo ""
read -rp "   Please Insert Number : " nombor
if [ -z $nombor ]; then
cd
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 DELETE IP                 \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "  [${G}INFO${NC}] Please Insert Correct Number"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
fi

name1=$(grep -E "^### " "/root/IP-Multiport-Websocket/access" | cut -d ' ' -f 2 | sed -n "$nombor"p) #name
exp=$(grep -E "^### " "/root/IP-Multiport-Websocket/access" | cut -d ' ' -f 3 | sed -n "$nombor"p) #exp
ivps1=$(grep -E "^### " "/root/IP-Multiport-Websocket/access" | cut -d ' ' -f 4 | sed -n "$nombor"p) #ip
sed -i "s/### $name1 $exp $ivps1//g" /root/IP-Multiport-Websocket/access &> /dev/null
hariini2=$(date -d "0 days" +"%Y-%m-%d")

git add . &> /dev/null
git commit -m remove &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/${USERGIT}/IP-Multiport-Websocket.git &> /dev/null
git push -f https://${APIGIT}@github.com/${USERGIT}/IP-Multiport-Websocket.git &> /dev/null
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 DELETE IP                 \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "Client IP Deleted Successfully"
echo -e ""
echo -e "IP VPS       : $ivps1"
echo -e "Expired Date : $exp"
echo -e "Client Name  : $name1"
cd
rm -rf /root/IP-Multiport-Websocket
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
}

function renewipvps(){
 clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 RENEW IP                  \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
rm -rf /root/IP-Multiport-Websocket
git config --global user.email "${EMAILGIT}" &> /dev/null
git config --global user.name "${USERGIT}" &> /dev/null
git clone https://github.com/${USERGIT}/IP-Multiport-Websocket.git
cd /root/IP-Multiport-Websocket/
rm -rf .git
git init
touch access
echo -e "   [ ${O}INFO${NC} ] Checking list.."

NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/IP-Multiport-Websocket/access")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
  clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 RENEW IP                  \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "  [${G}INFO${NC}] You have no existing clients!"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
fi
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 RENEW IP                  \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
grep -E "^### " "/root/IP-Multiport-Websocket/access" | cut -d ' ' -f 2-4 | nl -s '. '
echo -e ""
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
  if [[ ${CLIENT_NUMBER} == '1' ]]; then
    read -rp " Select one client [1]: " CLIENT_NUMBER
  else
    read -rp " Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
  fi
if [ -z $CLIENT_NUMBER ]; then
cd
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 RENEW IP                  \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "  [${G}INFO${NC}] Please Insert Correct Number"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
fi
done
echo -e ""
read -p " Expired (days): " masaaktif
if [ -z $masaaktif ]; then
cd
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 RENEW IP                  \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "  [${G}INFO${NC}] Please Insert Correct Number"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
fi
name1=$(grep -E "^### " "/root/IP-Multiport-Websocket/access" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p) #name
exp=$(grep -E "^### " "/root/IP-Multiport-Websocket/access" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p) #exp
ivps1=$(grep -E "^### " "/root/IP-Multiport-Websocket/access" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p) #ip

now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(((d1 - d2) / 86400))
exp3=$(($exp2 + $masaaktif))
exp4=$(date -d "$exp3 days" +"%Y-%m-%d")
sed -i "s/### $name1 $exp $ivps1/### $name1 $exp4 $ivps1/g" /root/IP-Multiport-Websocket/access
git add .
git commit -m renew
git branch -M main
git remote add origin https://github.com/${USERGIT}/IP-Multiport-Websocket.git
git push -f https://${APIGIT}@github.com/${USERGIT}/IP-Multiport-Websocket.git
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 RENEW IP                  \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "Client IP VPS Renew Successfully"
echo -e ""
echo -e "IP VPS        : $ivps1"
echo -e "Renew Date    : $now"
echo -e "Days Added    : $masaaktif Days"
echo -e "Expired Date  : $exp4"
echo -e "Client Name   : $name1"
cd
rm -rf /root/IP-Multiport-Websocket
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
}

function useripvps(){
clear
rm -rf /root/IP-Multiport-Websocket
git config --global user.email "${EMAILGIT}"
git config --global user.name "${USERGIT}"
git clone https://github.com/${USERGIT}/IP-Multiport-Websocket.git
cd /root/IP-Multiport-Websocket/
rm -rf .git
git init
touch access
clear
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m              LIST REGISTER IP              \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo ""
grep -E "^### " "/root/IP-Multiport-Websocket/access" | cut -d ' ' -f 2 | nl -s '. '
cd
rm -rf /root/IP-Multiport-Websocket
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip
}
function resetipvps(){
clear
rm -f /etc/Vinstechmy/github/email
rm -f /etc/Vinstechmy/github/username
rm -f /etc/Vinstechmy/github/api
rm -f /etc/Vinstechmy/github/gitstat
echo "OFF" > /etc/Vinstechmy/github/gitstat
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m              RESET GITHUB API             \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "  [${G}INFO${NC}] Github API Reseted Successfully" 
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip  
}
Isadmin=$(curl -sS https://raw.githubusercontent.com/vinstechmy/IP-Multiport-Websocket/main/access | grep $MYIP | awk '{print $5}')
if [ "$Isadmin" = "OFF" ]; then
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                REGISTER IP                \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "  [${G}INFO${NC}] Only Admin Can Use This Panel"
echo -e "  [${G}INFO${NC}] PM : t.me/Vinstechmy"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
regip  
fi
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                REGISTER IP                \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
GITREQ=/etc/Vinstechmy/github/gitstat
if [ -f "$GITREQ" ]; then
    cekk="ok"
else 
    mkdir /etc/Vinstechmy/github
    touch /etc/Vinstechmy/github/gitstat
    echo "OFF" > /etc/Vinstechmy/github/gitstat
fi

stst1=$(cat /etc/Vinstechmy/github/gitstat)
if [ "$stst1" = "OFF" ]; then
clear
echo -e "\e[36m╒═══════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                REGISTER IP                \E[0m"
echo -e "\e[36m╘═══════════════════════════════════════════╛\033[0m"
echo ""
echo -e "  [${G}INFO${NC}] You Need To Set Github API First!"
echo -e ""
read -n 1 -s -r -p "   Press any key to Set API"
setapi
fi
stst=$(cat /etc/Vinstechmy/github/gitstat)
if [ "$stst" = "ON" ]; then
APIOK="Check API"
rex="viewapi"
else
APIOK="Set API"
rex="setapi"
fi
if [ "$stst" = "ON" ]; then
ISON="Reset API"
ressee="resetipvps"
else
ISON=""
ressee="regip"
fi
echo -e "\033[1;37mRegister IP By Vinstechmy\033[0m
\033[1;37mTelegram : https://t.me/Vinstechmy / @Vinstechmy\033[0m
 [\033[1;36m•1 \033[0m]  $APIOK
 [\033[1;36m•2 \033[0m]  Register IP VPS
 [\033[1;36m•3 \033[0m]  Delete IP VPS
 [\033[1;36m•4 \033[0m]  Renew IP VPS
 [\033[1;36m•5 \033[0m]  List IP VPS
 [\033[1;36m•6 \033[0m]  $ISON
 [\033[1;36m•7 \033[0m]  Back To Main Menu"
echo ""
echo -e "\033[1;37mPress [ Ctrl+C ] • To-Exit-Script\033[0m"
echo ""
read -p "Select From Options [ 1-7 ] :  " opt
echo -e   ""
case $opt in
01 | 1) clear ; $rex ;;
02 | 2) clear ; add_ip ;;
03 | 3) clear ; delipvps ;;
04 | 4) clear ; renewipvps ;;
05 | 5) clear ; useripvps ;;
06 | 6) clear ; $ressee ;;
07 | 7) clear ; menu ;;
*) clear ; regip ;;
esac
