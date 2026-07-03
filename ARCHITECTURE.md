# Solution Architecture

> High-level architecture and deployment models for secure MikroTik VPN environments using WireGuard, OpenVPN and L2TP/IPsec.

---

# Purpose

This document describes the recommended architecture for deploying Virtual Private Networks (VPNs) on MikroTik RouterOS.

The objective is to provide a secure, scalable and maintainable design suitable for small businesses, medium-sized enterprises and multi-site organizations.

The architectures presented in this document follow current security best practices and are intended as reference implementations. Every environment is unique, therefore all configurations should be reviewed and adapted before deployment into production.

---

# VPN Deployment Models

This repository covers three primary VPN technologies available on MikroTik RouterOS:

- WireGuard
- OpenVPN
- L2TP/IPsec

Each protocol is suitable for different business requirements.

---

# Recommended Enterprise Architecture

```text
                     Internet
                         │
                         │
                Public IP Address
                         │
                         ▼
              +----------------------+
              | MikroTik RouterOS    |
              | VPN Gateway          |
              +----------+-----------+
                         │
        ┌────────────────┼────────────────┐
        │                │                │
        ▼                ▼                ▼
   WireGuard         OpenVPN        L2TP/IPsec
        │                │                │
        └────────────────┼────────────────┘
                         │
                         ▼
                Internal Firewall
                         │
                         ▼
              Corporate LAN / VLANs
                         │
         ┌───────────────┼───────────────┐
         │               │               │
         ▼               ▼               ▼
   File Servers      Virtualization   Workstations
                     Infrastructure
```

---

# Remote Access VPN

Remote employees establish encrypted tunnels over the Internet and securely access internal company resources.

```text
Remote Employee
       │
       ▼
Encrypted VPN Tunnel
       │
       ▼
MikroTik RouterOS
       │
       ▼
Corporate Network
```

Typical resources include:

- File Servers
- Microsoft 365 Hybrid Services
- NAS Systems
- ERP Systems
- SQL Databases
- Internal Web Applications
- Remote Desktop Servers

---

# Site-to-Site VPN

Multiple company locations can be securely connected through permanent VPN tunnels.

```text
 Headquarters
      │
      │
 WireGuard Tunnel
      │
      ▼
 Branch Office

      │

 OpenVPN Tunnel

      ▼

 Remote Office
```

Benefits include:

- Shared internal resources
- Centralized authentication
- Simplified management
- Reduced operational costs
- Secure inter-office communication

---

# Security Layers

A VPN should always be considered one component of a layered security strategy.

Recommended security layers:

| Layer | Purpose |
|--------|---------|
| Firewall | Traffic filtering |
| VPN | Encrypted communication |
| Authentication | User verification |
| MFA | Additional identity protection |
| Logging | Audit and diagnostics |
| Monitoring | Continuous health monitoring |
| Backup | Disaster recovery |
| Updates | Security patch management |

---

# Authentication Models

Different VPN protocols support different authentication methods.

Typical options include:

- Username and Password
- Certificates
- RADIUS Authentication
- Active Directory Integration
- Multi-Factor Authentication (MFA)

For OpenVPN deployments requiring stronger authentication, consider integrating PrivacyIDEA and FreeRADIUS.

Related project:

https://github.com/sarabelinformatika/privacyidea-freeradius-mikrotik-openvpn

---

# Recommended Network Segmentation

For enterprise deployments, VPN clients should not receive unrestricted access to the internal network.

A recommended design separates:

```text
Internet

↓

VPN Gateway

↓

VPN VLAN

↓

Firewall Policies

↓

Corporate LAN

↓

Servers
```

Network segmentation reduces the potential impact of compromised endpoints.

---

# High Availability

Business-critical environments should consider:

- Redundant Internet connections
- RouterOS configuration backups
- Regular encrypted backups
- High Availability virtualization
- Redundant storage
- UPS protection
- Monitoring and alerting

---

# Monitoring Recommendations

The VPN infrastructure should be continuously monitored.

Recommended metrics include:

- Active VPN sessions
- Failed login attempts
- CPU utilization
- Memory usage
- Interface traffic
- Tunnel availability
- Packet loss
- RouterOS logs

Monitoring solutions such as Zabbix can provide proactive alerting before users experience connectivity issues.

---

# Security Best Practices

For production deployments always:

- Use the latest stable RouterOS version.
- Disable unused services.
- Restrict management access.
- Use strong passwords.
- Enable Multi-Factor Authentication where possible.
- Regularly review firewall rules.
- Backup RouterOS configuration.
- Monitor authentication logs.
- Keep VPN client software updated.

---

# Summary

A well-designed VPN infrastructure provides far more than encrypted communication.

By combining secure authentication, network segmentation, monitoring and regular maintenance, organizations can significantly reduce the risk of unauthorized access while ensuring reliable and secure remote connectivity for employees and branch offices.
