# Troubleshooting Guide

> Enterprise troubleshooting handbook for diagnosing and resolving VPN connectivity issues on MikroTik RouterOS using WireGuard, OpenVPN and L2TP/IPsec.

---

# Introduction

Troubleshooting a VPN environment should never be based on guesswork.

Changing multiple settings simultaneously often makes problems worse and significantly increases the time required to identify the root cause.

A structured troubleshooting methodology provides predictable results while minimizing service disruption.

This document presents a systematic approach to diagnosing and resolving VPN-related issues commonly encountered in MikroTik RouterOS environments.

The recommendations apply to:

- WireGuard
- OpenVPN
- L2TP/IPsec
- Firewall
- Routing
- NAT
- DNS
- Authentication
- Certificates
- RouterOS

---

# Troubleshooting Principles

Before modifying any configuration:

- Identify the exact symptom.
- Determine whether the issue is reproducible.
- Review recent configuration changes.
- Verify the affected users.
- Check whether the issue affects all users or only specific users.
- Collect logs before making changes.
- Backup the current configuration if modifications are required.

Avoid making multiple configuration changes simultaneously.

Always verify the result after every modification.

---

# Recommended Troubleshooting Workflow

Follow the same sequence for every VPN-related issue.

```text
Internet Connectivity

↓

Public IP Reachability

↓

VPN Service Availability

↓

Authentication

↓

Firewall

↓

Routing

↓

DNS

↓

Application Access
```

Skipping troubleshooting steps often leads to incorrect conclusions.

---

# Layered Troubleshooting Method

The most effective troubleshooting process follows the network stack from the lowest layer upward.

```text
Layer 1

Physical Connectivity

↓

Layer 2

Interface Status

↓

Layer 3

IP Addressing

↓

Routing

↓

Firewall

↓

VPN Protocol

↓

Authentication

↓

DNS

↓

Applications
```

Never begin by assuming that the VPN configuration itself is responsible for the problem.

Many VPN issues originate elsewhere in the network.

---

# Collect Information First

Before changing anything, collect as much information as possible.

Examples include:

- When did the problem begin?
- Which users are affected?
- Which VPN protocol is being used?
- Has anything changed recently?
- Can the user access the Internet?
- Does the VPN connect successfully?
- Is authentication successful?
- Can internal IP addresses be reached?
- Can internal hostnames be resolved?

Accurate information significantly reduces troubleshooting time.

---

# Verify Internet Connectivity

A VPN cannot function correctly if Internet connectivity is unavailable.

Verify:

- WAN interface status
- Public IP address
- Default route
- DNS resolution
- Internet latency
- Packet loss

Typical symptoms include:

- VPN timeout
- Handshake failure
- Authentication timeout
- Tunnel establishment failure

---

# Verify RouterOS Health

Confirm that the router itself is operating normally.

Review:

- CPU utilization
- Memory usage
- Interface errors
- Temperature
- Disk usage
- System logs
- Running RouterOS version

Resource exhaustion may produce symptoms similar to VPN failures.

---

# Verify VPN Service

Determine whether the VPN service itself is operational.

Check:

- WireGuard Interface
- OpenVPN Server
- L2TP Server
- IPsec Status
- PPP Service

If the VPN service is unavailable, client-side troubleshooting will not resolve the issue.

---

# Check Router Logs

RouterOS logs should always be reviewed before changing the configuration.

Useful information includes:

- Authentication failures
- Firewall drops
- Interface errors
- Routing changes
- IPsec negotiation failures
- Certificate validation errors
- PPP events

Logs frequently identify the failing component directly.

---

# Common Root Causes

Based on operational experience, most VPN incidents originate from a limited number of causes.

Typical root causes include:

- Incorrect firewall rules
- Missing routes
- Incorrect NAT configuration
- DNS misconfiguration
- Expired certificates
- Incorrect credentials
- Disabled VPN service
- ISP-related issues
- RouterOS updates
- User configuration errors

Identifying the root cause should always take priority over implementing temporary workarounds.

---

# WireGuard Troubleshooting

WireGuard is designed to be simple and reliable. Nevertheless, configuration errors, firewall policies, routing issues and incorrect peer definitions can prevent successful VPN communication.

This section describes the most common WireGuard problems together with systematic diagnostic and resolution procedures.

---

# Problem 1 — Handshake Never Completes

## Symptoms

Typical symptoms include:

- VPN cannot connect.
- No handshake is visible.
- No traffic counters increase.
- Tunnel remains inactive.
- Remote client repeatedly retries.

---

## Possible Causes

Potential causes include:

- Incorrect public IP address
- Incorrect DNS record
- Wrong UDP port
- Firewall blocking UDP 51820
- Incorrect public key
- Incorrect private key
- ISP blocking UDP traffic
- Wrong endpoint configuration
- Interface disabled

---

## Diagnosis

Verify the following:

- Internet connectivity
- Public IP address
- WireGuard interface status
- Firewall rules
- Peer configuration
- Endpoint configuration
- Port forwarding (if applicable)

---

## Verification

Confirm:

- Router can reach the Internet.
- Client can resolve the VPN hostname.
- UDP port 51820 is reachable.
- Correct public keys are configured.
- WireGuard interface is enabled.

Observe:

