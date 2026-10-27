#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com || wget -qO- ipinfo.io/ip)
izin_data=$(curl -sS https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/ip)
if echo "$izin_data" | grep -q "$MYIP"; then
    echo "IZIN DITERIMA: $MYIP"
else
    echo "SERVER TERDAFTAR: $MYIP"
fi
cp /media/izzvpn/var.txt /tmp
clear
cp /root/izzvpn/var.txt /tmp
clear
rm -rf izzvpn
clear
apt update && apt upgrade -y
apt install python3 python3-pip -y
apt install sqlite3 -y
cd /media/
rm -rf izzvpn cybervpn
clear
wget -q https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/izzvpn.zip || wget -q https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/cybervpn.zip -O izzvpn.zip
unzip -o izzvpn.zip
[ -d cybervpn ] && mv cybervpn izzvpn
cd /media/izzvpn
rm var.txt
clear
rm database.db
clear
apt update && apt upgrade -y
apt install python3 python3-pip git python3-venv -y
cd /usr/bin
python3 -m venv /media/izzvpn/venv
source /media/izzvpn/venv/bin/activate
pip install --upgrade pip
pip install telethon pillow speedtest-cli aiohttp paramiko requests
[ -f /media/izzvpn/requirements.txt ] && pip install -r /media/izzvpn/requirements.txt || true
deactivate
sldns=$(cat /root/nsdomain)
domain=$(cat /etc/xray/domain)
clear
echo -e ""
echo -e ""
echo "INSTALL BOT CREATE SSH via TELEGRAM"
read -e -p "[*] Input Your Id Telegram :" admin
read -e -p "[*] Input Your bot Telegram :" token
read -e -p "[*] Input username Telegram :" user
cat > /media/izzvpn/var.txt << END
ADMIN="$admin"
BOT_TOKEN="$token"
DOMAIN="$domain"
DNS="$sldns"
PUB="7fbd1f8aa0abfe15a7903e837f78aba39cf61d36f183bd604daa2fe4ef3b7b59"
OWN="$user"
SALDO="100000"
END
clear
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "[44;97;1m          UZZ STORE VPN          [0m"
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e ""
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "[44;97;1m     CREATE BOT SUCCESFULLY        \e[0m"
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e ""
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "[96;1m Api Token     : $token"
echo -e "[96;1m ID Telegram   : $admin"
echo -e "[96;1m Domain vps    : $domain"
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e ""
echo -e "91;1m Wait in 4 second.....[0m"
sleep 4
clear
rm -f /usr/bin/nenen
echo -e '#!/bin/bash
cd /media/
python3 -m izzvpn' > /usr/bin/nenen
chmod 777 /usr/bin/nenen
cat > /etc/systemd/system/botrs.service << END
[Unit]
Description=Simple kyt - @kyt
After=network.target
[Service]
WorkingDirectory=/media
ExecStart=/media/izzvpn/venv/bin/python3 -m izzvpn
Restart=always
[Install]
WantedBy=multi-user.target
END
systemctl start botrs
systemctl enable botrs
systemctl restart botrs
cd /root
rm -rf botrs.sh
clear
echo
echo
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "[44;97;1m        DOWNLOAD ASSET BOT         \e[0m"
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e ""
# Link all bot helper scripts from existing local installation
for f in add-ss add-ws add-vless add-tr del-ss del-ws del-vless del-tr renew-ss renew-ws renew-vless renew-tr; do
    src=$(echo "$f" | tr -d '-')
    [ -f "/usr/local/sbin/$src" ] && ln -sf "/usr/local/sbin/$src" "/usr/bin/$f"
    [ -f "/usr/bin/$src" ] && ln -sf "/usr/bin/$src" "/usr/bin/$f"
done
ln -sf /usr/bin/bot-cek-ss /usr/bin/cek-ss 2>/dev/null || true
ln -sf /usr/bin/bot-cek-ss /usr/bin/cek-mss 2>/dev/null || true
ln -sf /usr/bin/bot-cek-ws /usr/bin/cek-ws 2>/dev/null || true
ln -sf /usr/bin/bot-cek-ws /usr/bin/cek-mws 2>/dev/null || true
ln -sf /usr/bin/bot-cek-vless /usr/bin/cek-vless 2>/dev/null || true
ln -sf /usr/bin/bot-cek-vless /usr/bin/cek-mvs 2>/dev/null || true
ln -sf /usr/bin/bot-cek-tr /usr/bin/cek-tr 2>/dev/null || true
ln -sf /usr/bin/bot-cek-tr /usr/bin/cek-mts 2>/dev/null || true
ln -sf /usr/bin/bot-cek-login-ssh /usr/bin/cek-ssh 2>/dev/null || true
ln -sf /usr/local/sbin/add-bot-panel /usr/bin/panelbot 2>/dev/null || true
ln -sf /usr/local/sbin/menu /usr/bin/menu 2>/dev/null || true
[ -f /media/izzvpn/addssh-bot ] && ln -sf /media/izzvpn/addssh-bot /usr/bin/addssh-bot 2>/dev/null || true
touch /media/log-install.txt 2>/dev/null || true
cp /tmp/var.txt /media/izzvpn
clear
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "[44;97;1m          UZZ STORE VPN          [0m"
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e ""
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e "[44;97;1m       DOWNLOAD SUCCESFULLY        \e[0m"
echo -e "[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo -e ""
echo -e "[96;1m KETIK /menu : .menu : .crot : .gas DI BOT TELEGRAM ANDA [0m"
echo -e ""
rm /media/izzvpn.zip
exec bash
