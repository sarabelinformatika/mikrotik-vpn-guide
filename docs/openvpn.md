# OpenVPN Deployment Guide

> Complete deployment guide for implementing secure OpenVPN services on MikroTik RouterOS 7.x.

---

# Overview

OpenVPN is one of the most widely deployed Virtual Private Network (VPN) technologies in enterprise environments.

Its flexibility, certificate-based authentication and broad operating system support make it an excellent choice for organizations requiring secure remote access across multiple platforms.

Unlike WireGuard, OpenVPN supports Public Key Infrastructure (PKI), certificate authentication and advanced authentication methods such as RADIUS and Multi-Factor Authentication (MFA).

Although WireGuard is generally recommended for new VPN deployments, OpenVPN remains the preferred solution whenever advanced authentication or enterprise identity integration is required.

---

# Why OpenVPN?

OpenVPN has been the industry standard for secure remote access for more than two decades.

Its strengths include:

- Mature and stable protocol
- Certificate-based authentication
- Broad client compatibility
- Enterprise deployment support
- RADIUS authentication
- Active Directory integration
- Multi-Factor Authentication (MFA)
- Extensive documentation
- Cross-platform availability

OpenVPN is particularly well suited for organizations that already maintain a Public Key Infrastructure (PKI) or require centralized authentication.

---

# Typical Use Cases

OpenVPN is commonly deployed in the following scenarios:

- Remote employee access
- IT administrator access
- Managed Service Providers (MSPs)
- Third-party contractor access
- Secure administrative VPN
- Cross-platform remote access
- Multi-site enterprise environments

---

# Reference Lab Environment

All examples presented in this guide use the repository reference environment.

| Component | Value |
|-----------|-------|
| RouterOS Version | 7.x |
| WAN Interface | ether1 |
| LAN Network | 192.168.110.0/24 |
| Router LAN Address | 192.168.110.1 |
| OpenVPN Port | TCP 1194 |
| VPN Network | 192.168.120.0/24 |
| PPP Profile | vpn-profile |

Maintaining a consistent reference environment ensures that every document in this repository follows the same architecture.

---

# OpenVPN Architecture

```text
                 Internet
                     │
                     ▼
             OpenVPN Client
                     │
          TLS Encrypted Tunnel
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
             Corporate Network
```

The OpenVPN server terminates encrypted VPN tunnels, authenticates users and grants access according to the configured PPP profile and firewall policies.

---

# Authentication Methods

OpenVPN supports several authentication models.

Common deployment options include:

- Username and Password
- Certificate Authentication
- Username + Certificate
- RADIUS Authentication
- Active Directory Integration
- Multi-Factor Authentication (MFA)

Enterprise deployments should avoid password-only authentication whenever possible.

---

# Public Key Infrastructure (PKI)

Certificate-based authentication significantly improves VPN security.

A typical PKI deployment includes:

- Certificate Authority (CA)
- Server Certificate
- Client Certificate
- Certificate Revocation List (CRL)

Every client should receive an individual certificate.

Sharing certificates between users should never be permitted.

---

# Certificates

The minimum recommended certificate set consists of:

| Certificate | Purpose |
|------------|---------|
| CA Certificate | Trust Anchor |
| Server Certificate | VPN Server Identity |
| Client Certificate | User Authentication |

Private keys should always remain confidential and securely stored.

Compromised certificates should be revoked immediately.

---

# Why Certificates Matter

Passwords can be guessed, reused or stolen.

Certificates provide:

- Device authentication
- Strong cryptographic identity
- Protection against credential theft
- Better auditing
- Simplified certificate revocation

Certificate-based authentication should be considered the baseline for production OpenVPN deployments.


---

# PPP Profiles

On MikroTik RouterOS, OpenVPN users are typically assigned a PPP Profile after successful authentication.

The PPP Profile defines:

