###############################################################################
# IP Pool
###############################################################################

/ip pool

add \
    name=vpn-pool \
    ranges=192.168.120.100-192.168.120.199

###############################################################################
# PPP Profile
###############################################################################

/ppp profile

add \
    name=vpn-profile \
    local-address=192.168.120.1 \
    remote-address=vpn-pool \
    dns-server=192.168.110.10,192.168.110.11 \
    use-encryption=required \
    only-one=yes \
    change-tcp-mss=yes \
    use-compression=no \
    use-upnp=no \
    comment="Default VPN Profile"

###############################################################################
# Optional Static Route
###############################################################################

#
# Uncomment if VPN clients should automatically receive
# additional routes.
#

#/ppp profile
#
#set vpn-profile routes="192.168.110.0/24 192.168.120.1 1"

###############################################################################
# Example User
###############################################################################

/ppp secret

add \
    name=testuser \
    password=ChangeThisPassword! \
    service=ovpn \
    profile=vpn-profile \
    comment="Example OpenVPN User"

###############################################################################
# Additional Services
###############################################################################

#
# Supported services:
#
# service=ovpn
# service=l2tp
# service=pptp
# service=sstp
#
# Duplicate the PPP Secret if the same user should
# authenticate using a different VPN technology.
#

###############################################################################
# Deployment Checklist
###############################################################################

#
# □ IP Pool configured
# □ PPP Profile assigned
# □ DNS verified
# □ Firewall rules applied
# □ NAT verified
# □ Test user created
# □ Client authentication verified
#

###############################################################################
# Security Recommendations
###############################################################################

#
# • Create one account per user.
# • Remove inactive accounts.
# • Use strong passwords.
# • Consider RADIUS authentication for enterprise environments.
# • Combine with MFA whenever possible.
#

###############################################################################
# End of Configuration
###############################################################################
