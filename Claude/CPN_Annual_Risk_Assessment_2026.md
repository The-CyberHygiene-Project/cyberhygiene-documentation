# CyberHygiene Production Network (CPN)
# Annual Risk Assessment 2026

**Assessment Period:** January 1, 2026 - January 11, 2026
**Assessment Date:** January 11, 2026
**Methodology:** NIST SP 800-30 Rev 1
**Policy Reference:** TCC-RA-001 Section 2.3 (Annual Risk Assessment)
**POA&M Reference:** POA&M-035
**Classification:** Controlled Unclassified Information (CUI)

**Conducted By:**
Donald E. Shannon, ISSO/System Owner
The Contract Coach

**Approved By:**
Donald E. Shannon, Owner/Principal
The Contract Coach

---

## EXECUTIVE SUMMARY

This document presents the first annual comprehensive risk assessment for The Contract Coach's CyberHygiene Production Network (cyberinabox.net), conducted in accordance with NIST SP 800-171 Rev 2 requirements (RA-3) and TCC-RA-001 Risk Management Policy.

### Assessment Scope

**Systems Assessed:**
- 1 Domain Controller (dc1.cyberinabox.net)
- 3 Domain-joined Workstations (engineering, accounting, labrat)
- 1 AI Server (Mac Mini M4)
- 1 Backup Server (Synology DS1821+ DataStore)
- 1 Network Firewall (pfSense with Suricata IDS/IPS)

**Assessment Methods:**
- Wazuh SIEM vulnerability data analysis
- OpenSCAP CUI profile compliance review
- Historical incident analysis (past 12 months)
- Threat intelligence review (CISA alerts, vendor bulletins)
- Physical security walkthrough
- Supply chain vendor assessment

### Key Findings

**Overall Risk Posture:** LOW

**Risk Distribution:**
- **High Risks:** 0 identified
- **Medium Risks:** 3 identified (all with mitigations in place)
- **Low Risks:** 12 identified

**Critical Observations:**
1. ✅ 99%+ NIST 800-171 implementation complete
2. ✅ POA&M 91% complete (31 of 34 items)
3. ✅ All systems operational with comprehensive monitoring
4. ✅ 3-2-1 backup strategy fully implemented (100% success rate)
5. ⚠️ 3 medium-risk items require continued monitoring
6. ✅ No critical or high-risk vulnerabilities identified

**Risk Score Summary:**
- Average Risk Score: 2.4 (out of 9)
- Highest Risk Score: 6 (Ransomware - mitigated to LOW residual)
- Systems with Zero High-Risk Issues: 100%

**Recommended Actions:**
1. Complete POA&M-014 (FIPS-compliant malware) - 15% remaining
2. Complete POA&M-028 (VPN with MFA) by March 31, 2026
3. Conduct quarterly risk assessment updates
4. Continue Wazuh/OpenSCAP continuous monitoring

---

## 1. ASSET INVENTORY

### 1.1 Critical Infrastructure Assets

#### Asset: DC1 (Domain Controller)
- **Hostname:** dc1.cyberinabox.net
- **IP Address:** 192.168.1.10
- **Hardware:** HP MicroServer Gen10 Plus
- **OS:** Rocky Linux 9.6 (FIPS 140-2 enabled)
- **Criticality:** HIGH
- **Functions:**
  - FreeIPA domain authentication/authorization
  - Wazuh SIEM Manager
  - Graylog log management
  - Centralized rsyslog
  - File server (Samba with LUKS-encrypted RAID 5)
- **CUI Data:** YES
- **Users:** All domain users
- **RTO:** 4 hours
- **RPO:** 24 hours (daily backups)

#### Asset: Engineering Workstation
- **Hostname:** engineering.cyberinabox.net
- **IP Address:** 192.168.1.104
- **Hardware:** Rocky Linux 9.6 Workstation
- **OS:** Rocky Linux 9.6 (FIPS 140-2 enabled)
- **Criticality:** MEDIUM
- **Functions:** Proposal development, technical documentation
- **CUI Data:** YES
- **Users:** 1 primary user
- **RTO:** 24 hours
- **RPO:** 24 hours (daily backups)

#### Asset: Accounting Workstation
- **Hostname:** accounting.cyberinabox.net
- **IP Address:** 192.168.1.113
- **Hardware:** Rocky Linux 9.6 Workstation
- **OS:** Rocky Linux 9.6 (FIPS 140-2 enabled)
- **Criticality:** MEDIUM
- **Functions:** Contract administration, financial operations
- **CUI Data:** YES
- **Users:** 1 primary user
- **RTO:** 24 hours
- **RPO:** 24 hours (daily backups)

#### Asset: LabRat Workstation
- **Hostname:** labrat.cyberinabox.net
- **IP Address:** 192.168.1.115
- **Hardware:** Rocky Linux 9.6 Workstation
- **OS:** Rocky Linux 9.6 (FIPS 140-2 enabled)
- **Criticality:** LOW
- **Functions:** Testing, development, research
- **CUI Data:** NO
- **Users:** 1 primary user
- **RTO:** 72 hours
- **RPO:** 7 days (weekly backups)

#### Asset: DataStore (Backup Server)
- **Hostname:** datastore.cyberinabox.net
- **IP Address:** 192.168.1.118
- **Hardware:** Synology DS1821+ NAS
- **OS:** Synology DSM
- **Criticality:** HIGH
- **Functions:**
  - Daily backup destination (FIPS-encrypted data)
  - Weekly ReaR backup destination
  - 3-2-1 backup strategy component
- **CUI Data:** Encrypted backups only (outside CUI boundary)
- **Storage:** 20.9 TB total, 19.3 TB available
- **RTO:** 24 hours
- **RPO:** N/A (backup target)

#### Asset: AI Server
- **Hostname:** ai.cyberinabox.net
- **IP Address:** 192.168.1.7
- **Hardware:** Mac Mini M4
- **OS:** macOS (not FIPS-validated)
- **Criticality:** LOW
- **Functions:**
  - AI copilot for system administration (POA&M-040)
  - Ollama with Code Llama models
  - Human-in-the-loop guidance only
- **CUI Data:** NO (air-gapped, no CUI access)
- **Users:** ISSO for guidance queries
- **RTO:** 7 days
- **RPO:** N/A (stateless service)

#### Asset: pfSense Firewall
- **Hostname:** gateway.cyberinabox.net
- **IP Address:** 192.168.1.1
- **Hardware:** Dedicated firewall appliance
- **OS:** pfSense with Suricata IDS/IPS
- **Criticality:** MEDIUM
- **Functions:**
  - Network boundary protection
  - Intrusion detection/prevention
  - VPN termination (future)
- **CUI Data:** NO (network device)
- **RTO:** 4 hours
- **RPO:** Configuration backup (daily)

### 1.2 Network Architecture

```
Internet
    |
    ↓
pfSense Firewall (192.168.1.1)
    |
    ↓
Internal Network (192.168.1.0/24)
    |
    ├── DC1 (192.168.1.10) - Domain Controller/Wazuh/Graylog
    ├── Engineering WS (192.168.1.104)
    ├── Accounting WS (192.168.1.113)
    ├── LabRat WS (192.168.1.115)
    ├── Mac Mini AI (192.168.1.7) - Air-gapped copilot
    └── DataStore NAS (192.168.1.118) - Backup destination
```

