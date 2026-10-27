#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
red() { echo -e "\033[32;1m${*}\033[0m"; }
clear
if ! command -v 7z >/dev/null 2>&1; then
apt update && apt install p7zip-full -y
fi
fun_bar() {
CMD[0]="$1"
CMD[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${CMD[0]} -y >/dev/null 2>&1
${CMD[1]} -y >/dev/null 2>&1
touch $HOME/fim
) >/dev/null 2>&1 &
tput civis
echo -ne "  [0;33mPlease Wait Loading \e[1;37m- \e[0;33m["
while true; do
for ((i = 0; i < 18; i++)); do
echo -ne "\e[0;32m#"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\e[0;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "  [0;33mPlease Wait Loading \e[1;37m- \e[0;33m["
done
echo -e "\e[0;33m][1;37m -[1;32m OK !\033[1;37m"
tput cnorm
}
res1() {
# --- Apply Network & SSH Stability Anti-Disconnect Settings ---
wget -q -O /etc/ssh/sshd_config "https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/sshd"
chmod 600 /etc/ssh/sshd_config
wget -q -O /etc/default/dropbear "https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/dropbear.conf"
chmod 644 /etc/default/dropbear
wget -q -O /etc/nginx/conf.d/xray.conf "https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/xray.conf"
domain=$(cat /etc/xray/domain 2>/dev/null || cat /root/domain 2>/dev/null || echo "localhost")
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf

# Kernel KeepAlive
sysctl -w net.ipv4.tcp_keepalive_time=60 >/dev/null 2>&1
sysctl -w net.ipv4.tcp_keepalive_intvl=10 >/dev/null 2>&1
sysctl -w net.ipv4.tcp_keepalive_probes=5 >/dev/null 2>&1

systemctl daemon-reload >/dev/null 2>&1
systemctl restart ssh >/dev/null 2>&1 || service ssh restart >/dev/null 2>&1
systemctl restart dropbear >/dev/null 2>&1 || service dropbear restart >/dev/null 2>&1
systemctl restart nginx >/dev/null 2>&1
wget -q -O /usr/bin/ws "https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/ws"
chmod +x /usr/bin/ws
wget -q -O /usr/bin/tun.conf "https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/tun.conf"
chmod 644 /usr/bin/tun.conf
wget -q -O /etc/systemd/system/ws.service "https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/ws.service"
chmod +x /etc/systemd/system/ws.service
systemctl daemon-reload >/dev/null 2>&1
systemctl restart ws >/dev/null 2>&1


systemctl disable --now haproxy 2>/dev/null || true
apt remove -y haproxy 2>/dev/null || true
rm -rf /etc/haproxy
wget -q -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/nginx.conf"
wget -q -O /etc/nginx/conf.d/xray.conf "https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/xray.conf"
domain=$(cat /etc/xray/domain 2>/dev/null || cat /root/domain 2>/dev/null || echo "localhost")
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
systemctl restart nginx 2>/dev/null || true

ARCH=$(uname -m)
case "$ARCH" in
    x86_64|amd64) ARCH_XRAY="64" ;;
    aarch64|arm64) ARCH_XRAY="arm64-v8a" ;;
    armv7*|armv6*|armhf|arm) ARCH_XRAY="arm32-v7a" ;;
    i386|i686) ARCH_XRAY="32" ;;
    *) ARCH_XRAY="64" ;;
esac

if [ ! -f /usr/local/bin/xray ] || ! /usr/local/bin/xray version >/dev/null 2>&1; then
    if [ "$ARCH_XRAY" = "64" ]; then
        wget -q -O /tmp/xray.zip "https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/xray.zip"
    else
        wget -q -O /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/v25.8.31/Xray-linux-${ARCH_XRAY}.zip" || \
        wget -q -O /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${ARCH_XRAY}.zip"
    fi
    if [ -f /tmp/xray.zip ]; then
        unzip -o /tmp/xray.zip -d /tmp/xray_ext/ >/dev/null 2>&1
        mv -f /tmp/xray_ext/xray /usr/local/bin/xray
        mkdir -p /usr/local/share/xray
        mv -f /tmp/xray_ext/*.dat /usr/local/share/xray/
        rm -rf /tmp/xray.zip /tmp/xray_ext
        chmod +x /usr/local/bin/xray
    fi
fi
if [ ! -f /usr/local/bin/xray ]; then
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install --version 25.8.31 || true
fi
mkdir -p /var/log/xray /run/xray /etc/xray /usr/local/share/xray
touch /var/log/xray/access.log /var/log/xray/error.log
chmod 777 /var/log/xray /var/log/xray/*.log
chmod 755 /run/xray /etc/xray
[ ! -f /usr/local/share/xray/geosite.dat ] && wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" || true
[ ! -f /usr/local/share/xray/geoip.dat ] && wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" || true
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
systemctl restart xray 2>/dev/null || true

rm -f menu.zip
wget -O menu.zip https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/menu.zip
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
for f in /usr/local/sbin/*; do
    if [ -f "$f" ] && [ -x "$f" ]; then
        bname=$(basename "$f")
        ln -sf "$f" "/usr/bin/$bname" 2>/dev/null || true
        ln -sf "$f" "/usr/local/bin/$bname" 2>/dev/null || true
    fi
done
sed -i '/usr\/local\/sbin/d' /root/.bashrc /etc/profile 2>/dev/null || true
sed -i '/alias menu=/d' /root/.bashrc 2>/dev/null || true
sed -i '/botapi/d' /root/.bashrc 2>/dev/null || true
sed -i '/botap1/d' /root/.bashrc 2>/dev/null || true
echo 'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"' >> /root/.bashrc
echo 'alias menu="/usr/local/sbin/menu"' >> /root/.bashrc
echo 'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"' >> /etc/profile
dos2unix /usr/local/sbin/install-plugin 2>/dev/null
rm -rf menu menu.zip update.sh
}
netfilter-persistent
clear
echo -e "\e[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m"
echo -e "\e[1;96m              UPDATE SCRIPT              \E[0m"
echo -e "\e[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m"
echo -e ""
echo -e "  \033[1;91m update script service\033[1;37m"
fun_bar 'res1'
echo -e "\e[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m"
echo -e ""
read -n 1 -s -r -p "Tekan [ Enter ] untuk kembali ke menu..."
sync && echo 3 > /proc/sys/vm/drop_caches 2>/dev/null || true
printf "\033[2J\033[3J\033[H"
exec menu