- Handshake timestamp
- RX packets
- TX packets

If the handshake timestamp never updates, communication between peers has not been established.

---

## Resolution

Recommended actions:

- Verify public/private keys.
- Verify endpoint address.
- Verify UDP port.
- Review firewall rules.
- Restart the WireGuard interface if necessary.
- Verify ISP connectivity.
- Confirm that NAT forwarding is configured correctly.

Retest after every modification.

---

## Prevention

- Document every peer.
- Assign meaningful peer comments.
- Maintain consistent addressing.
- Backup configuration after changes.
- Test connectivity immediately after adding new peers.

---

# Problem 2 — Tunnel Connects but No Traffic Passes

## Symptoms

Typical symptoms include:

- Handshake succeeds.
- Tunnel appears active.
- No internal resources are reachable.
- Ping fails.
- Applications cannot connect.

---

## Possible Causes

- Missing route
- Incorrect Allowed Address configuration
- Firewall blocking traffic
- Missing NAT rule
- Wrong subnet configuration
- Incorrect VPN IP address
- Missing return route

---

## Diagnosis

Verify:

- Routing table
- Firewall Forward chain
- Allowed Address configuration
- NAT rules
- Client IP address
- Internal routing

---

## Verification

Confirm:

- VPN client received the expected IP address.
- Internal subnet is reachable.
- Firewall permits VPN traffic.
- Return traffic reaches the VPN subnet.

Use:

- Ping
- Traceroute
- Route inspection

to identify where communication stops.

---

## Resolution

Typical corrective actions include:

- Correct Allowed Address values.
- Add missing routes.
- Adjust firewall rules.
- Review NAT configuration.
- Verify interface assignments.
- Confirm destination subnet configuration.

---

## Prevention

- Document routing.
- Validate firewall rules.
- Use dedicated VPN subnets.
- Avoid overlapping address ranges.

---

# Problem 3 — One-Way Traffic

## Symptoms

Users report:

- Requests leave successfully.
- Responses never return.
- Ping succeeds only in one direction.
- File access fails.
- RDP sessions disconnect.

---

## Possible Causes

- Missing return route
- Firewall blocking return traffic
- Asymmetric routing
- Incorrect NAT
- Policy-based routing conflicts

---

## Diagnosis

Review:

- Routing table
- Firewall Forward chain
- NAT rules
- Gateway selection
- Route distances

---

## Verification

Perform:

- Ping in both directions.
- Traceroute from both ends.
- Packet capture if necessary.
- Firewall log review.

---

## Resolution

- Add missing return routes.
- Correct asymmetric routing.
- Adjust NAT.
- Verify gateway selection.
- Simplify routing policies where possible.

---

## Prevention

Always verify bidirectional communication after deploying new VPN tunnels.

---

# Problem 4 — DNS Resolution Fails

## Symptoms

Users can:

- Ping internal IP addresses.

But cannot:

- Resolve hostnames.
- Access servers by DNS name.
- Locate Active Directory services.

---

## Possible Causes

- Incorrect DNS server
- Missing DNS suffix
- Public DNS in VPN profile
- Internal DNS unreachable
- Firewall blocking DNS

---

## Diagnosis

Verify:

- Assigned DNS server
- DNS reachability
- Internal DNS records
- VPN client configuration

---

## Verification

Test:

- Internal hostname
- Internal FQDN
- External hostname
- Reverse lookup

---

## Resolution

Configure VPN clients to use internal DNS servers whenever internal resources rely on private DNS zones.

Ensure DNS traffic is permitted by firewall policies.

---

## Prevention

Maintain centralized DNS design.

Avoid mixing internal and public DNS for corporate resources.

---

# Problem 5 — MTU and Fragmentation Issues

## Symptoms

Typical symptoms include:

- VPN connection establishes successfully.
- Small packets pass without issues.
- Large file transfers fail.
- HTTPS pages load partially.
- RDP sessions freeze intermittently.
- Video conferences become unstable.
- SMB file copies stop unexpectedly.

---

## Possible Causes

Potential causes include:

- Incorrect MTU value
- Packet fragmentation
- PPPoE overhead
- ISP MTU limitations
- Nested VPN tunnels
- Cloud provider MTU restrictions

---

## Diagnosis

Verify:

- WAN connection type
- MTU configuration
- Packet fragmentation
- VPN packet size
- Router interface MTU

If problems occur only during large transfers, MTU should be investigated first.

---

## Verification

Perform tests using:

- Large ICMP packets
- Continuous ping
- File transfers
- HTTPS downloads

Compare results using different packet sizes.

---

## Resolution

Recommended actions:

- Adjust MTU gradually.
- Verify MSS behavior.
- Test after every change.
- Keep consistent MTU values across the VPN path.

Avoid changing multiple parameters simultaneously.

---

## Prevention

- Document MTU settings.
- Standardize WAN technologies.
- Validate MTU after ISP changes.
- Test large file transfers before production rollout.

---

# Problem 6 — Mobile Roaming Issues

## Symptoms

Users report:

- VPN disconnects while travelling.
- Tunnel reconnects slowly.
- Applications lose connectivity.
- Connection drops after switching from Wi-Fi to mobile data.

---

## Possible Causes

