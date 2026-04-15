#!/bin/bash
# --------------
# | BGP Vortex |
# --------------
# GNS3 kali presentation node script
# 
# GSN3 node configuration:
# eth0 - Cloud
# eth1 - AS65001 g0/3
# eth2 - AS65002 g0/3
# eth3 - AS65003 g0/3
#
nmcli connection down "Wired connection 1"
nmcli connection modify "Wired connection 1" ipv4.method auto
nmcli connection up "Wired connection 1"
nmcli connection down "Wired connection 2"
nmcli connection modify "Wired connection 2" ipv4.method manual ipv4.addresses "172.16.1.10/24" ipv4.gateway "172.16.1.1"
nmcli connection up "Wired connection 2"
nmcli connection down "Wired connection 3"
nmcli connection modify "Wired connection 3" ipv4.method manual ipv4.addresses "172.16.2.10/24" ipv4.gateway "172.16.2.1"
nmcli connection up "Wired connection 3"
nmcli connection down "Wired connection 4"
nmcli connection modify "Wired connection 4" ipv4.method manual ipv4.addresses "172.16.3.10/24" ipv4.gateway "172.16.3.1"
nmcli connection up "Wired connection 4"

mtr 172.16.10.1 -I eth1 &
mtr 172.16.10.1 -I eth2 &
mtr 172.16.10.1 -I eth3 &