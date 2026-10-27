#!/bin/bash
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
grenbo="[92;1m"
NC='[0m'
apt update && apt upgrade -y
apt install python3 python3-pip git python3-venv -y
cd /usr/bin
wget  https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/bot.zip
unzip bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
rm -rf bot.zip
clear
wget  https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/kyt.zip
unzip kyt.zip
python3 -m venv /usr/bin/kyt/venv
source /usr/bin/kyt/venv/bin/activate
pip install --upgrade pip
pip install telethon requests pillow aiohttp
[ -f /usr/bin/kyt/requirements.txt ] && pip install -r /usr/bin/kyt/requirements.txt || true
deactivate
if [ ! -f /usr/bin/kyt/var.txt ]; then
echo ""
echo -e "\e[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e " [1;97;101m          ADD BOT PANEL          \e[0m"
echo -e "\e[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "${grenbo}Tutorial Create Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Create Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , command /info${NC}"
echo -e "\e[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/kyt/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/kyt/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/kyt/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/kyt/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/kyt/var.txt
else
echo "Using existing bot configuration from var.txt"
bottoken=$(grep 'BOT_TOKEN' /usr/bin/kyt/var.txt | cut -d'=' -f2 | tr -d '"')
admin=$(grep 'ADMIN' /usr/bin/kyt/var.txt | cut -d'=' -f2 | tr -d '"')
domain=$(grep 'DOMAIN' /usr/bin/kyt/var.txt | cut -d'=' -f2 | tr -d '"')
PUB=$(grep 'PUB' /usr/bin/kyt/var.txt | cut -d'=' -f2 | tr -d '"')
NS=$(grep 'HOST' /usr/bin/kyt/var.txt | cut -d'=' -f2 | tr -d '"')
echo -e "Loaded the following from var.txt:"
echo "Token Bot       : $bottoken"
echo "Admin           : $admin"
echo "Domain          : $domain"
echo "Pub             : $PUB"
echo "Host            : $NS"
fi
clear
echo "Deleting old session files..."
sudo find /usr/bin -type f -name "*.session" -exec rm -f {} \;
cat > /etc/systemd/system/kyt.service << END
[Unit]
Description=Simple kyt - @kyt
After=network.target
[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/kyt/venv/bin/python3 -m kyt
Restart=always
[Install]
WantedBy=multi-user.target
END
systemctl start kyt
systemctl enable kyt
systemctl restart kyt
cd /root
rm -rf kyt.sh
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Token Bot         : $bottoken"
echo "Admin            : $admin"
echo "Domain           : $domain"
echo "Pub              : $PUB"
echo "Host             : $NS"
echo -e "==============================="
echo "Setting done"
clear
echo "Installations complete, type /menu on your bot"