- Mobile IP address changes
- Aggressive firewall timeouts
- Carrier NAT
- Network switching
- Battery optimization

---

## Diagnosis

Verify:

- Client logs
- WireGuard handshake timestamps
- Mobile operating system settings
- Network transitions

Determine whether failures occur during network changes.

---

## Resolution

Recommended actions:

- Update WireGuard client.
- Verify endpoint configuration.
- Disable aggressive battery optimization.
- Allow the WireGuard application to run in the background.
- Test across multiple mobile networks.

---

## Prevention

- Keep mobile clients updated.
- Document supported client versions.
- Validate roaming before production deployment.

---

# Problem 7 — Poor Performance

## Symptoms

Users experience:

- Slow downloads
- Slow uploads
- High latency
- Reduced throughput
- Delayed application response

---

## Possible Causes

- ISP congestion
- High CPU utilization
- MTU mismatch
- Packet loss
- QoS policies
- FastTrack interaction
- Hardware limitations

---

## Diagnosis

Review:

- CPU utilization
- Interface statistics
- WAN utilization
- Packet loss
- Latency
- VPN throughput

Avoid assuming that the VPN protocol itself is responsible.

---

## Verification

Measure:

- Internet speed without VPN
- Internet speed through VPN
- CPU utilization
- Packet retransmissions

---

## Resolution

Possible corrective actions:

- Upgrade RouterOS.
- Review FastTrack configuration.
- Optimize MTU.
- Upgrade router hardware if necessary.
- Reduce unnecessary firewall processing.

---

## Prevention

Monitor VPN performance continuously.

Establish baseline performance measurements before production deployment.

---

# Problem 8 — Packet Loss

## Symptoms

Typical symptoms include:

- Intermittent application failures.
- Audio dropouts.
- Video conferencing problems.
- File transfer interruptions.
- High latency.

---

## Possible Causes

- ISP instability
- Wireless interference
- Router overload
- Congested Internet links
- Faulty network equipment

---

## Diagnosis

Measure:

- Packet loss
- Latency
- Interface errors
- CPU utilization
- Internet quality

Determine whether packet loss occurs before, during or after the VPN tunnel.

---

## Resolution

Correct the underlying network issue before modifying VPN configuration.

VPN protocols cannot compensate for poor Internet connectivity.

---

## Prevention

- Monitor WAN quality.
- Replace faulty hardware.
- Review ISP performance.
- Monitor interface errors continuously.

---

# Problem 9 — Overlapping Networks

## Symptoms

Users can connect successfully but cannot reach internal resources.

---

## Possible Causes

Examples include:

Corporate LAN

```
192.168.110.0/24
```

Remote Home Network

```
192.168.110.0/24
```

The operating system cannot determine whether traffic should remain local or traverse the VPN.

---

## Diagnosis

Verify:

- Client LAN subnet
- Corporate LAN subnet
- Routing table
- Allowed Address configuration

---

## Resolution

Use unique IP addressing throughout the organization.

Avoid deploying VPN environments using commonly used residential address ranges whenever possible.

---

## Prevention

Implement an IP addressing policy before expanding the VPN infrastructure.

Document every allocated subnet.

---

# Problem 10 — Peer Configuration Errors

## Symptoms

One or more VPN peers cannot establish communication.

---

## Possible Causes

- Wrong public key
- Wrong private key
- Incorrect Allowed Address
- Incorrect endpoint
- Duplicate peer configuration
- Disabled peer

---

## Diagnosis

Review every peer individually.

Confirm:

- Public Key
- Allowed Address
- Endpoint
- Keepalive
- Peer status

Never assume that copied configurations are correct.

---

## Resolution

Recreate the peer configuration if necessary.

Avoid editing multiple peer parameters simultaneously.

Test each peer independently.

---

## Prevention

- One peer per user.
- One key pair per device.
- Clear documentation.
- Configuration review before deployment.

---

# WireGuard Troubleshooting Summary

Most WireGuard issues originate from one of the following categories:

- Firewall
- Routing
- MTU
- DNS
- Incorrect Keys
- Allowed Address
- NAT
- Internet Connectivity

Following the structured troubleshooting methodology presented in this guide will typically identify the root cause without unnecessary configuration changes.

---

# OpenVPN Troubleshooting

OpenVPN provides a flexible and highly secure VPN solution, but its support for certificates, PPP profiles, RADIUS authentication and optional Multi-Factor Authentication introduces additional components that may affect connectivity.

Successful troubleshooting requires identifying exactly which stage of the authentication or connection process is failing.

The recommended troubleshooting sequence is:

```text
Internet Connectivity

↓

OpenVPN Service

↓

TLS Handshake

↓

Certificate Validation

↓

Authentication

↓

PPP Profile

↓

Firewall

↓

Routing

↓

DNS

↓

Application Access
```

Never assume that the VPN server is responsible for every connection problem.

Always isolate the failing component before making configuration changes.

---

# Problem 1 — Authentication Failed (AUTH_FAILED)

## Symptoms

Typical symptoms include:

- Client reports `AUTH_FAILED`.
- Username and password are rejected.
- VPN connection terminates immediately.
- User cannot authenticate.

---

## Possible Causes

Potential causes include:

