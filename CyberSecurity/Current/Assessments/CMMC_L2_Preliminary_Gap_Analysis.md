# CMMC Level 2 Preliminary Gap Analysis

**Assessment Type:** Independent Preliminary Gap Analysis (Pre-Assessment)
**Assessment Standard:** CMMC Assessment Guide Level 2, Version 2.13 (September 2024)
**Reference:** 32 CFR 170.16 / 32 CFR 170.17 / NIST SP 800-171 Rev 2
**Document ID:** DoD-CIO-00003 (ZRIN 0790-ZA19)

---

**Organization Seeking Assessment (OSA):** The Contract Coach
**System Name:** CyberHygiene Production Network
**System FQDN:** cyberinabox.net
**System Owner:** Donald E. Shannon, ISSO
**Assessment Date:** February 9, 2026
**Assessor:** Independent C3PAO Preliminary Reviewer
**Classification:** Controlled Unclassified Information (CUI)

---

## 1. Executive Summary

This document presents the findings of an independent preliminary gap analysis of the CyberHygiene Production Network (cyberinabox.net) operated by The Contract Coach against the 110 security requirements specified in NIST SP 800-171 Rev 2, as required for CMMC Level 2 certification under 32 CFR 170.17.

### Key Findings

| Metric | Value |
|--------|-------|
| **Total Requirements Assessed** | 110 |
| **Requirements MET** | 96 |
| **Requirements NOT MET** | 10 |
| **Requirements NOT APPLICABLE** | 4 |
| **Estimated Independent SPRS Score** | **88 / 110** |
| **Self-Assessed SPRS Score (POA&M v2.2)** | 107 / 110 |
| **Variance** | -19 points |
| **CMMC Level 2 Conditional Eligibility** | **NOT YET ELIGIBLE** |

### Assessment Determination

The CyberHygiene Production Network demonstrates **strong technical implementation** across the majority of NIST SP 800-171 requirements. The system benefits from a well-architected defense-in-depth approach including FreeIPA centralized identity management, Wazuh SIEM, Suricata IDS/IPS, FIPS 140-2 validated encryption, SELinux enforcing mode, and comprehensive audit logging.

However, the assessment identifies **10 requirements as NOT MET**, resulting in an estimated SPRS score of **88/110**. The primary gap areas are:

1. **Multi-Factor Authentication (MFA)** not implemented (-5 points)
2. **Security Awareness & Training** program not established (-7 points across 3 requirements)
3. **Periodic Risk Assessment** not yet conducted (-3 points)
4. **Periodic Security Control Assessment** not formally established (-3 points)
5. **Operational gaps** in session lock, login banners, removable media control, and IR testing (-4 points)

Per CMMC Assessment Guide v2.13, an OSA must achieve a CMMC Status of either Conditional Level 2 (minimum SPRS score of 80/110 with POA&M for NOT MET items) or Final Level 2 (all 110 requirements MET). At a score of 88/110 with no single NOT MET requirement exceeding 5 points weight, **the system would qualify for Conditional Level 2 with a POA&M**, provided all NOT MET items are remediated within 180 days of assessment.

### SPRS Variance Analysis

The organization's self-assessed SPRS score of 107/110 accounts for only MFA (-3 points) and IR testing (-0.5 points). The independent assessment identifies an additional -19 points of deductions the self-assessment did not capture:

| Gap Category | Self-Assessment | Independent Assessment | Variance |
|--------------|----------------|----------------------|----------|
| MFA (3.5.3) | -3 | -5 | -2 |
| IR Testing (3.6.3) | -0.5 | -1 | -0.5 |
| Training (3.2.1, 3.2.2, 3.2.3) | 0 | -7 | -7 |
| Risk Assessment (3.11.1) | 0 | -3 | -3 |
| Security Assessment (3.12.1) | 0 | -3 | -3 |
| Session Lock (3.1.10) | 0 | -1 | -1 |
| Login Banners (3.1.9) | 0 | -1 | -1 |
| Removable Media (3.8.7) | 0 | -1 | -1 |
| **Total** | **-3.5** | **-22** | **-18.5** |

**Root Cause of Variance:** The self-assessment appears to credit requirements as MET based on (a) the existence of DRAFT policies that have not been formally approved, and (b) planned implementations that are not yet operational. Per the CMMC Assessment Guide v2.13 (Assessment Findings, p.9), *draft policies and planned implementations do not constitute evidence of a MET requirement*.

---

## 2. Assessment Methodology

### 2.1 Assessment Approach

This preliminary gap analysis follows the methodology prescribed in the CMMC Assessment Guide Level 2 v2.13, Section "Assessment Criteria and Methodology" (pp. 7-11). Each of the 110 NIST SP 800-171 Rev 2 requirements was evaluated using the three assessment methods:

- **Examine:** Review of documentation including the SSP v2.0, POA&M v2.2, 6 approved policies, 5 DRAFT/planned policies, Evidence Package Summary, Control-to-Policy Quick Reference, and SBOM v2.3
- **Interview:** Assessment of organizational knowledge and processes through system documentation and operational records
- **Test:** Evaluation of technical controls through system configuration review, service status verification, and compliance scan results

### 2.2 Assessment Criteria

Per the CMMC Assessment Guide v2.13, each requirement receives one of three findings:

| Finding | Definition |
|---------|-----------|
| **MET** | All assessment objectives are satisfied. The requirement is implemented, documented, and operational. |
| **NOT MET** | One or more assessment objectives are not satisfied. The requirement has gaps in implementation, documentation, or operation. |
| **NOT APPLICABLE (N/A)** | The requirement does not apply to the system's operational environment, with documented justification. |

### 2.3 Evidence Sources

| Document | Version | Date |
|----------|---------|------|
| System Security Plan (SSP) | v2.0 | February 2026 |
| Plan of Action & Milestones (POA&M) | v2.2 | February 3, 2026 |
| Incident Response Policy (TCC-IRP-001) | v1.0 | November 2, 2025 |
| Risk Management Policy (TCC-RA-001) | v1.0 | November 2, 2025 |
| Personnel Security Policy (TCC-PS-001) | v1.0 | November 2, 2025 |
| Physical & Media Protection Policy (TCC-PE-MP-001) | v1.0 | November 2, 2025 |
| System & Information Integrity Policy (TCC-SI-001) | v1.0 | November 2, 2025 |
| Acceptable Use Policy (TCC-AUP-001) | v1.0 | November 2, 2025 |
| Audit & Accountability Policy (TCC-AU-001) | DRAFT | -- |
| Configuration Management Policy (TCC-CM-001) | DRAFT | -- |
| Security Awareness & Training Policy (TCC-AT-001) | DRAFT | -- |
| Identification & Authentication Policy (TCC-IA-001) | DRAFT | -- |
| System & Communications Protection Policy (TCC-SC-001) | PLANNED | -- |
| Control-to-Policy Quick Reference | v1.0 | November 2, 2025 |
| Evidence Package Summary | v1.0 | November 2, 2025 |
| Software Bill of Materials (SBOM) | v2.3 | February 2026 |
| OpenSCAP Compliance Report | Latest | 104/104 PASS |

### 2.4 Scope Determination

