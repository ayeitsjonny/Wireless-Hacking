# Wireless Hacking
**REDTEECON Workshop**  
Lam Yu Zhe · Jonathan New Kah Hwee

---

## Slide 2 — Disclaimer and Purpose

> All techniques demonstrated in this workshop are strictly for educational purposes in a controlled lab environment. Do not attempt these on any network without explicit permission.

---

## Slide 3 — Why Wireless Hacking?

- Wi-Fi is ubiquitous in daily life — yet wireless security is frequently neglected
- Wireless attacks require no expensive specialised hardware
- Tools and tutorials are widely available online
- Understanding attacks helps defenders protect their networks

---

## Slide 4 — Contents

1. Disclaimer and Purpose
2. Basics of Wireless Hacking
3. WPA
4. WPA2
5. WPA2 Enterprise
6. Conclusion

---

## Slide 5 — Basics of Wireless Hacking

---

## Slide 6 — Wireless Networks

- Connect devices wirelessly using an **Access Point** (e.g. a router)
- Data is transmitted using wireless technologies (Wi-Fi, Bluetooth, cellular)
- Wireless networks offer mobility and convenience — but vulnerabilities can be exploited

---

## Slide 7 — How a Wireless Connection Works

*(Diagram slide — see PPTX for visual)*

---

## Slide 8 — Basic Terminology

*(Terminology reference slide — see PPTX for visual)*

---

## Slide 9 — Introduction to Different Wireless Security Protocols

| Protocol | Notes |
|---|---|
| WEP | Wired Equivalent Privacy — deprecated, easily cracked |
| WPA | Wi-Fi Protected Access — TKIP encryption |
| WPA2 | Industry standard — AES/CCMP encryption |
| WPA2 Enterprise | 802.1x with RADIUS server authentication |
| WPA3 | Latest standard — SAE handshake |

---

## Slide 10 — Introduction to Wireless Hacking Tools

| Tool | Purpose |
|---|---|
| Aircrack-ng suite | Monitor mode, packet capture, WPA cracking |
| hcxdumptool | PMKID / EAPOL frame capture |
| hcxpcapngtool | Convert captures to hashcat format |
| Hashcat | GPU-accelerated password cracking |
| hostapd-mana | Rogue AP for Evil Twin attacks |
| Wireless adapter | Essential — required for all wireless attacks |

> **Note:** EAPOL = Extensible Authentication Protocol over LAN

---

## Slide 11 — WPA

---

## Slide 12 — Wi-Fi Protected Access (WPA)

- WPA is a security protocol for wireless networks
- Introduced as a secure alternative/upgrade to the older **WEP** protocol
- Offers stronger encryption and enhanced security features

---

## Slide 13 — Improvements from WEP

| Feature | Improvement |
|---|---|
| Security | WPA fixes WEP vulnerabilities |
| Encryption | Dynamic TKIP for strong wireless security |
| Authentication | WPA-PSK with Pre-Shared Keys |
| Data Integrity | Message Integrity Checks (MIC) |
| Key Management | Enhanced key processes and authentication |

---

## Slide 14 — Vulnerabilities of WPA

- **Weak Passwords** — easily attacked by brute-force or dictionary methods
- **Pre-Shared Key (PSK)** — vulnerable to man-in-the-middle attacks
- **Rogue Access Points** — WPA has no protection against Evil Twin attacks

---

## Slide 15 — Brute Force

---

## Slide 16 — Types of Brute Force Attack

- **Simple brute force** — tries all possible character combinations
- **Dictionary attack** — uses a wordlist of common passwords
- **Hybrid attack** — combines dictionary words with character substitutions
- **Credential stuffing** — uses previously leaked username/password pairs

---

## Slide 17 — Motive Behind Brute Force Attacks

- Gain unauthorised network access
- Steal sensitive data or credentials
- Pivot to further internal attacks
- Financial gain or espionage

---

## Slide 18 — Brute Force Attack Tools

- **Aircrack-ng** — WPA/WPA2 handshake cracking
- **Hashcat** — GPU-accelerated cracking
- **John the Ripper** — versatile hash cracking
- **Hydra** — online brute force (login forms, SSH, etc.)

---

## Slide 19 — How Does a Brute Force Attack Work?

1. Attacker captures the authentication handshake between client and AP
2. Handshake is saved and cracked offline
3. Tool iterates through a wordlist (e.g. `rockyou.txt`) comparing hashes
4. Match found → password recovered

---

## Slide 20 — 🧪 Lab Time — WPA Cracking

> Proceed to Lab 1: WPA cracking with Aircrack-ng

---

## Slide 21 — WPA2

---

## Slide 22 — Lab Setup

*(Lab environment diagram — see PPTX for visual)*

- Kali Linux VM (attack machine)
- Wi-Fi router (target, configured with WPA2-PSK)
- Participants without adapters connect via SSH to group leader's VM

---

## Slide 23 — Improvements over WPA

- Replaced TKIP with **AES-CCMP** encryption (much stronger)
- Mandatory use of CCMP — not optional like in WPA
- Two variants: **WPA2-Personal (PSK)** for consumers, **WPA2-Enterprise (EAP)** for organisations

