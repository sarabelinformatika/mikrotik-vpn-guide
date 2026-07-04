###############################################################################
# SOURCE NAT
###############################################################################

/ip firewall nat

# Masquerade LAN traffic to the Internet
add chain=srcnat \
    action=masquerade \
    out-interface-list=WAN \
    src-address-list=LAN \
    comment="LAN -> Internet"

# Masquerade VPN clients to the Internet
# Required only if Full Tunnel VPN is used.
add chain=srcnat \
    action=masquerade \
    out-interface-list=WAN \
    src-address-list=VPN \
    comment="VPN -> Internet"

###############################################################################
# DESTINATION NAT
###############################################################################

#
# Example Port Forward
#
# Uncomment and modify as required.
#

# add chain=dstnat \
#     action=dst-nat \
#     protocol=tcp \
#     dst-port=443 \
#     in-interface-list=WAN \
#     to-addresses=192.168.110.20 \
#     to-ports=443 \
#     comment="HTTPS Server"

###############################################################################
# Hairpin NAT
###############################################################################

#
# Enable only if internal clients access services using
# the organization's public DNS name.
#

# add chain=srcnat \
#     action=masquerade \
#     src-address-list=LAN \
#     dst-address-list=Infrastructure \
#     comment="Hairpin NAT"

###############################################################################
# Documentation
###############################################################################

#
# Recommended NAT Strategy
#
# ✔ One masquerade rule for LAN
# ✔ One masquerade rule for VPN (Full Tunnel only)
# ✔ Keep destination NAT rules grouped together
# ✔ Enable Hairpin NAT only when required
#
# Avoid:
#
# ✘ Multiple duplicate masquerade rules
# ✘ NAT based on physical interfaces where Interface Lists can be used
# ✘ Unnecessary destination NAT entries
#
###############################################################################