- Incorrect username
- Incorrect password
- Disabled account
- Incorrect RADIUS configuration
- PrivacyIDEA authentication failure
- Active Directory authentication failure
- Account lockout

---

## Diagnosis

Verify:

- Username
- Password
- User status
- RADIUS connectivity
- Authentication server availability
- RouterOS logs
- OpenVPN client logs

---

## Verification

Confirm that:

- The user account exists.
- The account is enabled.
- Credentials are correct.
- Authentication succeeds directly against the authentication source.

If MFA is enabled, verify that the second factor is also accepted.

---

## Resolution

Recommended actions:

- Reset user credentials if necessary.
- Verify RADIUS configuration.
- Verify shared secrets.
- Review PrivacyIDEA logs.
- Review Active Directory logs.
- Confirm time synchronization.

Test authentication after every change.

---

## Prevention

- Individual user accounts
- Strong password policy
- MFA for all remote users
- Regular account reviews
- Centralized authentication

---

# Problem 2 — TLS Handshake Failed

## Symptoms

Typical symptoms include:

- Connection timeout
- TLS negotiation never completes
- Client repeatedly retries
- No VPN tunnel established

---

## Possible Causes

- Firewall blocking VPN traffic
- Incorrect TCP port
- Certificate mismatch
- Incorrect server configuration
- ISP filtering
- Invalid TLS configuration

---

## Diagnosis

Verify:

- Public IP address
- OpenVPN port
- Firewall rules
- TLS configuration
- Server certificate
- Client certificate

---

## Verification

Confirm:

- VPN port is reachable.
- Server certificate is valid.
- Client certificate is trusted.
- RouterOS OpenVPN service is running.

---

## Resolution

Recommended actions:

- Verify certificate chain.
- Review firewall configuration.
- Confirm port forwarding.
- Verify TLS settings.
- Restart the OpenVPN service if necessary.

---

## Prevention

- Standardize certificate deployment.
- Document TLS configuration.
- Validate certificates before distribution.

---

# Problem 3 — Certificate Verification Failed

## Symptoms

Typical symptoms include:

- Client rejects server certificate.
- Connection closes immediately.
- TLS negotiation fails.
- Authentication never begins.

---

## Possible Causes

- Expired certificate
- Revoked certificate
- Wrong Certificate Authority
- Incorrect Common Name
- Missing intermediate certificate

---

## Diagnosis

Verify:

- Certificate validity period
- Certificate chain
- Certificate revocation status
- Certificate subject
- Certificate issuer

---

## Verification

Confirm that:

- CA certificate is trusted.
- Client certificate matches the server configuration.
- Certificate has not expired.

---

## Resolution

Issue new certificates if necessary.

Remove obsolete certificates.

Distribute updated certificates securely.

---

## Prevention

- Track certificate expiration.
- Review certificates periodically.
- Revoke compromised certificates immediately.

---

# Problem 4 — VPN Connects but No LAN Access

## Symptoms

Users successfully authenticate but cannot:

- Access file servers
- Reach NAS devices
- Connect via RDP
- Access internal applications

---

## Possible Causes

- Missing route
- Firewall blocking VPN subnet
- Incorrect PPP Profile
- Missing NAT rule
- DNS misconfiguration

---

## Diagnosis

Review:

- PPP Profile
- Assigned VPN address
- Routing table
- Firewall Forward chain
- NAT rules

---

## Verification

Verify:

- Ping VPN gateway
- Ping internal gateway
- Ping internal server
- Resolve internal hostname

Determine the exact point where communication stops.

---

## Resolution

Correct:

- Firewall rules
- Routing
- PPP Profile
- NAT configuration
- DNS settings

Retest after each modification.

---

## Prevention

Always validate complete end-to-end connectivity before deploying new VPN users.

---

# Problem 5 — PPP Profile Issues

## Symptoms

Typical symptoms include:

- User authenticates successfully.
- Incorrect IP address assigned.
- Missing DNS server.
- No internal connectivity.

---

## Possible Causes

- Incorrect PPP Profile
- Wrong address pool
- Incorrect local address
- Missing DNS configuration
- Invalid routing parameters

---

## Diagnosis

Review:

- PPP Profile
- Address Pool
- Assigned IP address
- DNS settings
- Route distribution

---

## Resolution

Assign the correct PPP Profile.

Verify address pools.

Review DNS configuration.

---

## Prevention

Use standardized PPP Profiles.

Document every profile.

Avoid manual configuration for individual users.

---

# OpenVPN Troubleshooting Summary

Most OpenVPN incidents originate from one of the following categories:

- Authentication
- Certificates
- PPP Profile
- Firewall
- Routing
- DNS
- RADIUS
- MFA
- Internet Connectivity

Identifying the failing stage before making configuration changes significantly reduces troubleshooting time and minimizes service disruption.

---

# Problem 6 — RADIUS Authentication Timeout

## Symptoms

Typical symptoms include:

- VPN client waits for authentication.
- Connection eventually times out.
- User credentials appear correct.
- Authentication never completes.

---

## Possible Causes

Potential causes include:

- FreeRADIUS service unavailable
- Incorrect RADIUS server address
- Incorrect shared secret
- Firewall blocking UDP/1812
- Network connectivity problems
- High authentication server latency

---

## Diagnosis

Verify:

