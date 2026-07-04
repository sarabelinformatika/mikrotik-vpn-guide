###############################################################################
#
# Enterprise MikroTik VPN Guide
#
# File:
# mikrotik/base/address-list.rsc
#
# Purpose:
# Centralized Address Lists used throughout the reference VPN deployment.
#
# RouterOS:
# Version 7.x
#
###############################################################################

###############################################################################
# Corporate Networks
###############################################################################

/ip firewall address-list

add list=LAN address=192.168.110.0/24 comment="Corporate LAN"

add list=VPN address=192.168.120.0/24 comment="VPN Client Network"

###############################################################################
# Infrastructure Servers
###############################################################################

add list=Infrastructure address=192.168.110.10 comment="Primary Domain Controller"

add list=Infrastructure address=192.168.110.20 comment="NAS"

add list=Infrastructure address=192.168.110.30 comment="Monitoring Server"

###############################################################################
# Management Hosts
###############################################################################

add list=Management address=192.168.110.100 comment="Administrator Workstation"

###############################################################################
# DNS Servers
###############################################################################

add list=DNS address=192.168.110.10 comment="Primary DNS"

###############################################################################
# VPN Gateway
###############################################################################

add list=VPNGateway address=192.168.120.1 comment="VPN Gateway"

###############################################################################
# RFC1918 Networks
###############################################################################

add list=RFC1918 address=10.0.0.0/8 comment="Private Network"

add list=RFC1918 address=172.16.0.0/12 comment="Private Network"

add list=RFC1918 address=192.168.0.0/16 comment="Private Network"

###############################################################################
# Loopback
###############################################################################

add list=Loopback address=127.0.0.0/8 comment="Loopback"

###############################################################################
# Multicast
###############################################################################

add list=Multicast address=224.0.0.0/4 comment="Multicast"

###############################################################################
# Broadcast
###############################################################################

add list=Broadcast address=255.255.255.255 comment="Broadcast"

###############################################################################
# Bogon Networks
###############################################################################

add list=Bogons address=0.0.0.0/8 comment="Bogon"

add list=Bogons address=100.64.0.0/10 comment="Carrier Grade NAT"

add list=Bogons address=169.254.0.0/16 comment="Link Local"

add list=Bogons address=198.18.0.0/15 comment="Benchmark"

add list=Bogons address=240.0.0.0/4 comment="Reserved"

###############################################################################
# Documentation
###############################################################################

# This file is used by:
#
# firewall-filter.rsc
# firewall-nat.rsc
# wireguard.rsc
# openvpn-server.rsc
# l2tp-ipsec.rsc
#
# Modify the example addresses before importing into production.
#
###############################################################################