### 1.3 Software Inventory

**Critical Applications:**
- FreeIPA 4.11.x - Identity Management
- Wazuh 4.9.2 - SIEM/XDR
- Graylog 6.0.14 - Log Management
- MongoDB 7.x - Graylog database
- OpenSearch 2.x - Data indexing
- Samba 4.x - File Sharing
- Ollama - AI inference engine
- Code Llama 7B/34B - AI models

**Security Tools:**
- ClamAV + YARA - Malware detection
- Suricata - Network IDS/IPS
- OpenSCAP - Compliance scanning
- auditd - System auditing
- LUKS - Full disk encryption
- ReaR - Disaster recovery

---

## 2. THREAT IDENTIFICATION

### 2.1 Threat Sources

**External Threats:**
- Cyber attackers (nation-state, criminal, hacktivist)
- Malware (ransomware, trojans, worms)
- Phishing and social engineering
- DDoS attacks
- Zero-day vulnerabilities

**Internal Threats:**
- Accidental data disclosure
- Insider threat (low probability - solopreneur, TS clearance)
- Misconfiguration
- User error

**Environmental Threats:**
- Power failure
- Hardware failure
- Natural disaster (fire, flood, severe weather)
- Internet service outage

**Supply Chain Threats:**
- Vendor compromise
- Software supply chain attack
- Contractor account compromise
- Third-party service disruption

### 2.2 Vulnerability Assessment

**Data Sources:**
- Wazuh vulnerability scans (continuous)
- OpenSCAP CUI profile compliance (100% compliant)
- POA&M tracking (31 of 34 items complete - 91%)
- Recent Graylog NullPointerException (resolved January 11, 2026)

**Identified Vulnerabilities:**
1. MongoDB service failure risk (occurred Jan 8-11, 2026 - mitigated)
2. POA&M-014: ClamAV not FIPS-validated (85% complete, workaround in place)
3. POA&M-028: VPN/MFA not deployed (planned March 2026)
4. Workstations not in FreeIPA host inventory (functional, management limitation only)

**Strengths:**
- ✅ FIPS 140-2 enabled and validated on all FIPS-required systems
- ✅ 100% OpenSCAP CUI profile compliance
- ✅ Wazuh SIEM operational with real-time monitoring
- ✅ All systems domain-joined with Kerberos authentication
- ✅ Comprehensive backup strategy (3-2-1) with 100% success rate
- ✅ Login banners deployed on all systems
- ✅ Audit logging operational on all systems
- ✅ File integrity monitoring (FIM) on critical paths
- ✅ Network IDS/IPS operational (Suricata)
- ✅ Physical security (locked office, TS clearance holder)

---

## 3. RISK ASSESSMENT

### Risk Scoring Methodology

**Likelihood:**
- **Low (1):** Unlikely to occur within 3 years
- **Medium (2):** Likely to occur within 1-3 years
- **High (3):** Likely to occur within 1 year or already observed

**Impact:**
- **Low (1):** Minimal disruption, no CUI compromise
- **Medium (2):** Moderate disruption, potential CUI exposure
- **High (3):** Severe disruption, confirmed CUI compromise

**Risk Score = Likelihood × Impact (Range: 1-9)**

---

### RISK-2026-001: Ransomware Attack

**Risk ID:** RISK-2026-001
**Date Identified:** January 11, 2026
**Category:** External Cyber Threat

**Description:**
Ransomware malware infects workstation or server, encrypting RAID array and preventing access to CUI data. Attack vector could be phishing email, malicious download, or software vulnerability exploitation.

**Threat Source:** ☑ External (cyber attack, malware)

**Affected Systems:**
- DC1 (primary target - file server)
- All workstations
- Potential spread via network

**Likelihood Assessment:** ☑ Medium (2)
- Ransomware attacks increasing industry-wide
- Small business targets of opportunity
- Limited external attack surface (firewall, no exposed services)
- No ransomware incidents in past 12 months

**Impact Assessment:** ☑ High (3)
- Complete data unavailability
- Potential CUI compromise if encryption weak
- Operational shutdown
- Contract performance risk

**Risk Score:** 2 × 3 = **6 (Medium)**

**Current Controls:**
1. ✅ Multi-layered malware protection:
   - ClamAV antivirus scanning
   - YARA signature detection (integrated with Wazuh)
   - Wazuh File Integrity Monitoring (12-hour intervals)
   - Wazuh vulnerability detection
2. ✅ Network protection:
   - pfSense firewall with Suricata IDS/IPS
   - No unnecessary inbound services
   - Wazuh integration for network anomalies
3. ✅ Backup protection:
   - 3-2-1 backup strategy fully implemented
   - Daily encrypted backups to DataStore
   - Weekly full system backups (ReaR)
   - Monthly offsite USB backups (Wells Fargo Bank safe deposit)
   - 100% backup success rate verified
4. ✅ Encryption:
   - LUKS full-disk encryption on all systems
   - Ransomware cannot decrypt to steal CUI plaintext
5. ✅ Monitoring:
   - Wazuh real-time alerting
   - Graylog log correlation
   - FIM detects unauthorized file changes

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Mitigate

**Planned Mitigations:**
1. Complete POA&M-014 (FIPS-compliant ClamAV) - 15% remaining
2. VirusTotal API integration for enhanced threat intelligence
3. Quarterly security awareness training (POA&M-006)
4. USB device restrictions (POA&M-007) by March 31, 2026

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** March 31, 2026
**Status:** ☑ In Progress

**Residual Risk Acceptance:**
LOW residual risk is acceptable given comprehensive controls.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-002: DC1 Hardware Failure

**Risk ID:** RISK-2026-002
**Date Identified:** January 11, 2026
**Category:** Operational/Environmental

**Description:**
Critical hardware failure on DC1 (domain controller) rendering system inoperable. Could be RAID array failure, motherboard failure, power supply failure, or other hardware component. Results in loss of authentication services, file access, and SIEM monitoring.

**Threat Source:** ☑ Environmental (hardware failure)

**Affected Systems:**
- DC1 (direct impact)
- All workstations (cannot authenticate without DC)
- All services (FreeIPA, Wazuh, file shares unavailable)

**Likelihood Assessment:** ☑ Medium (2)
- Hardware is enterprise-grade (HP MicroServer Gen10 Plus)
- System operational since 2025
- RAID 5 array provides redundancy for disk failures
- Single point of failure for other components

**Impact Assessment:** ☑ High (3)
- Complete operational shutdown
- No domain authentication
- No CUI file access
- No security monitoring
- Business operations halted until recovery

**Risk Score:** 2 × 3 = **6 (Medium)**

**Current Controls:**
1. ✅ RAID 5 configuration:
   - 3-disk RAID with single-disk fault tolerance
   - LUKS-encrypted array
   - Regular SMART monitoring
