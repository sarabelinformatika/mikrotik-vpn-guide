# Frequently Asked Questions (FAQ)

> Frequently asked questions about deploying VPN services on MikroTik RouterOS using WireGuard, OpenVPN and L2TP/IPsec.

---

# General Questions

## Which VPN protocol should I choose?

The answer depends on your requirements.

General recommendations:

| Requirement | Recommended Protocol |
|-------------|----------------------|
| New deployments | WireGuard |
| Enterprise authentication | OpenVPN |
| Legacy compatibility | L2TP/IPsec |
| Site-to-site VPN | WireGuard |
| Remote users | WireGuard |
| Multi-Factor Authentication | OpenVPN |

---

## Which protocol offers the best performance?

For most deployments:

1. WireGuard
2. OpenVPN
3. L2TP/IPsec

WireGuard has the smallest codebase and lowest protocol overhead, resulting in excellent throughput and low CPU utilization.

---

## Which protocol is the easiest to deploy?

WireGuard.

It requires fewer configuration parameters than traditional VPN technologies while providing strong modern cryptography.

---

## Which protocol is the most compatible?

L2TP/IPsec offers the broadest native operating system compatibility because built-in clients are available on most desktop and mobile operating systems.

---

# WireGuard

## Does WireGuard use certificates?

No.

WireGuard authenticates peers using public and private key pairs rather than X.509 certificates.

---

## Does WireGuard support usernames and passwords?

No.

Authentication is based entirely on cryptographic key pairs.

If centralized user authentication is required, OpenVPN is generally the more appropriate choice.

---

## Can WireGuard be used for Site-to-Site VPNs?

Yes.

WireGuard is an excellent choice for permanent site-to-site VPN deployments due to its performance, simplicity and low resource utilization.

---

## Can WireGuard be used on mobile devices?

Yes.

Official clients are available for:

- Windows
- macOS
- Linux
- Android
- iOS

---

# OpenVPN

## Why would I choose OpenVPN instead of WireGuard?

OpenVPN is better suited for environments requiring:

- Certificate authentication
- RADIUS
- Active Directory
- Multi-Factor Authentication
- Enterprise identity integration

---

## Can OpenVPN use Multi-Factor Authentication?

Yes.

One recommended implementation combines:

- PrivacyIDEA
- FreeRADIUS
- Docker Compose
- MikroTik RouterOS

The complete implementation is available in the companion repository.

---

## Does OpenVPN support certificates?

Yes.

Certificate-based authentication is one of OpenVPN's primary strengths.

---

# L2TP/IPsec

## Is L2TP/IPsec still recommended?

It remains a practical solution for environments requiring broad client compatibility.

For new deployments, however, WireGuard or OpenVPN should generally be evaluated first.

---

## Does L2TP/IPsec require additional client software?

Usually not.

Most operating systems include a built-in L2TP/IPsec client.

---

# Security

## Is a VPN secure by itself?

No.

A secure deployment also requires:

- Strong authentication
- Firewall policies
- Network segmentation
- Monitoring
- Logging
- Regular updates

VPN encryption is only one component of an organization's overall security strategy.

---

## Should Multi-Factor Authentication be used?

Yes.

Multi-Factor Authentication significantly reduces the risk of unauthorized access and is strongly recommended for Internet-facing VPN services.

---

## How often should RouterOS be updated?

Security updates should be installed promptly after appropriate testing.

Feature updates should be validated before deployment into production environments.

---

# Performance

## Which VPN protocol uses the least CPU?

WireGuard generally provides the lowest CPU utilization.

Actual performance depends on hardware, traffic patterns and RouterOS configuration.

---

## Why is my VPN slow?

Common causes include:

- ISP congestion
- MTU mismatch
- Packet fragmentation
- Firewall processing
- High CPU utilization
- Routing issues
- DNS latency

The Troubleshooting Guide provides a systematic diagnostic methodology.

---

# Troubleshooting

## The VPN connects but I cannot access internal resources.

Review:

- Firewall
- Routing
- NAT
- DNS
- VPN address assignment

Most connectivity problems originate from one of these areas.

---

## Authentication fails.

Verify:

- Username
- Password
- Certificates (if applicable)
- RADIUS configuration
- Multi-Factor Authentication
- System time

---

## Where should I begin troubleshooting?

Use the structured workflow described in the Troubleshooting Guide.

Always identify the failing component before modifying the configuration.

---

# Best Practices

## Should every user have their own VPN account?

Yes.

Individual accounts improve:

- Security
- Auditing
- Accountability
- User management

Shared VPN accounts should never be used.

---

## Should VPN users receive unrestricted LAN access?

No.

Access should always follow the Principle of Least Privilege.

Users should receive access only to the resources required for their role.

---

## Should configurations be backed up?

Yes.

Recommended backups include:

- RouterOS configuration
- Certificates
- VPN documentation
- Firewall rules
- Routing configuration

Backups should be tested regularly.

---

# Additional Documentation

For more detailed guidance, refer to:

- installation.md
- wireguard.md
- openvpn.md
- l2tp-ipsec.md
- firewall.md
- routing.md
- security.md
- troubleshooting.md
- vpn-protocol-comparison.md

---

# Summary

This repository is intended to provide a practical, production-oriented reference for designing, deploying and maintaining secure VPN infrastructures on MikroTik RouterOS.

If your question is not answered here, consult the protocol-specific documentation or the Troubleshooting Guide for more detailed technical guidance.
