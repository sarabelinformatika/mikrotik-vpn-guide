# Secure Branch Office Connectivity Using MikroTik WireGuard VPN

> A production-oriented deployment example demonstrating how organizations can securely connect multiple office locations using MikroTik RouterOS and WireGuard VPN.

---

# Overview

As businesses grow, multiple office locations often need secure and reliable communication. Employees expect seamless access to shared resources regardless of which office they work from.

Instead of exposing internal services to the Internet or relying on expensive leased lines, organizations can securely connect their offices using encrypted site-to-site VPN tunnels.

This deployment example demonstrates how to build a scalable branch office architecture using **MikroTik RouterOS** and **WireGuard VPN**.

---

# Business Scenario

A company operates:

- Headquarters
- Branch Office
- Warehouse
- Retail Store
- Remote Production Site

Each location requires secure access to:

- File Servers
- Active Directory
- ERP Systems
- SQL Databases
- VoIP Systems
- Network Printers
- NAS Devices
- Monitoring Systems
- Backup Infrastructure

Employees should work as if every office belongs to the same internal network while maintaining strict security controls.

---

# Business Challenges

Organizations with multiple locations commonly face the following issues:

- Secure communication between offices
- High latency over the Internet
- Expensive MPLS or leased line solutions
- Centralized resource access
- Consistent firewall policies
- Simplified administration
- Reliable failover connectivity

WireGuard provides a modern, lightweight VPN solution capable of securely interconnecting multiple business locations with excellent performance.

---

# Recommended Architecture

```text
                 Internet
                     │
      ┌──────────────┴──────────────┐
      │                             │
      ▼                             ▼
Headquarters                 Branch Office
MikroTik                     MikroTik
      │                             │
      ▼                             ▼
Corporate LAN              Branch LAN
```

Each site maintains its own local network while securely exchanging traffic through an encrypted WireGuard tunnel.

---

# Reference Network

| Location | Network |
|-----------|---------|
| Headquarters LAN | 192.168.110.0/24 |
| Branch Office LAN | 192.168.210.0/24 |
| WireGuard Network | 192.168.120.0/24 |
| Headquarters VPN | 192.168.120.1 |
| Branch VPN | 192.168.120.2 |

---

# Recommended Repository Files

Deploy the following reference configurations:

| File | Purpose |
|------|---------|
| mikrotik/base/address-list.rsc | Address Lists |
| mikrotik/base/interface-list.rsc | Interface Lists |
| mikrotik/base/services-hardening.rsc | Router Hardening |
| mikrotik/base/firewall-filter.rsc | Firewall Rules |
| mikrotik/base/firewall-nat.rsc | NAT Configuration |
| mikrotik/base/logging.rsc | Centralized Logging |
| mikrotik/wireguard/wireguard.rsc | WireGuard Configuration |

---

# Deployment Workflow

Recommended deployment sequence:

1. Upgrade RouterOS.
2. Configure both MikroTik routers.
3. Apply security hardening.
4. Configure firewall policies.
5. Configure WireGuard interfaces.
6. Exchange public keys.
7. Configure Allowed IPs.
8. Configure static routes.
9. Verify inter-office communication.
10. Validate application connectivity.

---

# Security Recommendations

For production deployments:

- Use dedicated WireGuard keys for each site.
- Protect private keys.
- Restrict Allowed IPs.
- Enable centralized logging.
- Monitor tunnel availability.
- Backup RouterOS configurations.
- Keep RouterOS updated.
- Review firewall policies regularly.

---

# Validation Checklist

Before production rollout, verify:

- Headquarters reachable
- Branch Office reachable
- Tunnel established
- Internal routing operational
- DNS resolution working
- File server access verified
- Active Directory reachable
- Monitoring operational
- Backup connectivity verified

---

# Summary

WireGuard provides a secure, high-performance and cost-effective solution for connecting multiple business locations. Compared to traditional leased lines, it significantly reduces operational costs while maintaining strong encryption, excellent throughput and simplified administration.

For organizations operating multiple offices, a properly designed WireGuard site-to-site deployment delivers secure communication, centralized resource access and a scalable foundation for future growth.

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
