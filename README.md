# BGP Vortex: Update Message Floods Can Create Internet Instabilities

This repository contains a GNS3-based simulation environment demonstrating the **BGP Vortex** vulnerability discovered and presented at USENIX Security 2025.

## Research Paper

**Title:** BGP Vortex: Update Message Floods Can Create Internet Instabilities

**Authors:** Felix Stöger (ETH Zurich), Henry Birge-Lee (Princeton University), Giacomo Giuliari (Mysten Labs), Jordi Subira-Nieto (ETH Zurich), Adrian Perrig (ETH Zurich)

**Conference:** USENIX Security 2025

**Research Resources:**
- [Presentation](https://www.usenix.org/conference/usenixsecurity25/presentation/stoeger)
- [Full Paper PDF](https://www.usenix.org/system/files/usenixsecurity25-stoeger.pdf)
- [Appendix PDF](https://www.usenix.org/system/files/usenixsecurity25-appendix-stoeger.pdf)
- [Presentation Slides](https://www.usenix.org/system/files/sec25_slides_stoeger-felix.pdf)

## Overview

The **BGP Vortex** is a critical vulnerability in the Border Gateway Protocol (BGP) that can be exploited to create persistent Internet instability. The vulnerability can be triggered by just **three legitimate BGP UPDATE messages**, potentially causing widespread Internet connectivity issues through:

- Router overload
- Forwarding loops
- Routing instability

### Key Findings

- **Persistent instability**: The attack can cause sustained BGP routing oscillations
- **Legitimate protocol messages**: The vulnerability exploits standards-compliant BGP extensions, making it impossible to prevent using existing security mechanisms like BGPSEC or RPKI
- **Universal vulnerability**: All major router implementations tested are susceptible to this threat
- **Root cause**: BGP Communities and other BGP extensions used for traffic engineering can trigger the vulnerability when misconfigured

### Attack Vector

The BGP Vortex is caused by standards-compliant BGP extensions—specifically **BGP Communities**—that allow modification of route preferences for traffic engineering purposes. When these extensions interact in specific ways, they can create a state where routers continuously exchange UPDATE messages, leading to persistent instability.

## Project Structure

This GNS3 environment simulates the BGP Vortex attack scenario with autonomous systems (ASes) configured to demonstrate the vulnerability:

```
BGP-Vortex/
├── AS1.ios              # AS 65001 configuration (Peer provider)
├── AS2.ios              # AS 65002 configuration (Peer provider)
├── AS3.ios              # AS 65003 configuration (Peer provider)
├── AttackerAS10.ios      # AS 65010 configuration (Malicious customer AS)
├── presentation.sh      # Kali Linux presentation node setup script
└── README.md           # This file
```

### Router Configurations

Each router is configured with:
- **BGP Communities**: For traffic engineering and route preference manipulation
- **Route Maps**: To enforce Gao-Rexford propagation rules
- **Interface Configurations**: Connecting the autonomous systems

The configurations demonstrate how BGP Communities can be misused to trigger the vortex conditions that cause persistent routing oscillations.

## GNS3 Simulation Setup

### Requirements

- GNS3
- Cisco IOS Router images (c3700-adventerprisek9-mz.124-11.T3.bin or similar)
- Kali Linux appliance (or any Linux-based node)

### Network Configuration

The `presentation.sh` script configures the Kali Linux presentation node with multiple network interfaces connected to each AS:

- **eth1**: Connected to AS 65001 (172.16.1.10/24)
- **eth2**: Connected to AS 65002 (172.16.2.10/24)
- **eth3**: Connected to AS 65003 (172.16.3.10/24)
- **eth0**: Internet connected interface

The script runs MTR (My Traceroute) tools to monitor routing instability across the different AS connections.

## How to Use

1. **Import into GNS3**:
   - Create a new GNS3 project
   - Add Cisco IOS routers for each AS
   - Configure them with the provided `.ios` files
   - Add a Kali Linux node for observation

2. **Load Router Configurations**:
   - Copy the configuration from each `.ios` file
   - Paste into the corresponding router's console

3. **Run Presentation Script**:
   - Connect to the Kali Linux node
   - Execute `presentation.sh` to set up network interfaces
   - Observe routing table changes and BGP UPDATE message floods

4. **Observe the BGP Vortex**:
   - Monitor BGP UPDATE messages using `show ip bgp` commands
   - Watch for routing oscillations
   - Observe the impact on forwarding tables

## Security Implications

### Current Limitations of Existing Security Mechanisms

The BGP Vortex **cannot be prevented** by:
- **BGPSEC**: Only validates the origin of BGP announcements, not the validity of routes themselves
- **RPKI**: Route Origin Validation cannot detect illegitimate route communities

### Mitigation Strategy

The research proposes a **framework to determine which BGP extensions are problematic** and which are safe to deploy. This includes:

1. Careful analysis of BGP extension interactions
2. Traffic engineering capability vs. routing stability trade-offs
3. Validation of route community application on all major platforms

## Impact

This research highlights critical security issues in the BGP protocol infrastructure that:

- Affects the stability of the entire Internet
- Exploits legitimate protocol features
- Requires careful protocol evolution and operator education
- Demonstrates the need for comprehensive BGP extension validation

## References

- [USENIX Security 2025 Conference](https://www.usenix.org/conference/usenixsecurity25)
- [BGP Communities (RFC 1997)](https://tools.ietf.org/html/rfc1997)
- [BGP Route Oscillation Control (RFC 3345)](https://tools.ietf.org/html/rfc3345)

## License

This project is provided for educational and research purposes as part of the USENIX Security 2025 research publication.

---

**Note**: This simulation environment is for educational purposes only. Do not attempt to exploit actual BGP vulnerabilities on production networks.
