# 🔴 REDTEECON — Wireless Hacking Workshop

> A hands-on red teaming workshop focused on wireless hacking, organized as a Final Year Project at Temasek Polytechnic for Diploma in Cybersecurity & Digital Forensics students.

---

## 📌 Overview

**REDTEECON** is a 4-hour cybersecurity workshop designed to expose students to real-world red teaming techniques in wireless security. The workshop bridges the gap between classroom theory and practical offensive security skills, covering Wi-Fi attack methodologies using industry-standard tools in a controlled lab environment.

The event was conducted with **16 participants** across **5 groups**, targeting different Wi-Fi access points using a combination of dedicated wireless adapters and SSH-connected Kali Linux machines.

---

## 🎯 Problem Statement

Many organizations and individuals lack cybersecurity awareness of evolving threats — especially in wireless networks. Wi-Fi is ubiquitous in daily life, yet wireless security is often overlooked. Wireless attacks require no expensive hardware, and tooling is widely available, making this a critical area for practical education.

---

## 📦 Workshop Contents

| Deliverable | Description |
|---|---|
| 📊 Slides | Covered WPA, WPA2, and WPA2 Enterprise theory and attack concepts |
| 🧪 Lab Activity Sheets | Step-by-step guided hacking labs with real tools |
| 🏆 Challenge | Competitive challenge with prizes for top participants |

---

## 🧪 Lab Modules

| Lab | Attack | Tools |
|---|---|---|
| WPA Hacking | Dictionary attack on WPA handshake | Aircrack-ng suite |
| WPA2 Hacking (PMKID) | PMKID attack — no handshake required | hcxdumptool, hcxpcapngtool, Hashcat |
| WPA2 Enterprise | Evil Twin Attack with rogue AP | hostapd, RADIUS server |

---

## 🛠️ Tools Used

- [Aircrack-ng](https://www.aircrack-ng.org/) — WPA/WPA2 handshake cracking
- [hcxdumptool](https://github.com/ZerBea/hcxdumptool) — PMKID/handshake capture
- [hcxpcapngtool](https://github.com/ZerBea/hcxtools) — Capture file conversion
- [Hashcat](https://hashcat.net/) — GPU-accelerated password cracking
- [hostapd](https://w1.fi/hostapd/) — Rogue AP for Evil Twin attack
- Kali Linux — Primary attack platform

---

## 🏗️ Lab Environment

- **Kali Linux** — Attack machine (direct adapter + SSH access)
- **Wi-Fi Routers** — Targets configured with different authentication protocols per lab
- **RADIUS Server** — Simulates WPA2 Enterprise infrastructure for Evil Twin lab
- **SSH** — Used to extend access to participants without dedicated wireless adapters

---

## 📊 Participant Feedback

| Metric | Score |
|---|---|
| Content Rating | 3.27 / 4 |
| Pace Rating | 3.20 / 4 |
| Participants | 16 |

**Strengths:** Labs were engaging and fun; eye-opening topics; supportive trainers; easy to understand.  
**Areas for improvement:** Some labs were slow-paced; SSH instability caused disruptions; complex commands needed more explanation.

---

## 👥 Team

| Name | Role |
|---|---|
| Jonathan New Kah Hwee | Slides (WPA/WPA2/Enterprise), Hacking Labs, Lab Environment Setup |
| Lam Yu Zhe | Lab Environment Setup, Kali Linux & RADIUS Server, Testing |

**Supervisor:** Mr. Sayed Hamzah Alhabshe  
**Institution:** Temasek Polytechnic — Diploma in Cybersecurity & Digital Forensics

---

## ⚠️ Disclaimer

All lab activities were conducted in a controlled environment for **educational purposes only**. Unauthorized use of these techniques against real networks is illegal.
