# Security Best Practices

> Enterprise security recommendations for designing, deploying and maintaining secure VPN infrastructures on MikroTik RouterOS.

---

# Overview

A VPN provides confidentiality by encrypting traffic between remote users and internal resources.

Encryption alone, however, does not make an environment secure.

A secure VPN deployment requires multiple security controls working together to protect users, infrastructure and business data.

This document presents the security principles and operational practices recommended for MikroTik RouterOS VPN environments.

Although WireGuard, OpenVPN and L2TP/IPsec differ technically, the security concepts described here apply equally to all supported VPN protocols.

---

# Security Philosophy

Security should never rely on a single control.

Instead, organizations should implement multiple independent security layers capable of reducing overall risk.

A modern VPN deployment should assume that:

- User credentials may be compromised.
- Client devices may become infected.
- Internet-facing services are continuously scanned.
- Attackers actively search for exposed VPN gateways.

The objective is not to prevent every attack, but to reduce the likelihood of successful compromise and minimize its potential impact.

---

# Defense in Depth

Defense in Depth is one of the fundamental principles of enterprise security.

Rather than relying solely on VPN encryption, multiple protective layers should be implemented.

Example:

```text
Internet

↓

Firewall

↓

VPN Gateway

↓

Authentication

↓

Multi-Factor Authentication

↓

Firewall Policies

↓

Network Segmentation

↓

Servers
```

Each layer provides independent protection.

If one control fails, additional controls continue protecting the environment.

---

# Zero Trust

Modern VPN deployments should follow a Zero Trust security model.

Zero Trust assumes that no device or user should automatically be trusted solely because they have established a VPN connection.

Every request should be:

- Authenticated
- Authorized
- Logged
- Monitored

VPN connectivity should never imply unrestricted access to internal resources.

---

# Principle of Least Privilege

Users should receive only the permissions required to perform their job.

Examples include:

| User Role | Recommended Access |
|------------|--------------------|
| Administrator | Infrastructure Management |
| IT Support | Assigned Systems |
| Finance | Accounting Applications |
| HR | HR Systems |
| External Vendor | Approved Resources Only |

Granting unrestricted LAN access to all VPN users significantly increases organizational risk.

---

# Secure Authentication

Authentication is the first line of defense.

Recommended authentication methods include:

- Individual usernames
- Strong passwords
- Certificates
- RADIUS
- Active Directory
- Multi-Factor Authentication

Shared accounts should never be used.

Every VPN session should be attributable to an individual user.

---

# Multi-Factor Authentication (MFA)

Passwords alone are no longer sufficient to protect Internet-facing services.

Adding a second authentication factor significantly reduces the risk of account compromise.

Typical MFA methods include:

- Time-based One-Time Passwords (TOTP)
- Push Notifications
- Hardware Security Keys
- FIDO2
- WebAuthn

For MikroTik OpenVPN deployments, MFA can be implemented using:

- PrivacyIDEA
- FreeRADIUS
- Docker Compose

The complete implementation is documented in the companion project:

https://github.com/sarabelinformatika/privacyidea-freeradius-mikrotik-openvpn

---

# Certificate Management

Where certificate-based authentication is used, certificates should be managed throughout their entire lifecycle.

Recommended practices include:

- Issue individual certificates.
- Protect private keys.
- Revoke compromised certificates immediately.
- Track expiration dates.
- Renew certificates before expiration.
- Remove obsolete certificates.

Certificate lifecycle management is an essential part of enterprise VPN security.

---

# RouterOS Hardening

Before exposing a MikroTik router to the Internet:

- Install the latest stable RouterOS version.
- Remove unused services.
- Disable unnecessary management protocols.
- Restrict administrative access.
- Configure secure DNS.
- Synchronize system time using NTP.
- Review default settings.

Reducing the attack surface significantly lowers the likelihood of successful attacks.

---

# Secrets Management

Sensitive information should never be stored insecurely.

Examples of sensitive information include:

- Administrator passwords
- VPN credentials
- Private keys
- Pre-Shared Keys (PSKs)
- Certificate Authority private keys
- API keys
- Backup encryption passwords

Recommended practices include:

- Use strong, unique secrets.
- Never reuse administrator passwords.
- Rotate credentials periodically.
- Restrict access to sensitive information.
- Store secrets in encrypted password managers.
- Never commit secrets to Git repositories.

Proper secrets management significantly reduces the risk of credential compromise.

---

# Logging

Logging is essential for both operational troubleshooting and security investigations.

Recommended events to log include:

- Successful logins
- Failed logins
- Administrator logins
- VPN tunnel establishment
- VPN tunnel termination
- Configuration changes
- Firewall drops
- Authentication failures
- System warnings

Logs should be retained according to organizational policies and protected against unauthorized modification.

---

# Centralized Monitoring

Monitoring enables organizations to detect problems before users experience service disruptions.

Recommended monitoring targets include:

- VPN availability
- Active VPN sessions
- Authentication failures
- CPU utilization
- Memory utilization
- Disk usage
- Interface traffic
- Firewall drops
- Certificate expiration
- WAN availability

Enterprise environments should centralize monitoring using platforms such as Zabbix.

---

# Incident Response

Organizations should define procedures for responding to security incidents involving VPN infrastructure.

Typical response activities include:

- Identifying affected systems
- Isolating compromised devices
- Revoking user credentials
- Revoking certificates
- Reviewing authentication logs
- Verifying firewall integrity
- Restoring configurations from backup
- Performing post-incident analysis

Documented response procedures significantly reduce recovery time.

---

# Backup Security

Configuration backups are security-critical assets.

Recommended backup components include:

- RouterOS Binary Backup
- RouterOS Export
- Certificates
- Private Keys
- VPN Documentation
- Firewall Configuration
- Routing Configuration

Backups should be:

- Encrypted
- Stored securely
- Versioned
- Tested regularly
- Protected against ransomware

A backup that cannot be restored should not be considered a valid backup.

---

# Business Continuity

VPN infrastructure frequently supports critical business operations.

Organizations should prepare for events such as:

- Router failure
- Internet outage
- Certificate compromise
- Configuration corruption
- Hardware replacement
- Cybersecurity incidents

Business Continuity planning should define:

- Recovery procedures
- Recovery objectives
- Responsible personnel
- Backup locations
- Communication plans

Preparation before an incident significantly improves recovery capability.

---

# Compliance Considerations

Many organizations must comply with security frameworks and regulatory requirements.

Examples include:

- ISO/IEC 27001
- NIS2 Directive
- CIS Controls
- Cyber Essentials
- Internal Security Policies

Although this repository does not provide compliance guidance, the security practices described throughout the documentation support many commonly accepted security objectives.

---

# Vulnerability Management

Keeping VPN infrastructure secure requires continuous vulnerability management.

Recommended activities include:

- Monitor RouterOS security advisories.
- Apply security updates promptly.
- Review vendor release notes.
- Remove unsupported software.
- Replace obsolete cryptographic algorithms.
- Periodically assess exposed services.

Security maintenance should be treated as an ongoing operational process.

---

# Patch Management

Patch management is one of the simplest and most effective security controls.

Recommendations include:

- Deploy security updates promptly.
- Test updates before production deployment.
- Maintain rollback procedures.
- Schedule maintenance windows.
- Verify VPN functionality after every update.

Delaying critical security updates unnecessarily increases organizational risk.

---

# Security Audits

Security is not a one-time activity.

Regular security audits help identify configuration weaknesses, outdated settings and unnecessary exposure before they become security incidents.

A recommended audit should include:

- RouterOS version verification
- Review of enabled services
- Firewall rule analysis
- VPN configuration review
- User account review
- Certificate validation
- Password policy verification
- Routing review
- NAT review
- Logging configuration
- Backup verification
- Monitoring verification

