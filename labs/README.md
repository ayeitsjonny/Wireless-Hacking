# 🧪 Labs

This folder contains the lab materials distributed to workshop participants.

| File | Description |
|---|---|
| `Wireless_Hacking_Lab_Student_Handout.docx` | Quick-reference handout given to participants during labs |
| `Wireless_Hacking_Lab_Student_Guide.docx` | Full step-by-step guide with explanations for each lab |

## Lab Overview

### Lab 1 — WPA Cracking
- Put wireless adapter into monitor mode
- Scan for and lock onto the target WPA network
- Capture the 4-way EAPOL handshake
- Run a dictionary attack using `rockyou.txt` with Aircrack-ng

### Lab 2 — WPA2 PMKID Attack
- Stop conflicting network services
- Capture PMKID frames using hcxdumptool (no client needed)
- Convert capture to `hc22000` format with hcxpcapngtool
- Crack the PMKID hash using Hashcat with `-m 22000`

### Lab 3 — WPA2 Enterprise Evil Twin
- Scan and identify the WPA2 Enterprise target network
- Configure a rogue AP with `hostapd-mana` mimicking the target SSID
- Deauthenticate clients from the real AP to force reconnection
- Capture NETNTLM credentials from connecting clients
- Crack the hash offline using John the Ripper

> See `resources/commands.md` for the full command list for all labs.
