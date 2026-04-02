# Wireless Hacking Repository

## Purpose
This repository contains a collection of shell scripts designed for wireless network hacking. The scripts leverage powerful tools to facilitate tasks such as network monitoring, packet capturing, and password cracking. The primary goal is to provide users with techniques to enhance their understanding of wireless security and testing methodologies.

## Target OS
The scripts are designed to run on **Linux** distributions, with a specific focus on **Ubuntu**.

## Prerequisites
Before you begin, ensure you have the following:
- **Bash Version**: 4.0 or higher 
- **Required Tools**:  
  - `aircrack-ng`  
  - `hashcat`  
  - `hcxdumptool`  
  - `hostapd`

You can install these tools using the following command:
```bash
sudo apt-get install aircrack-ng hashcat hcxdumptool hostapd
```

## Cloning the Repository
To clone this repository, run the following command in your terminal:
```bash
git clone https://github.com/ayeitsjonny/Wireless-Hacking.git
cd Wireless-Hacking
```

## Running the Scripts
Each script can be executed directly from the terminal. Ensure you have executed the correct prerequisites before running the scripts. Here’s how you run each script:

- For example, to run `script.sh`, use:
```bash
bash script.sh
```

## Expected Output
The output may vary depending on the target network and the configurations applied. Generally, you can expect detailed logs of the actions taken by the script, including:
- Captured packets
- Cracking attempts
- Results of the wireless network assessments

## Folder Structure Breakdown
The structure of the repository is as follows:
```
Wireless-Hacking/
├── scripts/                     # Contains all the shell scripts
│   ├── script1.sh              # Description of script1
│   ├── script2.sh              # Description of script2
│   └── script3.sh              # Description of script3
├── README.md                    # This README file
└── LICENSE                      # License information
```

Make sure to read through the scripts for specific options, usage instructions, and additional information regarding their functionality. 

## Disclaimer
Use these scripts responsibly. Unauthorized access to networks is illegal and unethical. Ensure you have permission before performing penetration testing on any network.