Per 32 CFR 170.19(c), the assessment scope encompasses all assets within the CyberHygiene Production Network that process, store, or transmit CUI:

- **dc1.cyberinabox.net** (192.168.1.10) - Domain Controller / Primary Server (Rocky Linux 9.7)
- **LabRat** - Workstation (Rocky Linux 9.7)
- **Engineering** - Workstation (Rocky Linux 9.7)
- **Accounting** - Workstation (Rocky Linux 9.7)
- **pfSense** (192.168.1.1) - Network Gateway / Firewall (NetGate 2100)
- **Network infrastructure** - Switches, cabling, wireless AP
- **Physical environment** - Home office, server rack, storage media

---

## 3. Requirement-by-Requirement Assessment

### 3.1 ACCESS CONTROL (AC) - 22 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.1.1 | AC.L2-3.1.1 | Authorized Access Control [CUI Data] | **MET** | 5 | FreeIPA centralized authentication with Kerberos. RBAC via user groups (admins, cui_authorized, fci_authorized). |
| 3.1.2 | AC.L2-3.1.2 | Transaction & Function Control | **MET** | 3 | FreeIPA RBAC with group-based access control. sudo rules restrict privileged operations. |
| 3.1.3 | AC.L2-3.1.3 | Control CUI Flow | **MET** | 3 | pfSense firewall with restrictive egress rules. Network segmentation. CUI handling procedures in TCC-AUP-001 Section 3. |
| 3.1.4 | AC.L2-3.1.4 | Separation of Duties | **N/A** | 1 | Solopreneur business model - single operator. Documented justification in SSP. Owner holds TS clearance. |
| 3.1.5 | AC.L2-3.1.5 | Least Privilege | **MET** | 3 | FreeIPA groups enforce least privilege. Standard user accounts for daily operations. Admin accounts restricted. |
| 3.1.6 | AC.L2-3.1.6 | Non-Privileged Account Use | **MET** | 1 | Separate admin/standard accounts configured. TCC-AUP-001 Section 2.1 requires non-privileged accounts for non-security functions. |
| 3.1.7 | AC.L2-3.1.7 | Privileged Functions | **MET** | 3 | sudo configuration restricts privileged execution. sudorule: admins_all limits to authorized admins. |
| 3.1.8 | AC.L2-3.1.8 | Unsuccessful Logon Attempts | **MET** | 3 | FreeIPA password policy: 5 failed attempts = 30-minute lockout. Verified via `ipa pwpolicy-show`. |
| 3.1.9 | AC.L2-3.1.9 | Privacy & Security Notices | **NOT MET** | 1 | Login banners not implemented on all systems. POA&M-034 targets March 15, 2026. Policy exists (TCC-AUP-001 Section 2.6) but technical implementation incomplete. |
| 3.1.10 | AC.L2-3.1.10 | Session Lock | **NOT MET** | 1 | 15-minute session lock not configured on all systems. POA&M-029 targets March 15, 2026. Policy exists (TCC-AUP-001 Section 2.3) but technical implementation incomplete. |
| 3.1.11 | AC.L2-3.1.11 | Session Termination | **MET** | 1 | SSH session timeouts configured. ClientAliveInterval and ClientAliveCountMax set. |
| 3.1.12 | AC.L2-3.1.12 | Control Remote Access | **MET** | 3 | Remote access via SSH with FreeIPA authentication. All sessions monitored via Wazuh SIEM. pfSense single gateway. VPN with MFA planned as enhancement (POA&M-028). |
| 3.1.13 | AC.L2-3.1.13 | Remote Access Confidentiality | **MET** | 3 | All remote access encrypted via SSH and TLS. FIPS 140-2 validated algorithms. |
| 3.1.14 | AC.L2-3.1.14 | Remote Access Routing | **MET** | 1 | pfSense serves as single managed access control point for all external connections. |
| 3.1.15 | AC.L2-3.1.15 | Privileged Remote Access | **MET** | 1 | remote_access group in FreeIPA. SSH key authentication. Authorized prior to connection. TCC-PS-001 Section 2.2. |
| 3.1.16 | AC.L2-3.1.16 | Wireless Access Authorization | **MET** | 1 | WPA3 authentication required. Wireless access authorized through network configuration. |
| 3.1.17 | AC.L2-3.1.17 | Wireless Access Protection | **MET** | 1 | WPA3-Personal encryption. Strong passphrase. |
| 3.1.18 | AC.L2-3.1.18 | Mobile Device Connection | **MET** | 1 | Mobile devices prohibited for CUI processing per TCC-AUP-001 Section 2.4. |
| 3.1.19 | AC.L2-3.1.19 | Encrypt CUI on Mobile | **N/A** | 1 | No mobile CUI processing. Prohibited by policy. Documented justification. |
| 3.1.20 | AC.L2-3.1.20 | External Connections [CUI Data] | **MET** | 3 | Restrictive firewall egress rules. External connections monitored and controlled via pfSense. |
| 3.1.21 | AC.L2-3.1.21 | Portable Storage Use | **NOT MET** | 1 | USBGuard not yet deployed. Policy exists (TCC-AUP-001 Section 2.5) but technical enforcement mechanism not operational. POA&M identifies this gap. |
| 3.1.22 | AC.L2-3.1.22 | Control Public Information [CUI Data] | **MET** | 1 | CUI prohibited on publicly accessible systems per TCC-AUP-001 Section 4. Website (.htaccess) restricts confidential docs to local network. |

**AC Domain Summary:** 18 MET, 3 NOT MET, 2 N/A (1 originally counted as N/A but 3.1.4 is the primary N/A)
**AC Points Deducted:** -3 (3.1.9: -1, 3.1.10: -1, 3.1.21: -1)

---

### 3.2 AWARENESS AND TRAINING (AT) - 3 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.2.1 | AT.L2-3.2.1 | Role-Based Risk Awareness | **NOT MET** | 3 | No formal security awareness training program established. AUP acknowledgment provides minimal baseline but does not constitute a role-based risk awareness program. TCC-AT-001 in DRAFT status only. POA&M-006 targets March 31, 2026. |
| 3.2.2 | AT.L2-3.2.2 | Role-Based Training | **NOT MET** | 3 | No role-based security training has been conducted. ISSO has TS clearance and extensive security knowledge, but formal training records do not exist. TCC-AT-001 DRAFT. POA&M-032 targets March 31, 2026. |
| 3.2.3 | AT.L2-3.2.3 | Insider Threat Awareness | **NOT MET** | 1 | No insider threat awareness training conducted. AUP includes acknowledgment language but no formal insider threat awareness program. Solopreneur environment mitigates risk but does not eliminate requirement. |

**AT Domain Summary:** 0 MET, 3 NOT MET, 0 N/A
**AT Points Deducted:** -7 (3.2.1: -3, 3.2.2: -3, 3.2.3: -1)

**Assessor Note:** The Awareness and Training domain represents the most significant documentation and implementation gap. While the solopreneur business model reduces the practical risk (single operator with TS clearance), CMMC Level 2 requires demonstrable training regardless of organization size. The DRAFT AT policy must be finalized, and initial training must be completed and documented.

---

