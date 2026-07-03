# Firewall Best Practices

> Enterprise firewall design recommendations for securing MikroTik VPN deployments using WireGuard, OpenVPN and L2TP/IPsec.

---

# Overview

A Virtual Private Network (VPN) provides encrypted communication between remote users and internal resources.

Encryption alone, however, does not protect an organization's network.

Every VPN deployment should be protected by a properly designed firewall that controls:

- Incoming connections
- Outgoing connections
- Internal communication
- VPN client permissions
- Administrative access

A well-designed firewall significantly reduces the attack surface while improving network visibility and maintainability.

---

# Firewall Philosophy

A firewall should enforce business policies rather than simply allow or block traffic.

Every firewall rule should answer one question:

> Why is this traffic allowed?

If there is no documented business requirement, the traffic should normally be denied.

---

# Zero Trust Principles

Modern VPN deployments should follow Zero Trust principles.

Never assume that a connected VPN client is trusted.

Every connection should be:

- Authenticated
- Authorized
- Logged
- Monitored

VPN connectivity should never imply unrestricted network access.

---

# Least Privilege

The Principle of Least Privilege should be applied to every VPN deployment.

Users should receive access only to the resources required for their role.

Example:

| User Type | Allowed Resources |
|-----------|-------------------|
| Administrator | Entire infrastructure |
| Employee | File Server, ERP |
| Accountant | Accounting System |
| External Contractor | Single Application |
| Monitoring System | Monitoring Targets Only |

Avoid granting VPN users unrestricted access to the entire LAN.

---

# Recommended Network Segmentation

VPN users should be isolated from production systems whenever possible.

Example architecture:

```text
Internet
     │
     ▼
MikroTik RouterOS
     │
     ▼
VPN Network
192.168.120.0/24
     │
     ▼
Firewall Policies
     │
     ├──────────────┬───────────────┐
     ▼              ▼               ▼
Servers VLAN   Users VLAN     Management VLAN
```

Benefits include:

- Reduced attack surface
- Better auditing
- Easier troubleshooting
- Improved security
- Simplified policy management

---

# Default Deny Strategy

The recommended firewall policy is:

> Deny everything unless explicitly permitted.

Advantages include:

- Smaller attack surface
- Better visibility
- Predictable behavior
- Reduced configuration errors

Rules allowing access should always be intentional and documented.

---

# Rule Ordering

Firewall rules should be organized logically.

A recommended order is:

1. Established Connections
2. Related Connections
3. Invalid Connections
4. Management Access
5. VPN Services
6. Internal Services
7. Logging Rules
8. Drop Rules

Keeping a consistent rule order improves readability and simplifies troubleshooting.

---

# Interface Lists

Avoid referencing physical interfaces directly whenever possible.

Instead, use Interface Lists.

Typical examples include:

- WAN
- LAN
- VPN
- Management

Benefits include:

- Easier maintenance
- Cleaner firewall rules
- Simpler interface replacement
- Better scalability

---

# Address Lists

Address Lists should be used extensively.

Typical lists include:

- Trusted Administrators
- VPN Clients
- Internal Servers
- Monitoring Systems
- Blocked Hosts
- GeoIP Lists (optional)

Address Lists reduce duplicated firewall rules and simplify ongoing maintenance.

---

# Management Access

Administrative services should never be exposed unnecessarily.

Recommended restrictions include:

- WinBox only from trusted networks
- SSH only from administrators
- HTTPS management only from management VLAN
- Disable unused services
- Restrict MAC-based management

Management traffic should always be separated from normal user traffic.

---

# Firewall Chains

RouterOS processes firewall rules through multiple chains.

Understanding the purpose of each chain is essential for building secure and maintainable firewall policies.

| Chain | Purpose |
|--------|---------|
| Input | Traffic destined for the MikroTik router |
| Forward | Traffic passing through the router |
| Output | Traffic originating from the router |

Each chain should follow the same security principles while serving different purposes.

---

# Input Chain

The **Input** chain protects the router itself.

Only explicitly required services should be reachable.

Typical examples include:

- WinBox
- SSH
- HTTPS Management
- WireGuard
- OpenVPN
- L2TP/IPsec
- ICMP (limited)

Everything else should be denied.

Example policy:

```text
Accept Established

↓

Accept Related

↓

Drop Invalid

↓

Allow VPN Services

↓

Allow Management

↓

Log Suspicious Traffic

↓

Drop Everything Else
```

The router should expose as few services as possible.

---

# Forward Chain

The **Forward** chain controls traffic passing through the router.

Examples include:

- VPN Client → LAN
- LAN → Internet
- Site-to-Site VPN
- VLAN Routing

This chain enforces network segmentation.

Example policy:

```text
Accept Established

↓

Accept Related

↓

Drop Invalid

↓

Allow Required Business Traffic

↓

Log Denied Connections

↓

Drop Everything Else
```

Business requirements—not convenience—should determine access permissions.

---

# Output Chain

The **Output** chain controls traffic generated by the router itself.

Typical examples include:

- DNS Queries
- NTP Synchronization
- Package Updates
- Email Notifications
- Monitoring Systems

Although often overlooked, restricting outbound traffic can improve security in sensitive environments.

---

# FastTrack Considerations

FastTrack significantly improves routing performance by bypassing parts of the firewall processing pipeline.

However, administrators should understand its implications.

FastTrack is generally appropriate for:

- Standard Internet traffic
- High-throughput environments

FastTrack may not be appropriate for:

- Complex QoS policies
- Detailed traffic accounting
- Certain VPN scenarios
- Deep packet inspection

Always validate VPN behavior after enabling FastTrack.

---

# WireGuard Firewall Rules

WireGuard requires only a small number of firewall exceptions.