- RADIUS server availability
- Shared Secret configuration
- RouterOS RADIUS client settings
- Firewall rules
- Network latency
- FreeRADIUS logs

---

## Verification

Confirm that:

- RouterOS can reach the RADIUS server.
- UDP port 1812 is accessible.
- Shared Secret matches on both systems.
- FreeRADIUS receives authentication requests.

Review both RouterOS and FreeRADIUS logs simultaneously.

---

## Resolution

Recommended actions:

- Correct the RADIUS server configuration.
- Verify the shared secret.
- Restart the RADIUS service if required.
- Confirm firewall rules.
- Verify network connectivity.

Test authentication after each change.

---

## Prevention

- Use strong shared secrets.
- Restrict RADIUS access by IP address.
- Monitor the RADIUS service continuously.
- Document all authentication servers.

---

# Problem 7 — PrivacyIDEA MFA Authentication Failed

## Symptoms

Typical symptoms include:

- Username and password are accepted.
- OTP validation fails.
- User cannot complete authentication.
- Authentication is rejected by PrivacyIDEA.

---

## Possible Causes

Potential causes include:

- Incorrect TOTP code
- Token not enrolled
- Token disabled
- Time synchronization issues
- Incorrect Realm configuration
- Incorrect Resolver configuration
- User not synchronized

---

## Diagnosis

Review:

- PrivacyIDEA audit log
- Token status
- User assignment
- Realm configuration
- Resolver configuration
- System time

---

## Verification

Confirm that:

- The token belongs to the user.
- The token is enabled.
- System clocks are synchronized.
- The user exists in the configured Resolver.

---

## Resolution

Recommended actions:

- Resynchronize system time.
- Re-enroll the token if necessary.
- Verify Realm membership.
- Verify Resolver configuration.
- Test authentication directly in PrivacyIDEA.

---

## Prevention

- Synchronize all systems using NTP.
- Monitor token expiration.
- Document token ownership.
- Review audit logs regularly.

---

# Problem 8 — Active Directory Authentication Failed

## Symptoms

Typical symptoms include:

- Domain users cannot authenticate.
- Local users authenticate successfully.
- Authentication is rejected by the identity provider.

---

## Possible Causes

- LDAP connectivity failure
- Domain Controller unavailable
- Incorrect bind credentials
- User account locked
- Expired password
- Incorrect search base
- DNS resolution failure

---

## Diagnosis

Verify:

- Domain Controller availability
- LDAP connectivity
- DNS resolution
- Bind account
- User status
- Resolver configuration

---

## Verification

Confirm:

- Domain Controllers are reachable.
- LDAP authentication succeeds.
- User account is active.
- Password has not expired.

---

## Resolution

Correct:

- LDAP configuration
- Bind credentials
- DNS settings
- User account status

Retest authentication after each modification.

---

## Prevention

- Monitor Domain Controllers.
- Use redundant LDAP servers.
- Document Resolver configuration.
- Review synchronization regularly.

---

# Problem 9 — Unsupported Cipher

## Symptoms

Typical symptoms include:

- TLS negotiation fails.
- Client disconnects immediately.
- Authentication never begins.

---

## Possible Causes

- Unsupported encryption algorithm
- RouterOS version mismatch
- Client configuration mismatch
- Deprecated cipher suite

---

## Diagnosis

Review:

- RouterOS version
- Client version
- Cipher configuration
- Release notes

---

## Verification

Confirm that both the server and client support the configured cipher suite.

---

## Resolution

Use only supported and recommended encryption algorithms.

Avoid legacy ciphers unless compatibility requires them.

---

## Prevention

- Standardize client software.
- Document cryptographic settings.
- Test upgrades before production deployment.

---

# Problem 10 — Certificate Expired

## Symptoms

Typical symptoms include:

- VPN worked previously.
- Connection suddenly fails.
- TLS handshake is rejected.
- Certificate validation fails.

---

## Possible Causes

- Client certificate expired.
- Server certificate expired.
- Certificate Authority expired.

---

## Diagnosis

Verify:

- Certificate validity period
- Certificate issuer
- Certificate chain
- Revocation status

---

## Verification

Confirm that every certificate in the trust chain remains valid.

---

## Resolution

Renew the expired certificate.

Distribute updated certificates securely.

Verify successful authentication after renewal.

---

## Prevention

- Monitor certificate expiration dates.
- Schedule renewals in advance.
- Maintain an inventory of issued certificates.

---

# Problem 11 — Slow OpenVPN Performance

## Symptoms

Users report:

- Slow downloads
- Slow uploads
- High latency
- Poor file transfer performance
- Slow Remote Desktop sessions

---

## Possible Causes

- High CPU utilization
- TCP overhead
- MTU issues
- Packet fragmentation
- ISP congestion
- Firewall processing
- Router hardware limitations

---

## Diagnosis

Review:

- CPU utilization
- Memory usage
- Interface statistics
- Packet loss
- MTU configuration
- Internet bandwidth

---

## Verification

Compare:

- Performance without VPN
- Performance through VPN
- CPU utilization during VPN traffic
- Interface throughput

---

## Resolution

Possible corrective actions include:

- Optimize MTU.
- Upgrade RouterOS.
- Upgrade hardware if necessary.
- Review firewall processing.
- Verify Internet connectivity.

