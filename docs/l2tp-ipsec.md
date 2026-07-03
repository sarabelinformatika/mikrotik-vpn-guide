# L2TP/IPsec Deployment Guide

> Complete deployment guide for implementing secure L2TP/IPsec VPN services on MikroTik RouterOS 7.x.

---

# Overview

Layer 2 Tunneling Protocol (L2TP) combined with IPsec has been one of the most widely deployed remote access VPN technologies for many years.

Although newer VPN protocols such as WireGuard offer improved performance and simplified configuration, L2TP/IPsec remains relevant due to its broad operating system support and native client availability.

This guide explains how to deploy L2TP/IPsec securely on MikroTik RouterOS while following modern security best practices.

---

# Why L2TP/IPsec?

L2TP by itself does not provide encryption.

To secure VPN traffic, it is almost always combined with IPsec, which provides:

- Encryption
- Authentication
- Integrity verification
- Replay protection

The combination creates a secure VPN tunnel suitable for remote access and legacy compatibility.

---

# Typical Use Cases

L2TP/IPsec is commonly deployed for:

- Legacy operating systems
- Built-in Windows VPN client
- Built-in macOS VPN client
- Built-in Android VPN client
- Built-in iOS VPN client
- Small business environments
- Temporary remote access
- Compatibility-focused deployments

Although L2TP/IPsec remains functional, new deployments should evaluate WireGuard or OpenVPN before selecting L2TP/IPsec.

---

# Reference Lab Environment

All examples in this document follow the repository reference environment.

| Component | Value |
|-----------|-------|
| RouterOS Version | 7.x |
| WAN Interface | ether1 |
| LAN Network | 192.168.110.0/24 |
| Router LAN Address | 192.168.110.1 |
| VPN Network | 192.168.120.0/24 |
| VPN Gateway | 192.168.120.1 |
| IPsec Ports | UDP 500, 1701, 4500 |

Using a consistent addressing scheme ensures that every example in this repository remains easy to understand and reproduce.

---

# L2TP/IPsec Architecture

```text
                  Internet
                      │
                      ▼
               Remote Client
                      │
             IPsec Encrypted Tunnel
                      │
                      ▼
             MikroTik RouterOS
                      │
                      ▼
               PPP Profile
                      │
                      ▼
             Internal Firewall
                      │
                      ▼
              Corporate LAN
```

L2TP establishes the tunnel while IPsec protects the communication using strong cryptographic algorithms.

---

# How L2TP/IPsec Works

A typical connection follows these stages:

1. Client contacts the MikroTik VPN gateway.
2. IPsec negotiation begins.
3. Secure encryption parameters are established.
4. L2TP tunnel is created.
5. User authentication is performed.
6. PPP profile is assigned.
7. Internal routing becomes available.

Successful completion of these stages establishes a secure VPN connection.

---

# Authentication

Typical authentication methods include:

- Username and Password
- Certificate Authentication
- RADIUS Authentication

Enterprise deployments should avoid weak passwords and shared credentials.

Where possible, centralized authentication should be preferred.

---

# PPP Profiles

As with OpenVPN, L2TP/IPsec relies on PPP Profiles to define connection parameters.

Typical profile settings include:

- Local Address
- Remote Address
- DNS Servers
- Address Pool
- Session Limits
- Routing Parameters

Different PPP Profiles may be created for administrators, employees and contractors.

---

# Address Planning

VPN clients should always receive addresses from a dedicated VPN subnet.

Reference design:

| Network | Purpose |
|---------|----------|
| 192.168.110.0/24 | Internal LAN |
| 192.168.120.0/24 | VPN Clients |

Using separate subnets simplifies:

- Firewall policies
- Route management
- Monitoring
- Troubleshooting
- Future expansion

---

# Advantages

L2TP/IPsec continues to provide several practical benefits.

Advantages include:

- Native operating system support
- No additional VPN software required
- Mature implementation
- Broad compatibility
- Straightforward deployment

These characteristics make it attractive for organizations supporting a wide variety of client devices.

---

# Limitations

Administrators should also understand its limitations.

Compared with WireGuard:

- Higher protocol overhead
- Lower throughput
- More complex negotiation
- Greater CPU utilization

