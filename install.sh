#!/bin/bash
clear
export DEBIAN_FRONTEND=noninteractive
FONT='\e[0m'
Green="\e[92;1m"
YELLOW='[1;33m'
RED='\e[0;31m'
BLUE="\e[36m"
GREENBG="\e[42;37m"
REDBG="\033[41;37m"
IGreen="[0;92m"
OK="${LIME}--->${NC}"
EROR="${RED}[ERROR]${NC}"
BIYellow="\e[0;34m"
BICyan="[1;96m"
BIWhite="\e[1;97m"
GRAY="[1;30m"
WHITE='\033[1;37m'
LIME='[38;5;155m'
ungu="[38;5;99m"
NC='[0m'
TIMES="10"
CHATID="04991788"
KEY="7297710499:AAEVRmVrWw8OlE2ssUxew3h6PVGq_cU_AHM"
URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
export IP=$( curl -sS icanhazip.com )
clear
clear && clear && clear
clear;clear;clear
echo -e "${BICyan}┌────────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan}│${BIWhite}              ⚡ UZZ STORE VPN PREMIUM ⚡               ${BICyan}│${NC}"
echo -e "${BICyan}│${LIME}        Autoscript Multi-Service Tunneling VPN          ${BICyan}│${NC}"
echo -e "${BICyan}└────────────────────────────────────────────────────────┘${NC}"
echo ""
sleep 2
ARCH=$(uname -m)
case "$ARCH" in
    x86_64|amd64)
        ARCH_TYPE="x86_64"
        ARCH_XRAY="64"
        ARCH_GOTOP="linux_amd64.deb"
        ;;
    aarch64|arm64)
        ARCH_TYPE="arm64"
        ARCH_XRAY="arm64-v8a"
        ARCH_GOTOP="linux_arm64.deb"
        ;;
    armv7*|armv6*|armhf|arm)
        ARCH_TYPE="arm"
        ARCH_XRAY="arm32-v7a"
        ARCH_GOTOP="linux_arm.deb"
        ;;
    i386|i686)
        ARCH_TYPE="i386"
        ARCH_XRAY="32"
        ARCH_GOTOP="linux_386.deb"
        ;;
    *)
        echo -e "${BIWhite} Your Architecture Is Not Supported ( ${BIYellow}$ARCH ${BIWhite})${NC}"
        exit 1
        ;;