Typical requirements include:

- Allow UDP 51820
- Allow established connections
- Permit VPN-to-LAN traffic where required
- Restrict unnecessary lateral movement

Additional rules should always be based on business requirements.

---

# OpenVPN Firewall Rules

OpenVPN typically requires:

- TCP 1194 (or the configured port)
- Authentication traffic
- VPN subnet routing
- Internal resource access

If certificate revocation or RADIUS authentication is used, ensure all supporting services are reachable.

---

# L2TP/IPsec Firewall Rules

L2TP/IPsec generally requires:

- UDP 500
- UDP 1701
- UDP 4500
- ESP (IP Protocol 50)

Verify that upstream firewalls and Internet providers do not block these protocols.

---

# NAT Best Practices

Network Address Translation should be configured deliberately.

Recommendations include:

- Minimize unnecessary NAT rules.
- Document every translation rule.
- Exclude VPN traffic where appropriate.
- Avoid overlapping address spaces.
- Review NAT after topology changes.

Incorrect NAT configuration is one of the most common causes of VPN connectivity issues.

---

# Logging Strategy

Logging should support operational troubleshooting without overwhelming the logging system.

Recommended events to log include:

- Failed authentication
- Firewall drops
- Port scans
- Brute-force attempts
- Configuration changes
- VPN establishment failures

Routine traffic should generally not be logged unless troubleshooting requires additional visibility.

---

# Brute Force Protection

Administrative services should be protected against repeated authentication attempts.

Recommended techniques include:

- Address Lists
- Progressive blocking
- Rate limiting
- Temporary blacklisting
- Long-term blacklisting for repeated offenders

These controls significantly reduce exposure to automated attacks.

---

# Denial-of-Service (DoS) Protection

Although RouterOS includes efficient packet processing, additional protections are recommended.

Consider implementing:

- Connection limits
- Rate limits
- Invalid packet drops
- SYN flood protection
- ICMP rate limiting
- Bogon filtering (where appropriate)

DoS mitigation should be tailored to the organization's Internet exposure and traffic profile.

---

# Enterprise Security Recommendations

A firewall should be considered a living security control rather than a static configuration.

As business requirements evolve, firewall policies should be reviewed, tested and updated accordingly.

Enterprise environments should establish documented procedures for:

- Firewall rule creation
- Rule modification
- Rule removal
- Security reviews
- Emergency changes
- Configuration backups
- Disaster recovery

Proper governance significantly reduces long-term operational risk.

---

# Change Management

Firewall changes should never be performed without proper planning.

Before implementing any modification:

- Document the business requirement.
- Identify affected systems.
- Evaluate security implications.
- Schedule a maintenance window if necessary.
- Backup the current configuration.
- Validate the new rules after deployment.

Every change should be traceable and reversible.

---

# Firewall Rule Documentation

Each firewall rule should include a meaningful comment.

Avoid descriptions such as:

- Rule 1
- VPN
- Test
- Temporary

Instead, use descriptive comments.

Examples:

- Allow WireGuard VPN Clients
- Allow OpenVPN Authentication
- Allow Management from Admin VLAN
- Block Unauthorized Management Access
- Drop Invalid Connections
- Allow DNS for VPN Clients

Well-documented firewall rules simplify troubleshooting and long-term maintenance.

---

# Periodic Firewall Audits

Firewall policies should be reviewed regularly.

A recommended audit should verify:

- Unused firewall rules
- Duplicate rules
- Disabled rules
- Incorrect rule order
- Unused Address Lists
- Unused Interface Lists
- Open management services
- Unexpected exposed ports

Periodic audits help maintain a secure and efficient firewall configuration.

---

# Security Checklist

Review the following recommendations before placing a firewall into production.

| Security Control | Status |
|------------------|--------|
| Default Deny Policy | ✅ |
| Established Connections Allowed | ✅ |
| Related Connections Allowed | ✅ |
| Invalid Connections Dropped | ✅ |
| VPN Services Restricted | ✅ |
| Management Access Restricted | ✅ |
| Address Lists Used | ✅ |
| Interface Lists Used | ✅ |
| Logging Configured | ✅ |
| NAT Reviewed | ✅ |
| Configuration Backup Completed | ✅ |

Every deployment should satisfy these recommendations before production rollout.

---

# Validation Checklist

Confirm the following before enabling production VPN access:

- Firewall rules documented
- Rule order verified
- VPN ports tested
- Management services restricted
- Address Lists validated
- Interface Lists validated
- NAT configuration reviewed
- Logging operational
- Monitoring configured
- Backup completed

Validation should always be performed after significant firewall modifications.

---

# Reference Configuration

The RouterOS reference configurations described throughout this guide are provided in:

```text
mikrotik/firewall-filter.rsc

mikrotik/firewall-nat.rsc
```

These files include:

- Input Chain rules
- Forward Chain rules
- Output Chain recommendations
- VPN firewall rules
- NAT examples
- Address List integration
- Security comments

Review and adapt every configuration before importing it into a production environment.

---

# Related Documentation

Continue with:

- routing.md
- security.md
- troubleshooting.md
- faq.md
- vpn-protocol-comparison.md

Protocol-specific firewall considerations are also described in:

- wireguard.md
- openvpn.md
- l2tp-ipsec.md

---

# Summary

A secure VPN deployment depends as much on firewall design as it does on the VPN protocol itself.

Whether using WireGuard, OpenVPN or L2TP/IPsec, the firewall should enforce business requirements through clear, well-documented and maintainable security policies.

Applying principles such as **Least Privilege**, **Default Deny**, **Network Segmentation** and **Zero Trust** significantly improves the security posture of MikroTik VPN deployments while reducing operational complexity and simplifying long-term maintenance.