Compared with OpenVPN:

- Less flexible authentication
- Reduced integration options
- Fewer enterprise features

Because of these limitations, L2TP/IPsec is generally recommended only where compatibility requirements outweigh performance considerations.

---

# IPsec Security Associations

IPsec is responsible for providing encryption and integrity protection for the VPN tunnel.

A successful connection establishes one or more Security Associations (SAs) between the VPN client and the MikroTik router.

These Security Associations define:

- Encryption algorithms
- Integrity algorithms
- Key lifetime
- Security parameters
- Authentication method

The establishment of Security Associations is completely transparent to the end user but is critical to the security of the VPN connection.

---

# NAT Traversal (NAT-T)

Many VPN clients operate behind routers performing Network Address Translation (NAT).

To maintain compatibility with these environments, IPsec supports NAT Traversal (NAT-T).

NAT-T encapsulates IPsec traffic into UDP packets, allowing encrypted communication through NAT devices without requiring special routing configurations.

In most modern deployments NAT-T should remain enabled.

---

# Firewall Requirements

A secure firewall configuration is essential for every L2TP/IPsec deployment.

At minimum, allow only the required VPN traffic.

Typical services include:

| Protocol | Port | Purpose |
|----------|------|---------|
| UDP | 500 | IKE |
| UDP | 1701 | L2TP |
| UDP | 4500 | NAT Traversal |
| ESP | IP Protocol 50 | Encrypted IPsec Traffic |

All other unnecessary inbound services should remain blocked.

---

# Routing Considerations

Routing should always be planned before enabling VPN access.

Typical deployment models include:

## Full Tunnel

All traffic from VPN clients passes through the MikroTik gateway.

Recommended when:

- Company security policies require centralized Internet access.
- Users frequently connect from untrusted networks.
- Internet traffic should be filtered by the corporate firewall.

---

## Split Tunnel

Only traffic destined for internal networks traverses the VPN tunnel.

Recommended when:

- Internet bandwidth should be conserved.
- Remote users primarily require access to internal resources.
- Lower latency is preferred.

Split Tunnel is the most common deployment model for business environments.

---

# Mobile Device Support

One advantage of L2TP/IPsec is broad native client availability.

Supported operating systems include:

- Microsoft Windows
- macOS
- Android
- iOS

Because no additional VPN software is generally required, deployment is often straightforward for end users.

Administrators should nevertheless provide documented connection instructions and standardized configuration parameters.

---

# Site-to-Site Considerations

Although L2TP/IPsec can be used for connecting remote offices, it is generally not the preferred solution for permanent site-to-site VPN deployments.

Modern alternatives such as WireGuard typically provide:

- Better throughput
- Simpler configuration
- Faster tunnel establishment
- Lower CPU utilization

L2TP/IPsec should primarily be considered for remote access or environments requiring legacy compatibility.

---

# DNS Configuration

VPN clients should resolve internal resources exactly as users located inside the corporate network.

Recommended DNS options include:

- Internal Active Directory DNS
- MikroTik DNS Cache
- Dedicated internal DNS servers

Avoid public DNS servers for environments relying on internal DNS zones.

Incorrect DNS configuration is one of the most common causes of VPN support incidents.

---

# Monitoring

Continuous monitoring improves both security and operational reliability.

Recommended metrics include:

- Active VPN sessions
- Failed authentication attempts
- CPU utilization
- Memory usage
- Interface traffic
- IPsec Security Associations
- Firewall events
- VPN uptime

Monitoring platforms such as Zabbix can proactively detect failures before users experience service interruptions.

---

# Logging

Logging should provide sufficient detail for troubleshooting while avoiding excessive log generation.

Recommended categories include:

- Authentication events
- IPsec negotiation
- Tunnel establishment
- Tunnel termination
- Firewall events
- System events

Logs should be retained according to organizational security and compliance requirements.

---

# Backup Strategy

Configuration backups should be performed before and after significant changes.

Recommended backup components include:

- RouterOS Binary Backup
- RouterOS Export
- PPP Profiles
- Firewall Configuration
- IPsec Configuration
- Documentation

Backups should be stored securely and tested periodically to ensure successful recovery.


---