---

## Prevention

- Establish performance baselines.
- Monitor CPU utilization.
- Monitor VPN throughput.
- Review performance after every RouterOS upgrade.

---

# OpenVPN Enterprise Troubleshooting Summary

Enterprise OpenVPN deployments consist of multiple integrated components.

Typical authentication path:

```text
VPN Client

↓

OpenVPN

↓

TLS

↓

Certificate Validation

↓

RouterOS

↓

RADIUS (optional)

↓

PrivacyIDEA / Active Directory (optional)

↓

PPP Profile

↓

Firewall

↓

Routing

↓

DNS

↓

Internal Resources
```

When troubleshooting, always determine the exact stage at which the authentication or connection process fails.

Avoid changing multiple components simultaneously. A structured, step-by-step diagnostic process consistently leads to faster resolution and minimizes unnecessary configuration changes.

---

# L2TP/IPsec Troubleshooting

L2TP/IPsec remains a widely deployed VPN technology due to its native support across multiple operating systems.

However, because the connection process involves multiple negotiation phases—including Internet Key Exchange (IKE), IPsec Security Associations and PPP authentication—troubleshooting can be more complex than with WireGuard.

The recommended diagnostic sequence is:

```text
Internet Connectivity

↓

UDP 500 Reachable

↓

IKE Phase 1

↓

IKE Phase 2

↓

IPsec Security Association

↓

L2TP Tunnel

↓

PPP Authentication

↓

Firewall

↓

Routing

↓

DNS

↓

Application Access
```

Each stage depends on the successful completion of the previous one.

---

# Problem 1 — No Proposal Chosen

## Symptoms

Typical symptoms include:

- VPN connection fails immediately.
- IKE negotiation terminates.
- IPsec tunnel is never established.
- RouterOS reports "no proposal chosen".

---

## Possible Causes

Potential causes include:

- Encryption algorithm mismatch
- Authentication algorithm mismatch
- PFS mismatch
- DH Group mismatch
- Lifetime mismatch
- Unsupported cryptographic settings

---

## Diagnosis

Review:

- IPsec Proposal
- IPsec Profile
- IPsec Peer
- Client configuration

Compare every cryptographic parameter between the client and the MikroTik router.

---

## Verification

Confirm:

- Encryption algorithms match.
- Hash algorithms match.
- DH Groups are identical.
- Lifetime values are compatible.

---

## Resolution

Configure identical cryptographic parameters on both peers.

Avoid using deprecated algorithms unless compatibility requires them.

---

## Prevention

Standardize IPsec cryptographic policies across the organization.

---

# Problem 2 — IKE Phase 1 Fails

## Symptoms

Typical symptoms include:

- VPN client cannot establish an IPsec session.
- No Security Association is created.
- Authentication never begins.

---

## Possible Causes

- Incorrect Pre-Shared Key
- Firewall blocking UDP 500
- Incorrect Peer configuration
- Invalid identity configuration
- Incorrect public IP

---

## Diagnosis

Verify:

- Peer definition
- Public IP
- Firewall rules
- Pre-Shared Key
- Internet connectivity

---

## Verification

Confirm that:

- UDP 500 is reachable.
- The MikroTik router receives IKE requests.
- The configured peer matches the client.

---

## Resolution

Correct the peer configuration.

Verify the Pre-Shared Key.

Review Internet connectivity.

---

## Prevention

Document peer configurations and validate them before deployment.

---

# Problem 3 — IKE Phase 2 Fails

## Symptoms

Typical symptoms include:

- Phase 1 completes successfully.
- IPsec tunnel never becomes operational.
- Authentication cannot continue.

---

## Possible Causes

- Incorrect Proposal
- Policy mismatch
- PFS mismatch
- Incorrect subnet configuration

---

## Diagnosis

Review:

- IPsec Policies
- Proposal configuration
- Encryption settings
- Local and remote subnets

---

## Verification

Confirm that both VPN peers negotiate identical Phase 2 parameters.

---

## Resolution

Correct Policy and Proposal configuration.

Retest the VPN after each modification.

---

## Prevention

Use standardized IPsec policies across all VPN deployments.

---

# Problem 4 — Pre-Shared Key (PSK) Mismatch

## Symptoms

Typical symptoms include:

- Authentication fails immediately.
- Tunnel establishment stops during IKE negotiation.

---

## Possible Causes

- Typographical error
- Incorrect key
- Different keys configured on each peer

---

## Diagnosis

Review the configured Pre-Shared Key on both systems.

Avoid copying keys from outdated documentation.

---

## Verification

Confirm that both peers use exactly the same PSK.

---

## Resolution

Replace the PSK on both peers.

Use a strong randomly generated value.

---

## Prevention

Store Pre-Shared Keys securely.

Rotate them periodically.

---

# Problem 5 — NAT Traversal Issues

## Symptoms

Typical symptoms include:

- VPN works on some Internet connections.
- VPN fails behind NAT devices.
- Mobile users cannot connect.

---

## Possible Causes

- NAT-T disabled
- Firewall blocking UDP 4500
- Carrier NAT
- Double NAT

---

## Diagnosis

Verify:

- NAT Traversal configuration
- UDP 4500
- ISP network
- Client network topology