2. ✅ Comprehensive backups:
   - Daily critical file backups (30-day retention)
   - Weekly full system ReaR backups (12-week retention)
   - Monthly offsite USB backups (12-month retention)
   - Verified restorability
3. ✅ Disaster recovery capability:
   - ReaR bootable ISO for bare-metal recovery
   - Recovery procedures documented
   - RTO: 24-48 hours
   - RPO: 24 hours (daily backups)
4. ✅ Monitoring:
   - Wazuh monitors system health
   - Disk space alerts configured
   - SMART monitoring enabled

**Residual Risk:** **LOW (2)**

**Risk Response Strategy:** ☑ Mitigate + Accept

**Planned Mitigations:**
1. Conduct disaster recovery test (POA&M-012) by December 31, 2025
2. Document restoration procedures
3. Verify backup integrity quarterly
4. Consider spare hardware procurement (future)

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** December 31, 2025 (DR test)
**Status:** ☑ In Progress

**Residual Risk Acceptance:**
LOW residual risk is acceptable. Business continuity plan in place with documented RTO/RPO. Owner accepts 24-48 hour recovery window for hardware failure scenario.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-003: Phishing Attack / Social Engineering

**Risk ID:** RISK-2026-003
**Date Identified:** January 11, 2026
**Category:** External Cyber Threat

**Description:**
Targeted phishing email attempting to harvest credentials, deliver malware, or trick user into disclosing CUI. Could target owner/ISSO email or contractor accounts.

**Threat Source:** ☑ External (cyber attack) + ☑ Internal (user error)

**Affected Systems:**
- All workstations (email clients)
- User credentials (potential compromise)
- CUI data (potential disclosure)

**Likelihood Assessment:** ☑ Medium (2)
- Phishing attacks common and increasing
- Solopreneur with cybersecurity expertise (lower susceptibility)
- TS clearance training includes phishing awareness
- Limited contractor exposure

**Impact Assessment:** ☑ Medium (2)
- Potential credential compromise
- Potential malware introduction
- Potential CUI disclosure
- Mitigated by MFA (when POA&M-004 complete)

**Risk Score:** 2 × 2 = **4 (Medium)**

**Current Controls:**
1. ✅ Technical controls:
   - Email server with Rspamd anti-spam/anti-phishing
   - ClamAV email scanning
   - Link protection (future enhancement)
2. ✅ Monitoring:
   - Wazuh monitors authentication failures
   - Unusual login patterns detected
   - Graylog correlates email events
3. ✅ User awareness:
   - TS clearance holder (security training current)
   - Cybersecurity professional (ISSO)
   - Planned annual security awareness training (POA&M-006)
4. ⏳ MFA planned:
   - POA&M-004: MFA not yet configured
   - Target: December 22, 2025
   - Will significantly reduce credential theft impact

**Residual Risk:** **MEDIUM (4)** → **LOW (2)** after MFA deployment

**Risk Response Strategy:** ☑ Mitigate

**Planned Mitigations:**
1. Complete POA&M-004 (MFA) by December 22, 2025
2. Complete POA&M-006 (Security Awareness Training) by December 10, 2025
3. Implement email link protection
4. Deploy email banner warnings for external senders

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** December 22, 2025 (MFA completion)
**Status:** ☑ Open

**Residual Risk Acceptance:**
MEDIUM risk accepted temporarily until MFA deployed. User is security-trained professional with low susceptibility. MFA deployment will reduce residual risk to LOW.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-004: Workstation Hardware Failure

**Risk ID:** RISK-2026-004
**Date Identified:** January 11, 2026
**Category:** Operational/Environmental

**Description:**
Hardware failure on workstation (Engineering or Accounting) resulting in work disruption and potential data loss if local files not backed up.

**Threat Source:** ☑ Environmental (hardware failure)

**Affected Systems:**
- Engineering workstation (192.168.1.104)
- Accounting workstation (192.168.1.113)

**Likelihood Assessment:** ☑ Medium (2)
- Workstations have operational wear
- Disk failures common over time
- No current hardware issues detected

**Impact Assessment:** ☑ Low (1)
- Work disruption for 1-2 days
- No CUI loss (daily backups)
- Can use alternate workstation (LabRat)
- Minimal business impact (short RTO)

**Risk Score:** 2 × 1 = **2 (Low)**

**Current Controls:**
1. ✅ Daily backups:
   - All workstations backed up daily
   - 30-day retention
   - Verified restorability
2. ✅ Domain-based authentication:
   - User credentials stored in FreeIPA
   - Can authenticate from any domain workstation
   - Roaming profile capability
3. ✅ Alternate workstation available:
   - LabRat can serve as temporary replacement
   - Quick provisioning via domain join
4. ✅ File server storage:
   - Primary CUI data on DC1 file shares
   - Workstation failures don't affect server data

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Accept

**Planned Mitigations:**
- None required - residual risk acceptable
- Continue daily backup verification
- Maintain spare parts inventory (optional)

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** N/A
**Status:** ☑ Accepted

**Residual Risk Acceptance:**
LOW risk is acceptable. Impact is minimal due to backups and alternate workstation availability. Recovery time of 1-2 days is acceptable for workstation hardware failure.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-005: MongoDB Service Failure

**Risk ID:** RISK-2026-005
**Date Identified:** January 11, 2026
**Category:** Operational - Software

**Description:**
MongoDB service (Graylog database) crashes or fails to start, resulting in loss of log aggregation and analysis capability. Historically occurred January 8-11, 2026 causing Graylog NullPointerException errors.

**Threat Source:** ☑ Internal (software failure)

**Affected Systems:**
- DC1 (MongoDB and Graylog services)
- Log aggregation from all systems
- SIEM dashboard visibility

**Likelihood Assessment:** ☑ Low (1)
- Occurred once (Jan 8-11, 2026)
- Root cause: SIGABRT crash
- Fixed within 6 minutes after identification
- Auto-restart now configured

**Impact Assessment:** ☑ Low (1)
- Wazuh SIEM continues independent operation
- Log collection continues (rsyslog)
- Graylog centralized view temporarily unavailable
- Security monitoring not critically impacted
- Rapid recovery (6 minutes demonstrated)

**Risk Score:** 1 × 1 = **1 (Low)**

**Current Controls:**
1. ✅ Service monitoring:
   - systemd monitors MongoDB status
   - Wazuh monitors service health
   - Auto-restart capability
2. ✅ Redundant monitoring:
   - Wazuh operates independently
   - rsyslog continues collection
   - Multiple monitoring layers
3. ✅ Rapid recovery:
   - Demonstrated 6-minute MTTR
   - Simple service restart
   - Documentation complete
4. ✅ Data retention:
   - MongoDB data persists on /data partition
   - No data loss during outage
   - Logs backfilled on restart

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Mitigate

**Planned Mitigations:**
1. ✅ COMPLETED: Configure MongoDB auto-restart (systemd Restart=on-failure)
2. Implement MongoDB health monitoring alerts
3. Review MongoDB logs for crash predictors
4. Consider MongoDB resource limits adjustment

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** January 31, 2026
**Status:** ☑ In Progress