### 3.3 AUDIT AND ACCOUNTABILITY (AU) - 9 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.3.1 | AU.L2-3.3.1 | System Auditing | **MET** | 3 | auditd running on all systems with comprehensive rule set. Wazuh SIEM aggregates logs. 90-day online retention, 3-year archive. TCC-AU-001 DRAFT, but technical implementation verified. |
| 3.3.2 | AU.L2-3.3.2 | User Accountability | **MET** | 3 | FreeIPA provides unique user identification. auditd traces all actions to individual users. AUID tracking configured. |
| 3.3.3 | AU.L2-3.3.3 | Event Review | **MET** | 3 | Wazuh dashboard provides real-time event review. Weekly audit log review documented. Correlation with Suricata IDS alerts. |
| 3.3.4 | AU.L2-3.3.4 | Audit Failure Alerting | **MET** | 1 | auditd configured for admin email alerts on logging failure. Wazuh monitors auditd service status. |
| 3.3.5 | AU.L2-3.3.5 | Audit Correlation | **MET** | 1 | Wazuh SIEM provides cross-system event correlation. Integration with Suricata for network-host correlation. TCC-IRP-001 Section 2.5. |
| 3.3.6 | AU.L2-3.3.6 | Reduction & Reporting | **MET** | 1 | Wazuh dashboard reporting with filtering, aggregation, and export capabilities. |
| 3.3.7 | AU.L2-3.3.7 | Authoritative Time Source | **MET** | 1 | chronyd configured with authoritative NTP sources. Time synchronization verified across all domain members. |
| 3.3.8 | AU.L2-3.3.8 | Audit Protection | **MET** | 3 | /var/log/audit permissions root:root 0600. Audit logs on separate LUKS-encrypted partition. Access restricted to ISSO. |
| 3.3.9 | AU.L2-3.3.9 | Audit Management | **MET** | 1 | Audit logging management restricted to admin/ISSO via sudo rules. No non-privileged access to audit configuration. |

**AU Domain Summary:** 9 MET, 0 NOT MET, 0 N/A
**AU Points Deducted:** 0

**Assessor Note:** While all AU controls are technically implemented and operational, the Audit and Accountability Policy (TCC-AU-001) remains in DRAFT status. For CMMC Level 2 maturity, this policy must be formally approved. The strong technical implementation (auditd, Wazuh, centralized logging) provides sufficient evidence for MET determination, but the assessor recommends policy finalization as a priority to support maturity objectives.

---

### 3.4 CONFIGURATION MANAGEMENT (CM) - 9 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.4.1 | CM.L2-3.4.1 | System Baselining | **MET** | 3 | SBOM v2.3 documents complete software inventory (1,774 RPMs). Configuration Management Baseline document exists. Wazuh FIM tracks configuration changes. |
| 3.4.2 | CM.L2-3.4.2 | Security Configuration Enforcement | **MET** | 3 | OpenSCAP quarterly scans enforce CUI security profile (104/104 PASS). SELinux enforcing. FIPS 140-2 enabled. |
| 3.4.3 | CM.L2-3.4.3 | System Change Management | **MET** | 1 | ISSO approval required for system changes. Change control documented through git version control and POA&M tracking. |
| 3.4.4 | CM.L2-3.4.4 | Security Impact Analysis | **MET** | 1 | Security impact considered before changes. OpenSCAP rescan after major changes. FIPS mode verification after patching. |
| 3.4.5 | CM.L2-3.4.5 | Access Restrictions for Change | **MET** | 3 | System changes restricted to ISSO/admin accounts via sudo. FreeIPA RBAC enforces access restrictions. |
| 3.4.6 | CM.L2-3.4.6 | Least Functionality | **MET** | 1 | Rocky Linux minimal install + required packages only. Unnecessary services disabled. firewalld restricts ports. |
| 3.4.7 | CM.L2-3.4.7 | Nonessential Functionality | **MET** | 1 | Nonessential programs, functions, ports disabled. SELinux enforcing prevents unauthorized program execution. |
| 3.4.8 | CM.L2-3.4.8 | Application Execution Policy | **MET** | 1 | Software installation restricted to dnf package management. Wazuh monitors for unauthorized software. |
| 3.4.9 | CM.L2-3.4.9 | User-Installed Software | **MET** | 1 | User software installation monitored via Wazuh FIM. Package management restricted to admin accounts. |

**CM Domain Summary:** 9 MET, 0 NOT MET, 0 N/A
**CM Points Deducted:** 0

**Assessor Note:** Configuration Management controls are well-implemented technically. The CM Policy (TCC-CM-001) is currently only PLANNED. While technical evidence supports MET determinations, policy formalization is critical for CMMC Level 2 maturity demonstration. The SBOM, OpenSCAP scans, and Wazuh FIM provide strong technical evidence.

---

### 3.5 IDENTIFICATION AND AUTHENTICATION (IA) - 11 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.5.1 | IA.L2-3.5.1 | Identification [CUI Data] | **MET** | 3 | FreeIPA uniquely identifies all users, processes, and devices. Kerberos realm: CYBERINABOX.NET. |
| 3.5.2 | IA.L2-3.5.2 | Authentication [CUI Data] | **MET** | 3 | FreeIPA Kerberos authentication for all system access. Certificate-based auth for services. |
| 3.5.3 | IA.L2-3.5.3 | Multifactor Authentication | **NOT MET** | 5 | **MFA not implemented.** FreeIPA supports OTP but not configured. POA&M-004 targets March 31, 2026. This is the highest-weight NOT MET finding. |
| 3.5.4 | IA.L2-3.5.4 | Replay-Resistant Authentication | **MET** | 3 | Kerberos provides replay-resistant authentication via ticket-based protocol with timestamps and sequence numbers. |
| 3.5.5 | IA.L2-3.5.5 | Identifier Reuse | **MET** | 1 | FreeIPA prevents identifier reuse. Disabled accounts preserved in directory. Unique UIDs enforced. |
| 3.5.6 | IA.L2-3.5.6 | Identifier Handling | **MET** | 1 | Inactive accounts disabled after 90 days per password policy. FreeIPA account lifecycle management. |
| 3.5.7 | IA.L2-3.5.7 | Password Complexity | **MET** | 1 | FreeIPA policy: 14-character minimum, 3 character classes, meets NIST 800-171 requirements. |
| 3.5.8 | IA.L2-3.5.8 | Password Reuse | **MET** | 1 | Password history: 24 passwords. FreeIPA enforces no-reuse policy. |
| 3.5.9 | IA.L2-3.5.9 | Temporary Passwords | **MET** | 1 | FreeIPA forces password change on first login for temporary/initial passwords. |
| 3.5.10 | IA.L2-3.5.10 | Cryptographically-Protected Passwords | **MET** | 1 | Passwords stored as salted hashes in FreeIPA LDAP (389 Directory Server). FIPS-validated algorithms. |
| 3.5.11 | IA.L2-3.5.11 | Obscure Feedback | **MET** | 1 | Authentication feedback obscured. No password display during entry. Generic error messages. |

**IA Domain Summary:** 10 MET, 1 NOT MET, 0 N/A
**IA Points Deducted:** -5 (3.5.3: -5)