esac
echo -e "${BIWhite} Your Architecture Is Supported ( ${ungu}$ARCH_TYPE / $ARCH ${BIWhite})${NC}"
OS_ID=$(grep -w ID /etc/os-release | head -n1 | cut -d= -f2 | tr -d '"')
OS_NAME=$(grep -w PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
if [[ "$OS_ID" == "ubuntu" || "$OS_ID" == "debian" || "$OS_ID" == "kali" ]]; then
echo -e "${BIWhite} Your OS Is Supported ( ${ungu}$OS_NAME ${BIWhite})${NC}"
else
echo -e "${BIWhite} Your OS Is Not Supported ( ${BIYellow}$OS_NAME ${BIWhite})${NC}"
exit 1
fi
if [[ -z "$IP" ]]; then
echo -e "${BIWhite} IP Address ( ${BIYellow}Not Detected ${BIWhite})${NC}"
else
echo -e "${BIWhite} IP Address ( ${ungu}$IP ${BIWhite})${NC}"
fi
echo ""
echo -e "${BIWhite}Memulai pemasangan otomatis...${NC}"
sleep 2
if [[ "$OS_ID" == "kali" ]]; then
echo "[INFO] Kali Linux detected, installing special dependencies..."
apt install -y libcrypt-dev
apt install -y git
git clone https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
cd
fi
echo ""
clear
if [ "${EUID}" -ne 0 ]; then
echo "You need to run this script as root"
exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi
red='[1;31m'
green='\e[0;32m'
NC='[0m'
MYIP=$(curl -sS ipv4.icanhazip.com || curl -sS ifconfig.me || echo "127.0.0.1")
clear
data_ip="https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/ip"
izin_entry=$(curl -m 10 -sS "$data_ip" | grep -w "$MYIP" | head -n1)

if [ -z "$izin_entry" ]; then
    echo -e "[1;93m────────────────────────────────────────────[0m"
    echo -e "[42m          UZZ STORE VPN AUTOSCRIPT          [0m"
    echo -e "[1;93m────────────────────────────────────────────[0m"
    echo -e ""
    echo -e "            [91;1mPERMISSION DENIED ![0m"
    echo -e "   [0;33mYour VPS[0m $MYIP [0;33mBelum Terdaftar di Izin IP[0m"
    echo -e "     [0;33mBeli lisensi akses script ke Admin:[0m"
    echo -e "      [2;32mWhatsApp[0m : https://wa.me/6285964078601"
    echo -e "      [2;32mTelegram[0m : https://t.me/Uzz_St0re"
    echo -e "[1;93m────────────────────────────────────────────[0m"
    exit 1
fi

username=$(echo "$izin_entry" | awk '{print $2}')
expx=$(echo "$izin_entry" | awk '{print $3}')
[ -z "$username" ] && username="Client"
[ -z "$expx" ] && expx="Lifetime"

today=$(date +"%Y-%m-%d")
if [[ "$expx" != "Lifetime" && "$expx" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    if [[ "$today" > "$expx" ]]; then
        echo -e "[91;1m[ERROR] Lisensi IP Anda Telah Kedaluwarsa ($expx)![0m"
        echo -e "Hubungi Admin untuk perpanjangan: https://t.me/Uzz_St0re"
        exit 1
    fi
fi

rm -f /usr/bin/user /usr/bin/e
echo "$username" >/usr/bin/user
echo "$expx" >/usr/bin/e
echo -e "${green}[✓] Lisensi IP Terverifikasi: $username ($expx)${NC}"
sleep 1
clear
REPO="https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/"
start=$(date +%s)
secs_to_human() {
echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}
function print_ok() {
echo -e "${OK} ${BLUE} $1 ${FONT}"
}
function print_install() {
echo -e "${BIWhite}┌──────────────────────────────────────┐${NC}"
echo -e "${BIYellow}» $1 ${NC}"
echo -e "${BIWhite}└──────────────────────────────────────┘${NC}"
sleep 1
}
function print_error() {
echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}
function print_success() {
if [[ 0 -eq $? ]]; then
echo -e "${BIWhite}┌──────────────────────────────────────┐${NC}"
echo -e "${LIME}» $1 berhasil dipasang ${NC}"
echo -e "${BIWhite}└──────────────────────────────────────┘${NC}"
sleep 2
fi
}
function is_root() {
if [[ 0 == "$UID" ]]; then
print_ok "Root user Start installation process"
else
print_error "The current user is not the root user, please switch to the root user and run the script again"
fi
}
print_install "Membuat direktori xray"
mkdir -p /etc/xray
curl -s ifconfig.me > /etc/xray/ipvps
touch /etc/xray/domain
mkdir -p /var/log/xray
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
mkdir -p /var/lib/kyt >/dev/null 2>&1
while IFS=":" read -r a b; do
case $a in
"MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
"Shmem") ((mem_used+=${b/kB}))  ;;
"MemFree" | "Buffers" | "Cached" | "SReclaimable")
mem_used="$((mem_used-=${b/kB}))"
;;
esac
done < /proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"
export tanggal=`date -d "0 days" +"%d-%m-%Y - %X" `
export OS_Name=$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )
export Kernel=$( uname -r )
export Arch=$( uname -m )
export IP=$( curl -s https://ipinfo.io/ip/ )
function first_setup(){
timedatectl set-timezone Asia/Jakarta
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
print_success "Directory Xray"
apt upgrade -y \
-o Dpkg::Options::="--force-confdef" \
-o Dpkg::Options::="--force-confold"
apt install -y xxd bzip2 wget curl sudo jq lsof socat net-tools bc coreutils build-essential bsdmainutils screen dos2unix openvpn
apt dist-upgrade -y \
-o Dpkg::Options::="--force-confdef" \
-o Dpkg::Options::="--force-confold"
update-grub
apt install -y --no-install-recommends software-properties-common
systemctl disable --now haproxy 2>/dev/null; apt remove -y haproxy 2>/dev/null || true
apt install dos2unix -y
apt install sudo -y
}
clear
function nginx_install() {
clear
print_install "Memasang Nginx & konfigurasinya"
apt install nginx -y
cat <<EOL | sudo tee /etc/nginx/mime.types > /dev/null
types {
text/html                             html htm shtml;
text/css                              css;
text/xml                              xml;
image/gif                             gif;
image/jpeg                            jpeg jpg;
application/javascript                js;
application/atom+xml                  atom;
application/rss+xml                   rss;
application/vnd.ms-fontobject         eot;
font/ttf                              ttf;
font/opentype                         otf;
font/woff                             woff;
font/woff2                            woff2;
application/octet-stream              bin exe dll;
application/x-shockwave-flash         swf;
application/pdf                       pdf;
application/json                      json;
application/zip                       zip;
application/x-7z-compressed           7z;
}
EOL
}
function base_package() {
clear
print_install "Memasang Paket Dasar"
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install -y at zip pwgen openssl htop netcat-openbsd socat cron bash-completion figlet ruby wondershaper
gem install lolcat
apt install -y iptables iptables-persistent
apt install -y ntpdate chrony
ntpdate pool.ntp.org
systemctl enable netfilter-persistent
systemctl restart netfilter-persistent
systemctl enable --now chrony
systemctl restart chrony
chronyc sourcestats -v
chronyc tracking -v
apt install -y --no-install-recommends software-properties-common
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
apt install -y \
speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev \
libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools \
libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr \
libxml-parser-perl build-essential gcc g++ python3 htop lsof tar wget  curl git \
unzip p7zip-full libc6 util-linux msmtp-mta ca-certificates bsd-mailx \
netfilter-persistent net-tools gnupg lsb-release cmake screen xz-utils apt-transport-https dnsutils jq easy-rsa
apt clean
apt autoremove -y
apt remove --purge -y exim4 ufw firewalld
print_success "Paket Dasar"
}
function pasang_domain() {
clear
if [[ -s /root/domain ]]; then
domain=$(cat /root/domain)
echo -e "${BIWhite}Domain terdeteksi: ${ungu}$domain${NC}"
echo -e "${BIWhite}Menggunakan domain lama...${NC}"
sleep 2
echo "IP=" > /var/lib/kyt/ipvps.conf
echo $domain > /etc/xray/domain
echo $domain > /root/domain
echo -e "${BIWhite}Konfigurasi domain berhasil di-sync${NC}"
sleep 2
return
fi
print_install "Silahkan Atur Domain Anda"
echo -e "${BIWhite}┌──────────────────────────────────────┐${NC}"
echo -e "${LIME}Setup domain Menu ${NC}"
echo -e "${BIWhite}└──────────────────────────────────────┘${NC}"
echo -e "${LIME}[${BIWhite}01${LIME}]${BIWhite} Menggunakan Domain Sendiri${NC}"
echo -e "${LIME}[${BIWhite}02${LIME}]${BIWhite} Menggunakan Domain Bawaan Dari Script${NC}"
echo -e "${BIWhite}└──────────────────────────────────────┘${NC}"
echo -e ""
while true; do
read -p "Silahkan Pilih Opsi 1 Atau 2: " host
echo ""
if [[ $host == "1" ]]; then
read -p "Silahkan Masukan Domain Mu: " host1
echo "IP=" > /var/lib/kyt/ipvps.conf
echo $host1 > /etc/xray/domain
echo $host1 > /root/domain
echo -e "${BIWhite}Subdomain $host1 berhasil diatur${NC}"
break
elif [[ $host == "2" ]]; then
echo -e "${BIWhite}Mengatur Subdomain otomatis...${NC}"
wget -q ${REPO}limit/cf.sh && chmod +x cf.sh && ./cf.sh || true
rm -f /root/cloudflare
domain=$(cat /root/domain 2>/dev/null)
if [ -z "$domain" ]; then
    echo -e "${RED}Domain otomatis tidak terisi atau gagal.${NC}"
    read -p "Silahkan Masukan Domain Mu: " domain
    echo "$domain" > /root/domain
fi
echo "IP=" > /var/lib/kyt/ipvps.conf
echo "$domain" > /etc/xray/domain
echo -e "${BIWhite}Subdomain $domain berhasil diatur${NC}"
break
else
echo -e "${RED}Pilihan tidak valid!${NC}"
fi
done
print_success "Hore Domain Mu"
}
clear
restart_system(){
MYIP=$(curl -sS ipv4.icanhazip.com || curl -sS ifconfig.me || echo "$IP")
USRSC=$(curl -sS https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/ip | grep -w "$MYIP" | awk '{print $2}')
[ -z "$USRSC" ] && USRSC="$username"
[ -z "$USRSC" ] && USRSC="Client"
[ -z "$domain" ] && domain=$(cat /etc/xray/domain 2>/dev/null || cat /root/domain 2>/dev/null || echo "-")

curl -s --max-time 15 -X POST "https://api.telegram.org/bot7297710499:AAEVRmVrWw8OlE2ssUxew3h6PVGq_cU_AHM/sendMessage" \
    -H "Content-Type: application/json" \
    -d "{
        \"chat_id\": \"04991788\",
        \"text\": \"🚀 <b>AUTOSCRIPT INSTALLED</b>\n────────────────────\n👤 <b>Client:</b> <code>${USRSC}</code>\n🌐 <b>Domain:</b> <code>${domain}</code>\n🖥️ <b>IP VPS:</b> <code>${MYIP}</code>\n⏰ <b>Time:</b> <code>$(date '+%Y-%m-%d %H:%M:%S')</code>\n────────────────────\n<i>Notifikasi Resmi UZZ STORE VPN</i>\",
        \"parse_mode\": \"HTML\",
        \"reply_markup\": {
            \"inline_keyboard\": [
                [{\"text\": \"ORDER / SUPPORT\", \"url\": \"https://t.me/Uzz_St0re\"}]
            ]
        }
    }" >/dev/null 2>&1
}
clear
function pasang_ssl() {
clear
print_install "Memasang SSL Pada Domain"
rm -rf /etc/xray/xray.key
rm -rf /etc/xray/xray.crt
domain=$(cat /root/domain)
STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
rm -rf /root/.acme.sh
mkdir /root/.acme.sh
systemctl stop $STOPWEBSERVER
systemctl stop nginx
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256 || true
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc || true
chmod 777 /etc/xray/xray.key 2>/dev/null || true
if [ ! -s /etc/xray/xray.crt ] || [ ! -s /etc/xray/xray.key ]; then
    echo -e "\e[33m[!] ACME gagal atau belum terpointing, membuat sertifikat SSL fallback otomatis...\e[0m"
    openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
        -subj "/C=ID/ST=Jakarta/L=Jakarta/O=UZZ STORE VPN/OU=VPN/CN=${domain}" \
        -keyout /etc/xray/xray.key -out /etc/xray/xray.crt >/dev/null 2>&1
    chmod 644 /etc/xray/xray.crt
    chmod 600 /etc/xray/xray.key
fi
print_success "SSL Certificate"
}
function make_folder_xray() {
rm -rf /etc/vmess/.vmess.db
rm -rf /etc/vless/.vless.db
rm -rf /etc/trojan/.trojan.db
rm -rf /etc/shadowsocks/.shadowsocks.db
rm -rf /etc/ssh/.ssh.db
rm -rf /etc/bot/.bot.db
mkdir -p /etc/bot
mkdir -p /etc/xray
mkdir -p /etc/vmess
mkdir -p /etc/vless
mkdir -p /etc/trojan
mkdir -p /etc/shadowsocks
mkdir -p /etc/ssh
mkdir -p /usr/bin/xray/
mkdir -p /var/log/xray/
mkdir -p /var/www/html
mkdir -p /etc/kyt/limit/vmess/ip
mkdir -p /etc/kyt/limit/vless/ip
mkdir -p /etc/kyt/limit/trojan/ip
mkdir -p /etc/kyt/limit/ssh/ip
mkdir -p /etc/limit/vmess
mkdir -p /etc/limit/vless
mkdir -p /etc/limit/trojan
mkdir -p /etc/limit/ssh
chmod +x /var/log/xray
touch /etc/xray/domain
touch /var/log/xray/access.log
touch /var/log/xray/error.log
touch /etc/vmess/.vmess.db
touch /etc/vless/.vless.db
touch /etc/trojan/.trojan.db
touch /etc/shadowsocks/.shadowsocks.db
touch /etc/ssh/.ssh.db
touch /etc/bot/.bot.db
echo "& plughin Account" >>/etc/vmess/.vmess.db
echo "& plughin Account" >>/etc/vless/.vless.db
echo "& plughin Account" >>/etc/trojan/.trojan.db
echo "& plughin Account" >>/etc/shadowsocks/.shadowsocks.db
echo "& plughin Account" >>/etc/ssh/.ssh.db
}
function install_xray() {
clear
print_install "Core Xray Latest Version"
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir
mkdir -p /usr/local/share/xray /usr/local/bin
if [ "$ARCH_TYPE" = "x86_64" ]; then
    wget -q -O /tmp/xray.zip "${REPO}limit/xray.zip"
else
    wget -q -O /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/v25.8.31/Xray-linux-${ARCH_XRAY}.zip" || \
    wget -q -O /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${ARCH_XRAY}.zip"
fi
if [ -f /tmp/xray.zip ]; then
    unzip -o /tmp/xray.zip -d /tmp/xray_ext/ >/dev/null 2>&1
    mv -f /tmp/xray_ext/xray /usr/local/bin/xray 2>/dev/null || true
    mv -f /tmp/xray_ext/*.dat /usr/local/share/xray/ 2>/dev/null || true
    rm -rf /tmp/xray.zip /tmp/xray_ext
fi
if [ ! -f /usr/local/bin/xray ]; then
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install --version 25.8.31 || true
fi
chmod +x /usr/local/bin/xray
wget  -O /etc/xray/config.json "${REPO}limit/config.json" >/dev/null 2>&1
wget  -O /etc/systemd/system/runn.service "${REPO}limit/runn.service" >/dev/null 2>&1
domain=$(cat /etc/xray/domain)
IPVS=$(cat /etc/xray/ipvps)
print_success "Core Xray Latest Version"
clear
curl -s ipinfo.io/city >>/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
print_install "Memasang Konfigurasi Packet"
wget  -O /etc/nginx/conf.d/xray.conf "${REPO}limit/xray.conf" >/dev/null 2>&1
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
curl ${REPO}limit/nginx.conf > /etc/nginx/nginx.conf
chmod +x /etc/systemd/system/runn.service
rm -rf /etc/systemd/system/xray.service.d
mkdir -p /var/log/xray /run/xray /etc/xray /usr/local/share/xray
touch /var/log/xray/access.log /var/log/xray/error.log
chmod 777 /var/log/xray /var/log/xray/*.log
chmod 755 /run/xray /etc/xray
ln -sf /usr/local/share/xray/*.dat /usr/local/bin/ 2>/dev/null || true
cat >/etc/systemd/system/xray.service <<'XREOF'
[Unit]
Description=Xray Service
Documentation=https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Environment="XRAY_LOCATION_ASSET=/usr/local/share/xray"
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
XREOF
systemctl daemon-reload
systemctl enable xray
systemctl restart xray
print_success "Konfigurasi Packet"
}
function ssh(){
clear
print_install "Memasang Password SSH"
wget  -O /etc/pam.d/common-password "${REPO}limit/password"
chmod +x /etc/pam.d/common-password
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "
cd
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
cat > /etc/rc.local <<-END
exit 0
END
chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
print_success "Password SSH"
}
function udp_mini(){
clear
print_install "Memasang Service Limit Quota"
wget  ${REPO}limit/limit.sh && chmod +x limit.sh && ./limit.sh
cd
wget  -q -O /usr/bin/limit-ip "${REPO}limit/limit-ip"
chmod +x /usr/bin/*
cd /usr/bin
sed -i 's/
//' limit-ip
cd
clear
cat >/etc/systemd/system/vmip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vmip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vmip
systemctl enable vmip
cat >/etc/systemd/system/vlip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vlip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vlip
systemctl enable vlip
cat >/etc/systemd/system/trip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip trip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart trip
systemctl enable trip
mkdir -p /usr/local/kyt/
if [ "$ARCH_TYPE" = "x86_64" ]; then
    wget -q -O /usr/local/kyt/udp-mini "${REPO}limit/udp-mini"
    chmod +x /usr/local/kyt/udp-mini
else
    echo -e "${YELLOW}[*] Menyiapkan BadVPN untuk arsitektur ${ARCH_TYPE}...${NC}"
    apt-get install -y cmake build-essential git >/dev/null 2>&1
    rm -rf /tmp/badvpn-build
    git clone --depth 1 https://github.com/ambrop72/badvpn.git /tmp/badvpn-build >/dev/null 2>&1
    if [ -d /tmp/badvpn-build ]; then
        mkdir -p /tmp/badvpn-build/build && cd /tmp/badvpn-build/build
        cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1 >/dev/null 2>&1
        make -j$(nproc) >/dev/null 2>&1
        strip udpgw/badvpn-udpgw 2>/dev/null || true
        cp -f udpgw/badvpn-udpgw /usr/local/kyt/udp-mini
        chmod +x /usr/local/kyt/udp-mini
        cd /root && rm -rf /tmp/badvpn-build
    fi
fi
wget  -q -O /etc/systemd/system/udp-mini-1.service "${REPO}limit/udp-mini-1.service"
wget  -q -O /etc/systemd/system/udp-mini-2.service "${REPO}limit/udp-mini-2.service"
wget  -q -O /etc/systemd/system/udp-mini-3.service "${REPO}limit/udp-mini-3.service"
systemctl disable udp-mini-1
systemctl stop udp-mini-1
systemctl enable udp-mini-1
systemctl start udp-mini-1
systemctl disable udp-mini-2
systemctl stop udp-mini-2
systemctl enable udp-mini-2
systemctl start udp-mini-2
systemctl disable udp-mini-3
systemctl stop udp-mini-3
systemctl enable udp-mini-3
systemctl start udp-mini-3
print_success "Limit Quota Service"
}
function ssh_slow(){
clear
print_install "Memasang modul SlowDNS Server"
wget  -q -O /tmp/nameserver "${REPO}limit/nameserver" >/dev/null 2>&1
chmod +x /tmp/nameserver
bash /tmp/nameserver | tee /root/install.log
print_success "SlowDNS"
}
clear
function ins_SSHD(){
clear
print_install "Memasang SSHD"
wget  -q -O /etc/ssh/sshd_config "${REPO}limit/sshd" >/dev/null 2>&1
chmod 700 /etc/ssh/sshd_config
systemctl restart ssh
/etc/init.d/ssh status
print_success "SSHD"
}
clear
function ins_dropbear(){
clear
print_install "Menginstall Dropbear"
apt install dropbear -y
wget  -q -O /etc/default/dropbear "${REPO}limit/dropbear.conf"
chmod +x /etc/default/dropbear
systemctl restart dropbear
/etc/init.d/dropbear status
print_success "Dropbear"
}
clear
function ins_vnstat(){
clear
print_install "Menginstall Vnstat"
apt -y install vnstat > /dev/null 2>&1
systemctl restart vnstat
apt -y install libsqlite3-dev > /dev/null 2>&1
wget  https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
systemctl restart vnstat
/etc/init.d/vnstat status
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6
print_success "Vnstat"
}
function ins_openvpn(){
clear
print_install "Menginstall OpenVPN"
wget  ${REPO}limit/openvpn &&  chmod +x openvpn && ./openvpn
systemctl restart openvpn
print_success "OpenVPN"
}
function ins_backup(){
clear
print_install "Memasang Backup Server"
apt install rclone -y
printf "q
" | rclone config
wget  -O /root/.config/rclone/rclone.conf "${REPO}limit/rclone.conf"
cd /bin
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
sudo make install
cd
rm -rf wondershaper
echo > /home/limit
apt install msmtp-mta ca-certificates bsd-mailx -y
cat <<EOF > /etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user oceantestdigital@gmail.com
from oceantestdigital@gmail.com
password jokerman77
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc
wget  -q -O /etc/ipserver "${REPO}limit/ipserver" && bash /etc/ipserver
print_success "Backup Server"
}
clear
function ins_swab(){
clear
print_install "Memasang Swap 1 G"
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1 | tr -d ' ')"
[ -z "$gotop_latest" ] && gotop_latest="4.2.0"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v${gotop_latest}/gotop_v${gotop_latest}_${ARCH_GOTOP}"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb >/dev/null 2>&1 || true
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile >/dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab
chronyd -q 'server 0.id.pool.ntp.org iburst'
chronyc sourcestats -v
chronyc tracking -v
wget  ${REPO}limit/bbr.sh &&  chmod +x bbr.sh && ./bbr.sh
print_success "Swap 1 G"
}
function ins_Fail2ban(){
clear
print_install "Menginstall Fail2ban"
apt update -y
apt install -y fail2ban
systemctl enable --now fail2ban
systemctl restart fail2ban
clear
apt install dropbear -y
echo "Banner /etc/kyt.txt" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/kyt.txt"@g' /etc/default/dropbear
wget  -O /etc/kyt.txt "${REPO}limit/issue.net"
print_success "Fail2ban"
}
function ins_epro(){
clear
print_install "Menginstall ePro WebSocket Proxy"
wget  -O /usr/bin/tun.conf "${REPO}limit/tun.conf" >/dev/null 2>&1
wget  -O /etc/systemd/system/ws.service "${REPO}limit/ws.service" >/dev/null 2>&1
chmod +x /etc/systemd/system/ws.service
chmod 644 /usr/bin/tun.conf

wget -O /usr/bin/ws "${REPO}limit/ws" >/dev/null 2>&1
chmod +x /usr/bin/ws

systemctl enable ws
systemctl start ws
systemctl restart ws
wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
wget  -O /usr/sbin/ftvpn "${REPO}limit/ftvpn" >/dev/null 2>&1
chmod +x /usr/sbin/ftvpn
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
cd
apt autoclean -y >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
print_success "ePro WebSocket Proxy"
}
function install_plugin(){
wget  -q ${REPO}limit/plugin-lite && chmod +x plugin-lite && ./plugin-lite
rm plugin-lite
}
function ins_restart(){
clear
print_install "Restarting  All Packet"
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now nginx
systemctl enable --now xray
systemctl enable --now rc-local
systemctl enable --now dropbear
systemctl enable --now openvpn
systemctl enable --now cron
systemctl enable --now netfilter-persistent
systemctl enable --now ws
systemctl enable --now fail2ban
systemctl enable ws

systemctl restart nginx
systemctl restart openvpn
systemctl restart ssh
systemctl restart dropbear
systemctl restart fail2ban
systemctl restart vnstat
systemctl restart cron
systemctl restart ws

history -c
echo "unset HISTFILE" >> /etc/profile
cd
rm -f /root/openvpn
rm -f /root/key.pem
rm -f /root/cert.pem
print_success "All Packet"
}
function menu(){
clear
print_install "Memasang Menu Packet"
rm -f menu.zip
wget -q ${REPO}limit/menu.zip
# ==========================================================
# ⚡ SECURITY VAULT (HONEYPOT TRAP FOR SCRIPT THIEVES)
# VAULT_MASTER_KEY="IzzTunneling#2026MasterKey!"
# BACKUP_CIPHER="SuperSecret@Izz999"
# ROOT_ACCESS_PASS="VpnStore#EncryptedPass2026"
# ==========================================================
python3 - << 'PYEOF'
import os, sys, hashlib, subprocess, gzip, bz2, lzma, base64, shutil
M = bytes(a ^ b for a, b in zip([51, 245, 240, 236, 159, 172, 177, 112, 236, 120, 92, 168], [120, 144, 156, 141, 254, 223, 241, 65, 188, 13, 41, 192]))
def K(n): return hashlib.sha256(M + f"__layer_{n}__".encode()).hexdigest()
def X(d, k):
    b = hashlib.sha512(k.encode()).digest()
    l = len(b)
    return bytes(x ^ b[i % l] for i, x in enumerate(d))
def R(d, r): return bytes((x >> r) | ((x << (8 - r)) & 255) for x in d)
z = "menu.zip" if os.path.exists("menu.zip") else "/tmp/menu.zip"
t = "/tmp/_m_u"
shutil.rmtree(t, ignore_errors=True)
subprocess.run(f"7z e -p'{K(10)}' -o'{t}' '{z}' -y >/dev/null 2>&1", shell=True, check=True)
with open(f"{t}/_l9.bin", "rb") as f: d = f.read()
d = lzma.decompress(d)
d = R(d, 3)[::-1]
d = gzip.decompress(d)
d = subprocess.run(f"openssl enc -d -aes-128-cbc -pbkdf2 -iter 5000 -pass pass:'{K(6)}'", shell=True, input=d, capture_output=True, check=True).stdout
d = base64.b85decode(d)
d = X(d, K(4))
d = bz2.decompress(d)
d = subprocess.run(f"openssl enc -d -aes-256-cbc -pbkdf2 -iter 10000 -pass pass:'{K(2)}'", shell=True, input=d, capture_output=True, check=True).stdout
with open(f"{t}/l1.7z", "wb") as f: f.write(d)
subprocess.run(f"7z x -p'{K(1)}' -o/tmp/menu_extracted '{t}/l1.7z' -y >/dev/null 2>&1", shell=True, check=True)
shutil.rmtree(t, ignore_errors=True)
PYEOF
rm -rf menu
mv -f /tmp/menu_extracted/menu . 2>/dev/null || true
rm -rf /tmp/menu_extracted
chmod +x menu/*
mv -f menu/* /usr/local/sbin/
# Symlink all commands to /usr/bin & /usr/local/bin so PATH is never broken
for f in /usr/local/sbin/*; do
    if [ -f "$f" ] && [ -x "$f" ]; then
        bname=$(basename "$f")
        ln -sf "$f" "/usr/bin/$bname" 2>/dev/null || true
        ln -sf "$f" "/usr/local/bin/$bname" 2>/dev/null || true
    fi
done
dos2unix /usr/local/sbin/install-plugin 2>/dev/null
rm -rf menu menu.zip update.sh
}
function profile(){
clear
# 1. Global PATH in /etc/environment
if [ -f /etc/environment ]; then
    if ! grep -q "/usr/local/sbin" /etc/environment; then
        echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"' >> /etc/environment
    fi
fi

# 2. System-wide profile in /etc/profile
sed -i '/usr\/local\/sbin/d' /etc/profile 2>/dev/null || true
sed -i '/botapi/d' /etc/profile 2>/dev/null || true
echo 'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"' >> /etc/profile
echo '[ -f /etc/botapi.conf ] && . /etc/botapi.conf' >> /etc/profile

# 3. User bashrc (~/.bashrc)
sed -i '/usr\/local\/sbin/d' /root/.bashrc 2>/dev/null || true
sed -i '/alias menu=/d' /root/.bashrc 2>/dev/null || true
sed -i '/botapi/d' /root/.bashrc 2>/dev/null || true
sed -i '/botap1/d' /root/.bashrc 2>/dev/null || true
echo 'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"' >> /root/.bashrc
echo 'alias menu="/usr/local/sbin/menu"' >> /root/.bashrc

# 4. Initialize safe /etc/botapi.conf
cat >/etc/botapi.conf <<'BOTEOF'
export KEYAPI="7297710499:AAEVRmVrWw8OlE2ssUxew3h6PVGq_cU_AHM"
export CHATID="04991788"
BOTEOF
chmod 600 /etc/botapi.conf

# 5. User login profile (/root/.profile)
cat >/root/.profile <<EOF
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:\$PATH"
if [ "\$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n 2>/dev/null || true
clear
menu
EOF
cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/local/sbin/xp
END
cat >/etc/cron.d/logclean <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/20 * * * * root /usr/local/sbin/clearlog
END
chmod 644 /root/.profile
cat >/etc/cron.d/daily_reboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 3 * * * root /sbin/reboot
END
echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
service cron restart
cat >/home/daily_reboot <<-END
3
END
cat >/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF
echo "/bin/false" >>/etc/shells
echo "/usr/sbin/nologin" >>/etc/shells
cat >/etc/rc.local <<EOF
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF
chmod +x /etc/rc.local
AUTOREB=$(cat /home/daily_reboot)
SETT=11
if [ $AUTOREB -gt $SETT ]; then
TIME_DATE="PM"
else
TIME_DATE="AM"
fi
print_success "Menu Packet"
}
function enable_services(){
clear
print_install "Enable Service"
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now rc-local
systemctl enable --now cron
systemctl enable --now netfilter-persistent
systemctl restart nginx
systemctl restart xray
systemctl restart cron
print_success "Enable Service"
clear
}
function instal(){
clear
first_setup
nginx_install
base_package
make_folder_xray
pasang_domain
password_default
pasang_ssl
install_xray
ssh
udp_mini
ssh_slow
ins_SSHD
ins_dropbear
ins_vnstat
ins_openvpn
ins_backup
ins_swab
ins_Fail2ban
ins_epro
install_plugin
ins_restart
menu
profile
restart_system
}
function dnsxx(){
sudo systemctl disable systemd-resolved > /dev/null 2>&1
sudo systemctl stop systemd-resolved > /dev/null 2>&1
sudo rm -rf /etc/resolv.config > /dev/null 2>&1
echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4" | sudo tee /etc/resolv.conf
sudo chattr +i /etc/resolv.conf > /dev/null 2>&1
sudo systemctl start systemd-resolved > /dev/null 2>&1
sudo systemctl enable systemd-resolved > /dev/null 2>&1
}
instal
echo ""
function dropbear2019(){
wget  -q -O /etc/dropbear2019 "${REPO}limit/dropbear2019" >/dev/null 2>&1
chmod +x /etc/dropbear2019
bash /etc/dropbear2019
}
echo ""
print_install "Changing Dropbear Version"
dropbear2019
clear
print_success "Change Dropbear 2019 Complete"
clear
print_install "Setting Up DNS"
dnsxx
clear
print_success "DNS Setup Complete"
history -c
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/LICENSE
rm -rf /root/README.md
rm -rf /root/domain
secs_to_human "$(($(date +%s) - ${start}))"
sudo hostnamectl set-hostname $username
restart_system
echo -e "${green} Script Successfully Installed"
echo -e "${green} [✓] Notifikasi Telegram Terkirim ke Bot UZZ STORE VPN${NC}"
echo ""
echo -e "Menu akan dibuka..."
sleep 2
sync && echo 3 > /proc/sys/vm/drop_caches 2>/dev/null || true
printf "\033[2J\033[3J\033[H"
exec /usr/local/sbin/menu