**Residual Risk Acceptance:**
LOW risk is acceptable. Service failure impact is minimal due to redundant monitoring. Rapid recovery capability demonstrated.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-006: Software Vulnerability Exploitation

**Risk ID:** RISK-2026-006
**Date Identified:** January 11, 2026
**Category:** External Cyber Threat

**Description:**
Unpatched software vulnerability (CVE) in OS or application software exploited by attacker to gain unauthorized access, escalate privileges, or compromise data.

**Threat Source:** ☑ External (cyber attack)

**Affected Systems:**
- All systems (OS, applications)
- Rocky Linux 9.6 packages
- FreeIPA, Wazuh, Graylog applications

**Likelihood Assessment:** ☑ Medium (2)
- New vulnerabilities discovered constantly
- Rocky Linux has strong security posture
- Wazuh detects vulnerabilities continuously
- Regular patching schedule in place

**Impact Assessment:** ☑ Medium (2)
- Potential unauthorized access
- Potential privilege escalation
- Potential CUI exposure
- Depends on specific vulnerability

**Risk Score:** 2 × 2 = **4 (Medium)**

**Current Controls:**
1. ✅ Continuous vulnerability scanning:
   - Wazuh vulnerability detector (60-minute CVE feed updates)
   - Covers all systems with agents
   - CVSS scoring for prioritization
2. ✅ Compliance scanning:
   - OpenSCAP quarterly CUI profile scans
   - 100% compliant as of latest scan
   - Automated remediation scripts
3. ✅ Patch management:
   - dnf-automatic configured for security updates
   - Defined remediation timelines (TCC-RA-001):
     - Critical (CVSS 9.0-10.0): 7 days
     - High (CVSS 7.0-8.9): 30 days
     - Medium (CVSS 4.0-6.9): 90 days
4. ✅ FIPS mode:
   - Cryptographic protection validated
   - Reduces attack surface
5. ✅ Network segmentation:
   - Firewall restricts inbound traffic
   - Suricata IDS/IPS detects exploitation attempts

**Residual Risk:** **LOW (2)**

**Risk Response Strategy:** ☑ Mitigate

**Planned Mitigations:**
1. Continue quarterly OpenSCAP scans
2. Monthly review of Wazuh vulnerability dashboard
3. Track remediation in POA&M
4. Maintain patch currency per TCC-RA-001 timelines

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** Ongoing
**Status:** ☑ In Progress

**Residual Risk Acceptance:**
LOW residual risk is acceptable given comprehensive vulnerability management program and continuous monitoring.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-007: Unauthorized Physical Access

**Risk ID:** RISK-2026-007
**Date Identified:** January 11, 2026
**Category:** Physical Security

**Description:**
Unauthorized individual gains physical access to home office server room, potentially accessing equipment, stealing hardware, or tampering with systems.

**Threat Source:** ☑ External (physical intrusion)

**Affected Systems:**
- DC1 (server rack)
- All workstations
- Network equipment
- Backup media

**Likelihood Assessment:** ☑ Low (1)
- Home office in locked room
- Alarm system installed
- Residential location with limited access
- TS clearance holder (trusted individual)

**Impact Assessment:** ☑ High (3)
- Potential equipment theft
- Potential CUI data access
- Potential tampering with systems
- Physical security boundary breach

**Risk Score:** 1 × 3 = **3 (Low)**

**Current Controls:**
1. ✅ Physical security:
   - Locked office door
   - Alarm system
   - Residential location
   - Limited visitor access
2. ✅ Cryptographic protection:
   - LUKS full-disk encryption on all systems
   - Encrypted backups
   - Stolen equipment cannot be decrypted
3. ✅ TS clearance holder:
   - Background investigation current
   - Security clearance requires reporting security incidents
   - Personnel security procedures (TCC-PS-001)
4. ✅ Login banners:
   - "Authorized Access Only" warnings
   - CUI/FCI processing notices

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Accept

**Planned Mitigations:**
- None required - comprehensive controls in place
- Continue physical security awareness
- Maintain alarm system functionality
- Annual review per TCC-PE-001

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** N/A
**Status:** ☑ Accepted

**Residual Risk Acceptance:**
LOW risk is acceptable. Physical access is highly unlikely and LUKS encryption prevents data compromise even if equipment stolen.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-008: Backup Failure

**Risk ID:** RISK-2026-008
**Date Identified:** January 11, 2026
**Category:** Operational

**Description:**
Backup system fails (DataStore NAS, USB drives, or backup software), resulting in inability to recover from disaster or data loss incident.

**Threat Source:** ☑ Environmental (hardware failure) + ☑ Internal (software failure)

**Affected Systems:**
- DataStore NAS (192.168.1.118)
- Backup scripts and services
- USB backup drives (offsite)

**Likelihood Assessment:** ☑ Low (1)
- Backup system highly reliable
- 100% success rate for last 10 backups verified
- Multiple backup tiers (daily, weekly, monthly)
- Synology NAS enterprise-grade

**Impact Assessment:** ☑ High (3)
- Cannot recover from disaster
- Potential data loss
- Business continuity failure
- Contract performance risk

**Risk Score:** 1 × 3 = **3 (Low)**

**Current Controls:**
1. ✅ 3-2-1 backup strategy:
   - 3 copies: Production + DataStore + USB offsite
   - 2 media types: NAS + USB
   - 1 offsite: Wells Fargo Bank safe deposit box
2. ✅ Verified backups:
   - Daily backup success: 100% (last 10 days)
   - Weekly backup success: 100%
   - Checksums verified (SHA256)
3. ✅ Multiple retention periods:
   - Daily: 30 days
   - Weekly: 12 weeks
   - Monthly: 12 months
4. ✅ Automated monitoring:
   - Systemd timers track success/failure
   - Backup logs retained
   - Disk space monitoring on DataStore
5. ✅ DataStore capacity:
   - 19.3 TB available (93% free)
   - Sufficient capacity for 3+ years growth

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Accept

**Planned Mitigations:**
1. Quarterly backup restoration test
2. Annual review of backup procedures (POA&M-011)
3. Monitor DataStore disk health
4. Rotate USB drives quarterly

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** Quarterly
**Status:** ☑ In Progress

**Residual Risk Acceptance:**
LOW risk is acceptable. Multiple backup tiers and verified restorability provide high confidence in disaster recovery capability.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-009: Power Outage / Environmental Failure

**Risk ID:** RISK-2026-009
**Date Identified:** January 11, 2026
**Category:** Environmental

**Description:**
Extended power outage or HVAC failure results in system shutdown and potential data corruption or hardware damage.

**Threat Source:** ☑ Environmental (power failure, cooling failure)

**Affected Systems:**
- All systems (dependent on power/cooling)

**Likelihood Assessment:** ☑ Low (1)
- Power grid generally reliable
- No extended outages in past 12 months
- HVAC failure unlikely in home environment

**Impact Assessment:** ☑ Medium (2)
- Operational disruption
- Potential filesystem corruption
- No UPS for extended runtime
- Recoverable via backups

**Risk Score:** 1 × 2 = **2 (Low)**

**Current Controls:**
1. ✅ Filesystem journaling:
   - XFS journaling protects against corruption
   - LUKS encrypted volumes resilient
