# Installation Guide

> Complete deployment guide for implementing secure VPN services on MikroTik RouterOS using WireGuard, OpenVPN and L2TP/IPsec.

---

# Disclaimer

This repository is intended for educational purposes, proof-of-concept environments and production reference implementations.

Although the configurations and recommendations included in this repository follow industry best practices, every production environment is unique.

Always validate all configurations in a non-production environment before deploying them into production.

---

# Project Overview

Virtual Private Networks (VPNs) enable users to securely access internal company resources over the Internet.

MikroTik RouterOS supports multiple VPN technologies, each designed for different use cases and security requirements.

This repository provides practical deployment guidance for:

- WireGuard
- OpenVPN
- L2TP/IPsec

along with security recommendations, firewall examples and troubleshooting procedures.

---

# Supported RouterOS Versions

The examples provided in this repository have been designed for:

| Component | Recommended Version |
|-----------|---------------------|
| MikroTik RouterOS | 7.x |
| WinBox | Latest Stable |
| WireGuard | Native RouterOS Support |
| OpenVPN | RouterOS OpenVPN Server |
| L2TP/IPsec | Native RouterOS Support |

Always keep RouterOS updated to the latest stable release.

---

# Minimum Requirements

Recommended hardware depends on the number of concurrent VPN users.

| Environment | Recommendation |
|-------------|----------------|
| Home Office | hAP ax² / hAP ax³ |
| Small Business | RB5009 |
| Medium Business | CCR2004 |
| Enterprise | CCR2116 or higher |

---

# Before You Begin

Before configuring any VPN service, ensure that:

- RouterOS is updated.
- A backup of the current configuration exists.
- Internet connectivity is working correctly.
- DNS resolution functions properly.
- Accurate date and time are configured.
- NTP synchronization is enabled.
- Firewall rules are documented.
- Administrator passwords are secure.

---

# Recommended Deployment Order

For production environments, configure the infrastructure in the following order:

1. Update RouterOS
2. Backup the current configuration
3. Configure system identity
4. Configure date, time and NTP
5. Verify Internet connectivity
6. Configure DNS
7. Configure firewall rules
8. Configure NAT
9. Deploy the selected VPN protocol
10. Test connectivity
11. Restrict management access
12. Monitor VPN connections

Following this sequence minimizes deployment issues.

---

# Step 1 – Update RouterOS

Install the latest stable RouterOS release before enabling VPN services.

Benefits include:

- Security patches
- Bug fixes
- Improved VPN compatibility
- Better stability
- Performance improvements

Reboot the router after every successful upgrade.

---

# Step 2 – Backup Configuration

Before making any changes, export the current configuration.

Recommended backups include:

- Binary Backup
- RouterOS Export
- Off-device backup storage

Store backups securely and test restoration procedures regularly.

---

# Step 3 – Configure System Identity

Assign a meaningful system identity.

Example:

- Headquarters
- Branch Office
- Data Center
- VPN Gateway

Clear device naming simplifies monitoring and troubleshooting.

---

# Step 4 – Configure Time Synchronization

Correct system time is essential.

Time synchronization affects:

- Certificates
- VPN authentication
- Log timestamps
- Scheduled tasks
- Security auditing

Always configure reliable NTP servers.

---

# Step 5 – Verify Internet Connectivity

Confirm that the router has:

- Internet access
- DNS resolution
- Stable routing
- Correct default gateway

VPN deployment should never begin before Internet connectivity has been verified.

---

# Step 6 – Configure Firewall

A VPN server should never be deployed without reviewing firewall rules.

Recommended principles:

- Default deny
- Least privilege
- Explicit allow rules
- Logging for critical events

Document every firewall modification.

---

# Step 7 – Configure NAT

Review existing NAT rules before enabling VPN services.

Typical considerations include:

- Source NAT
- Masquerade
- Hairpin NAT
- VPN subnet exclusions

Incorrect NAT rules are among the most common VPN deployment issues.

---

# Step 8 – Deploy the VPN Service

Choose the VPN protocol that best matches your environment.

## WireGuard

Recommended for:

- Modern deployments
- Remote workers
- Site-to-site VPN
- High-performance connections

---

## OpenVPN

Recommended for:

- Certificate-based authentication
- Cross-platform clients
- Enterprise environments
- Advanced authentication

---

## L2TP/IPsec

Recommended for:

- Legacy compatibility
- Built-in operating system support
- Existing infrastructures

---

# Step 9 – Configure VPN Users

Create only the users that are actually required.

Recommendations:

- Unique usernames
- Strong passwords
- Individual accounts
- Disable unused accounts
- Remove inactive users

Never share VPN credentials.

---

# Step 10 – Test Connectivity

Verify:

- Successful VPN connection
- Internal resource access
- Internet access
- DNS resolution
- Routing
- Firewall behavior
- Connection stability

Testing should include multiple client operating systems where applicable.

---

# Security Recommendations

For production deployments always:

- Disable unused RouterOS services.
- Restrict WinBox access.
- Restrict SSH access.
- Use strong passwords.
- Rotate credentials regularly.
- Use certificates whenever possible.
- Enable Multi-Factor Authentication for OpenVPN deployments.
- Monitor failed login attempts.
- Backup configurations regularly.

---

# Monitoring

Recommended monitoring items include:

- Active VPN sessions
- CPU utilization
- Memory usage
- Interface traffic
- Failed logins
- Authentication errors
- Firewall drops
- RouterOS health

Enterprise environments should implement centralized monitoring using solutions such as Zabbix.

---

# Validation Checklist

Before deploying into production verify:

- RouterOS updated
- Backup completed
- Internet connectivity verified
- DNS working
- NTP synchronized
- Firewall reviewed
- NAT validated
- VPN tested
- Routing verified
- Management access secured
- Monitoring enabled
- Configuration backed up

All items should be completed before allowing production users to connect.

---

# Next Steps

Continue with the protocol-specific documentation:

- wireguard.md
- openvpn.md
- l2tp-ipsec.md

Then continue with:

- firewall.md
- routing.md
- security.md
- troubleshooting.md

These documents provide detailed deployment guidance for each supported VPN technology.
