###############################################################################
#
# Enterprise MikroTik VPN Guide
#
# File:
# mikrotik/base/services-hardening.rsc
#
# Purpose:
# RouterOS Management Service Hardening
#
# RouterOS:
# Version 7.x
#
###############################################################################

###############################################################################
# Disable Unused Services
###############################################################################

/ip service

set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes

###############################################################################
# Secure Management Services
###############################################################################

set ssh address=192.168.110.0/24 strong-crypto=yes

set winbox address=192.168.110.0/24

###############################################################################
# Disable MAC Services
###############################################################################

/tool mac-server

set allowed-interface-list=none

/tool mac-server mac-winbox

set allowed-interface-list=MGMT

###############################################################################
# Disable Neighbor Discovery on Untrusted Networks
###############################################################################

/ip neighbor discovery-settings

set discover-interface-list=MGMT

###############################################################################
# Disable Bandwidth Test Server
###############################################################################

/tool bandwidth-server

set enabled=no

###############################################################################
# Enable Login Notes
###############################################################################

/system note

set show-at-login=yes \
note="Authorized access only. All activity may be monitored and logged."

###############################################################################
# Time Zone
###############################################################################

/system clock

set time-zone-autodetect=yes

###############################################################################
# NTP Client
###############################################################################

/system ntp client

set enabled=yes

/system ntp client servers

add address=time.cloudflare.com
add address=time.google.com

###############################################################################
# DNS
###############################################################################

/ip dns

set allow-remote-requests=no

###############################################################################
# SMB
###############################################################################

/ip smb

set enabled=no

###############################################################################
# SOCKS Proxy
###############################################################################

/ip socks

set enabled=no

###############################################################################
# Proxy
###############################################################################

/ip proxy

set enabled=no

###############################################################################
# UPnP
###############################################################################

/ip upnp

set enabled=no

###############################################################################
# ROMON
###############################################################################

/tool romon

set enabled=no

###############################################################################
# IPv6
#
# Disable IPv6 if not actively used.
###############################################################################

/ipv6 settings

set disable-ipv6=yes

###############################################################################
# Documentation
###############################################################################

# Security Recommendations
#
# - Disable unused management services.
# - Restrict WinBox access to management networks.
# - Restrict SSH access to trusted administrators.
# - Disable Layer 2 discovery on untrusted interfaces.
# - Keep RouterOS updated.
# - Enable Multi-Factor Authentication where applicable.
# - Review user accounts regularly.
# - Backup configuration after every significant change.
#
###############################################################################