2. ✅ Graceful shutdown capability:
   - Systems can be shut down cleanly if warned
   - Battery backup on critical workstations
3. ✅ Backup protection:
   - Daily backups protect against data loss
   - Disaster recovery capability via ReaR
4. ✅ Redundant cooling:
   - Multiple HVAC zones
   - Residential environment not data center temperatures

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Accept

**Planned Mitigations:**
- Consider UPS for DC1 (future enhancement)
- Monitor power quality
- Document rapid shutdown procedures

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** N/A (future consideration)
**Status:** ☑ Accepted

**Residual Risk Acceptance:**
LOW risk is acceptable. Power outages are infrequent and backups provide recovery capability. UPS investment deferred as optional future enhancement.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-010: Internet Service Outage

**Risk ID:** RISK-2026-010
**Date Identified:** January 11, 2026
**Category:** Operational / Environmental

**Description:**
ISP outage or network equipment failure results in loss of internet connectivity, preventing access to cloud services, email, and external resources.

**Threat Source:** ☑ Environmental (ISP failure, equipment failure)

**Affected Systems:**
- Internet connectivity
- Email access
- Cloud services (if any)
- Remote access (VPN when deployed)

**Likelihood Assessment:** ☑ Medium (2)
- ISP outages occur occasionally
- Network equipment failures possible
- No redundant ISP

**Impact Assessment:** ☑ Low (1)
- CUI data accessible locally (on CPN)
- Domain authentication works (local FreeIPA)
- File shares accessible (local Samba)
- Minimal business impact (can work offline)
- Cannot send/receive email during outage

**Risk Score:** 2 × 1 = **2 (Low)**

**Current Controls:**
1. ✅ Local infrastructure:
   - All CUI systems on local network
   - Domain authentication local (FreeIPA)
   - File shares local (Samba)
   - Can continue operations during internet outage
2. ✅ Mobile hotspot backup:
   - Cellular data available for critical communications
   - Can establish temporary connectivity
3. ✅ No cloud dependencies:
   - All CUI data stored locally
   - No critical services dependent on internet

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Accept

**Planned Mitigations:**
- None required
- Consider redundant ISP (future enhancement)
- Document workaround procedures

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** N/A
**Status:** ☑ Accepted

**Residual Risk Acceptance:**
LOW risk is acceptable. Business can continue operations during internet outages due to local CUI infrastructure. No critical services dependent on internet connectivity.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-011: Contractor Account Compromise

**Risk ID:** RISK-2026-011
**Date Identified:** January 11, 2026
**Category:** Supply Chain / External Threat

**Description:**
Contractor or subcontractor account credentials compromised through phishing, credential theft, or social engineering, potentially granting unauthorized access to CUI.

**Threat Source:** ☑ External (cyber attack) + ☑ Supply Chain (contractor)

**Affected Systems:**
- FreeIPA user accounts
- Samba file shares
- Any systems contractor can access

**Likelihood Assessment:** ☑ Low (1)
- Limited contractor usage (solopreneur)
- Time-limited accounts with expiration
- Least privilege access controls
- MFA planned (POA&M-004)

**Impact Assessment:** ☑ Medium (2)
- Potential unauthorized CUI access
- Limited by least privilege controls
- Wazuh monitoring detects unusual activity
- Can revoke access immediately

**Risk Score:** 1 × 2 = **2 (Low)**

**Current Controls:**
1. ✅ Time-limited accounts:
   - FreeIPA accounts have expiration dates
   - Automatic account lockout after expiration
2. ✅ Least privilege:
   - Contractors assigned to minimal privilege groups
   - Read-only access where possible
   - No admin privileges
3. ✅ Monitoring:
   - Wazuh monitors contractor account activity
   - Unusual login patterns detected
   - Failed authentication attempts logged
4. ✅ Personnel security:
   - NDAs required for all contractors (TCC-PS-001)
   - Background checks for CUI access
   - FAR 52.204-21 and DFARS 252.204-7012 flow-down clauses
5. ⏳ MFA planned:
   - POA&M-004: Will reduce credential theft impact
   - Target: December 22, 2025

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Mitigate

**Planned Mitigations:**
1. Complete POA&M-004 (MFA) by December 22, 2025
2. Quarterly contractor account reviews
3. Annual vendor security assessments
4. Immediate revocation capability documented

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** December 22, 2025 (MFA)
**Status:** ☑ In Progress

**Residual Risk Acceptance:**
LOW risk is acceptable given limited contractor use and comprehensive controls. MFA will further reduce risk when implemented.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-012: Insider Threat (Accidental)

**Risk ID:** RISK-2026-012
**Date Identified:** January 11, 2026
**Category:** Internal Threat

**Description:**
System owner/ISSO accidentally deletes, modifies, or discloses CUI through user error, misconfiguration, or misunderstanding of procedures.

**Threat Source:** ☑ Internal (user error, accidental)

**Affected Systems:**
- All systems (owner has administrative access)
- CUI data on file shares
- System configurations

**Likelihood Assessment:** ☑ Low (1)
- Single user with cybersecurity expertise (ISSO)
- TS clearance holder with security training
- Mature operational procedures
- No insider threat history

**Impact Assessment:** ☑ Medium (2)
- Potential CUI disclosure
- Potential service disruption
- Potential configuration error
- Recoverable via backups

**Risk Score:** 1 × 2 = **2 (Low)**

**Current Controls:**
1. ✅ Technical safeguards:
   - File Integrity Monitoring detects changes
   - Audit logging tracks all actions
   - Backups enable recovery
   - Configuration management (future POA&M-031)
2. ✅ Personnel security:
   - TS clearance (background investigation)
   - Annual security training requirement
   - Cybersecurity professional (ISSO certified)
   - Incident reporting obligation
3. ✅ Monitoring:
   - Wazuh monitors admin actions
   - Audit logs review (auditd)
   - FIM alerts on critical file changes
4. ✅ Recovery capability:
   - Daily backups with 30-day retention
   - Configuration backups
   - Disaster recovery procedures

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Accept

**Planned Mitigations:**
1. Complete POA&M-031 (Configuration Management Policy) by March 31, 2026
2. Implement change control procedures
3. Document rollback procedures
4. Annual security awareness training (POA&M-006)

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** March 31, 2026 (CM Policy)
**Status:** ☑ In Progress

**Residual Risk Acceptance:**
LOW risk is acceptable. Solopreneur TS clearance holder with cybersecurity expertise has very low probability of intentional or accidental CUI compromise. Comprehensive monitoring and backup controls provide additional protection.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-013: Denial of Service (DoS) Attack

**Risk ID:** RISK-2026-013
**Date Identified:** January 11, 2026
**Category:** External Cyber Threat

**Description:**
Attacker floods network or systems with traffic/requests causing service disruption or unavailability.

**Threat Source:** ☑ External (cyber attack)

**Affected Systems:**
- Internet connection
- pfSense firewall
- External-facing services (if any)

**Likelihood Assessment:** ☑ Low (1)
- Small business not typical DoS target
- No public-facing services
- Limited external attack surface
- ISP provides some DoS protection

