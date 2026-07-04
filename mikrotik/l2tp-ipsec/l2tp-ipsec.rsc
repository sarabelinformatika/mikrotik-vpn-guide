###############################################################################
# L2TP Server
###############################################################################

/interface l2tp-server server

set \
    enabled=yes \
    use-ipsec=required \
    ipsec-secret=ChangeThisIPsecSecret! \
    authentication=mschap2 \
    default-profile=vpn-profile \
    max-mtu=1460 \
    max-mru=1460 \
    one-session-per-host=yes

###############################################################################
# IPsec Proposal
###############################################################################

/ip ipsec proposal

set [ find default=yes ] \
    auth-algorithms=sha256 \
    enc-algorithms=aes-256-cbc \
    pfs-group=modp2048

###############################################################################
# IPsec Profile
###############################################################################

/ip ipsec profile

set [ find default=yes ] \
    hash-algorithm=sha256 \
    enc-algorithm=aes-256 \
    dh-group=modp2048

###############################################################################
# Network Design
###############################################################################

#
# LAN
#
# 192.168.110.0/24
#
# L2TP/IPsec
#
# 192.168.120.0/24
#
# VPN Gateway
#
# 192.168.120.1
#
# Client Pool
#
# 192.168.120.100-199
#
###############################################################################

###############################################################################
# Static Route Example
###############################################################################

#
# Example:
#
# Route traffic to a remote site through an L2TP/IPsec client.
#
# Uncomment and modify as required.
#

#/ip route
#
#add \
#    dst-address=192.168.210.0/24 \
#    gateway=192.168.120.100 \
#    comment="Branch Office"

###############################################################################
# Authentication Recommendations
###############################################################################

#
# Supported authentication:
#
# - MS-CHAPv2 (Recommended)
#
# Avoid:
#
# - PAP
# - CHAP
# - MS-CHAP
#
# Enterprise environments should use RADIUS authentication.
#

###############################################################################
# Client Compatibility
###############################################################################

#
# Native Client Support
#
# - Windows
# - macOS
# - Linux
# - Android
# - iOS
#
# L2TP/IPsec remains an excellent choice when native
# VPN clients are preferred.
#

###############################################################################
# Split Tunnel
###############################################################################

#
# Route only internal networks through the VPN.
#
# Example:
#
# 192.168.110.0/24
#
# Internet traffic remains local.
#

###############################################################################
# Full Tunnel
###############################################################################

#
# Route all client traffic through the VPN.
#
# Requires:
#
# - Source NAT
# - Firewall rules
# - Internet connectivity through MikroTik
#

###############################################################################
# Deployment Checklist
###############################################################################

#
# □ L2TP Server enabled
# □ IPsec enabled
# □ Strong IPsec Secret configured
# □ PPP Profile assigned
# □ Firewall rules applied
# □ NAT rules verified
# □ DNS configured
# □ Routing verified
# □ Client connected successfully
# □ Internal resources reachable
#

###############################################################################
# Security Recommendations
###############################################################################

#
# • Use a strong IPsec Pre-Shared Key (PSK).
# • Create one VPN account per user.
# • Never share user credentials.
# • Disable inactive VPN accounts.
# • Restrict VPN access using firewall policies.
# • Keep RouterOS updated.
# • Monitor authentication failures.
# • Enable centralized logging where possible.
# • Backup the RouterOS configuration regularly.
#

###############################################################################
# Enterprise Authentication
###############################################################################

#
# This configuration uses the shared PPP profile.
#
# Enterprise deployments may integrate:
#
# - FreeRADIUS
# - Microsoft Active Directory
# - LDAP
# - PrivacyIDEA (MFA)
#
# See:
#
# mikrotik/radius/radius-example.rsc
#
# Companion Project:
#
# https://github.com/sarabelinformatika/privacyidea-freeradius-mikrotik-openvpn
#

###############################################################################
# Notes
###############################################################################

#
# This file configures only the L2TP/IPsec server.
#
# PPP Profile, IP Pool and user accounts are managed in:
#
# mikrotik/openvpn/ppp-profile.rsc
#
# Before deploying:
#
# - Verify firewall rules
# - Verify NAT configuration
# - Verify routing
# - Verify DNS configuration
# - Verify IPsec proposal compatibility
# - Test client connectivity
#

###############################################################################
# End of Configuration
###############################################################################