**Assessor Note:** MFA (3.5.3) is the single highest-impact finding in this assessment. FreeIPA natively supports OTP tokens, making remediation straightforward. The IA Policy (TCC-IA-001) is currently only PLANNED; it should be formalized to support the IA domain maturity. All other IA controls are well-implemented through FreeIPA.

---

### 3.6 INCIDENT RESPONSE (IR) - 3 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.6.1 | IR.L2-3.6.1 | Incident Handling | **MET** | 3 | Comprehensive IR Policy (TCC-IRP-001) with preparation, detection, analysis, containment, recovery procedures. Wazuh provides real-time detection. DFARS 252.204-7012 72-hour reporting documented. |
| 3.6.2 | IR.L2-3.6.2 | Incident Reporting | **MET** | 3 | TCC-IRP-001 Section 2.6 documents reporting procedures. Internal (2-hour), external/DoD (72-hour) timelines. DIBCSIA contact documented. |
| 3.6.3 | IR.L2-3.6.3 | Incident Response Testing | **NOT MET** | 1 | Annual tabletop exercise not yet conducted. First exercise scheduled June 2026 (POA&M-SPRS-2). Policy documents testing requirement but no test has been performed. |

**IR Domain Summary:** 2 MET, 1 NOT MET, 0 N/A
**IR Points Deducted:** -1 (3.6.3: -1)

**Assessor Note:** IR policy and procedures are well-documented. The IR testing gap is common for newly established programs. Recommend conducting the tabletop exercise before the formal C3PAO assessment to close this finding.

---

### 3.7 MAINTENANCE (MA) - 6 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.7.1 | MA.L2-3.7.1 | Perform Maintenance | **MET** | 3 | System maintenance performed by ISSO. dnf-automatic for patches. Documented maintenance windows. |
| 3.7.2 | MA.L2-3.7.2 | System Maintenance Control | **MET** | 3 | Maintenance tools controlled. Only authorized personnel (ISSO) perform maintenance. |
| 3.7.3 | MA.L2-3.7.3 | Equipment Sanitization | **MET** | 1 | Media sanitization procedures in TCC-PE-MP-001 Part 2 Section 2.6. LUKS erase and shred documented. |
| 3.7.4 | MA.L2-3.7.4 | Media Inspection | **MET** | 3 | Media inspected for malicious content before use. ClamAV and YARA scanning available. |
| 3.7.5 | MA.L2-3.7.5 | Nonlocal Maintenance | **MET** | 3 | Nonlocal maintenance via SSH with FreeIPA authentication. Sessions encrypted and logged. |
| 3.7.6 | MA.L2-3.7.6 | Maintenance Personnel | **MET** | 1 | Single operator (ISSO) with TS clearance. No third-party maintenance personnel. Contractor procedures documented in TCC-PS-001. |

**MA Domain Summary:** 6 MET, 0 NOT MET, 0 N/A
**MA Points Deducted:** 0

---

### 3.8 MEDIA PROTECTION (MP) - 9 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.8.1 | MP.L2-3.8.1 | Media Protection | **MET** | 3 | TCC-PE-MP-001 Part 2. Locked storage for physical media. LUKS encryption for digital media. |
| 3.8.2 | MP.L2-3.8.2 | Media Access | **MET** | 1 | CUI media access restricted to ISSO. LUKS encryption ensures owner-only access. |
| 3.8.3 | MP.L2-3.8.3 | Media Disposal [CUI Data] | **MET** | 3 | LUKS cryptographic erase, shred (10-pass), and physical destruction procedures documented in TCC-PE-MP-001 Section 2.6. |
| 3.8.4 | MP.L2-3.8.4 | Media Markings | **MET** | 1 | CUI marking procedures per 32 CFR Part 2002 in TCC-PE-MP-001 Section 2.3. |
| 3.8.5 | MP.L2-3.8.5 | Media Accountability | **MET** | 3 | Media transport procedures documented. Chain of custody for CUI media. TCC-PE-MP-001 Section 2.5. |
| 3.8.6 | MP.L2-3.8.6 | Portable Storage Encryption | **MET** | 3 | All portable storage LUKS-encrypted with FIPS 140-2 validated AES-256. USB backup drives encrypted. |
| 3.8.7 | MP.L2-3.8.7 | Removeable Media | **NOT MET** | 1 | USBGuard not yet deployed for technical enforcement. Policy prohibits unauthorized removable media (TCC-PE-MP-001 Section 2.7) but no automated enforcement mechanism. POA&M identifies this gap. |
| 3.8.8 | MP.L2-3.8.8 | Shared Media | **MET** | 1 | Portable storage devices without identifiable owner prohibited per TCC-PE-MP-001 Section 2.7. |
| 3.8.9 | MP.L2-3.8.9 | Protect Backups | **MET** | 3 | Backup CUI protected via LUKS encryption. On-site locked cabinet, off-site safe deposit box. Monthly rotation. |

**MP Domain Summary:** 8 MET, 1 NOT MET, 0 N/A
**MP Points Deducted:** -1 (3.8.7: -1)

---

### 3.9 PERSONNEL SECURITY (PS) - 2 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.9.1 | PS.L2-3.9.1 | Screen Individuals | **MET** | 3 | ISSO holds active Top Secret clearance (FBI investigation). Significantly exceeds CUI screening requirements per 32 CFR Part 2002. Contractor screening procedures in TCC-PS-001 Section 2.3. |
| 3.9.2 | PS.L2-3.9.2 | Personnel Actions | **MET** | 3 | FreeIPA account disable procedures for termination. Access agreements (NDA, CUI Access, AUP) documented. TCC-PS-001 Sections 2.4-2.6. |

**PS Domain Summary:** 2 MET, 0 NOT MET, 0 N/A
**PS Points Deducted:** 0

---

### 3.10 PHYSICAL PROTECTION (PE) - 6 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.10.1 | PE.L2-3.10.1 | Limit Physical Access [CUI Data] | **MET** | 3 | Dedicated locked office. Locking 42U server rack. Residence alarm system (monitored). TCC-PE-MP-001 Part 1 Sections 1.2-1.3. |
| 3.10.2 | PE.L2-3.10.2 | Monitor Facility | **MET** | 3 | Owner monitoring (solopreneur - sole occupant). Residence alarm system. HP iLO 5 environmental monitoring. |
| 3.10.3 | PE.L2-3.10.3 | Escort Visitors [CUI Data] | **N/A** | 1 | No visitors in CUI processing area. Documented in TCC-PE-MP-001 Part 1 Section 1.8. Home office environment. |
| 3.10.4 | PE.L2-3.10.4 | Physical Access Logs [CUI Data] | **N/A** | 1 | Owner sole occupant. Physical access logging not applicable for single-occupant home office. Documented justification. |
| 3.10.5 | PE.L2-3.10.5 | Manage Physical Access [CUI Data] | **MET** | 1 | Keys and locks documented. Physical access devices controlled by owner. Quarterly inspection checklist. |
| 3.10.6 | PE.L2-3.10.6 | Alternative Work Sites | **MET** | 1 | No alternate work sites for CUI processing. Documented restriction in TCC-PE-MP-001 Part 1 Section 1.17. |

