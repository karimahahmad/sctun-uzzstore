<div align="center">

# ⚡ Autoscript UZZ STORE VPN (sctun-uzzstore)
**High-Performance & Fully Automated VPN/Tunneling Setup for Linux**

[![Telegram](https://img.shields.io/badge/Telegram-@Uzz_St0re-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/Uzz_St0re)
[![WhatsApp](https://img.shields.io/badge/WhatsApp-Chat%20Admin-25D366?style=for-the-badge&logo=whatsapp&logoColor=white)](https://wa.me/6285964078601)
[![Architecture](https://img.shields.io/badge/Arch-x86__64%20%7C%20ARM64%20%7C%20ARM%20%7C%20i386-informational?style=for-the-badge&logo=linux&logoColor=white)](#-spesifikasi--arsitektur)
[![OS Support](https://img.shields.io/badge/OS-Debian%20%7C%20Ubuntu-orange?style=for-the-badge&logo=debian&logoColor=white)](#-sistem-operasi-didukung)

---

</div>

## 🌟 Fitur Utama

- ⚡ **Instalasi Otomatis & Dinamis:** Setup cepat serta otomatis menerapkan tuning kernel server terbaik.
- 🛡️ **Keamanan Server Terpadu:** Dilengkapi **Fail2ban security system** & filter auto-block iklan Indonesia.
- 🚀 **Core Xray Khusus:** Engine Xray kustom yang dioptimalkan oleh **@Uzz_St0re**.
- 🧹 **Auto Maintenance:**
  - Auto swap 1 GB (mencegah *Out-Of-Memory* pada RAM kecil).
  - Pembersihan log server otomatis tiap 3 menit.
  - Auto delete akun yang sudah expired / kedaluwarsa.
- 📊 **Detail User Management:** Manajemen akun, pemantauan status, dan servis yang terpusat dan rapi.

---

## 🚀 Panduan Instalasi

### 1. Persiapan Sistem & DNS

Jalankan perintah berikut untuk konfigurasi awal, optimasi DNS, dan disable IPv6:

```bash
rm -f /etc/resolv.conf
touch /etc/sysctl.conf
sed -i '/disable_ipv6/d' /etc/sysctl.conf
echo "nameserver 1.1.1.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
```

### 2. Update Package

Lakukan pembaruan repositori dan instalasi paket dependensi:

```bash
apt update -y && apt upgrade -y --fix-missing && apt install --reinstall wget curl screen -y
```

### 3. Install Script

Jalankan proses instalasi di dalam sesi `screen` agar proses tetap aman jika jaringan terputus:

```bash
screen -S setup-session bash -c "wget -q https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/install.sh && chmod +x install.sh && ./install.sh"
```

> [!TIP]
> **Jika koneksi terputus saat instalasi:**  
> Anda dapat masuk kembali ke sesi yang sedang berjalan dengan perintah:
> ```bash
> screen -r -d setup-session
> ```

---

## 🔄 Update Script

Untuk memperbarui autoscript ke versi terbaru kapan saja:

```bash
wget https://raw.githubusercontent.com/karimahahmad/sctun-uzzstore/main/update.sh && chmod +x update.sh && ./update.sh
```

---

## 📡 Port yang Digunakan

| Protokol | Transport / Tipe | Port | Keterangan |
| :--- | :--- | :---: | :--- |
| **Trojan** | WS / gRPC | `443` | TLS Encrypted |
| **Shadowsocks** | WS / gRPC | `443` | TLS Encrypted |
| **VLESS** | WS / gRPC | `443` | TLS Encrypted |
| **VLESS** | Non-TLS | `80` | Direct HTTP |
| **VMess** | WS / gRPC | `443` | TLS Encrypted |
| **VMess** | Non-TLS | `80` | Direct HTTP |
| **SSH** | WS / TLS | `443` | WebSocket TLS |
| **SSH** | Non-TLS | `8880` | CDN / Direct Non-TLS |
| **OpenVPN** | SSL / TCP | `1194` | OVPN Tunnel |
| **SlowDNS** | UDP | `5300` | DNS Tunneling |

---

## ☁️ Setting Cloudflare

Pastikan konfigurasi Cloudflare Anda diatur sebagai berikut:

| Parameter | Pengaturan | Keterangan |
| :--- | :---: | :--- |
| **SSL/TLS** | `FULL` | Hindari mode Flexible |
| **SSL/TLS Recommender** | `OFF` | Mencegah loop redirect |
| **gRPC** | `ON` | Wajib untuk protokol gRPC |
| **WebSocket** | `ON` | Wajib untuk jalur WS |
| **Always Use HTTPS** | `OFF` | Agar port Non-TLS (80 & 8880) tetap dapat diakses |
| **Under Attack Mode** | `OFF` | Mencegah gangguan handshake tunnel |

---

## 🖥️ Supported System

### Sistem Operasi (Tested OS)
| Distro | Versi / Rilis | Status Dukungan |
| :--- | :--- | :---: |
| **Ubuntu** | 20.04 LTS, 22.04 LTS, 24.04.5 LTS | 🟢 Stable (Recommended) |
| **Ubuntu** | 18.04, 23.10 | 🟡 Testing / Various Status |
| **Debian** | 10 (Buster), 11 (Bullseye), 12 (Bookworm) | 🟢 Stable |
| **Debian** | 9 (Stretch) | 🟡 Unstable |
| **Debian** | 13 (Trixie), 14 (Forky) | ⏳ Coming Soon |
| **Kali Linux** | Kali Rolling | 🟢 Stable |

### Virtualization Support
Didukung pada berbagai tipe virtualisasi server & hypervisor:
- `KVM`
- `VMware`
- `Xen` / `XenServer`
- `Proxmox`
- `LXC`
- `OpenVZ 7`
- `Virtuozzo`
- `ZFS environments`

---

## ⚙️ Spesifikasi & Persyaratan Sistem

| Komponen | Minimum Requirements | Recommended Spec |
| :--- | :--- | :--- |
| **CPU** | 1 vCPU | 1 vCPU atau lebih |
| **RAM** | 512 MB *(Auto swap 1GB aktif)* | 1 GB RAM atau lebih |
| **Penyimpanan** | 10 GB SSD | 10 GB+ SSD / NVMe |
| **Sistem Operasi** | Debian 10+ / Ubuntu 20.04+ | Ubuntu / Debian LTS version |

### Arsitektur (Multi-Architecture Supported)
- ✅ **x86_64 / amd64 (64-bit)** : Supported
- ✅ **aarch64 / arm64** : Supported (Oracle Ampere, AWS Graviton, RPi 4/5 64-bit)
- ✅ **armv7l / armhf** : Supported (RPi 2/3 32-bit, OrangePi)
- ✅ **i386 / i686 (32-bit)** : Supported

---

## 📬 Contact & Author

<div align="center">

Dibuat & dikelola oleh **[@Uzz_St0re](https://t.me/Uzz_St0re)**

[![Telegram](https://img.shields.io/badge/Telegram-Contact-blue?style=for-the-badge&logo=telegram)](https://t.me/Uzz_St0re)
&nbsp;
[![WhatsApp](https://img.shields.io/badge/WhatsApp-Contact-green?style=for-the-badge&logo=whatsapp)](https://wa.me/6285964078601)

</div>