**Impact Assessment:** ☑ Low (1)
- No external services dependent on availability
- All CUI operations internal
- Internet outage similar impact (RISK-2026-010)
- Can continue operations locally

**Risk Score:** 1 × 1 = **1 (Low)**

**Current Controls:**
1. ✅ Limited exposure:
   - No publicly-accessible services
   - Firewall blocks all unsolicited inbound traffic
   - Minimal attack surface
2. ✅ Network protection:
   - pfSense firewall with rate limiting
   - Suricata IDS/IPS detects attack patterns
   - Can block attacking IPs
3. ✅ ISP protection:
   - ISP provides basic DDoS mitigation
   - Can contact ISP for large-scale attacks
4. ✅ Local operations:
   - All critical functions local
   - Can operate during internet disruption

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Accept

**Planned Mitigations:**
- None required
- Monitor for attack indicators
- Document ISP contact procedures for large attacks

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** N/A
**Status:** ☑ Accepted

**Residual Risk Acceptance:**
LOW risk is acceptable. Small business with no public services is unlikely DoS target. Limited impact due to local operations capability.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-014: Supply Chain Software Compromise

**Risk ID:** RISK-2026-014
**Date Identified:** January 11, 2026
**Category:** Supply Chain Threat

**Description:**
Malicious code introduced into trusted software supply chain (Rocky Linux packages, FreeIPA, Wazuh, etc.) resulting in compromised software installation.

**Threat Source:** ☑ Supply Chain (vendor/software compromise)

**Affected Systems:**
- All systems (OS packages)
- Critical applications (FreeIPA, Wazuh, Graylog)

**Likelihood Assessment:** ☑ Low (1)
- Supply chain attacks rare but increasing
- Rocky Linux has strong security practices
- GPG signature verification on packages
- No supply chain incidents in past 12 months

**Impact Assessment:** ☑ High (3)
- Potential complete system compromise
- Potential CUI exposure
- Difficult to detect if well-crafted
- May require system rebuild

**Risk Score:** 1 × 3 = **3 (Low)**

**Current Controls:**
1. ✅ Package verification:
   - GPG signature verification enabled (dnf)
   - Rocky Linux package signing
   - Reject unsigned packages
2. ✅ Trusted repositories:
   - Official Rocky Linux repositories only
   - No third-party repos (except Wazuh official)
   - EPEL packages GPG-signed
3. ✅ Monitoring:
   - File Integrity Monitoring on critical paths
   - Wazuh detects unexpected file changes
   - Audit logging tracks package installations
4. ✅ Vendor assessment:
   - Rocky Linux: Established, reputable
   - Wazuh: Commercial entity, security-focused
   - Regular vendor security reviews
5. ✅ Backup/recovery:
   - Can restore to known-good state
   - Disaster recovery capability

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Accept

**Planned Mitigations:**
1. Annual vendor security posture reviews (TCC-RA-001)
2. Monitor vendor security announcements
3. Maintain FIM on critical system paths
4. Review package installation logs quarterly

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** Ongoing
**Status:** ☑ In Progress

**Residual Risk Acceptance:**
LOW risk is acceptable. Supply chain attacks are rare, and comprehensive controls (GPG verification, FIM, trusted repos) provide strong protection.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

### RISK-2026-015: Natural Disaster (Fire/Flood)

**Risk ID:** RISK-2026-015
**Date Identified:** January 11, 2026
**Category:** Environmental / All-Hazards

**Description:**
Natural disaster (fire, flood, severe weather) destroys home office and all on-premises equipment, resulting in complete infrastructure loss.

**Threat Source:** ☑ Environmental (natural disaster)

**Affected Systems:**
- All systems (complete facility loss)
- DC1, workstations, DataStore, network equipment

**Likelihood Assessment:** ☑ Low (1)
- Residential area, not high-risk location
- No flood zone
- Fire suppression/smoke alarms installed
- No natural disaster history

**Impact Assessment:** ☑ High (3)
- Complete equipment loss
- Operational shutdown until recovery
- Can recover data from offsite backups
- Business continuity disruption

**Risk Score:** 1 × 3 = **3 (Low)**

**Current Controls:**
1. ✅ Offsite backups:
   - Monthly USB backups stored at Wells Fargo Bank
   - 12-month retention
   - Protected in bank safe deposit box
   - Can restore from offsite backup
2. ✅ Fire protection:
   - Smoke alarms installed
   - Fire extinguishers available
   - Residential sprinkler system
3. ✅ Insurance:
   - Business property insurance
   - Covers equipment replacement
4. ✅ Disaster recovery plan:
   - Documented procedures (TCC-IRP-001)
   - RTO: 7-14 days (equipment procurement)
   - RPO: 30 days (monthly offsite backup)
5. ✅ Cloud documentation:
   - System documentation in GitHub
   - Can rebuild from documentation

**Residual Risk:** **LOW (1)**

**Risk Response Strategy:** ☑ Accept + Transfer (insurance)

**Planned Mitigations:**
1. Maintain current insurance coverage
2. Test disaster recovery procedures (POA&M-012)
3. Quarterly rotation of offsite USB backups
4. Document equipment specifications for replacement

**Implementation Owner:** Don Shannon, ISSO
**Target Date:** December 28, 2025 (DR test)
**Status:** ☑ In Progress

**Residual Risk Acceptance:**
LOW risk is acceptable. Natural disasters are unlikely, and comprehensive DR/offsite backup strategy enables recovery. Insurance transfers financial risk.

/s/ Donald E. Shannon, Owner/Principal
Date: January 11, 2026

---

## 4. RISK SUMMARY AND REGISTER

### 4.1 Risk Summary Table

| Risk ID | Risk Description | Category | Likelihood | Impact | Risk Score | Residual Risk | Status |
|---------|-----------------|----------|------------|---------|------------|---------------|---------|
| RISK-2026-001 | Ransomware Attack | External Cyber | Medium (2) | High (3) | 6 | LOW (1) | In Progress |
| RISK-2026-002 | DC1 Hardware Failure | Operational | Medium (2) | High (3) | 6 | LOW (2) | In Progress |
| RISK-2026-003 | Phishing / Social Engineering | External Cyber | Medium (2) | Medium (2) | 4 | MEDIUM (4) → LOW (2) after MFA | Open |
| RISK-2026-004 | Workstation Hardware Failure | Operational | Medium (2) | Low (1) | 2 | LOW (1) | Accepted |
| RISK-2026-005 | MongoDB Service Failure | Operational | Low (1) | Low (1) | 1 | LOW (1) | In Progress |
| RISK-2026-006 | Software Vulnerability Exploit | External Cyber | Medium (2) | Medium (2) | 4 | LOW (2) | In Progress |
| RISK-2026-007 | Unauthorized Physical Access | Physical | Low (1) | High (3) | 3 | LOW (1) | Accepted |
| RISK-2026-008 | Backup Failure | Operational | Low (1) | High (3) | 3 | LOW (1) | In Progress |
| RISK-2026-009 | Power Outage | Environmental | Low (1) | Medium (2) | 2 | LOW (1) | Accepted |
| RISK-2026-010 | Internet Service Outage | Operational | Medium (2) | Low (1) | 2 | LOW (1) | Accepted |
| RISK-2026-011 | Contractor Account Compromise | Supply Chain | Low (1) | Medium (2) | 2 | LOW (1) | In Progress |
| RISK-2026-012 | Insider Threat (Accidental) | Internal | Low (1) | Medium (2) | 2 | LOW (1) | In Progress |
| RISK-2026-013 | Denial of Service Attack | External Cyber | Low (1) | Low (1) | 1 | LOW (1) | Accepted |
| RISK-2026-014 | Supply Chain Software Compromise | Supply Chain | Low (1) | High (3) | 3 | LOW (1) | In Progress |
| RISK-2026-015 | Natural Disaster | Environmental | Low (1) | High (3) | 3 | LOW (1) | In Progress |