**PE Domain Summary:** 4 MET, 0 NOT MET, 2 N/A
**PE Points Deducted:** 0

---

### 3.11 RISK ASSESSMENT (RA) - 3 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.11.1 | RA.L2-3.11.1 | Risk Assessments | **NOT MET** | 3 | Risk Management Policy (TCC-RA-001) established with NIST SP 800-30 methodology, but first formal annual risk assessment not yet conducted. POA&M-035 targets April 30, 2026. Risk identification occurs through POA&M and Wazuh, but periodic formal risk assessment not completed. |
| 3.11.2 | RA.L2-3.11.2 | Vulnerability Scan | **MET** | 3 | Wazuh continuous vulnerability detection (60-minute CVE feed updates). OpenSCAP quarterly compliance scans (104/104 PASS). |
| 3.11.3 | RA.L2-3.11.3 | Vulnerability Remediation | **MET** | 3 | TCC-RA-001 Section 2.7 defines remediation timelines: Critical 7 days, High 30 days, Medium 90 days. POA&M tracks remediation. |

**RA Domain Summary:** 2 MET, 1 NOT MET, 0 N/A
**RA Points Deducted:** -3 (3.11.1: -3)

---

### 3.12 SECURITY ASSESSMENT (CA) - 4 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.12.1 | CA.L2-3.12.1 | Security Control Assessment | **NOT MET** | 3 | While OpenSCAP provides quarterly technical compliance scanning, a formal periodic assessment of security control effectiveness (per NIST SP 800-53A methodology) has not been conducted. POA&M-011 addresses SSP quarterly review but not comprehensive control assessment. |
| 3.12.2 | CA.L2-3.12.2 | Operational Plan of Action | **MET** | 3 | POA&M v2.2 is comprehensive, well-maintained, and current. 43 items tracked with clear milestones, priorities, and completion evidence. Exemplary. |
| 3.12.3 | CA.L2-3.12.3 | Security Control Monitoring | **MET** | 3 | Wazuh SIEM provides continuous security control monitoring. OpenSCAP quarterly scans. Suricata IDS. Comprehensive logging and alerting. |
| 3.12.4 | CA.L2-3.12.4 | System Security Plan | **MET** | 3 | SSP v2.0 current and comprehensive. Documents system boundary, architecture, control implementations, and authorization status. |

**CA Domain Summary:** 3 MET, 1 NOT MET, 0 N/A
**CA Points Deducted:** -3 (3.12.1: -3)

---

### 3.13 SYSTEM AND COMMUNICATIONS PROTECTION (SC) - 16 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.13.1 | SC.L2-3.13.1 | Boundary Protection [CUI Data] | **MET** | 5 | pfSense firewall with Suricata IDS/IPS at network boundary. Wazuh monitors boundary communications. Default-deny rules. |
| 3.13.2 | SC.L2-3.13.2 | Security Engineering | **MET** | 1 | Defense-in-depth architecture: network firewall, host firewall, IDS/IPS, SIEM, FIM, encryption, SELinux. Layered security approach. |
| 3.13.3 | SC.L2-3.13.3 | Role Separation | **MET** | 1 | User functionality separated from system management. Standard user accounts vs admin accounts. FreeIPA group-based separation. |
| 3.13.4 | SC.L2-3.13.4 | Shared Resource Control | **MET** | 1 | SELinux type enforcement prevents unauthorized information transfer via shared resources. |
| 3.13.5 | SC.L2-3.13.5 | Public-Access System Separation [CUI Data] | **MET** | 3 | Network segmentation separates public-facing services. pfSense default-deny firewall. |
| 3.13.6 | SC.L2-3.13.6 | Network Communication by Exception | **MET** | 3 | firewalld on all hosts with default-deny. pfSense default-deny at boundary. Only explicitly authorized traffic permitted. |
| 3.13.7 | SC.L2-3.13.7 | Split Tunneling | **MET** | 1 | Network routing prevents split tunneling. All traffic routed through managed gateway. |
| 3.13.8 | SC.L2-3.13.8 | Data in Transit | **MET** | 3 | TLS for all network services. SSH for remote access. FIPS 140-2 validated cryptographic algorithms. |
| 3.13.9 | SC.L2-3.13.9 | Connections Termination | **MET** | 1 | SSH session timeouts configured. Network connections terminated at session end. |
| 3.13.10 | SC.L2-3.13.10 | Key Management | **MET** | 3 | LUKS key management for encryption. FreeIPA CA for certificate management. SSH key management procedures. |
| 3.13.11 | SC.L2-3.13.11 | CUI Encryption | **MET** | 5 | FIPS 140-2 mode ENABLED. `fips-mode-setup --check` confirms. All cryptographic operations use FIPS-validated modules. |
| 3.13.12 | SC.L2-3.13.12 | Collaborative Device Control | **MET** | 1 | No webcams or microphones on CUI systems. Collaborative computing devices not present. |
| 3.13.13 | SC.L2-3.13.13 | Mobile Code | **MET** | 1 | Browser JavaScript restricted. No mobile code execution on servers. |
| 3.13.14 | SC.L2-3.13.14 | Voice over Internet Protocol | **MET** | 1 | No VoIP systems deployed. Not applicable to current environment. |
| 3.13.15 | SC.L2-3.13.15 | Communications Authenticity | **MET** | 1 | SSH host keys, TLS certificates, Kerberos tickets protect session authenticity. |
| 3.13.16 | SC.L2-3.13.16 | Data at Rest | **MET** | 5 | All CUI partitions LUKS-encrypted with AES-256 (FIPS 140-2). /home, /var, /tmp, /data, /backup, /srv/samba all encrypted. |

**SC Domain Summary:** 16 MET, 0 NOT MET, 0 N/A
**SC Points Deducted:** 0

**Assessor Note:** System and Communications Protection is one of the strongest domains. FIPS 140-2, LUKS encryption, defense-in-depth architecture, and network segmentation are all exemplary. The SC Policy (TCC-SC-001) is currently only PLANNED; formalization recommended for maturity.

---

### 3.14 SYSTEM AND INFORMATION INTEGRITY (SI) - 7 Requirements

| Req ID | CMMC ID | Requirement Title | Finding | Weight | Evidence/Rationale |
|--------|---------|-------------------|---------|--------|--------------------|
| 3.14.1 | SI.L2-3.14.1 | Flaw Remediation [CUI Data] | **MET** | 3 | dnf-automatic for automated patching. Wazuh vulnerability detection. TCC-SI-001 Section 2.2 defines 7/30/90-day remediation timelines. |
| 3.14.2 | SI.L2-3.14.2 | Malicious Code Protection [CUI Data] | **MET** | 3 | Multi-layer protection: YARA 4.5.2 (25 rules), Wazuh FIM (12-hour scans), ClamAV (FIPS compatibility issue accepted with compensating controls per Risk Acceptance). |
| 3.14.3 | SI.L2-3.14.3 | Security Alerts & Advisories | **MET** | 1 | US-CERT, NIST NVD, Rocky Linux security advisories monitored. TCC-SI-001 Section 2.5. |
| 3.14.4 | SI.L2-3.14.4 | Update Malicious Code Protection [CUI Data] | **MET** | 1 | YARA rules updated as needed. ClamAV signatures daily (when operational). Wazuh FIM continuously monitored. |
| 3.14.5 | SI.L2-3.14.5 | System & File Scanning [CUI Data] | **MET** | 3 | OpenSCAP quarterly system scans. ClamAV real-time + weekly full scans. Wazuh FIM on all critical paths. |
| 3.14.6 | SI.L2-3.14.6 | Monitor Communications for Attacks | **MET** | 3 | Wazuh SIEM monitors inbound/outbound traffic. Suricata IDS with ET Open ruleset (daily updates). Behavioral analysis. |
| 3.14.7 | SI.L2-3.14.7 | Identify Unauthorized Use | **MET** | 1 | Wazuh behavioral analysis identifies unauthorized system use. auditd monitors privileged operations. Alert escalation configured. |