---

## Verification

Determine whether the VPN succeeds from an unrestricted Internet connection.

---

## Resolution

Enable NAT Traversal.

Allow UDP 4500 through every firewall.

Review ISP NAT behavior.

---

## Prevention

Always validate VPN connectivity behind NAT environments before production deployment.

---

# Problem 6 — ESP Traffic Blocked

## Symptoms

Typical symptoms include:

- IKE negotiation succeeds.
- VPN tunnel never carries traffic.
- Connection drops immediately.

---

## Possible Causes

- Firewall blocking ESP
- Upstream security appliance
- ISP filtering

---

## Diagnosis

Verify:

- Firewall configuration
- Upstream firewall
- Internet provider restrictions

---

## Resolution

Permit ESP traffic.

Review upstream firewall policies.

---

## Prevention

Validate firewall rules whenever Internet infrastructure changes.

---

# Problem 7 — VPN Connects but No Internal Access

## Symptoms

Users authenticate successfully but cannot:

- Access servers
- Ping internal hosts
- Open shared folders
- Use Remote Desktop

---

## Possible Causes

- Missing routes
- Firewall restrictions
- NAT configuration
- PPP Profile configuration
- DNS problems

---

## Diagnosis

Review:

- Routing table
- Firewall rules
- PPP Profile
- Assigned IP address
- DNS configuration

---

## Verification

Confirm:

- VPN client received the expected IP address.
- Internal gateway responds.
- Required routes exist.
- Firewall permits traffic.

---

## Resolution

Correct routing, firewall and DNS configuration.

Retest every service individually.

---

## Prevention

Always validate end-to-end connectivity after deploying new VPN users.

---

# Problem 8 — Windows Built-in VPN Cannot Connect

## Symptoms

Typical symptoms include:

- Windows reports a generic VPN error.
- Authentication fails.
- Tunnel establishment stops unexpectedly.

---

## Possible Causes

- Incorrect VPN type
- Incorrect credentials
- Firewall restrictions
- Unsupported encryption settings
- Windows security policy

---

## Diagnosis

Verify:

- Windows VPN configuration
- VPN type
- Authentication settings
- Event Viewer logs

---

## Resolution

Correct the Windows VPN configuration.

Review RouterOS compatibility.

Install the latest Windows updates.

---

## Prevention

Provide standardized client configuration documentation for end users.

---

# Problem 9 — Apple and Android Native VPN Issues

## Symptoms

Users report:

- Connection instability
- Authentication failures
- Frequent disconnects
- Tunnel establishment failures

---

## Possible Causes

- Operating system restrictions
- Incorrect VPN profile
- Mobile network transitions
- Battery optimization
- Unsupported configuration

---

## Diagnosis

Verify:

- Operating system version
- VPN profile
- Network type
- Device logs

---

## Resolution

Update the operating system.

Review VPN configuration.

Disable aggressive battery optimization where appropriate.

---

## Prevention

Maintain documented support for approved client operating systems and versions.

---

# L2TP/IPsec Troubleshooting Summary

Most L2TP/IPsec incidents originate from one of the following areas:

- IKE Phase 1
- IKE Phase 2
- IPsec Proposal
- Pre-Shared Key
- NAT Traversal
- Firewall
- Routing
- DNS
- PPP Profile

Following the diagnostic sequence presented in this guide enables administrators to isolate the failing component systematically and restore service with minimal disruption.

---

# Firewall Troubleshooting

A correctly configured VPN cannot function if firewall policies prevent legitimate traffic.

Firewall issues are among the most common causes of VPN connectivity problems.

The recommended troubleshooting sequence is:

```text
VPN Established

↓

Input Chain

↓

Forward Chain

↓

NAT

↓

Internal Resource

↓

Successful Communication
```

Always verify firewall rules before modifying VPN configuration.

---

# Problem 1 — VPN Port Not Reachable

## Symptoms

Typical symptoms include:

- VPN client times out.
- Connection never starts.
- No authentication occurs.
- No traffic reaches the router.

---

## Possible Causes

- Firewall blocking VPN port
- Incorrect interface assignment
- Wrong destination address
- ISP filtering
- Missing NAT forwarding

---

## Diagnosis

Verify:

- Input Chain
- WAN Interface
- Public IP Address
- Port Forwarding
- Firewall Rule Order

---

## Verification

Confirm:

- VPN port is reachable.
- Router receives connection attempts.
- Firewall counters increase.
- Logs show incoming packets.

---

## Resolution

- Allow the required VPN protocol.
- Review Input Chain rules.
- Verify Interface Lists.
- Confirm correct WAN interface.

---

## Prevention

Document every Internet-facing firewall rule.

Review exposed services regularly.

---

# Problem 2 — Connected but Internal Resources Unreachable

## Symptoms

Users authenticate successfully.

However they cannot:

- Access file servers.
- Ping internal hosts.
- Connect using RDP.
- Open internal web applications.

---

## Possible Causes

- Forward Chain blocking traffic
- Missing firewall rule
- Incorrect Address List
- VLAN restriction
- Network segmentation policy

---

## Diagnosis

Review:

- Forward Chain
- Interface Lists
- Address Lists
- VLAN policy
- Routing

---

## Verification

