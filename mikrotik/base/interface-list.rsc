###############################################################################
#
# Enterprise MikroTik VPN Guide
#
# File:
# mikrotik/base/interface-list.rsc
#
# Purpose:
# Standardized Interface Lists for RouterOS 7.x
#
# RouterOS:
# Version 7.x
#
###############################################################################

###############################################################################
# Interface Lists
###############################################################################

/interface/list

add name=WAN comment="Internet-facing Interfaces"

add name=LAN comment="Internal Local Area Network"

add name=VPN comment="VPN Interfaces"

add name=MGMT comment="Management Interfaces"

###############################################################################
# Interface Membership
#
# Modify the interface names to match your environment.
###############################################################################

/interface/list/member

###############################################################################
# WAN
###############################################################################

add interface=ether1 list=WAN comment="Primary Internet Connection"

###############################################################################
# LAN
###############################################################################

add interface=bridge list=LAN comment="Corporate LAN Bridge"

###############################################################################
# VPN
###############################################################################

# WireGuard

add interface=wireguard1 list=VPN comment="WireGuard Interface"

# OpenVPN
#
# OpenVPN server interfaces are dynamic.
# PPP connections are handled by the PPP subsystem.
# No static interface assignment is required.

# L2TP/IPsec
#
# L2TP interfaces are created dynamically after successful authentication.

###############################################################################
# Management
###############################################################################

add interface=bridge list=MGMT comment="Router Management"

###############################################################################
# Documentation
###############################################################################

# These Interface Lists are referenced throughout the repository by:
#
# firewall-filter.rsc
# firewall-nat.rsc
# wireguard.rsc
# openvpn-server.rsc
# l2tp-ipsec.rsc
#
# Using Interface Lists instead of physical interfaces improves:
#
# - Scalability
# - Readability
# - Maintainability
# - Multi-WAN compatibility
#
# Adjust interface names before importing into production.
#
###############################################################################