**SI Domain Summary:** 7 MET, 0 NOT MET, 0 N/A
**SI Points Deducted:** 0

**Assessor Note:** System and Information Integrity is well-implemented with an approved policy (TCC-SI-001). The ClamAV/FIPS incompatibility has a documented risk acceptance with compensating controls (YARA, Wazuh FIM). This is an acceptable approach.

---

## 4. SPRS Score Calculation

### 4.1 Score Summary

| Domain | Requirements | MET | NOT MET | N/A | Points Deducted |
|--------|-------------|-----|---------|-----|-----------------|
| Access Control (AC) | 22 | 17 | 3 | 2 | -3 |
| Awareness & Training (AT) | 3 | 0 | 3 | 0 | -7 |
| Audit & Accountability (AU) | 9 | 9 | 0 | 0 | 0 |
| Configuration Management (CM) | 9 | 9 | 0 | 0 | 0 |
| Identification & Authentication (IA) | 11 | 10 | 1 | 0 | -5 |
| Incident Response (IR) | 3 | 2 | 1 | 0 | -1 |
| Maintenance (MA) | 6 | 6 | 0 | 0 | 0 |
| Media Protection (MP) | 9 | 8 | 1 | 0 | -1 |
| Personnel Security (PS) | 2 | 2 | 0 | 0 | 0 |
| Physical Protection (PE) | 6 | 4 | 0 | 2 | 0 |
| Risk Assessment (RA) | 3 | 2 | 1 | 0 | -3 |
| Security Assessment (CA) | 4 | 3 | 1 | 0 | -3 |
| System & Comm Protection (SC) | 16 | 16 | 0 | 0 | 0 |
| System & Info Integrity (SI) | 7 | 7 | 0 | 0 | 0 |
| **TOTALS** | **110** | **95** | **10** | **4** | **-22** |

### 4.2 SPRS Score

| Metric | Value |
|--------|-------|
| Base Score | 110 |
| Total Deductions | -22 |
| **Estimated SPRS Score** | **88** |
| Percentage | 80.0% |

### 4.3 NOT MET Requirements Detail

| # | Req ID | Requirement | Weight | POA&M Ref | Target Date | Remediation Difficulty |
|---|--------|-------------|--------|-----------|-------------|----------------------|
| 1 | 3.5.3 | Multifactor Authentication | -5 | POA&M-004 | 03/31/2026 | Medium - FreeIPA OTP available |
| 2 | 3.2.1 | Role-Based Risk Awareness | -3 | POA&M-006 | 03/31/2026 | Low - training materials needed |
| 3 | 3.2.2 | Role-Based Training | -3 | POA&M-032 | 03/31/2026 | Low - document and conduct training |
| 4 | 3.11.1 | Risk Assessments | -3 | POA&M-035 | 04/30/2026 | Low - conduct using TCC-RA-001 methodology |
| 5 | 3.12.1 | Security Control Assessment | -3 | POA&M-011 | 03/31/2026 | Low - formalize existing OpenSCAP process |
| 6 | 3.2.3 | Insider Threat Awareness | -1 | POA&M-032 | 03/31/2026 | Low - include in AT program |
| 7 | 3.1.9 | Privacy & Security Notices | -1 | POA&M-034 | 03/15/2026 | Low - configure login banners |
| 8 | 3.1.10 | Session Lock | -1 | POA&M-029 | 03/15/2026 | Low - configure screen lock |
| 9 | 3.6.3 | Incident Response Testing | -1 | POA&M-SPRS-2 | 06/30/2026 | Low - conduct tabletop exercise |
| 10 | 3.8.7 | Removable Media Control | -1 | N/A | TBD | Low - deploy USBGuard |

---

## 5. Top 10 Findings by Severity

### Finding 1: Multi-Factor Authentication Not Implemented (CRITICAL)
- **Requirement:** 3.5.3 (IA.L2-3.5.3)
- **SPRS Impact:** -5 points
- **Description:** MFA is not configured for any system access. FreeIPA supports OTP tokens but this capability has not been enabled.
- **Risk:** Unauthorized access through compromised credentials. Single authentication factor is the most commonly exploited attack vector.
- **Remediation:** Enable FreeIPA OTP authentication. Configure TOTP or HOTP tokens for all user accounts. Test with FreeIPA web UI and SSH.
- **Estimated Effort:** 4-8 hours configuration + testing
- **POA&M Reference:** POA&M-004

### Finding 2: Security Awareness Training Not Established (HIGH)
- **Requirements:** 3.2.1, 3.2.2, 3.2.3
- **SPRS Impact:** -7 points (combined)
- **Description:** No formal security awareness or role-based training program exists. The AUP acknowledgment provides minimal baseline but does not meet the CMMC requirement for demonstrated training. The AT Policy is in DRAFT status.
- **Risk:** Personnel (including contractors, if engaged) may not recognize security threats or follow proper CUI handling procedures.
- **Remediation:** Finalize TCC-AT-001 policy. Complete initial ISSO security training (self-study acceptable for solopreneur). Document training completion. Establish annual recurrence.
- **Estimated Effort:** 8-16 hours (policy finalization + initial training + documentation)
- **POA&M Reference:** POA&M-006, POA&M-032

### Finding 3: Formal Risk Assessment Not Conducted (HIGH)
- **Requirement:** 3.11.1 (RA.L2-3.11.1)
- **SPRS Impact:** -3 points
- **Description:** While the Risk Management Policy (TCC-RA-001) establishes a NIST SP 800-30 methodology, the first formal periodic risk assessment has not been conducted. Risk identification occurs through POA&M tracking and Wazuh monitoring, but this does not substitute for a formal risk assessment.
- **Risk:** Unknown risks may exist that have not been formally identified, analyzed, and prioritized.
- **Remediation:** Conduct formal risk assessment using TCC-RA-001 Section 2.3 methodology. Document risk register with likelihood, impact, and mitigation strategies.
- **Estimated Effort:** 8-16 hours
- **POA&M Reference:** POA&M-035

### Finding 4: Security Control Assessment Not Formalized (HIGH)
- **Requirement:** 3.12.1 (CA.L2-3.12.1)
- **SPRS Impact:** -3 points
- **Description:** While OpenSCAP provides quarterly technical compliance scanning (104/104 PASS), a comprehensive assessment of security control effectiveness covering all 110 NIST 800-171 requirements has not been formally conducted. This preliminary gap analysis itself begins to address this gap.
- **Risk:** Security controls may degrade over time without periodic comprehensive assessment.
- **Remediation:** Establish annual security control assessment using NIST SP 800-53A methodology. Formalize the OpenSCAP quarterly scan as part of the assessment program. Document results and track findings.
- **Estimated Effort:** 16-24 hours (initial; 8 hours annually thereafter)
- **POA&M Reference:** POA&M-011