Verify communication step by step.

VPN Client

↓

VPN Gateway

↓

Firewall

↓

Internal Gateway

↓

Destination Host

Determine the exact point where traffic stops.

---

## Resolution

Modify only the required firewall rule.

Avoid broad "Allow All" rules.

Maintain Least Privilege.

---

## Prevention

Review firewall policies whenever new VPN networks are introduced.

---

# Problem 3 — One-Way Communication

## Symptoms

- Client reaches server.
- Server cannot respond.
- Ping succeeds only one direction.
- TCP sessions fail.

---

## Possible Causes

- Forward Chain
- Asymmetric Routing
- Incorrect NAT
- Missing Return Route

---

## Diagnosis

Verify:

- Forward Chain
- Route Table
- NAT Rules
- Gateway Selection

---

## Resolution

Correct routing first.

Then review firewall rules.

Finally review NAT.

---

## Prevention

Always verify bidirectional communication.

---

# NAT Troubleshooting

Network Address Translation is frequently responsible for VPN communication failures.

Review NAT only after authentication and routing have been verified.

---

# Problem 4 — Internet Access Through VPN Fails

## Symptoms

- VPN connected.
- Internal LAN accessible.
- Internet unavailable.

---

## Possible Causes

- Missing Masquerade
- Incorrect Source NAT
- Incorrect Default Route
- Firewall restrictions

---

## Diagnosis

Verify:

- Source NAT
- Masquerade
- Default Route
- WAN Interface

---

## Resolution

Correct Source NAT configuration.

Verify Internet routing.

---

## Prevention

Document every NAT rule.

Avoid duplicate Masquerade rules.

---

# Problem 5 — Hairpin NAT Failure

## Symptoms

Internal users cannot access services using the organization's public domain name.

External users connect successfully.

---

## Possible Causes

- Missing Hairpin NAT
- Incorrect DNS
- Incorrect NAT order

---

## Diagnosis

Review:

- NAT Rules
- DNS Resolution
- Firewall

---

## Resolution

Implement Hairpin NAT.

Verify internal DNS behavior.

---

## Prevention

Document every published service.

Validate internal and external access.

---

# DNS Troubleshooting

DNS issues frequently appear to be VPN failures.

Always verify DNS independently.

---

# Problem 6 — Internal Hostnames Cannot Be Resolved

## Symptoms

Users can:

- Ping IP addresses.

Users cannot:

- Resolve hostnames.
- Locate Active Directory.
- Access internal applications by name.

---

## Possible Causes

- Wrong DNS server
- Firewall blocking DNS
- Incorrect DNS suffix
- Internal DNS unavailable

---

## Diagnosis

Verify:

- Assigned DNS Server
- DNS Reachability
- DNS Suffix
- Internal DNS Records

---

## Resolution

Assign internal DNS servers to VPN clients.

Verify firewall rules.

Review DNS forwarding.

---

## Prevention

Never rely on public DNS servers for internal infrastructure.

---

# Problem 7 — DNS Resolution is Slow

## Symptoms

- Applications pause.
- Login delays.
- Slow file access.
- Intermittent failures.

---

## Possible Causes

- DNS timeout
- Incorrect Forwarder
- Packet Loss
- WAN latency

---

## Diagnosis

Measure:

- DNS response time
- Packet loss
- WAN latency

---

## Resolution

Correct DNS infrastructure before modifying VPN configuration.

---

## Prevention

Monitor DNS continuously.

Include DNS in infrastructure monitoring.

---

# Firewall, NAT and DNS Troubleshooting Summary

Most communication failures originate from one of the following:

- Firewall Input Chain
- Firewall Forward Chain
- Incorrect NAT
- Missing Hairpin NAT
- Incorrect DNS Server
- Missing Return Route
- Incorrect VLAN Policy

Always troubleshoot in the following order:

```text
Authentication

↓

Firewall

↓

Routing

↓

NAT

↓

DNS

↓

Applications
```

---

# Troubleshooting Decision Tree

When diagnosing VPN connectivity problems, follow the troubleshooting process in the order shown below.

Changing multiple configuration elements simultaneously should be avoided, as it makes identifying the root cause significantly more difficult.

```text
VPN Doesn't Connect

        │
        ▼
Can Reach Public IP?

        │
   ┌────┴────┐
   │         │
  NO        YES
   │         │
Internet   Can Reach VPN Port?
               │
          ┌────┴────┐
          │         │
         NO        YES
          │         │
     Firewall   Authentication
                     │
                     ▼
                  Routing
                     │
                     ▼
                     DNS
                     │
                     ▼
               Application Access
                     │
                     ▼
                 Problem Solved
```

Following this structured workflow helps isolate the failing component quickly while minimizing unnecessary configuration changes and reducing service downtime.

---

# Conclusion

Most VPN incidents are not caused by the VPN protocol itself, but by issues related to firewall policies, routing, NAT, DNS or authentication.

By following the systematic troubleshooting methodology presented throughout this document, administrators can identify the root cause efficiently, reduce recovery time and maintain a secure, stable and well-documented VPN infrastructure.

The procedures described in this guide apply to WireGuard, OpenVPN and L2TP/IPsec deployments based on MikroTik RouterOS and should be incorporated into every production support and operational workflow.
