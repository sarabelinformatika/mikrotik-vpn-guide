###############################################################################
# INPUT CHAIN
###############################################################################

/ip firewall filter

# Allow established and related connections
add chain=input action=accept connection-state=established,related comment="Accept Established, Related"

# Drop invalid connections
add chain=input action=drop connection-state=invalid comment="Drop Invalid"

# Allow ICMP
add chain=input action=accept protocol=icmp comment="Allow ICMP"

# Allow management access from LAN
add chain=input action=accept in-interface-list=LAN src-address-list=Management comment="Allow Router Management"

# Allow WireGuard
add chain=input action=accept protocol=udp dst-port=51820 in-interface-list=WAN comment="Allow WireGuard"

# Allow OpenVPN
add chain=input action=accept protocol=tcp dst-port=1194 in-interface-list=WAN comment="Allow OpenVPN"

# Allow IKE
add chain=input action=accept protocol=udp dst-port=500 in-interface-list=WAN comment="Allow IPsec IKE"

# Allow NAT Traversal
add chain=input action=accept protocol=udp dst-port=4500 in-interface-list=WAN comment="Allow IPsec NAT-T"

# Allow L2TP
add chain=input action=accept protocol=udp dst-port=1701 in-interface-list=WAN comment="Allow L2TP"

# Allow ESP
add chain=input action=accept protocol=ipsec-esp in-interface-list=WAN comment="Allow IPsec ESP"

# Allow AH (optional)
add chain=input action=accept protocol=ipsec-ah in-interface-list=WAN comment="Allow IPsec AH"

# Drop everything else from WAN
add chain=input action=drop in-interface-list=WAN comment="Drop Everything Else"

###############################################################################
# FORWARD CHAIN
###############################################################################

# Accept established and related
add chain=forward action=accept connection-state=established,related comment="Accept Established, Related"

# Drop invalid
add chain=forward action=drop connection-state=invalid comment="Drop Invalid"

###############################################################################
# LAN → WAN
###############################################################################

add chain=forward action=accept in-interface-list=LAN out-interface-list=WAN comment="LAN -> Internet"

###############################################################################
# VPN → LAN
###############################################################################

add chain=forward action=accept src-address-list=VPN dst-address-list=LAN comment="VPN -> LAN"

###############################################################################
# LAN → VPN
###############################################################################

add chain=forward action=accept src-address-list=LAN dst-address-list=VPN comment="LAN -> VPN"

###############################################################################
# VPN → Infrastructure
###############################################################################

add chain=forward action=accept src-address-list=VPN dst-address-list=Infrastructure comment="VPN -> Infrastructure"

###############################################################################
# Infrastructure → VPN
###############################################################################

add chain=forward action=accept src-address-list=Infrastructure dst-address-list=VPN comment="Infrastructure -> VPN"

###############################################################################
# VPN → Internet (Optional Full Tunnel)
###############################################################################

add chain=forward action=accept src-address-list=VPN out-interface-list=WAN comment="VPN -> Internet"

###############################################################################
# Drop everything else
###############################################################################

add chain=forward action=drop comment="Drop Everything Else"
