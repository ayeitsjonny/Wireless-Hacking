# Wireless Hacking
**Major Project**  
Done by: Jonathan and Yu Zhe

---

## Slide 2 — Ethical Considerations

- Ethical hacking (also known as penetration testing or white-hat hacking) refers to authorised cybersecurity operations aimed at identifying vulnerabilities in systems, networks, and applications
- Always obtain written permission before conducting any tests
- Stay within the defined scope of the engagement
- Report all findings responsibly to the relevant stakeholders

---

## Slide 3 — Legal Considerations

- Comply with applicable laws in your jurisdiction (e.g. Computer Misuse Act, Singapore)
- Unauthorised access — even for "testing" purposes — is a criminal offence
- Terms of service of any system or network must be respected
- Potential consequences include criminal prosecution, fines, and civil liability

---

## Slide 4 — Why Wireless Hacking?

- Wi-Fi is an essential part of modern life — homes, offices, public spaces
- Wireless security is frequently overlooked by everyday users
- Attacks can be performed cheaply with consumer-grade hardware
- Tools and tutorials are freely available online
- Understanding how attacks work is the first step in building better defences

---

## Slide 5 — Contents

1. Disclaimer and Considerations
2. Basics of Wireless Hacking
3. WPA
4. WPA2
5. WPA2 Enterprise
6. Legal and Ethical Considerations

---

## Slide 6 — Basics of Wireless Hacking

---

## Slide 7 — Wireless Networks

- Devices connect wirelessly via an **Access Point** (e.g. a router)
- Data is transmitted using wireless technologies: Wi-Fi, Bluetooth, or cellular networks
- Wireless networks offer mobility and convenience — but vulnerabilities can be exploited

---

## Slide 8 — How a Wireless Connection Works

*(Diagram slide — see PPTX for visual)*

---

## Slide 9 — Basic Terminology

| Term | Definition |
|---|---|
| SSID | Service Set Identifier — the name of a Wi-Fi network |
| BSSID | MAC address of the Access Point |
| Access Point (AP) | Device that allows wireless clients to connect to a network |
| Monitor Mode | Adapter mode that allows passive capture of all wireless frames |
| EAPOL | Extensible Authentication Protocol over LAN — used in handshakes |
| Handshake | Authentication exchange between client and AP |

---

## Slide 10 — Introduction to Different Wireless Security Protocols

| Protocol | Encryption | Status |
|---|---|---|
| WEP | RC4 (static keys) | Deprecated — easily cracked |
| WPA | TKIP | Superseded |
| WPA2 | AES-CCMP | Current standard |
| WPA2 Enterprise | AES-CCMP + 802.1x | Enterprise standard |
| WPA3 | SAE | Latest standard |

---

## Slide 11 — Introduction to Wireless Hacking Tools

| Tool | Purpose |
|---|---|
| Aircrack-ng suite | Monitor mode, capture, WPA/WPA2 cracking |
| hcxdumptool | PMKID / EAPOL frame capture |
| hcxpcapngtool | Convert captures to Hashcat-compatible format |
| Hashcat | GPU-accelerated password cracking |
| hostapd-mana | Rogue AP for Evil Twin attacks |
| Wireless adapter | Essential for all wireless attacks — monitor + injection capable |

> EAPOL = Extensible Authentication Protocol over LAN

---

## Slide 12 — WPA

---

## Slide 13 — Wi-Fi Protected Access (WPA)

- WPA is a security protocol for wireless networks
- Introduced as a secure alternative/upgrade to the **WEP** protocol
- Offers stronger encryption and enhanced security features over WEP

---

## Slide 14 — Improvements from WEP

| Feature | Improvement |
|---|---|
| Security | WPA fixes known WEP vulnerabilities |
| Encryption | Dynamic TKIP replaces static WEP keys |
| Authentication | WPA-PSK with passphrases instead of static keys |
| Data Integrity | Message Integrity Checks (MIC) prevent tampering |
| Key Management | Enhanced key rotation and authentication processes |

---

## Slide 15 — Vulnerabilities of WPA

- **Weak Passwords** — easily attacked by brute-force or dictionary methods
- **Pre-Shared Key (PSK)** — single shared key makes MITM attacks possible
- **Rogue Access Points** — WPA has no protection against Evil Twin attacks

---

## Slide 16 — Brute Force Attack

---

## Slide 17 — How Does a Brute Force Attack Work?

1. Attacker captures the WPA authentication handshake (4-way EAPOL exchange)
2. Handshake file is saved locally for offline cracking
3. Cracking tool iterates through a wordlist (e.g. `rockyou.txt`)
4. Each candidate password is hashed and compared against the captured handshake
5. Match found → password recovered

---

## Slide 18 — 🧪 Lab Time — WPA Cracking

> Proceed to Lab 1: WPA cracking with Aircrack-ng

---

## Slide 19 — WPA2

> An upgrade to WPA offering stronger encryption (AES-CCMP) and authentication. WPA2 became the industry standard for securing Wi-Fi networks after its introduction in 2004.

---

## Slide 20 — Lab Setup

*(Lab environment diagram — see PPTX for visual)*