- Local IP address
- Remote IP address pool
- DNS servers
- Routing behavior
- Session parameters
- Rate limits (optional)

Using dedicated PPP Profiles simplifies administration and allows different user groups to receive different network permissions.

Recommended examples include:

- vpn-admin
- vpn-users
- vpn-contractors
- vpn-monitoring

Separate PPP Profiles help enforce the principle of least privilege.

---

# User Management

Each VPN user should have an individual account.

Never share credentials between users.

Recommended practices include:

- Unique usernames
- Strong passwords
- Individual certificates
- Individual permissions
- Regular account reviews
- Immediate removal of inactive accounts

Every VPN connection should be traceable to a specific user.

---

# RADIUS Authentication

Instead of maintaining local user accounts, OpenVPN can authenticate users through a RADIUS server.

Benefits include:

- Centralized user management
- Centralized password policies
- Centralized auditing
- Simplified administration
- Better scalability

The MikroTik router becomes an authentication client while the RADIUS server performs credential verification.

---

# Active Directory Integration

Organizations using Microsoft Active Directory should avoid creating duplicate VPN user databases.

Instead, authentication can be delegated through:

- Microsoft Active Directory
- LDAP
- FreeRADIUS
- Enterprise Identity Providers

This approach simplifies user lifecycle management and reduces administrative overhead.

---

# Multi-Factor Authentication (MFA)

Password-only authentication is no longer sufficient for protecting business-critical VPN infrastructure.

Adding a second authentication factor significantly reduces the risk of unauthorized access.

Typical MFA methods include:

- TOTP
- Push Authentication
- Hardware Tokens
- FIDO2
- WebAuthn

For MikroTik OpenVPN deployments, one practical solution is to integrate:

- PrivacyIDEA
- FreeRADIUS
- Docker Compose

The complete implementation is documented in the related project:

https://github.com/sarabelinformatika/privacyidea-freeradius-mikrotik-openvpn

---

# RouterOS OpenVPN Limitations

Although MikroTik provides an OpenVPN server, administrators should be aware of its implementation differences.

Important considerations include:

- RouterOS supports a limited subset of OpenVPN features.
- Feature availability may differ between RouterOS releases.
- Client compatibility should always be validated.
- Configuration should be tested before production deployment.

Review the official RouterOS documentation whenever deploying new RouterOS versions.

---

# TCP vs UDP

Historically, OpenVPN has supported both TCP and UDP transport.

When selecting the transport protocol, consider:

## TCP

Advantages:

- Reliable transmission
- Better compatibility with restrictive networks
- Easier traversal through some firewalls

Disadvantages:

- Higher latency
- Increased protocol overhead
- TCP-over-TCP inefficiencies

---

## UDP

Advantages:

- Lower latency
- Better throughput
- Improved VPN performance
- Reduced protocol overhead

Disadvantages:

- May be blocked by restrictive networks
- Less tolerant of packet loss

Whenever RouterOS and client compatibility allow, UDP should generally be preferred for performance-sensitive deployments.

---

# Encryption Recommendations

Use strong and modern cryptographic settings.

Recommendations include:

- Strong TLS configuration
- Modern cipher suites
- Strong certificates
- Secure key lengths

Avoid outdated or deprecated cryptographic algorithms whenever possible.

Regularly review RouterOS release notes for cryptographic improvements.

---

# Certificate Lifecycle Management

Certificates should be managed throughout their entire lifecycle.

Recommended practices include:

- Document certificate ownership.
- Track expiration dates.
- Renew certificates before expiration.
- Revoke compromised certificates.
- Remove obsolete certificates.

Certificate lifecycle management is often overlooked but is essential for maintaining a secure VPN infrastructure.

---

---

# Enterprise Deployment Recommendations

OpenVPN should be deployed as part of a comprehensive security architecture rather than as a standalone service.

Recommended enterprise practices include:

- Dedicated VPN subnet
- Network segmentation
- Centralized authentication
- Role-based access control
- Certificate-based authentication
- Multi-Factor Authentication (MFA)
- Centralized logging
- Continuous monitoring
- Configuration management
- Regular security reviews

A well-designed VPN infrastructure should integrate seamlessly with the organization's overall security strategy.

---

# Firewall Considerations

A properly configured firewall is essential for protecting the OpenVPN service.

Recommended firewall principles include:

- Allow only the required OpenVPN port.
- Drop invalid connections.
- Restrict management access.
- Log suspicious connection attempts.
- Apply a default deny policy.
- Review firewall rules regularly.

Firewall rules should be documented and periodically audited.

---

# Network Segmentation

VPN users should never receive unrestricted access to every internal resource.

Instead, implement segmentation based on business requirements.

Example:

```text
Internet
     │
     ▼
OpenVPN Server
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
- Better access control
- Simplified auditing
- Improved compliance
- Easier troubleshooting

---

# Monitoring

Every production deployment should be monitored continuously.

Recommended monitoring metrics include:

- Active VPN sessions
- Failed login attempts
- Authentication failures
- CPU utilization
- Memory utilization
- Interface traffic
- Tunnel availability
- Certificate expiration
- Firewall events

Monitoring platforms such as Zabbix provide proactive alerting and historical performance analysis.

---

# Logging

Enable sufficient logging to diagnose operational and security issues.

Recommended log categories include:

- Authentication events
- Connection establishment
- Connection termination
- Certificate validation
- Firewall events
- System events

Logs should be retained according to organizational policies and reviewed regularly.

---

# Backup Strategy

Regular backups are critical for disaster recovery.

Recommended backup components include:

- RouterOS Binary Backup
- RouterOS Export
- Certificates
- Private Keys
- Certificate Authority
- Documentation
- Firewall Configuration

Backups should be encrypted, stored securely and tested periodically.

---

# Security Best Practices

For production environments always:

- Keep RouterOS updated.
- Use certificate-based authentication.
- Enable Multi-Factor Authentication whenever possible.
- Restrict administrative access.
- Protect private keys.
- Rotate passwords regularly.
- Remove inactive users.
- Monitor authentication activity.
- Review firewall rules periodically.
- Backup configurations before making changes.

Security is an ongoing process rather than a one-time deployment task.

---

# Validation Checklist

Before allowing production users to connect, verify the following:

- RouterOS updated
- Certificates installed
- Certificate chain verified
- OpenVPN server operational
- PPP Profile configured
- Firewall rules validated
- NAT rules reviewed
- Routing verified
- DNS functioning correctly
- Authentication tested
- Client connectivity verified
- Internal resource access confirmed
- Monitoring enabled
- Backup completed

All validation steps should be completed successfully before production rollout.

---

# Reference Configuration

The complete RouterOS reference configuration described throughout this guide is provided in:

```text
mikrotik/openvpn-server.rsc
```

The reference configuration includes:

- OpenVPN server configuration
- PPP Profile example
- Certificate recommendations
- Firewall rules
- NAT configuration
- Routing recommendations
- Security comments

Review and adapt the configuration before importing it into a production environment.

---

# Related Project

Organizations requiring stronger authentication for OpenVPN deployments should consider implementing Multi-Factor Authentication (MFA).

The complete PrivacyIDEA + FreeRADIUS integration project is available at:

https://github.com/sarabelinformatika/privacyidea-freeradius-mikrotik-openvpn

The project includes:

- PrivacyIDEA
- FreeRADIUS
- Docker Compose
- MariaDB
- Enterprise MFA deployment guide
- Complete documentation

---

# Next Steps

Continue with the following documentation:

- l2tp-ipsec.md
- firewall.md
- routing.md
- security.md
- troubleshooting.md
- faq.md

Each document builds upon the same reference architecture used throughout this repository, ensuring a consistent and production-oriented deployment methodology.