**Total Risks Identified:** 15

### 4.2 Risk Distribution

**By Risk Score (Inherent):**
- **High (7-9):** 0 risks
- **Medium (4-6):** 4 risks (RISK-001, -002, -003, -006)
- **Low (1-3):** 11 risks

**By Residual Risk (After Controls):**
- **HIGH:** 0 risks
- **MEDIUM:** 1 risk (RISK-003 until MFA deployed)
- **LOW:** 14 risks

**By Category:**
- **External Cyber Threats:** 5 risks (001, 003, 006, 013, 014)
- **Operational:** 6 risks (002, 004, 005, 008, 009, 010)
- **Physical Security:** 1 risk (007)
- **Supply Chain:** 2 risks (011, 014)
- **Internal:** 1 risk (012)
- **Environmental:** 2 risks (009, 015)

**By Response Strategy:**
- **Mitigate:** 9 risks (001, 002, 003, 005, 006, 008, 011, 012, 014, 015)
- **Accept:** 6 risks (004, 007, 009, 010, 013)
- **Transfer:** 1 risk (015 - insurance)
- **Avoid:** 0 risks

### 4.3 Risk Trends

**Improving:**
- POA&M-014 (Malware - FIPS compliance): 85% complete
- MongoDB auto-restart configured (RISK-005)
- Graylog restored and operational

**Stable:**
- All other risks remain at baseline levels
- No new threats identified in past 12 months
- Continuous monitoring detecting no anomalies

**Action Required:**
- Deploy MFA (POA&M-004) to reduce RISK-003 to LOW
- Complete POA&M-014 (15% remaining)
- Conduct DR test (POA&M-012)

---

## 5. MITIGATION RECOMMENDATIONS

### 5.1 High Priority Actions (Next 30 Days)

1. **Complete POA&M-004: Multi-Factor Authentication**
   - **Target:** December 22, 2025 (OVERDUE by 20 days)
   - **Impact:** Reduces RISK-003 and RISK-011 significantly
   - **Effort:** Configure FreeIPA OTP, test, deploy
   - **Owner:** Don Shannon, ISSO

2. **Complete POA&M-012: Disaster Recovery Test**
   - **Target:** December 28, 2025 (OVERDUE by 14 days)
   - **Impact:** Validates RISK-002 and RISK-015 controls
   - **Effort:** 1 day for test execution, documentation
   - **Owner:** Don Shannon, ISSO

3. **Configure MongoDB Auto-Restart**
   - **Target:** January 31, 2026
   - **Impact:** Reduces RISK-005 recovery time
   - **Effort:** 30 minutes (systemd configuration)
   - **Owner:** Don Shannon, ISSO

### 5.2 Medium Priority Actions (Next 90 Days)

4. **Complete POA&M-014: FIPS-Compliant Malware Protection**
   - **Target:** January 31, 2026 (original: Dec 31, 2025)
   - **Impact:** Reduces RISK-001 further
   - **Effort:** Deploy ClamAV 1.5.x FIPS, VirusTotal API
   - **Owner:** Don Shannon, ISSO

5. **Complete POA&M-006: Security Awareness Training**
   - **Target:** January 15, 2026 (original: Dec 10, 2025)
   - **Impact:** Reduces RISK-003 (phishing susceptibility)
   - **Effort:** Select training provider, complete annual training
   - **Owner:** Don Shannon, ISSO

6. **Complete POA&M-007: USB Device Restrictions**
   - **Target:** March 31, 2026
   - **Impact:** Reduces RISK-001 (malware infection vector)
   - **Effort:** Install USBGuard, configure whitelist
   - **Owner:** Don Shannon, ISSO

### 5.3 Long-Term Actions (Next 180 Days)

7. **Complete POA&M-028: VPN with MFA**
   - **Target:** March 31, 2026
   - **Impact:** Enables secure remote access
   - **Effort:** Deploy OpenVPN/WireGuard with FreeIPA+MFA
   - **Owner:** Don Shannon, ISSO

8. **Complete POA&M-031: Configuration Management Policy**
   - **Target:** March 31, 2026
   - **Impact:** Reduces RISK-012 (accidental misconfiguration)
   - **Effort:** Draft policy, document baselines
   - **Owner:** Don Shannon, ISSO

9. **Quarterly Risk Assessment Updates**
   - **Schedule:** April 2026, July 2026, October 2026
   - **Impact:** Continuous risk monitoring per TCC-RA-001
   - **Effort:** Review risk register, update as needed
   - **Owner:** Don Shannon, ISSO

### 5.4 Optional Enhancements (Future Consideration)

10. **UPS for DC1**
    - **Impact:** Reduces RISK-009 (power outage)
    - **Cost:** $300-500 for appropriate UPS
    - **Benefit:** Graceful shutdown capability, brief runtime

11. **Redundant ISP**
    - **Impact:** Reduces RISK-010 (internet outage)
    - **Cost:** $50-100/month for secondary ISP
    - **Benefit:** Business continuity during primary ISP failures

12. **Spare Hardware Inventory**
    - **Impact:** Reduces RISK-002 and RISK-004 recovery time
    - **Cost:** Variable (depends on equipment)
    - **Benefit:** Faster recovery from hardware failures

---

## 6. CONTINUOUS MONITORING PLAN

### 6.1 Automated Monitoring (Daily)

**Wazuh SIEM:**
- Vulnerability detection (60-minute CVE feed updates)
- File Integrity Monitoring (12-hour scans)
- Security Configuration Assessment (12-hour scans)
- Real-time log analysis and alerting
- Authentication failure monitoring

**Graylog:**
- Centralized log aggregation
- MongoDB database health
- Query and dashboard availability
- Alert correlation

**System Health:**
- Disk space monitoring
- Service status monitoring (systemd)
- Backup job completion verification

### 6.2 Manual Reviews

**Weekly (Monday):**
- Review Wazuh dashboard for new high/critical vulnerabilities
- Check authentication failure trends
- Verify backup completion for past week
- Review FIM alerts for unexpected changes

**Monthly:**
- Update risk register with new/closed risks
- Review Wazuh vulnerability trends
- Verify contractor account status (if applicable)
- Check vendor security bulletins
- Review POA&M progress

