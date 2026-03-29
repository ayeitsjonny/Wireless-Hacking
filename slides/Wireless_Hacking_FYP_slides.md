# Major Project — Red Teaming Workshop
**Temasek Polytechnic | Wireless Hacking**  
Lam Yu Zhe · Jonathan New Kah Hwee  
Supervisor: Mr. Sayed Hamzah Alhabshe

---

## Slide 2 — Project Overview

1. Background
2. Project Architecture
3. Feedback and Improvements
4. Project Dynamics
5. Learning Points

---

## Slide 3 — Problem Statement

> Lack of cybersecurity awareness and readiness on evolving cyber threats and vulnerabilities amongst organisations and individuals.

---

## Slide 4 — Background

- The cyber threat landscape is constantly evolving
- Red teaming is critical in assessing organisational resilience — but many are intimidated by its learning curve
- Wireless networks are a major attack surface: Wi-Fi is part of daily life, yet wireless security is often neglected
- Wireless hacking requires no expensive specialised tools, and tutorials are widely available online

**REDTEECON addresses these concerns by:**
- Providing accessible red teaming training
- Offering expertise in the latest trends and technologies
- Enhancing practical cybersecurity skills with real-world tools and exercises

---

## Slide 5 — Target Audience

Students of Temasek Polytechnic who:
- Are looking for unique cybersecurity topics outside their curriculum
- Want hands-on experience with real-world tools and exercises
- Are looking to gain deeper insight into red teaming

---

## Slide 6 — Project Architecture: Wireless Hacking

---

## Slide 7 — Project Components

| Component | Role |
|---|---|
| Kali Linux Machine | Primary platform for wireless attacks |
| Wi-Fi Router | Target — each lab uses a different authentication protocol |
| RADIUS Server | Provides 802.1x infrastructure for the WPA2 Enterprise lab |

---

## Slide 8 — Main Features of the Project

- PowerPoint slides covering theory and concepts
- Guided lab activity sheets with tools tailored per subtopic
- Creation of isolated lab environments

**Wireless Hacking Tools Used:**
- Aircrack-ng suite
- hcxdumptool & hcxpcapngtool
- Hashcat

---

## Slide 9 — Methodology: Initial Research & Testing

- Conducted initial research on wireless protocols: WEP, WPA, WPA2, WPA2 Enterprise, WPA3
- Set up test lab environments
- Explored tooling options for each attack vector
- Identified suitable lab activities for each protocol

---

## Slide 10 — Methodology: Early Changes

- ❌ Removed **WEP** — router limitations prevented reliable WEP testing
- ✅ Replaced WEP with **WPA2 Enterprise**
- ❌ Removed **WPA3** content — too advanced for workshop scope
- ✅ Added **WPA2 cracking using hcxtools + Hashcat** (PMKID Attack)

---

## Slide 11 — Methodology: Further Research & Testing

- Explored WPA2 Enterprise in depth — protocols, 802.1x infrastructure, RADIUS setup
- Decided on **Evil Twin Attack with hostapd-mana** for the enterprise lab
- Studied the **PMKID attack**, set up tools, and built a working lab

**Final lab activities:**
1. Cracking WPA with Aircrack-ng
2. WPA2 cracking using hcxtools & Hashcat (PMKID)
3. WPA2 Enterprise Evil Twin Attack with hostapd-mana

---

## Slide 12 — Methodology: Final Changes & Testing

Conducted dry runs with friends and incorporated feedback:

- ✂️ Cut down slide content — too dense
- ❌ Removed WPA2 cracking with Aircrack-ng — time constraints
- ✅ Added PMKID theory slides for conceptual grounding
- ✅ Implemented **SSH access** due to insufficient wireless adapters for all participants

---

## Slide 13 — Challenges

| Challenge | Detail |
|---|---|
| WPA2 Enterprise setup | NPAS didn't always start on boot; IAS issues with Windows Server 2019 |
| hcxdumptool reliability | Inconsistent capture behaviour during testing |
| VM management | VMs frequently shuffled between the two teams |
| Time pressure | VMs and SSH had to be set up the day before with minimal testing time |
| During workshop | Participants worked at different speeds; SSH was very unstable |

---

## Slide 14 — Project Demo

> Wireless Hacking — live walkthrough of lab activities

---

## Slide 15 — Class Breakdown

- **25 students** organised into **5 groups of 5**
- Each group has **1 leader** with the wireless adapter
- Remaining 4 members **SSH into the leader's Kali VM**
- Class split in half — each half targets a **separate Access Point**
- Trainers roam to assist groups

---

## Slide 16 — Workshop Breakdown

*(Timeline/schedule visual — see PPTX)*

---

## Slide 17 — Feedback & Improvements

---

## Slide 18 — Participant Feedback: Statistics

| Metric | Result |
|---|---|
| Number of Participants | 16 |
| Content Rating | 3.27 / 4 |
| Pace Rating | 3.20 / 4 |

---

## Slide 19 — Participant Feedback: Strengths & Weaknesses

**✅ Positive Feedback**
- Labs were fun and engaging
- Eye-opening topics
- Labs were well structured
- Good at teaching; easy to understand
- Supportive and enthusiastic trainers
- Interesting and enjoyable content

**⚠️ Areas for Improvement**
- Hard to follow at times
- Labs were slow-paced
- Issues with laptops — a lot of troubleshooting
- Complicated commands with little explanation
- Unreliable VMs

---

## Slide 20 — Future Enhancements

- More dry runs — especially testing the SSH workflow — to proactively identify issues
- Simplify technical terms and improve slide explanations
- Begin workshop environment setup earlier
- Gather more wireless adapters if possible to reduce SSH dependency

---

## Slide 21 — Project Dynamics

---

## Slide 22 — Project Dynamics: Yu Zhe

**Lab Environment Setup:**
- Kali Linux
- RADIUS Server
- Router setup

**Hacking Labs:**
- WPA2 Hacking with Aircrack-ng suite
- WPA2 cracking with hcxdumptool & hcxpcapngtool
- WPA2 Enterprise cracking with Evil Twin Attack

**Slides:**
- Introduction / Basics · WPA · WPA2 · WPA2 Enterprise · Conclusion

**Testing:** Wireless Hacking & Active Directory Hacking

---

## Slide 23 — Project Dynamics: Jonathan

**Workshop Breakdown:** Created the full workshop structure for Wireless Hacking

**Slides:**
- Introduction / Basics · WPA Hacking · WPA2 Hacking · WPA2 Enterprise Hacking · Conclusion

**Hacking Labs:**
- WEP Hacking with Aircrack-ng suite
- WPA Hacking with Aircrack-ng suite
- WPA2 Hacking with Aircrack-ng suite

**Testing:** Wireless Hacking + Active Directory

---

## Slide 24 — Learning Points

---

## Slide 25 — Learning Points: Jonathan

- Developed creative ways to present slides and design activities that make the workshop engaging
- Learned to think from the participant's perspective when creating content
- Gained exposure to new tools and techniques through hands-on lab development
- Sharpened problem-solving skills — crafting lab questions required creative phrasing of steps
- Improved content delivery skills: pacing and managing content volume

---

## Slide 26 — Learning Points: Yu Zhe

- Learned to draft technical content from scratch without a predefined brief
- Improved communication with teammates on tracking progress
- Gained appreciation that red teaming is challenging but enjoyable
- Developed the ability to teach others in a simplified yet comprehensive manner
- Learned to create presentations that are technical but accessible
- Improved prioritisation skills under project constraints

---

## Slide 27 — Thank You!