---

## Slide 24 — WPA2-Personal (PSK) vs. WPA2-Enterprise (EAP)

| Feature | WPA2-Personal | WPA2-Enterprise |
|---|---|---|
| Authentication | Pre-Shared Key | RADIUS server (802.1x) |
| Use case | Home / SMB | Corporate / institutional |
| Credential type | Single shared password | Individual user credentials |
| Security level | Moderate | High |

> RADIUS = Remote Authentication Dial-in User Service

---

## Slide 25 — The WPA2 Four-Way Handshake Procedure

1. AP sends ANonce to client
2. Client sends SNonce + MIC to AP
3. AP sends GTK (Group Temporal Key) + MIC to client
4. Client sends ACK to AP
5. Both derive PTK (Pairwise Transient Key) from ANonce + SNonce + PMK

---

## Slide 27 — PMKID

> **Pairwise Master Key Identifier** — a unique identifier used by an Access Point to track a specific client's PMK.

```
PMKID = HMAC-SHA1-128(PMK + "PMK name" + AP BSSID + Client BSSID)
```

- PMK is derived from the network's Pre-Shared Key
- PMKID is stored in the AP's cache — a feature called **PMKID Caching**

---

## Slide 28 — PMKID Caching

- AP stores a client's PMKID in cache to assist **Wi-Fi roaming**
- Wi-Fi roaming = when a client moves out of range of one AP and reconnects to another
- With PMKID caching, clients don't need to re-authenticate from scratch

---

## Slide 29 — What is the PMKID Attack?

- Exploits vulnerabilities in the PMKID caching mechanism
- Attacker pretends to be an AP to encourage devices to authenticate
- Client cannot actually authenticate → falls back to the real AP
- Attacker captures **EAPOL frames** containing the PMKID (MITM)
- **Clientless attack** — no need to wait for a client to connect

---

## Slide 30 — 🧪 Lab Time — WPA2 PMKID Attack

> Proceed to Lab 2: WPA2 cracking with hcxdumptool + Hashcat

---

## Slide 31 — WPA2-Enterprise

---

## Slide 32 — WPA2-Enterprise and 802.1x

**802.1x Authentication Protocol:**
- Enables network access via RADIUS server
- Grants access to authorised users only

**Role of RADIUS Server:**
- Vital for enterprise network security
- Ensures unique Wi-Fi logins per user
- Records event logs
- Enforces authorisation policies

---

## Slide 33 — Components of 802.1x

| Component | Role |
|---|---|
| Client / Supplicant | Initiates EAP transactions; packages credentials |
| Switch / AP / Controller | Acts as broker between client and RADIUS |
| RADIUS Server | Authenticates users; replaces pre-shared keys |
| Identity Store | Stores credentials (Active Directory / LDAP) |

---

## Slide 34 — WPA2-Enterprise Authentication Protocols

- **PEAP** (Protected EAP) — tunnels EAP inside TLS
- **EAP-TTLS** — tunnels legacy auth methods inside TLS
- **EAP-TLS** — mutual certificate-based authentication
- **CHAP** — Challenge Handshake Authentication Protocol

---

## Slide 35 — How Does CHAP Work?

1. Server sends a randomly generated challenge to the client
2. Client hashes the challenge with its password and sends it back
3. Server hashes the same challenge with its stored password copy
4. If hashes match → access granted

---

## Slide 36 — 802.1x Authentication Methods

*(Reference diagram — see PPTX for visual)*

---

## Slide 37 — Evil Twin Attack

1. Attacker scans and identifies the target WPA2 Enterprise network
2. Sets up a rogue AP (`hostapd-mana`) mimicking the target SSID
3. Sends **deauth frames** to kick clients off the real AP
4. Clients attempt to reconnect → hit the rogue AP instead
5. Rogue AP captures **NETNTLM credentials**
6. Hash cracked offline with John the Ripper

---

## Slide 38 — 🧪 Lab Time — WPA2 Enterprise Evil Twin

> Proceed to Lab 3: Evil Twin attack with hostapd-mana

---

## Slide 39 — Good Wireless Security Habits

- Use **strong, unique passwords** (12+ characters, not dictionary words)
- Enable **WPA2 or WPA3** — never WEP or open networks
- Use a **VPN** on public/untrusted Wi-Fi
- **Stick to HTTPS** when browsing on public networks
- Regularly **audit connected devices** on your network
- For enterprises: deploy **WPA2-Enterprise** with certificate validation

---

## Slide 40 — Legal Considerations

- **Authorisation** — only conduct ethical hacking with explicit written permission
- **Applicable Laws** — comply with jurisdiction-specific frameworks (e.g. Computer Misuse Act, Singapore)
- **Terms of Service** — abide by organisational usage standards
- **Consequences** — unauthorised hacking can result in criminal prosecution and fines
- **Collaboration** — ethical hackers should liaise with legal teams for proper approvals

> ⚠️ DO NOT hack into networks you do not own or have explicit permission to test.

---

## Slide 41 — Thank You!

*Hopefully you are still awake and learnt something new ;)*