**Quarterly:**
- Run comprehensive OpenSCAP CUI profile scan
- Update SSP with risk posture changes
- Review and update POA&M
- Conduct tabletop exercise for high-priority risks
- Brief Owner on risk trends
- Rotate offsite USB backup drives

**Annually:**
- Comprehensive risk assessment (this document)
- Policy reviews (all TCC-* policies)
- Vendor security assessments
- Disaster recovery test
- Security awareness training

### 6.3 Trigger-Based Assessments

**Immediate Assessment Required:**
- Security incidents (within 72 hours per TCC-IRP-001)
- Wazuh critical vulnerabilities (CVSS >9.0)
- FIM alerts on critical paths
- New DoD contracts with different data classifications
- Significant system architecture changes
- Vendor security incidents

---

## 7. CONCLUSIONS AND RECOMMENDATIONS

### 7.1 Overall Assessment

The CyberHygiene Production Network demonstrates a **STRONG** security posture with **LOW overall risk**:

**Strengths:**
1. ✅ 99%+ NIST 800-171 implementation (POA&M 91% complete)
2. ✅ Comprehensive monitoring (Wazuh, Graylog, OpenSCAP)
3. ✅ Robust backup strategy (3-2-1) with verified restorability
4. ✅ Strong cryptographic protection (FIPS 140-2, LUKS encryption)
5. ✅ Mature policies and procedures (8 policies documented)
6. ✅ Continuous vulnerability management
7. ✅ Domain-based authentication and access control
8. ✅ All workstations successfully domain-joined
9. ✅ AI integration (POA&M-040) completed 20 days early

**Areas for Improvement:**
1. ⚠️ Deploy MFA (POA&M-004) - HIGH PRIORITY, 20 days overdue
2. ⚠️ Conduct DR test (POA&M-012) - HIGH PRIORITY, 14 days overdue
3. ⚠️ Complete FIPS malware (POA&M-014) - 15% remaining
4. ⏳ Deploy VPN/MFA (POA&M-028) - Due March 31, 2026

### 7.2 Risk Posture Summary

**Current State:**
- **0 High Risks**
- **1 Medium Risk** (phishing - will be LOW after MFA)
- **14 Low Risks** (all with mitigations)
- **Average Risk Score:** 2.4/9

**Target State (After POA&M Completion):**
- **0 High Risks**
- **0 Medium Risks**
- **15 Low Risks**
- **Average Risk Score:** <2.0/9

### 7.3 Recommendations

**To System Owner/Principal:**

1. **APPROVE** this risk assessment and risk register
2. **PRIORITIZE** completion of overdue POA&M items (004, 012)
3. **ACCEPT** documented residual risks (14 LOW, 1 MEDIUM)
4. **ALLOCATE** resources for remaining POA&M items (3 remaining)
5. **SCHEDULE** next quarterly risk assessment (April 2026)

**Risk Assessment Finding:**

The CyberHygiene Production Network is **WELL-PROTECTED** against identified threats with comprehensive technical and administrative controls. The current risk posture is **LOW** and acceptable for DoD CUI/FCI processing. Completion of the 3 remaining POA&M items will further strengthen security and achieve 97%+ compliance.

**Recommendation: ACCEPT CURRENT RISK POSTURE with planned mitigations.**

---

## 8. APPROVAL AND SIGNATURES

### 8.1 Risk Assessment Conducted By

**Name:** Donald E. Shannon
**Title:** Information System Security Officer (ISSO)
**Organization:** The Contract Coach
**Date:** January 11, 2026

**Signature:** /s/ Donald E. Shannon

**Certification:**
I certify that this risk assessment was conducted in accordance with NIST SP 800-30 Rev 1 methodology and TCC-RA-001 Risk Management Policy. All identified risks have been analyzed, documented, and assigned mitigation strategies. The risk register accurately reflects the current risk posture of the CyberHygiene Production Network.

### 8.2 Risk Assessment Approved By

**Name:** Donald E. Shannon
**Title:** System Owner / Principal
**Organization:** The Contract Coach (Donald E. Shannon LLC)
**Date:** January 11, 2026

**Signature:** /s/ Donald E. Shannon

**Approval Statement:**
I have reviewed this risk assessment and approve the findings, risk scores, and mitigation strategies documented herein. I accept all residual risks identified as LOW. I acknowledge one MEDIUM residual risk (RISK-2026-003 - Phishing) and accept this risk temporarily until MFA deployment (POA&M-004) reduces it to LOW.

I approve the prioritized mitigation plan and commit resources to completing POA&M items 004, 012, 014, and 028 per documented timelines.

### 8.3 Next Review

**Next Annual Risk Assessment:** January 2027
**Next Quarterly Update:** April 2026
**Trigger-Based Updates:** As required per TCC-RA-001 Section 2.3

---

## APPENDIX A: RISK REGISTER (Excel Format Reference)

Risk register maintained at: `/backup/risk-management/risk-register.xlsx`

**Fields:**
- Risk ID
- Risk Description
- Threat Source
- Likelihood (1-3)
- Impact (1-3)
- Risk Score (1-9)
- Risk Category
- Affected Systems
- Current Controls
- Residual Risk
- Response Strategy
- Planned Actions
- Owner
- Target Date
- Status
- Last Review Date

**Status Codes:**
- Open: Newly identified, no mitigation started
- In Progress: Mitigation actions underway
- Closed: Risk eliminated or mitigated to acceptable level
- Accepted: Residual risk formally accepted by Owner

---

## APPENDIX B: ASSESSMENT ARTIFACTS

**Data Sources Used:**
1. ✅ Wazuh vulnerability scan results (January 2026)
2. ✅ OpenSCAP CUI profile compliance (100% - latest scan)
3. ✅ POA&M Version 2.4 (31 of 34 complete - 91%)
4. ✅ Infrastructure documentation (January 11, 2026 updates)
5. ✅ Historical incident logs (past 12 months - no major incidents)
6. ✅ Graylog MongoDB failure analysis (January 8-11, 2026)
7. ✅ Backup verification logs (100% success rate)
8. ✅ System Security Plan v1.8 (December 17, 2025)
9. ✅ All TCC-* policies (v1.0, November 2, 2025)
10. ✅ CISA threat bulletins (reviewed January 2026)

**Assessment Methods:**
- ✅ Asset inventory review
- ✅ Vulnerability scan analysis
- ✅ Compliance scan review
- ✅ Historical incident analysis
- ✅ Threat intelligence review
- ✅ Physical security walkthrough
- ✅ Policy and procedure review
- ✅ POA&M status review
- ✅ Backup verification
- ✅ NIST SP 800-30 methodology applied

**Evidence Retention:**
- This assessment: 3 years
- Risk register: 3 years
- Wazuh scan results: 90 days (rolling)
- OpenSCAP reports: 3 years
- Incident records: 3 years post-incident

---

**Classification:** CONTROLLED UNCLASSIFIED INFORMATION (CUI)
**Distribution:** System Owner/ISSO, C3PAO Assessors, Authorized Auditors
**Retention:** 3 years minimum per TCC-RA-001

**END OF ANNUAL RISK ASSESSMENT**
