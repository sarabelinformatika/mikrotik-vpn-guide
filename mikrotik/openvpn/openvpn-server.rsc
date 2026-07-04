###############################################################################
# PPP Profile
###############################################################################

/ppp profile

add \
    name=ovpn-profile \
    local-address=192.168.120.1 \
    remote-address=ovpn-pool \
    dns-server=192.168.110.10 \
    use-encryption=required \
    only-one=yes \
    change-tcp-mss=yes \
    comment="OpenVPN Users"

###############################################################################
# IP Pool
###############################################################################

/ip pool

add \
    name=ovpn-pool \
    ranges=192.168.120.100-192.168.120.199

###############################################################################
# OpenVPN Server
###############################################################################

/interface ovpn-server server

set \
    enabled=yes \
    port=1194 \
    mode=ip \
    protocol=tcp \
    auth=sha256 \
    cipher=aes256-gcm \
    certificate=server-cert \
    require-client-certificate=yes \
    default-profile=ovpn-profile \
    tls-version=only-1.2

###############################################################################
# Example User
###############################################################################

/ppp secret

add \
    name=vpnuser \
    password=ChangeThisPassword! \
    service=ovpn \
    profile=ovpn-profile \
    comment="Example VPN User"

###############################################################################
# Static Route Example
###############################################################################

#
# Example:
#
# Route traffic to a remote site through an OpenVPN client.
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
# DNS Recommendations
###############################################################################

#
# Recommended Internal DNS
#
# Primary DNS:
# 192.168.110.10
#
# Secondary DNS:
# 192.168.110.11
#
# Public DNS should only be used if internal name resolution
# is not required.
#

###############################################################################
# Authentication Recommendations
###############################################################################

#
# Local PPP users
#
# Suitable for:
#
# - Small businesses
# - Test environments
# - Standalone deployments
#
# RADIUS authentication
#
# Recommended for:
#
# - Medium and large environments
# - Active Directory integration
# - Centralized user management
# - Multi-Factor Authentication
#

###############################################################################
# Client Compatibility
###############################################################################

#
# Recommended Client:
#
# OpenVPN Connect
#
# Supported Platforms:
#
# - Windows
# - macOS
# - Linux
# - Android
# - iOS
#
# Ensure that the client supports:
#
# - TLS 1.2+
# - AES-256-GCM
# - SHA-256
#

###############################################################################
# Network Design
###############################################################################

#
# LAN
#
# 192.168.110.0/24
#
# OpenVPN
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
# Split Tunnel Example
###############################################################################

#
# Push only internal routes to clients.
#
# Example:
#
# 192.168.110.0/24
#
# Internet traffic remains local.
#
###############################################################################
# Full Tunnel Example
###############################################################################

#
# Route all client traffic through the VPN.
#
# Requires:
#
# - Source NAT
# - Firewall rules
# - Internet access via MikroTik
#
###############################################################################

###############################################################################
# Deployment Checklist
###############################################################################

#
# □ Server certificate installed
# □ CA certificate installed
# □ Server certificate trusted
# □ OpenVPN Server enabled
# □ PPP Profile assigned
# □ IP Pool configured
# □ Firewall rules applied
# □ NAT rules verified
# □ DNS configured
# □ Routing verified
# □ Test client connected
# □ Internal resources reachable
#

###############################################################################
# Security Recommendations
###############################################################################

#
# • Use individual user accounts.
# • Never share VPN credentials.
# • Use strong passwords.
# • Require client certificates.
# • Keep RouterOS updated.
# • Restrict VPN access using firewall rules.
# • Review inactive users regularly.
# • Enable centralized logging.
# • Monitor authentication failures.
#

###############################################################################
# Enterprise Authentication
###############################################################################

#
# This reference configuration uses local PPP authentication.
#
# Enterprise deployments may integrate:
#
# - FreeRADIUS
# - PrivacyIDEA
# - Active Directory
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
# This file is intended as a secure baseline for RouterOS 7.x.
#
# Review:
#
# - Certificates
# - Firewall
# - NAT
# - Routing
# - DNS
#
# before deploying into production.
#

###############################################################################
# End of Configuration
###############################################################################