### Finding 5: Session Lock Not Configured (MEDIUM)
- **Requirement:** 3.1.10 (AC.L2-3.1.10)
- **SPRS Impact:** -1 point
- **Description:** 15-minute session lock with pattern-hiding display not configured on all workstations.
- **Risk:** Unattended terminals could allow unauthorized access to CUI.
- **Remediation:** Configure GNOME/KDE screen lock at 15 minutes. Set lock screen to blank/pattern-hiding. Verify on all workstations.
- **Estimated Effort:** 1-2 hours
- **POA&M Reference:** POA&M-029

### Finding 6: Login Banners Not Implemented (MEDIUM)
- **Requirement:** 3.1.9 (AC.L2-3.1.9)
- **SPRS Impact:** -1 point
- **Description:** Privacy and security notices (login banners) not implemented on all systems. Required for SSH, console login, and web interfaces.
- **Risk:** Users may not receive required notice of monitoring and acceptable use policies.
- **Remediation:** Configure /etc/issue, /etc/issue.net, and SSH Banner directive. Add web interface banners.
- **Estimated Effort:** 1-2 hours
- **POA&M Reference:** POA&M-034

### Finding 7: IR Tabletop Exercise Not Conducted (MEDIUM)
- **Requirement:** 3.6.3 (IR.L2-3.6.3)
- **SPRS Impact:** -1 point
- **Description:** IR testing requirement documented in TCC-IRP-001 but first annual tabletop exercise not yet performed. Scheduled for June 2026.
- **Risk:** IR procedures may not be effective when needed. Staff may not be prepared for actual incident response.
- **Remediation:** Conduct tabletop exercise using scenarios documented in TCC-IRP-001 Section 2.3. Document results, lessons learned, and procedure updates.
- **Estimated Effort:** 4-8 hours (preparation + execution + documentation)
- **POA&M Reference:** POA&M-SPRS-2

### Finding 8: Removable Media Enforcement Missing (MEDIUM)
- **Requirement:** 3.8.7 (MP.L2-3.8.7)
- **SPRS Impact:** -1 point
- **Description:** Policy prohibits unauthorized removable media (TCC-PE-MP-001 Section 2.7) but no technical enforcement mechanism (USBGuard) is deployed.
- **Risk:** Unauthorized USB devices could introduce malware or exfiltrate CUI data.
- **Remediation:** Deploy USBGuard on all systems. Create device whitelist for authorized USB storage. Configure Wazuh to monitor USBGuard events.
- **Estimated Effort:** 4-8 hours
- **POA&M Reference:** Identified in POA&M but no dedicated ID

### Finding 9: Five Policy Documents Not Finalized (OBSERVATION)
- **Policies Affected:** TCC-AU-001 (DRAFT), TCC-CM-001 (DRAFT), TCC-AT-001 (DRAFT), TCC-IA-001 (DRAFT), TCC-SC-001 (PLANNED)
- **SPRS Impact:** Not directly scored (controls technically implemented) but affects CMMC Level 2 maturity determination
- **Description:** Five of eleven NIST 800-171 control families lack formally approved policy documentation. While technical controls are implemented for AU, CM, IA, and SC domains, the absence of approved policies undermines the "documented" and "managed" maturity levels required for CMMC Level 2.
- **Risk:** An assessor may determine that without approved policies, the organization cannot demonstrate institutionalization of security practices.
- **Remediation:** Finalize all five DRAFT/PLANNED policies. Follow TCC policy approval process. Update SSP to reference approved policies.
- **Estimated Effort:** 40-60 hours (8-12 hours per policy)
- **POA&M Reference:** POA&M-030, POA&M-031, POA&M-032, POA&M-033

### Finding 10: Disaster Recovery Testing Not Performed (OBSERVATION)
- **Requirement:** Related to CP-4 (Contingency Planning)
- **SPRS Impact:** Not directly scored under NIST 800-171 (800-53 control)
- **Description:** ReaR backup system operational with weekly full backups, but backup restoration has not been formally tested (POA&M-012 targets April 30, 2026).
- **Risk:** Backup integrity and restoration procedures unverified. Recovery capability is assumed but not demonstrated.
- **Remediation:** Conduct backup restoration test. Document results including RTO/RPO verification.
- **Estimated Effort:** 4-8 hours
- **POA&M Reference:** POA&M-012

---

## 6. Strengths Identified

The assessment identifies the following areas of notable strength:

### 6.1 Technical Infrastructure
- **FIPS 140-2 Encryption:** All CUI partitions LUKS-encrypted with FIPS-validated algorithms. Kernel FIPS mode enabled. This exceeds many organizations' encryption implementations.
- **SELinux Enforcing:** Mandatory access controls active, providing defense against privilege escalation and unauthorized access.
- **OpenSCAP 104/104 (100%):** Perfect technical compliance score against the CUI security profile demonstrates disciplined configuration management.
- **Defense-in-Depth:** pfSense + Suricata + Wazuh + auditd + FIM + YARA + SELinux + FIPS represents a mature, layered security architecture.

### 6.2 Identity and Access Management
- **FreeIPA Centralized IAM:** Kerberos-based authentication, RBAC, comprehensive password policy (14-char, 3 classes, 24 history, 5-attempt lockout). Industry-standard implementation.
- **Separation of Admin/User Accounts:** Privileged and non-privileged access clearly delineated.

### 6.3 Monitoring and Audit
- **Wazuh SIEM:** Comprehensive monitoring with vulnerability detection, FIM, event correlation, and alerting. Agents deployed across all systems.
- **Suricata IDS/IPS:** Network-level threat detection with ET Open ruleset. Integration with Wazuh for unified monitoring.
- **Centralized Logging:** rsyslog aggregation with 90-day online / 3-year archive retention.

### 6.4 Documentation Quality
- **POA&M v2.2:** Exemplary POA&M with 43 tracked items, clear milestones, completion evidence, and metrics. Demonstrates active security management.
- **Six Approved Policies:** IR, RA, PS, PE/MP, SI, and AUP policies are comprehensive, customized for the environment, and include actionable procedures.
- **Evidence Package:** Well-organized evidence structure with Control-to-Policy Quick Reference enables efficient assessment.

### 6.5 Personnel
- **ISSO Clearance:** Active Top Secret clearance significantly exceeds CUI screening requirements and demonstrates deep commitment to security.
- **Cost Efficiency:** 100% open-source implementation with $240,000+ estimated savings demonstrates that strong security is achievable without commercial solutions.

---

## 7. CMMC Level 2 Eligibility Analysis

### 7.1 Certification Pathway Options

Per 32 CFR 170.17 and the CMMC Assessment Guide v2.13:

**Option A: Conditional Level 2 (with POA&M)**
- Requires: SPRS score >= 80/110 AND no single NOT MET requirement with weight > 5 points AND POA&M for all NOT MET items with 180-day remediation timeline
- **Current Status: ELIGIBLE** (Score: 88/110, no single finding > 5 points, active POA&M)
- Conditional status valid for 180 days from assessment date
- Must achieve Final Level 2 within 180 days

**Option B: Final Level 2**
- Requires: All 110 requirements MET (SPRS = 110/110)
- **Current Status: NOT ELIGIBLE** (10 requirements NOT MET)
- Requires remediation of all 10 NOT MET findings

### 7.2 Recommended Pathway

Based on the current state, the recommended approach is:

1. **Remediate all 10 NOT MET findings** before scheduling the formal C3PAO assessment
2. **Finalize all 5 DRAFT/PLANNED policies** to demonstrate Level 2 maturity
3. **Target Final Level 2** to avoid the 180-day conditional remediation pressure
4. **Estimated timeline to Final Level 2 readiness:** 60-90 days from commencement

---

## 8. Prioritized Remediation Roadmap

### Phase 1: Quick Wins (Target: 2 weeks)
*Estimated Effort: 8-16 hours | SPRS Impact: +4 points*

| Priority | Finding | Action | SPRS Gain |
|----------|---------|--------|-----------|
| 1 | 3.1.9 - Login Banners | Configure /etc/issue, /etc/issue.net, SSH Banner | +1 |
| 2 | 3.1.10 - Session Lock | Configure 15-min screen lock on all workstations | +1 |
| 3 | 3.8.7 - Removable Media | Deploy USBGuard on all systems | +1 |
| 4 | 3.6.3 - IR Testing | Conduct tabletop exercise (advance from June schedule) | +1 |

**Projected SPRS after Phase 1:** 92/110

### Phase 2: Core Remediation (Target: 30 days)
*Estimated Effort: 40-60 hours | SPRS Impact: +13 points*

| Priority | Finding | Action | SPRS Gain |
|----------|---------|--------|-----------|
| 5 | 3.5.3 - MFA | Enable FreeIPA OTP, deploy tokens, test | +5 |
| 6 | 3.2.1/3.2.2/3.2.3 - Training | Finalize AT policy, complete initial training, document | +7 |
| 7 | 3.12.1 - Security Assessment | Formalize annual assessment process, conduct initial | +3 (partial, combine with Phase 1 OpenSCAP) |

*Note: Finding 7 (3.12.1) - This preliminary gap analysis document contributes toward satisfying this requirement. Formalize as the initial annual security control assessment.*

**Projected SPRS after Phase 2:** 103-105/110

### Phase 3: Complete Remediation (Target: 60 days)
*Estimated Effort: 24-40 hours | SPRS Impact: +5-7 points*

| Priority | Finding | Action | SPRS Gain |
|----------|---------|--------|-----------|
| 8 | 3.11.1 - Risk Assessment | Conduct formal risk assessment per TCC-RA-001 | +3 |
| 9 | Policy Finalization | Approve AU, CM, IA, SC policies | +0 (maturity) |
| 10 | DR Testing | Conduct backup restoration test | +0 (supporting) |

**Projected SPRS after Phase 3:** 110/110

### Phase 3 Completion Checklist

Before scheduling the formal C3PAO assessment, verify:

- [ ] All 10 NOT MET requirements remediated and verified
- [ ] All 11 policies approved (6 existing + 5 newly finalized)
- [ ] SSP updated to v2.1+ reflecting all changes
- [ ] POA&M updated showing all items completed
- [ ] OpenSCAP rescan confirms 104/104 PASS (or better)
- [ ] SPRS score updated in SPRS system
- [ ] Evidence package organized per Evidence_Package_Summary.md structure
- [ ] All evidence artifacts dated within 12 months
- [ ] Network diagram current
- [ ] Personnel agreements current and signed

---

## 9. Comparison: Self-Assessment vs. Independent Assessment

| Metric | Self-Assessment (POA&M v2.2) | Independent Assessment | Notes |
|--------|------------------------------|----------------------|-------|
| SPRS Score | 107/110 | 88/110 | -19 point variance |
| NOT MET Count | 2 | 10 | Self-assessment under-reports |
| MFA Gap | Identified (-3) | Identified (-5) | Weight difference |
| Training Gap | Not identified | Identified (-7) | Major gap in self-assessment |
| Risk Assessment Gap | Not identified | Identified (-3) | Methodology gap |
| Security Assessment Gap | Not identified | Identified (-3) | Process gap |
| Operational Gaps | Partially identified | Fully identified (-4) | Session lock, banners, media, IR |
| Policy Status | Not assessed | 5 of 11 families undocumented | Maturity impact |

### Root Cause Analysis

The variance between self-assessment and independent assessment is attributable to:

1. **Self-assessment bias:** As documented in the organization's own whitepaper ("Beyond the Checkbox," Shannon 2026), self-assessment creates inherent optimism. The system owner, deeply familiar with compensating controls and planned implementations, tends to credit intentions as achievements.

2. **Draft policy credit:** The self-assessment appears to credit DRAFT policies as satisfying documentation requirements. Per CMMC Assessment Guide v2.13, only formally approved and effective policies constitute acceptable evidence.

3. **Planned implementation credit:** Several controls are scored as MET based on planned implementations (USBGuard, MFA, login banners) that are not yet operational.

4. **Assessment methodology:** The self-assessment does not appear to have been conducted using the full assessment objectives from the CMMC Assessment Guide for each requirement. A systematic objective-by-objective evaluation reveals gaps not captured in the POA&M.

---

## 10. Conclusion

The CyberHygiene Production Network demonstrates a **strong security posture** with mature technical controls that significantly exceed typical small business implementations. The system's defense-in-depth architecture, FIPS 140-2 encryption, centralized identity management, and comprehensive monitoring capabilities provide a solid foundation for CMMC Level 2 certification.

The identified gaps are **primarily procedural and documentation-based** rather than fundamental architectural deficiencies:

- **MFA** is the only significant technical gap, and FreeIPA natively supports the required capability
- **Training, risk assessment, and security assessment** gaps represent process maturation needs
- **Operational gaps** (session lock, banners, USBGuard, IR testing) are straightforward configuration tasks
- **Policy gaps** require documentation effort but do not indicate missing technical capabilities

With focused remediation effort estimated at **80-120 hours over 60-90 days**, the system can achieve all 110 requirements and qualify for **Final CMMC Level 2 certification**.

The assessor commends the organization for:
- Achieving 100% OpenSCAP technical compliance
- Maintaining a comprehensive and current POA&M
- Implementing FIPS 140-2 encryption across all CUI storage
- Building a sophisticated monitoring capability with Wazuh SIEM and Suricata IDS
- Achieving all of this with 100% open-source components at zero licensing cost

---

## Document Control

**Classification:** Controlled Unclassified Information (CUI)
**Distribution:** System Owner/ISSO, Authorized C3PAO Assessors
**Retention:** 3 years minimum (CMMC evidence requirement)

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 1.0 | 02/09/2026 | Independent Preliminary Reviewer | Initial CMMC L2 Preliminary Gap Analysis |

---

*END OF CMMC LEVEL 2 PRELIMINARY GAP ANALYSIS*
