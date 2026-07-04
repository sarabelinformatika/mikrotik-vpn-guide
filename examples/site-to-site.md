# Site-to-Site VPN Using MikroTik WireGuard

> A production-oriented deployment example demonstrating how to securely connect two independent networks using MikroTik RouterOS and WireGuard Site-to-Site VPN.

---

# Overview

A Site-to-Site VPN securely connects two independent networks over the Internet, allowing devices at both locations to communicate as if they were part of the same private infrastructure.

Unlike Remote Access VPNs, where individual users establish encrypted connections, Site-to-Site VPNs permanently connect entire networks. This architecture is commonly used between company headquarters, branch offices, warehouses, production facilities and data centers.

This deployment example demonstrates a scalable Site-to-Site VPN architecture using **MikroTik RouterOS** and **WireGuard**.

---

# Business Scenario

A company operates two geographically separated locations.

Location A:

- Headquarters
- Active Directory
- File Servers
- SQL Server
- Virtualization Cluster
- Backup Server

Location B:

- Warehouse
- Production
- Office Staff
- Local Printers
- Local NAS

Employees at both locations require transparent access to shared business resources without exposing internal services directly to the Internet.

---

# Business Challenges

Organizations deploying Site-to-Site VPNs commonly require:

- Permanent encrypted connectivity
- Reliable routing
- High throughput
- Low latency
- Secure resource sharing
- Centralized administration
- Minimal maintenance
- Cost-effective infrastructure

WireGuard addresses these requirements with modern cryptography, low protocol overhead and excellent performance.

---

# Recommended Architecture

```text
                Internet
                    │
      ┌─────────────┴─────────────┐
      │                           │
      ▼                           ▼
 Headquarters Router        Branch Router
     MikroTik                  MikroTik
      │                           │
      ▼                           ▼
192.168.110.0/24            192.168.210.0/24
```

---

# Reference Network

| Component | Network |
|-----------|---------|
| Headquarters LAN | 192.168.110.0/24 |
| Branch LAN | 192.168.210.0/24 |
| WireGuard Tunnel | 192.168.120.0/24 |
| HQ VPN Address | 192.168.120.1 |
| Branch VPN Address | 192.168.120.2 |

---

# Recommended Repository Files

Deploy the following reference configurations:

| File | Purpose |
|------|---------|
| mikrotik/base/address-list.rsc | Address Lists |
| mikrotik/base/interface-list.rsc | Interface Lists |
| mikrotik/base/firewall-filter.rsc | Firewall Policy |
| mikrotik/base/firewall-nat.rsc | NAT Configuration |
| mikrotik/base/logging.rsc | Logging |
| mikrotik/wireguard/wireguard.rsc | WireGuard Configuration |

---

# Deployment Workflow

Recommended deployment sequence:

1. Update RouterOS on both routers.
2. Configure WireGuard interfaces.
3. Exchange public keys.
4. Configure Allowed IPs.
5. Configure static routes.
6. Apply firewall rules.
7. Verify routing.
8. Test connectivity.
9. Validate business applications.
10. Backup both configurations.

---

# Typical Business Applications

A Site-to-Site VPN commonly provides secure access to:

- Active Directory
- Microsoft SQL Server
- ERP Systems
- NAS Storage
- Hypervisors
- Monitoring Systems
- Backup Infrastructure
- VoIP Systems
- Remote Printing

---

# Security Recommendations

For production deployments:

- Generate unique WireGuard keys for every site.
- Restrict Allowed IPs to required networks only.
- Protect private keys.
- Enable centralized logging.
- Monitor tunnel availability.
- Keep RouterOS updated.
- Review firewall policies regularly.
- Backup configurations after every change.

---

# Validation Checklist

Before production deployment, verify:

- Tunnel established
- Static routes operational
- DNS resolution working
- Active Directory reachable
- File server access verified
- SQL connectivity verified
- Monitoring operational
- Backup traffic functioning
- Firewall policy validated

---

# Summary

A WireGuard Site-to-Site VPN provides a secure, high-performance and cost-effective solution for connecting geographically separated business locations. Proper routing, firewall policies and ongoing monitoring ensure reliable communication while protecting internal resources from direct Internet exposure.

---

# Continue Reading

Related documentation:

- docs/wireguard.md
- docs/routing.md
- docs/firewall.md
- docs/security.md
- docs/troubleshooting.md

Related blog article:

https://sarabelinformatika.hu/blog/mikrotik-vpn-beallitas-lepesei-wireguard-l2tp-es-openvpn-utmutato-2026
