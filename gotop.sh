#!/bin/bash
function ins_swab(){
clear
print_install "Memasang Swap 1 G"
ARCH=$(uname -m)
case "$ARCH" in
    x86_64|amd64) ARCH_GOTOP="linux_amd64.deb" ;;
    aarch64|arm64) ARCH_GOTOP="linux_arm64.deb" ;;
    armv7*|armv6*|armhf|arm) ARCH_GOTOP="linux_arm.deb" ;;
    i386|i686) ARCH_GOTOP="linux_386.deb" ;;
    *) ARCH_GOTOP="linux_amd64.deb" ;;
esac
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1 | tr -d ' ')"
[ -z "$gotop_latest" ] && gotop_latest="4.2.0"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v${gotop_latest}/gotop_v${gotop_latest}_${ARCH_GOTOP}"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb >/dev/null 2>&1
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile >/dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab
chronyd -q 'server 0.id.pool.ntp.org iburst'
chronyc sourcestats -v
chronyc tracking -v
wget  https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/limit/bbr.sh &&  chmod +x bbr.sh && ./bbr.sh
print_success "Swap 1 G"
}
