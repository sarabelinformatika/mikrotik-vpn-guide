###############################################################################
#
# Enterprise MikroTik VPN Guide
#
# File:
# mikrotik/base/logging.rsc
#
# Purpose:
# Logging configuration for RouterOS 7.x
#
# RouterOS:
# Version 7.x
#
###############################################################################

###############################################################################
# Logging Actions
###############################################################################

/system logging action

add name=memory target=memory memory-lines=5000

###############################################################################
# General System Logging
###############################################################################

/system logging

add topics=critical action=memory
add topics=error action=memory
add topics=warning action=memory
add topics=info action=memory

###############################################################################
# Authentication
###############################################################################

add topics=account action=memory

###############################################################################
# Login Events
###############################################################################

add topics=system,info action=memory

###############################################################################
# Firewall
###############################################################################

add topics=firewall action=memory

###############################################################################
# WireGuard
###############################################################################

add topics=wireguard action=memory

###############################################################################
# IPsec
###############################################################################

add topics=ipsec action=memory

###############################################################################
# PPP
###############################################################################

add topics=ppp action=memory

###############################################################################
# OpenVPN
###############################################################################

add topics=ovpn action=memory

###############################################################################
# DHCP
###############################################################################

add topics=dhcp action=memory

###############################################################################
# DNS
###############################################################################

add topics=dns action=memory

###############################################################################
# Routing
###############################################################################

add topics=route action=memory

###############################################################################
# Interface Status
###############################################################################

add topics=interface action=memory

###############################################################################
# Script Execution
###############################################################################

add topics=script action=memory

###############################################################################
# Scheduler
###############################################################################

add topics=scheduler action=memory

###############################################################################
# Optional Remote Syslog
#
# Uncomment and modify if centralized logging is used.
###############################################################################

#/system logging action
#
#add name=remote target=remote \
#remote=192.168.110.30 \
#remote-port=514
#
#/system logging
#
#add topics=critical action=remote
#add topics=error action=remote
#add topics=warning action=remote
#add topics=account action=remote
#add topics=wireguard action=remote
#add topics=ipsec action=remote
#add topics=ovpn action=remote
#add topics=ppp action=remote
#add topics=firewall action=remote

###############################################################################
# Documentation
###############################################################################

# Recommended Event Categories
#
# ✔ Authentication
# ✔ Firewall
# ✔ WireGuard
# ✔ OpenVPN
# ✔ L2TP/IPsec
# ✔ Routing
# ✔ Interface Status
# ✔ DHCP
# ✔ DNS
# ✔ Scheduler
# ✔ Scripts
#
# Production Recommendation:
#
# Forward all critical logs to a centralized Syslog server
# (e.g. Graylog, Zabbix, Wazuh, Splunk or Syslog-NG)
# for long-term retention, correlation and security auditing.
#
###############################################################################