# Security Best Practices

Although L2TP/IPsec remains a secure solution when properly configured, its overall security depends on the surrounding infrastructure.

For production environments always:

- Keep RouterOS updated.
- Disable unused RouterOS services.
- Restrict management access.
- Use strong administrator passwords.
- Assign individual VPN accounts.
- Remove inactive users.
- Review firewall policies regularly.
- Backup RouterOS configurations.
- Monitor authentication activity.
- Document all configuration changes.

Security should be treated as a continuous operational process rather than a one-time deployment task.

---

# Enterprise Deployment Recommendations

L2TP/IPsec should be deployed according to the organization's operational and security requirements.

Recommended practices include:

- Dedicated VPN subnet
- Centralized authentication
- Network segmentation
- Least privilege access
- Continuous monitoring
- Regular configuration reviews
- Standardized client configuration
- Configuration backups
- Change management procedures

For new deployments, organizations should evaluate WireGuard or OpenVPN before selecting L2TP/IPsec.

---

# Common Deployment Mistakes

Many L2TP/IPsec connectivity problems originate from simple configuration errors.

Common issues include:

- Incorrect pre-shared keys
- Incorrect PPP Profile configuration
- Missing firewall rules
- Incorrect NAT configuration
- DNS misconfiguration
- Overlapping IP address ranges
- Disabled IPsec policies
- Incorrect routing

Systematically verifying each component significantly reduces troubleshooting time.

---

# Validation Checklist

Before allowing production users to connect, verify the following:

- RouterOS updated
- L2TP Server enabled
- IPsec enabled
- Pre-Shared Key configured
- PPP Profile configured
- VPN Address Pool configured
- Firewall rules validated
- NAT configuration reviewed
- Routing verified
- DNS functioning correctly
- Client authentication tested
- Internal resource access verified
- Monitoring enabled
- Backup completed

All validation steps should be completed successfully before production rollout.

---

# Reference Configuration

The complete RouterOS reference configuration described throughout this guide is available in:

```text
mikrotik/l2tp-ipsec.rsc
```

The reference configuration includes:

- L2TP Server configuration
- IPsec configuration
- PPP Profile example
- VPN Address Pool
- Firewall rules
- NAT configuration
- Routing recommendations
- Security comments

The configuration is intended as a reference implementation and should always be reviewed and adapted before deployment in a production environment.

---

# Choosing the Right VPN Protocol

Selecting the appropriate VPN protocol depends on business requirements.

General recommendations:

| Scenario | Recommended Protocol |
|----------|----------------------|
| New Deployments | WireGuard |
| Enterprise Authentication | OpenVPN |
| Legacy Compatibility | L2TP/IPsec |
| Site-to-Site VPN | WireGuard |
| Remote Workers | WireGuard or OpenVPN |
| MFA Integration | OpenVPN |

No single VPN protocol is ideal for every environment.

Administrators should evaluate:

- Security requirements
- Client compatibility
- Performance expectations
- Authentication requirements
- Operational complexity
- Long-term maintainability

before making a deployment decision.

---

# Related Documentation

For additional guidance, continue with:

- firewall.md
- routing.md
- security.md
- troubleshooting.md
- faq.md
- vpn-protocol-comparison.md

Each document builds upon the same reference architecture used throughout this repository.

---

# Related Project

Organizations that require enterprise-grade Multi-Factor Authentication (MFA) for OpenVPN deployments should also review the companion project:

**PrivacyIDEA + FreeRADIUS + MikroTik OpenVPN**

https://github.com/sarabelinformatika/privacyidea-freeradius-mikrotik-openvpn

The project provides:

- Complete Docker Compose deployment
- PrivacyIDEA integration
- FreeRADIUS integration
- MikroTik OpenVPN configuration
- Enterprise MFA documentation
- Production-ready reference architecture

---

# Summary

L2TP/IPsec remains a practical VPN solution for environments requiring broad operating system compatibility and native client support.

However, for most new deployments, WireGuard provides better performance and simpler administration, while OpenVPN offers greater flexibility for enterprise authentication and certificate-based security.

Choosing the right protocol should always be based on technical requirements, operational needs and long-term maintainability rather than familiarity alone.