- Kali Linux VM — attack machine
- Wi-Fi router configured with WPA2-PSK — target
- Participants without adapters SSH into group leader's VM

---

## Slide 21 — Improvements over WPA

- Replaced TKIP with mandatory **AES-CCMP** (Counter Mode with CBC-MAC Protocol)
- AES-CCMP provides significantly stronger encryption
- Two variants: **WPA2-PSK** (personal) and **WPA2-Enterprise** (corporate)

---

## Slide 22 — WPA2-PSK vs. WPA2-Enterprise

| Feature | WPA2-PSK | WPA2-Enterprise |
|---|---|---|
| Authentication | Shared passphrase | Individual credentials via RADIUS (802.1x) |
| Use case | Home / small business | Corporate / institutional |
| Credential type | Single password for all users | Unique login per user |
| Security | Moderate | High |

> RADIUS = Remote Authentication Dial-in User Service

---

## Slide 23 — The WPA2-PSK Four-Way Handshake Procedure

1. AP sends **ANonce** (random number) to client
2. Client generates **SNonce**, derives PTK, sends SNonce + MIC to AP
3. AP derives PTK, validates MIC, sends **GTK** (Group Temporal Key) + MIC
4. Client installs keys and sends **ACK**
5. Both sides now share session keys for encrypted communication

---

## Slide 25 — PMKID

> **Pairwise Master Key Identifier** — a unique identifier used by an Access Point to track a specific client's PMK.

- PMK (Pairwise Master Key) is derived from the network's Pre-Shared Key
- PMKID is tied to a specific client's MAC address
- Stored in the AP's PMKID cache — a feature called **PMKID Caching**

---

## Slide 26 — PMKID Caching

- AP stores client PMKIDs in cache to assist **Wi-Fi roaming**
- Wi-Fi roaming = client moves out of range of one AP and connects to another
- PMKID caching means the client doesn't need to go through the full auth cycle again on return

---

## Slide 27 — What is the PMKID Attack?

- Exploits the PMKID caching mechanism
- Attacker tries to connect to the network, pretending to be an authenticated client
- AP responds with a PMKID (thinks attacker is a legitimate client)
- Attacker captures PMKID and uses it for offline password cracking
- **Clientless attack** — no need to wait for a real client to connect or capture a handshake

---

## Slide 28 — 🧪 Lab Time — WPA2 PMKID Attack

> Proceed to Lab 2: WPA2 cracking with hcxdumptool + Hashcat

---

## Slide 29 — WPA2-Enterprise

---

## Slide 30 — WPA2-Enterprise and 802.1x

**802.1x Authentication Protocol:**
- Enables network access via RADIUS server
- Grants access to authorised users only

**Role of RADIUS Server:**
- Vital for enterprise network security
- Ensures unique Wi-Fi logins per user
- Records event logs
- Enforces authorisation policies

---

## Slide 31 — Components of 802.1x

| Component | Role |
|---|---|
| Client / Supplicant | Initiates EAP transactions; packages user credentials |
| Switch / AP / Controller | Acts as broker; forwards auth traffic between client and RADIUS |
| RADIUS Server | Authenticates users; validates credentials against identity store |
| Identity Store | Stores usernames/passwords in Active Directory or LDAP |

---

## Slide 32 — WPA2-Enterprise Authentication Protocols

- **PEAP** (Protected EAP) — wraps EAP inside a TLS tunnel
- **EAP-TTLS** — tunnels legacy protocols (CHAP, PAP) inside TLS
- **EAP-TLS** — mutual certificate-based authentication (most secure)
- **CHAP** — Challenge Handshake Authentication Protocol

---

## Slide 33 — How CHAP Works

1. Server sends a randomly generated challenge to the client
2. Client hashes the challenge with its password and returns the hash
3. Server hashes the same challenge with its stored password copy
4. If hash values match → access granted

---

## Slide 34 — 802.1x Authentication Methods

*(Reference diagram — see PPTX for visual)*

---

## Slide 35 — Evil Twin Attack

1. Attacker scans and identifies the target WPA2 Enterprise network (SSID, channel, BSSID)
2. Configures a **rogue AP** using `hostapd-mana` with the same SSID
3. Sends **deauthentication frames** to kick clients off the legitimate AP
4. Clients attempt to reconnect → associate with the rogue AP
5. Rogue AP captures **NETNTLM credential hashes** from authenticating clients
6. Hashes cracked offline using John the Ripper with `rockyou.txt`

---

## Slide 36 — 🧪 Lab Time — WPA2 Enterprise Evil Twin

> Proceed to Lab 3: Evil Twin attack with hostapd-mana

---

## Slide 37 — Good Wireless Security Habits

- Use **strong, unique passwords** — avoid common dictionary words
- Always use **WPA2 or WPA3** — never WEP or open networks
- Use a **VPN** on public or untrusted Wi-Fi networks
- Stick to **HTTPS** when browsing on public networks
- **Verify network names** before connecting — beware of Evil Twin SSIDs
- For organisations: deploy **WPA2-Enterprise** with certificate validation to prevent rogue AP attacks

---

## Slide 38 — Thank You!
