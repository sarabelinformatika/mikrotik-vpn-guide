###############################################################################
# RADIUS Server
###############################################################################

/radius

add \
    service=ppp \
    address=192.168.110.30 \
    secret=ChangeThisSharedSecret! \
    protocol=udp \
    authentication-port=1812 \
    accounting-port=1813 \
    timeout=300ms \
    comment="Primary RADIUS Server"

###############################################################################
# PPP AAA
###############################################################################

/ppp aaa

set \
    use-radius=yes \
    accounting=yes \
    interim-update=5m

###############################################################################
# Incoming
###############################################################################

/radius incoming

set \
    accept=yes \
    port=3799

###############################################################################
# Network Design
###############################################################################

#
# MikroTik Router
#
# 192.168.110.1
#
# RADIUS Server
#
# 192.168.110.30
#
# Shared Secret
#
# ChangeThisSharedSecret!
#
###############################################################################

###############################################################################
# Authentication Flow
###############################################################################

#
# VPN Client
#      │
#      ▼
# MikroTik RouterOS
#      │
#      ▼
# RADIUS Server
#      │
#      ▼
# Active Directory / PrivacyIDEA / LDAP
#
###############################################################################

###############################################################################
# Supported Authentication Backends
###############################################################################

#
# This configuration is compatible with:
#
# - FreeRADIUS
# - Windows Network Policy Server (NPS)
# - Microsoft Active Directory
# - LDAP
# - PrivacyIDEA (MFA)
#

###############################################################################
# Deployment Checklist
###############################################################################

#
# □ RADIUS server reachable
# □ Shared Secret matches on both systems
# □ PPP AAA configured to use RADIUS
# □ Firewall allows UDP 1812/1813
# □ User authentication verified
# □ Accounting verified
# □ Logging enabled
# □ Backup completed
#

###############################################################################
# Security Recommendations
###############################################################################

#
# • Use a long, randomly generated Shared Secret.
# • Restrict access to trusted RADIUS servers only.
# • Protect RADIUS traffic with network segmentation.
# • Enable accounting for auditing purposes.
# • Monitor authentication failures.
# • Remove obsolete RADIUS servers.
# • Keep RouterOS and RADIUS software updated.
# • Use Multi-Factor Authentication whenever possible.
#

###############################################################################
# Integration Examples
###############################################################################

#
# Example Integrations
#
# MikroTik
#      │
#      ├── FreeRADIUS
#      │        │
#      │        └── Active Directory
#      │
#      ├── Windows NPS
#      │        │
#      │        └── Active Directory
#      │
#      └── PrivacyIDEA
#               │
#               └── FreeRADIUS
#

###############################################################################
# Notes
###############################################################################

#
# This file configures only the RouterOS RADIUS client.
#
# User management, authentication policies and
# Multi-Factor Authentication are handled by the
# external RADIUS infrastructure.
#
# Companion Project:
#
# https://github.com/sarabelinformatika/privacyidea-freeradius-mikrotik-openvpn
#
# Review:
#
# - Shared Secret
# - Firewall Rules
# - Routing
# - DNS
#
# before deploying into production.
#

###############################################################################
# End of Configuration
###############################################################################
