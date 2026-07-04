###############################################################################
# WireGuard Server
###############################################################################

/interface wireguard

add \
    name=wireguard1 \
    listen-port=51820 \
    mtu=1420 \
    private-key="<SERVER_PRIVATE_KEY>" \
    comment="WireGuard VPN Server"

###############################################################################
# IP Address
###############################################################################

/ip address

add \
    address=192.168.120.1/24 \
    interface=wireguard1 \
    comment="WireGuard Gateway"

###############################################################################
# Example Peer
###############################################################################

/interface wireguard peers

add \
    interface=wireguard1 \
    public-key="<CLIENT_PUBLIC_KEY>" \
    allowed-address=192.168.120.10/32 \
    persistent-keepalive=25s \
    comment="Remote Laptop"

###############################################################################
# Additional Peer Examples
###############################################################################

# Office Workstation
#
# add \
#     interface=wireguard1 \
#     public-key="<CLIENT_PUBLIC_KEY>" \
#     allowed-address=192.168.120.11/32 \
#     persistent-keepalive=25s \
#     comment="Office Workstation"

# Mobile Device
#
# add \
#     interface=wireguard1 \
#     public-key="<CLIENT_PUBLIC_KEY>" \
#     allowed-address=192.168.120.12/32 \
#     persistent-keepalive=25s \
#     comment="Mobile Device"

###############################################################################
# Site-to-Site Example
###############################################################################

# Example:
#
# Local LAN:
# 192.168.110.0/24
#
# Remote LAN:
# 192.168.210.0/24
#
# Remote WireGuard IP:
# 192.168.120.2
#
# Uncomment and modify before use.
#

# /interface wireguard peers
#
# add \
#     interface=wireguard1 \
#     public-key="<REMOTE_SITE_PUBLIC_KEY>" \
#     allowed-address=192.168.210.0/24,192.168.120.2/32 \
#     persistent-keepalive=25s \
#     comment="Branch Office"

###############################################################################
# Optional Static Route
###############################################################################

# /ip route
#
# add \
#     dst-address=192.168.210.0/24 \
#     gateway=192.168.120.2 \
#     comment="Branch Office Route"

###############################################################################
# Client Configuration Reference
###############################################################################

#
# Example Client Settings
#
# Interface Address:
# 192.168.120.10/24
#
# DNS Server:
# 192.168.110.10
#
# Endpoint:
# vpn.example.com:51820
#
# Allowed IPs (Split Tunnel):
# 192.168.110.0/24
#
# Allowed IPs (Full Tunnel):
# 0.0.0.0/0
#
# Persistent Keepalive:
# 25
#

###############################################################################
# Deployment Checklist
###############################################################################

#
# □ Generate a unique key pair for every client.
# □ Never reuse private keys.
# □ Assign one VPN IP address per device.
# □ Verify firewall rules.
# □ Verify NAT configuration.
# □ Verify routing.
# □ Verify DNS resolution.
# □ Test LAN connectivity.
# □ Test Internet connectivity (if Full Tunnel is used).
# □ Backup the RouterOS configuration after deployment.
#

###############################################################################
# Security Recommendations
###############################################################################

#
# • Use one peer per device.
# • Remove inactive peers immediately.
# • Restrict Allowed Address to the minimum required.
# • Protect private keys.
# • Keep RouterOS updated.
# • Review peer configuration periodically.
# • Monitor VPN activity.
# • Restrict management access using firewall rules.
#

###############################################################################
# End of Configuration
###############################################################################