Security audits should be performed at regular intervals and after significant infrastructure changes.

---

# Penetration Testing

Production VPN infrastructures should be periodically validated through controlled security testing.

Typical assessment areas include:

- VPN Gateway Exposure
- Firewall Validation
- Authentication Mechanisms
- Password Policies
- Certificate Validation
- Management Services
- Routing Security
- Network Segmentation

Testing should always be authorized and performed within a controlled environment.

---

# Common Security Mistakes

Many VPN security incidents are caused by configuration errors rather than software vulnerabilities.

Common mistakes include:

- Shared administrator accounts
- Weak passwords
- Missing Multi-Factor Authentication
- Unrestricted VPN access
- Outdated RouterOS versions
- Disabled logging
- Poor backup practices
- Unused services left enabled
- Missing firewall documentation
- Exposed management interfaces

Avoiding these common mistakes significantly improves the overall security posture of the environment.

---

# Operational Security

Operational security is just as important as technical security.

Recommended practices include:

- Document every configuration change.
- Use change management procedures.
- Review administrator permissions regularly.
- Remove inactive accounts.
- Rotate credentials periodically.
- Review firewall rules after infrastructure changes.
- Validate backups after every major update.
- Test disaster recovery procedures regularly.

A secure infrastructure depends on disciplined operational processes.

---

# Security Checklist

The following checklist summarizes the minimum recommended security controls for production environments.

| Security Control | Recommended |
|------------------|:-----------:|
| Latest Stable RouterOS | ✅ |
| Strong Administrator Passwords | ✅ |
| Multi-Factor Authentication | ✅ |
| Individual User Accounts | ✅ |
| Certificate Authentication (where applicable) | ✅ |
| Firewall Default Deny Policy | ✅ |
| Network Segmentation | ✅ |
| Logging Enabled | ✅ |
| Centralized Monitoring | ✅ |
| Configuration Backups | ✅ |
| Disaster Recovery Plan | ✅ |
| Regular Security Audits | ✅ |

Organizations with higher security requirements should implement additional controls appropriate to their regulatory and operational environment.

---

# Validation Checklist

Before deploying a VPN solution into production, verify the following:

- RouterOS updated
- Firewall reviewed
- VPN authentication tested
- Certificates validated
- Multi-Factor Authentication verified (if applicable)
- Routing confirmed
- DNS verified
- Logging operational
- Monitoring operational
- Backups completed
- Backup restoration tested
- Administrative access restricted
- Documentation completed

All validation steps should be completed successfully before granting production users access.

---

# Reference Configuration

The security concepts described throughout this document are implemented throughout the reference configurations included in this repository.

Reference files include:

```text
mikrotik/wireguard.rsc
mikrotik/openvpn-server.rsc
mikrotik/l2tp-ipsec.rsc
mikrotik/firewall-filter.rsc
mikrotik/firewall-nat.rsc
```

These files demonstrate:

- Secure VPN deployment
- Network segmentation
- Firewall protection
- Least Privilege implementation
- Enterprise security recommendations
- Production-oriented configuration examples

Every configuration should be reviewed and adapted before deployment in a production environment.

---

# Related Documentation

Continue with:

- troubleshooting.md
- faq.md
- vpn-protocol-comparison.md

Protocol-specific security recommendations are also available in:

- wireguard.md
- openvpn.md
- l2tp-ipsec.md

Additional firewall and routing guidance can be found in:

- firewall.md
- routing.md

---

# Summary

Building a secure VPN infrastructure requires far more than enabling encryption.

Long-term security depends on combining strong authentication, well-designed firewall policies, network segmentation, continuous monitoring, disciplined operational procedures and regular security reviews.

By applying the principles presented throughout this document—including **Defense in Depth**, **Zero Trust**, **Least Privilege** and **continuous operational security**—organizations can significantly strengthen the resilience of their MikroTik VPN infrastructure while reducing operational risk and improving long-term maintainability.
