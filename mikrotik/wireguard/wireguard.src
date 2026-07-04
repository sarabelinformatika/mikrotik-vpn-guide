# WireGuard Deployment Guide

> Complete deployment guide for implementing secure WireGuard VPN services on MikroTik RouterOS 7.x.

---

# Overview

WireGuard is a modern Virtual Private Network (VPN) protocol designed to provide high performance, strong cryptography and simplified configuration.

Unlike traditional VPN technologies, WireGuard was built with simplicity in mind. Its compact codebase, modern encryption algorithms and efficient packet handling make it one of the fastest VPN solutions available today.

For most new MikroTik deployments, WireGuard should be considered the preferred VPN protocol unless specific business requirements dictate otherwise.

---

# Why WireGuard?

WireGuard was created to solve many of the limitations found in older VPN technologies.

Compared to traditional VPN protocols, it offers:

- Smaller and easier-to-audit codebase
- Modern cryptographic primitives
- Lower CPU utilization
- Faster connection establishment
- Excellent roaming capabilities
- High throughput
- Minimal configuration requirements
- Native support in MikroTik RouterOS 7.x

These characteristics make WireGuard particularly suitable for both small businesses and enterprise environments.

---

# Typical Use Cases

WireGuard can be deployed in a variety of scenarios.

Common examples include:

- Remote employee access
- Site-to-site connectivity
- Branch office interconnection
- Home office access
- Administrator remote management
- Secure access to virtualization platforms
- Secure access to NAS devices
- Hybrid cloud connectivity

---

# Reference Lab Environment

All examples presented in this document are based on the reference environment defined for this repository.

| Component | Value |
|-----------|-------|
| RouterOS Version | 7.x |
| WAN Interface | ether1 |
| LAN Network | 192.168.110.0/24 |
| Router LAN Address | 192.168.110.1 |
| WireGuard Network | 192.168.120.0/24 |
| WireGuard Gateway | 192.168.120.1 |
| WireGuard Port | UDP 51820 |

Using a consistent reference environment ensures that every example in this repository follows the same network design.

---

# WireGuard Architecture

```text
                    Internet
                        │
                        ▼
              Remote WireGuard Client
                        │
             Encrypted UDP Tunnel
                        │
                        ▼
             MikroTik RouterOS 7.x
                        │
                        ▼
                 Internal Firewall
                        │
                        ▼
               Corporate LAN Network
```

WireGuard establishes encrypted peer-to-peer tunnels.

Unlike traditional VPN protocols, there is no distinction between "server" and "client" from a protocol perspective. Every participant is considered a peer. On MikroTik RouterOS, however, one router typically acts as the central VPN gateway while remote devices connect as peers.

---

# Cryptography

WireGuard intentionally supports only modern cryptographic algorithms.

The protocol uses:

- Curve25519 for key exchange
- ChaCha20 for encryption
- Poly1305 for message authentication
- BLAKE2s for hashing
- SipHash24 for hash table keys
- HKDF for key derivation

By avoiding legacy algorithms, WireGuard reduces configuration complexity while maintaining a high level of security.

---

# Advantages

WireGuard provides several operational advantages over older VPN technologies.

### Performance

WireGuard has very low protocol overhead, resulting in excellent throughput and reduced CPU utilization.

### Simplicity

A typical WireGuard deployment requires significantly fewer configuration parameters than traditional VPN protocols.

### Reliability

WireGuard maintains stable connections even when clients change their public IP address, making it particularly suitable for laptops and mobile devices.

### Security

The protocol is designed around a minimal attack surface and modern cryptographic standards.

---

# Limitations

Although WireGuard is the recommended VPN protocol for most deployments, administrators should be aware of several limitations.

- Native certificate-based authentication is not supported.
- User authentication is based on public/private key pairs.
- Individual peer management becomes more complex in very large deployments.
- Dynamic user databases require additional management processes.

For environments requiring username/password authentication or enterprise MFA, OpenVPN combined with RADIUS and PrivacyIDEA may be a more suitable solution.

---

# Deployment Planning

Before configuring WireGuard, define:

- VPN addressing scheme
- Allowed IP ranges
- Routing strategy
- DNS configuration
- Firewall policy
- Internet access requirements
- Management access policy
- Monitoring requirements

Proper planning significantly reduces deployment time and troubleshooting effort.

---

# Interface Design

WireGuard introduces a different design philosophy compared to traditional VPN technologies.

Instead of relying on usernames, passwords or certificates, each device participating in the VPN has its own cryptographic identity based on a public and private key pair.

A typical deployment consists of:

- One WireGuard interface on the MikroTik router
- One peer definition for every remote device
- One VPN subnet
- Firewall rules allowing WireGuard traffic
- Routing entries for remote networks (if required)

This architecture provides excellent scalability while maintaining a very small configuration footprint.

---

# Addressing Strategy

A dedicated subnet should always be reserved for VPN clients.

Avoid assigning addresses from the production LAN.

The reference environment used throughout this repository follows this addressing scheme.

| Network | Purpose |
|---------|----------|
| 192.168.110.0/24 | Internal LAN |
| 192.168.120.0/24 | WireGuard VPN |
| 192.168.120.1 | MikroTik WireGuard Interface |
| 192.168.120.2-254 | VPN Clients |

Separating VPN traffic from the production LAN simplifies routing, firewall policies and troubleshooting.

---

# Key Management

Every WireGuard peer owns:

- One private key
- One public key

The private key must never leave the device on which it was generated.

Only the corresponding public key should be exchanged between peers.

Recommended practices include:

- Generate a unique key pair for every client.
- Never reuse private keys.
- Replace compromised keys immediately.
- Remove unused peers.
- Document peer ownership.

Proper key management is one of the most important aspects of maintaining a secure WireGuard deployment.

---

# Routing Design

WireGuard itself does not automatically determine which traffic should traverse the VPN tunnel.

Routing decisions are controlled through the **Allowed Address** configuration assigned to each peer.

Typical deployment models include:

## Full Tunnel

All client traffic is routed through the VPN.

Suitable for:

- Remote workers
- Public Wi-Fi
- Secure Internet access
- Compliance requirements

Advantages:

- Maximum security
- Centralized filtering
- Consistent Internet breakout

---

## Split Tunnel

Only traffic destined for internal networks passes through the VPN.

Suitable for:

- Home office users
- Branch offices
- Reduced bandwidth usage
- Performance optimization

Advantages:

- Lower latency
- Reduced Internet bandwidth consumption
- Better scalability

For most business environments, Split Tunnel is the recommended deployment model.

---

# DNS Recommendations

Incorrect DNS configuration is one of the most common causes of VPN-related support incidents.

Recommended options include:

- Internal Active Directory DNS
- MikroTik DNS Cache
- Dedicated internal DNS servers

Avoid using public DNS servers when internal resources rely on private DNS zones.

VPN clients should resolve internal hostnames exactly as local users do.

---

# MTU Considerations

WireGuard performs well using default settings in most environments.

However, environments involving:

- PPPoE
- MPLS
- Nested VPNs
- Cloud providers
- Mobile networks

may require MTU tuning.

Symptoms of MTU issues include:

- Slow file transfers
- Hanging HTTPS sessions
- Intermittent connectivity
- Packet fragmentation

Always validate MTU settings before deploying into production.

---

# Roaming Support

One of WireGuard's major advantages is seamless roaming.

Clients can:

- Switch between Wi-Fi and mobile data.
- Move between public IP addresses.
- Resume connectivity without renegotiating complex VPN sessions.

This makes WireGuard particularly suitable for:

- Laptops
- Smartphones
- Tablets
- Field engineers
- Remote employees

Connection recovery is typically much faster than with legacy VPN protocols.

---

# Mobile Device Support

WireGuard provides official applications for:

- Windows
- macOS
- Linux
- Android
- iOS

Configuration can be distributed through:

- QR Codes
- Configuration files
- Mobile Device Management (MDM)
- Enterprise deployment platforms

This simplifies onboarding while reducing configuration errors.

---

---

# Firewall Considerations

A secure VPN deployment begins with a properly configured firewall.

Exposing a VPN service directly to the Internet without appropriate filtering significantly increases the attack surface.

For WireGuard deployments, consider the following recommendations:

- Allow only the required UDP port.
- Drop invalid connections.
- Restrict management access.
- Log suspicious connection attempts.
- Maintain a default deny policy.
- Review firewall rules regularly.
- Remove obsolete rules.

The reference firewall configuration provided in this repository follows these principles.

---

# Network Segmentation

VPN users should never receive unrestricted access to every internal network.

Instead, access should be granted according to business requirements.

Example:

```text
Internet
     │
     ▼
WireGuard VPN
     │
     ▼
VPN Network
192.168.120.0/24
     │
     ▼
Firewall Policies
     │
     ├───────────────┐
     ▼               ▼
Server VLAN      User VLAN
```

Benefits include:

- Reduced attack surface
- Better traffic control
- Easier auditing
- Improved compliance
- Simplified troubleshooting

Network segmentation should be considered a standard practice rather than an optional enhancement.

---

# Remote Access Deployment

WireGuard is particularly effective for remote access scenarios.

Typical users include:

- Employees working from home
- IT administrators
- External consultants
- Field engineers
- Mobile workers

A recommended deployment includes:

- Dedicated VPN subnet
- Strong firewall policies
- Least privilege access
- Secure DNS
- Continuous monitoring

Remote users should only be granted access to resources required for their role.

---

# Site-to-Site Deployment

WireGuard is also well suited for connecting multiple locations.

Example:

```text
Headquarters
192.168.110.0/24
        │
        │
Encrypted WireGuard Tunnel
        │
        ▼
Branch Office
192.168.210.0/24
```

Typical use cases:

- Branch offices
- Warehouses
- Retail stores
- Remote production sites
- Disaster recovery locations

Permanent site-to-site tunnels eliminate the need for repeated user authentication while providing secure communication between locations.

---

# Monitoring

Every production VPN deployment should be monitored.

Recommended metrics include:

- Active peers
- Tunnel availability
- Interface traffic
- CPU utilization
- Memory utilization
- Packet drops
- Firewall drops
- Connection errors

Monitoring solutions such as Zabbix can proactively detect problems before users report connectivity issues.

---

# Logging

Enable sufficient logging to diagnose authentication and connectivity problems.

Recommended log categories include:

- WireGuard events
- Firewall events
- Routing changes
- Interface status
- System events

Avoid excessive logging in high-throughput environments, as it may impact performance and consume storage unnecessarily.

---

# Backup Strategy

Configuration backups should be performed regularly.

Recommended backup types include:

- Binary RouterOS Backup
- Exported RouterOS Configuration
- Off-site Backup
- Version-controlled documentation

Backups should be encrypted and tested periodically to ensure successful restoration.

---

# Security Best Practices

For production deployments always:

- Keep RouterOS updated.
- Disable unused services.
- Restrict WinBox access.
- Restrict SSH access.
- Use strong administrator passwords.
- Protect private WireGuard keys.
- Remove inactive peers.
- Review firewall policies regularly.
- Backup RouterOS configurations.
- Monitor VPN activity continuously.

WireGuard itself provides strong cryptographic protection, but overall security depends on the complete infrastructure surrounding the VPN service.

---

# Validation Checklist

Before placing the VPN into production, verify the following:

- RouterOS updated
- WireGuard interface operational
- VPN subnet configured
- Firewall rules validated
- NAT rules reviewed
- Routing verified
- DNS functioning correctly
- Client connectivity tested
- Internal resource access verified
- Internet access verified (if required)
- Monitoring enabled
- Backup completed

Successful completion of this checklist significantly reduces deployment risks.

---

# Reference Configuration

The complete RouterOS reference configuration described throughout this guide is provided in:

```text
mikrotik/wireguard.rsc
```

The configuration includes:

- WireGuard interface
- Peer examples
- IP addressing
- Firewall rules
- NAT configuration
- Routing recommendations
- Security comments

Review and adapt the configuration before importing it into a production environment.

---

# Next Steps

After completing the WireGuard deployment, continue with:

- openvpn.md
- l2tp-ipsec.md
- firewall.md
- routing.md
- security.md
- troubleshooting.md

These documents build upon the same reference architecture used throughout this repository.
