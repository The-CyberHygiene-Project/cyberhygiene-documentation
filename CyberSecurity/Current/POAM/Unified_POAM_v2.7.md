# PLAN OF ACTION & MILESTONES (POA&M)

**Version:** 2.7
**Date:** February 17, 2026
**Organization:** The Contract Coach
**System:** CyberHygiene Production Network (cyberinabox.net)
**Reference:** System Security Plan Version 2.4
**Classification:** Controlled Unclassified Information (CUI)

---

## Executive Summary

**SPRS Score Status:**
- Current Score: 101/110 (91.8%)
- Previous Score: 98/110 (89.1%) as of February 17, 2026
- Target Score: 110/110 (100%)
- Target Completion: March 31, 2026 (most items), June 30, 2026 (IR testing)

SPRS score revised per independent CMMC L2 Preliminary Gap Analysis (February 9, 2026). See Assessment Reference section below. Score updated 02/17/2026 after completion of security awareness training program (POA&M-006, +7 points) and security control assessment program (POA&M-011, +3 points).

---

## Assessment Reference

**Document:** CMMC Level 2 Preliminary Gap Analysis
**Assessment Date:** February 9, 2026
**Assessor:** Independent C3PAO Preliminary Reviewer
**Methodology:** CMMC Assessment Guide Level 2, Version 2.13 (September 2024)
**Reference Standard:** NIST SP 800-171 Rev 2 / 32 CFR 170.16 / 32 CFR 170.17

### Variance Summary

The independent assessment identified a **19-point SPRS variance** between the self-assessed score (107/110) and the independent score (88/110). The self-assessment has been corrected to align with the independent findings.

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

**Root Causes of Variance:**
1. DRAFT policies credited as MET (CMMC Guide v2.13 requires formally approved policies)
2. Planned implementations credited as MET (USBGuard, training, risk assessment)
3. MFA weight scored at -3 (IA-8 only) instead of -5 (full 3.5.3 weight)
4. Several NOT MET items not captured as SPRS deficits in POA&M

---

## POA&M Summary

| Metric | Count | Percentage |
|--------|-------|------------|
| **Total Items** | 45 | 100% |
| **Completed** | 34 | 76% |
| **On Track** | 5 | 11% |
| **Ongoing** | 2 | 4% |
| **Closed (Risk Accepted)** | 1 | 2% |
| **Planned** | 1 | 2% |

**Priority Distribution (items with assigned priority):**
- High Priority: 9 items (5 completed, 3 on track, 1 planned)
- Medium Priority: 15 items (14 completed, 1 on track)
- Low Priority: 4 items (4 completed)
- Ongoing: 2 items

---

## Section 1: COMPLETED POA&M Items

Items completed and verified as of February 15, 2026:

### Infrastructure and Technical Controls

| POA&M ID | Weakness/Deficiency | NIST Controls | Completion Date | Evidence | Status |
|----------|---------------------|---------------|-----------------|----------|--------|
| POA&M-001 | Samba file sharing not operational | AC-3, AC-6, AU-2 | 01/26/2026 | Samba share operational at `/srv/samba/shared`, FreeIPA integration verified | COMPLETED |
| POA&M-002 | Email server not deployed | SC-8, SC-13, SI-3 | 01/26/2026 | Postfix 3.5.25 and Dovecot 2.3.16 operational with TLS encryption | COMPLETED |
| POA&M-003 | Backup system not implemented | CP-9, CP-10 | 10/28/2025 | ReaR backup system operational with weekly full backups and daily incremental backups | COMPLETED |
| POA&M-008 | IDS/IPS not operational on firewall | SI-4 | 10/28/2025 | Wazuh SIEM v4.9.2 deployed with Suricata integration on pfSense | COMPLETED |
| POA&M-009 | File integrity monitoring not deployed | SI-7 | 10/28/2025 | Wazuh FIM operational with 12-hour scan intervals on critical paths | COMPLETED |
| POA&M-010 | SSL certificate not installed | SC-8, SC-13 | 01/26/2026 | SSL.com wildcard certificate deployed, valid until October 28, 2026 | COMPLETED |

### Policy Documentation

| POA&M ID | Weakness/Deficiency | NIST Controls | Completion Date | Evidence | Status |
|----------|---------------------|---------------|-----------------|----------|--------|
| POA&M-015 | Incident Response Policy not documented | IR-1, IR-4, IR-6, IR-8 | 11/02/2025 | TCC-IRP-001 approved and effective | COMPLETED |
| POA&M-016 | Incident Response Procedures not documented | IR-2 through IR-8 | 11/02/2025 | Complete IR procedures in TCC-IRP-001 | COMPLETED |
| POA&M-017 | Personnel screening not documented | PS-3 | 11/02/2025 | TCC-PS-001, Section 2.3 documents TS clearance | COMPLETED |
| POA&M-018 | Personnel Security Policy not developed | PS-1 through PS-8 | 11/02/2025 | TCC-PS-001 approved and effective | COMPLETED |
| POA&M-019 | Physical security controls not documented | PE-1 through PE-20 | 11/02/2025 | TCC-PE-MP-001 Part 1 approved | COMPLETED |
| POA&M-020 | Media protection procedures not developed | MP-1 through MP-8 | 11/02/2025 | TCC-PE-MP-001 Part 2 approved | COMPLETED |
| POA&M-021 | Media sanitization not documented | MP-6 | 11/02/2025 | TCC-PE-MP-001, Section 2.6 (LUKS erase, shred) | COMPLETED |
| POA&M-022 | Risk Assessment Policy not developed | RA-1, RA-2, RA-3, RA-7 | 11/02/2025 | TCC-RA-001 approved and effective | COMPLETED |
| POA&M-023 | Vulnerability scanning not documented | RA-5 | 11/02/2025 | TCC-RA-001, Section 2.5 (Wazuh, OpenSCAP) | COMPLETED |
| POA&M-024 | System Integrity Policy not developed | SI-1, SI-2, SI-4 through SI-12 | 11/02/2025 | TCC-SI-001 approved and effective | COMPLETED |
| POA&M-025 | Malware protection not documented | SI-3 | 11/02/2025 | TCC-SI-001, Section 2.3 (YARA, Wazuh FIM) | COMPLETED |
| POA&M-026 | Acceptable Use Policy not developed | AC-1, PS-6, PL-4 | 11/02/2025 | TCC-AUP-001 approved and effective | COMPLETED |
| POA&M-027 | Risk Management Framework not established | RA-3, RA-5, RA-7 | 11/02/2025 | TCC-RA-001 with NIST SP 800-30 methodology | COMPLETED |

### AI Security Controls (NEW - February 2026)

| POA&M ID | Weakness/Deficiency | NIST Controls | Completion Date | Evidence | Status |
|----------|---------------------|---------------|-----------------|----------|--------|
| POA&M-036 | AI Gateway Security Controls | 3.1.1, 3.1.2, 3.5.2 | 02/02/2026 | OpenClaw gateway with token auth, loopback-only binding, tool allowlist | COMPLETED |
| POA&M-037 | Prompt Injection Defense (Citadel Guard) | 3.13.1, 3.6.1 | 02/02/2026 | Citadel Guard with 20+ detection patterns, sanitize-and-flag action | COMPLETED |
| POA&M-038 | Human-in-the-Loop Enforcement | 3.1.5, 3.1.7, 3.5.2 | 02/02/2026 | Sudo approval proxy with HMAC-signed responses, 120s timeout | COMPLETED |
| POA&M-039 | AI Audit Logging | 3.3.1, 3.3.2 | 02/02/2026 | Comprehensive logging at gateway, proxy, and agent layers | COMPLETED |
| POA&M-040 | AI Network Confinement | 3.1.7, 3.13.1, 3.13.8 | 02/02/2026 | nftables egress rules, UID-based filtering for openclaw-svc | COMPLETED |
| POA&M-041 | AI Security Documentation | 3.4.1, 3.4.5 | 02/02/2026 | OPENCLAW_AI_SECURITY_ARCHITECTURE.md, SBOM.json, SSP addendum | COMPLETED |
| POA&M-SPRS-3 | Email spam protection (SI-8) | SI-8 | 02/03/2026 | OpenDKIM 2.11.0, SpamAssassin 3.4.6, spamass-milter operational | COMPLETED |

### Gap Analysis Remediation (February 15, 2026)

#### Policy Approvals

| POA&M ID | Weakness/Deficiency | NIST Controls | Completion Date | Evidence | Status |
|----------|---------------------|---------------|-----------------|----------|--------|
| POA&M-030 | Audit & Accountability Policy not developed | AU-1 through AU-12 | 02/15/2026 | TCC-AAP-001 v1.0 approved, /s/ Donald E. Shannon. File: Audit_and_Accountability_Policy_v1.0.md | COMPLETED |
| POA&M-031 | Configuration Management Policy not developed | CM-1 through CM-11 | 02/15/2026 | TCC-CMP-001 v1.0 approved, /s/ Donald E. Shannon. File: Configuration_Management_Policy_v1.0.md | COMPLETED |
| POA&M-032 | Security Awareness and Training Policy not developed (POLICY COMPONENT) | AT-1 through AT-4 | 02/15/2026 | TCC-ATP-001 v1.0 approved, /s/ Donald E. Shannon. File: Security_Awareness_and_Training_Policy_v1.0.md. **Note:** Policy approved; training program implementation (3.2.1-3.2.3) remains ON TRACK — see POA&M-006/032-TRAINING below. | COMPLETED (POLICY) |
| POA&M-033 | Identification and Authentication Policy not developed | IA-1 through IA-11 | 02/15/2026 | TCC-IAP-001 v1.0 approved, /s/ Donald E. Shannon. File: Identification_and_Authentication_Policy_v1.0.md | COMPLETED |
| POA&M-045 | System & Communications Protection Policy not developed | SC-1 through SC-16 | 02/15/2026 | TCC-SCP-001 v1.0 approved, /s/ Donald E. Shannon. File: System_and_Communications_Protection_Policy_v1.0.md | COMPLETED |

#### Wazuh Dashboard (February 17, 2026)

| POA&M ID | Weakness/Deficiency | NIST Controls | Completion Date | Evidence | Status |
|----------|---------------------|---------------|-----------------|----------|--------|
| POA&M-013 | Wazuh Dashboard deployment | SI-4 (enhancement) | 02/17/2026 | Wazuh Dashboard 4.14.3 operational at https://dc1.cyberinabox.net:5601. OpenSearch 2.19.4 backend running on port 9200. Wazuh Manager API 4.14.3 on port 55000. Dashboard monitoring 7 enrolled agents. Root cause of prior crash-loop: file permission on wazuh.yml (corrected to wazuh-dashboard:wazuh-dashboard ownership). No SPRS impact (SI-4 enhancement, not a scored deficit). | COMPLETED |

#### Security Awareness Training (February 17, 2026)

| POA&M ID | Weakness/Deficiency | NIST Controls | Completion Date | Evidence | Status |
|----------|---------------------|---------------|-----------------|----------|--------|
| POA&M-006 | Security awareness training program not implemented | 3.2.1, 3.2.2, 3.2.3 (AT-2, AT-3) | 02/17/2026 | Training document TCC-SAT-FY2026 v1.0 (3 modules: General Awareness, Role-Based Technical, Insider Threat). Assessment quiz TCC-SAT-QUIZ-FY2026 (20 questions, 80% passing). Completion record TCC-SAT-RECORD-FY2026 signed. Training records stored at /srv/hr/training-records/. Self-study delivery per gap analysis finding (acceptable for solopreneur with TS clearance). **SPRS: +7 points recovered (3.2.1: +3, 3.2.2: +3, 3.2.3: +1).** | COMPLETED |

#### Security Control Assessment (February 17, 2026)

| POA&M ID | Weakness/Deficiency | NIST Controls | Completion Date | Evidence | Status |
|----------|---------------------|---------------|-----------------|----------|--------|
| POA&M-011 | Security control assessment not formally established | 3.12.1 (CA-2) | 02/17/2026 | **Formal Assessment:** Independent CMMC L2 Preliminary Gap Analysis conducted 02/09/2026 by C3PAO reviewer covering all 110 NIST 800-171 requirements. **Ongoing Automated Assessment:** OpenSCAP CUI profile (xccdf_org.ssgproject.content_profile_cui) scans all 4 CPN systems (dc1, labrat, engineering, accounting) every 12 hours via systemd timers. Centralized daily collection via `collect_openscap_results.sh` with consolidated HTML compliance dashboard at https://dc1.cyberinabox.net/dashboard/openscap-dashboard.html. Per-system pass/fail/score tracking with drill-down to full OpenSCAP HTML reports. Markdown summary at CyberSecurity/Current/Assessments/OpenSCAP/CUI_Compliance_Summary_YYYYMMDD.md. Assessment scope: all SCAP Security Guide CUI rules mapped to NIST 800-171 controls. **SPRS: +3 points recovered (3.12.1: +3).** | COMPLETED |

#### Technical Controls (dc1)

| POA&M ID | Weakness/Deficiency | NIST Controls | Completion Date | Evidence | Status |
|----------|---------------------|---------------|-----------------|----------|--------|
| POA&M-029 | Session lock not configured (15-min timeout) | 3.1.10 (AC-11) | 02/15/2026 | GNOME dconf: idle-delay=900s, lock-enabled=true, settings locked. Config: /etc/dconf/db/local.d/01-screensaver. **Deployed: dc1, labrat, engineering. Pending: accounting (out of service for maintenance).** | COMPLETED |
| POA&M-034 | Login banners not implemented on all systems | 3.1.9 (AC-8) | 02/15/2026 | DoD-standard banner in /etc/issue and /etc/issue.net. SSH Banner configured. Verified: `sshd -T \| grep banner`. **Deployed: dc1, labrat, engineering. Pending: accounting (out of service for maintenance).** | COMPLETED |
| POA&M-044 | Removable media technical enforcement (USBGuard) | 3.8.7 (MP.L2-3.8.7) | 02/15/2026 | USBGuard 1.0.0-16.el9 with device-specific allow policy per host. Wazuh monitoring via /var/log/usbguard/usbguard-audit.log. Verified: `usbguard list-devices`. **Deployed: dc1, labrat, engineering. Pending: accounting (out of service for maintenance).** | COMPLETED |

---

## Section 2: CLOSED POA&M Items (Risk Accepted)

| POA&M ID | Weakness/Deficiency | NIST Controls | Status | Risk Acceptance Reference |
|----------|---------------------|---------------|--------|---------------------------|
| POA&M-014 | ClamAV antivirus FIPS incompatible | SI-3 | CLOSED - Risk Accepted | Risk_Acceptance_ClamAV_FIPS_Incompatibility.md |

**Risk Acceptance Details:**
- ClamAV 1.4.3 incompatible with FIPS mode due to OpenSSL 3 cryptographic restrictions
- Compensating controls: YARA 4.5.2 pattern detection (operational), Wazuh FIM, network IDS/IPS
- Risk level: LOW (with compensating controls)
- Annual review scheduled: December 31, 2026

---

## Section 2A: CONSOLIDATED POA&M Items

| POA&M ID | Original Weakness | Consolidated Into | Rationale | Date |
|----------|-------------------|-------------------|-----------|------|
| POA&M-SPRS-1 | MFA not implemented for non-organizational users (IA-8) | POA&M-004 | Same FreeIPA OTP deployment covers both organizational and non-organizational users. IA-8 requirement addressed by the same MFA implementation as 3.5.3. | 02/11/2026 |

---

## Section 3: ON TRACK POA&M Items

### Q1 End (Target: March 31, 2026)

| POA&M ID | Weakness/Deficiency | NIST Controls | SPRS Impact | Target Date | Priority | Status | POC |
|----------|---------------------|---------------|-------------|-------------|----------|--------|-----|
| POA&M-004 | Multi-factor authentication not configured | 3.5.3 (IA-2(1), IA-2(2)) | **-5 points** | 03/31/2026 | High | ON TRACK | Shannon |

**POA&M-004 (MFA) Assessment Finding:** Independent assessment scores 3.5.3 at full **-5 point** weight (not -3 as previously assessed for IA-8 only). FreeIPA natively supports OTP tokens; remediation is straightforward. This item now absorbs POA&M-SPRS-1 (IA-8 for non-organizational users) — the same FreeIPA OTP deployment covers both organizational and non-organizational user MFA requirements.

### Q2 (Target: April 30, 2026)

| POA&M ID | Weakness/Deficiency | NIST Controls | SPRS Impact | Target Date | Priority | Status | POC |
|----------|---------------------|---------------|-------------|-------------|----------|--------|-----|
| POA&M-012 | Disaster recovery testing not performed | CP-4 | — | 04/30/2026 | High | ON TRACK | Shannon |
| POA&M-035 | First annual risk assessment not conducted | 3.11.1 (RA-3) | **-3 points** | 04/30/2026 | High | ON TRACK | Shannon |

**POA&M-035 (Risk Assessment) Assessment Finding:** Independent assessment identifies 3.11.1 as NOT MET with **-3 point** deficit. Risk Management Policy (TCC-RA-001) is approved with NIST SP 800-30 methodology established, but the first formal periodic risk assessment has not been conducted. Risk identification through POA&M and Wazuh monitoring does not substitute for a formal risk assessment.

### Q2 End (Target: June 30, 2026)

| POA&M ID | Weakness/Deficiency | NIST Controls | SPRS Impact | Target Date | Priority | Status | POC |
|----------|---------------------|---------------|-------------|-------------|----------|--------|-----|
| POA&M-SPRS-2 | IR tabletop exercise not conducted | 3.6.3 (IR-3) | **-1 point** | 06/30/2026 | Medium | ON TRACK | Shannon |

**POA&M-SPRS-2 (IR Testing) Assessment Finding:** Independent assessment scores 3.6.3 at **-1 point** (updated from -0.5 per assessment weight). Annual tabletop exercise requirement documented in TCC-IRP-001 but first exercise not yet performed.

---

## Section 4: ONGOING POA&M Items

| POA&M ID | Weakness/Deficiency | NIST Controls | Frequency | Status | POC |
|----------|---------------------|---------------|-----------|--------|-----|
| POA&M-042 | AI Continuous Monitoring | 3.3.4, 3.6.1, 3.12.3 | Daily/Weekly/Monthly | ONGOING | Shannon |
| POA&M-043 | Citadel Guard Pattern Updates | 3.14.1, 3.14.6 | Quarterly | ONGOING | Shannon |

**POA&M-042 Milestones:**
- Daily: Citadel Guard log review
- Weekly: Approval request analysis
- Monthly: HITL flow testing
- Quarterly: Penetration testing

**POA&M-043 Milestones:**
- Q1 2026: Review emerging injection techniques
- Q1 2026: Update pattern database
- Q1 2026: Test against new payloads

---

## Section 5: PLANNED POA&M Items

| POA&M ID | Weakness/Deficiency | NIST Controls | Target Date | Priority | Status | POC |
|----------|---------------------|---------------|-------------|----------|--------|-----|
| POA&M-028 | VPN with MFA for remote access | AC-17, IA-2(1) | 06/30/2026 | High | PLANNED | Shannon |

---

## POA&M Metrics

### By Status

| Status | Count | Percentage |
|--------|-------|------------|
| Completed | 34 | 76% |
| On Track | 5 | 11% |
| Ongoing | 2 | 4% |
| Closed (Risk Accepted) | 1 | 2% |
| Planned | 1 | 2% |

### By Priority

| Priority | Total | Completed | On Track | Ongoing | Planned/Closed |
|----------|-------|-----------|----------|---------|----------------|
| High | 9 | 5 | 3 | 0 | 1 |
| Medium | 15 | 13 | 2 | 0 | 0 |
| Low | 4 | 4 | 0 | 0 | 0 |
| Ongoing | 2 | 0 | 0 | 2 | 0 |

### By Target Date

| Quarter | Target Items | Completed | Remaining | Notes |
|---------|-------------|-----------|-----------|-------|
| Q1 2026 (Jan-Mar) | 11 items | 10 | 1 | MFA remains |
| Q2 2026 (Apr-Jun) | 5 items | 1 | 4 | Wazuh dashboard complete. Remaining: IR testing, risk assessment, DR testing, VPN |

### By Control Family

| Family | Total Items | Completed | Open | SPRS Deficit |
|--------|-------------|-----------|------|--------------|
| Access Control (AC) | 5 | 4 | 1 | — |
| Awareness & Training (AT) | 2 | 2 | 0 | — |
| Audit & Accountability (AU) | 1 | 1 | 0 | — |
| Security Assessment (CA) | 1 | 1 | 0 | — |
| Configuration Management (CM) | 1 | 1 | 0 | — |
| Contingency Planning (CP) | 2 | 1 | 1 | — |
| Identification & Authentication (IA) | 2 | 1 (policy) | 1 (MFA) | -5 |
| Incident Response (IR) | 3 | 2 | 1 | -1 |
| Media Protection (MP) | 3 | 3 | 0 | — |
| Physical Protection (PE) | 1 | 1 | 0 | — |
| Personnel Security (PS) | 2 | 2 | 0 | — |
| Risk Assessment (RA) | 4 | 3 | 1 | -3 |
| System & Communications Protection (SC) | 3 | 3 | 0 | — |
| System & Information Integrity (SI) | 7 | 6 | 1 | — |
| AI Security Controls | 8 | 6 | 2 | — |

*Items assigned to primary control family. Total: 45 items, 34 completed, 11 open (5 on track, 2 ongoing, 1 planned, 1 risk accepted, 2 AI ongoing). SPRS remaining deficit: -9.*

---

## Completion Trend

| Date | Total Items | Completed | % Complete | Notes |
|------|-------------|-----------|------------|-------|
| 10/26/2025 | 14 | 0 | 0% | Initial POA&M |
| 10/28/2025 | 14 | 3 | 21% | Backup, IDS/IPS, FIM complete |
| 10/31/2025 | 14 | 3 | 21% | POA&M-014 advanced to 85% |
| 11/02/2025 | 28 | 16 | 57% | Policy documentation complete |
| 12/26/2025 | 31 | 16 | 52% | SPRS gaps added |
| 01/26/2026 | 31 | 19 | 61% | Samba, Email, SSL complete |
| 02/03/2026 | 43 | 26 | 60% | AI controls integrated, POA&M-014 closed, POA&M-SPRS-3 complete |
| 02/11/2026 | 45 | 26 | 58% | v2.3: Reconciled with independent assessment. SPRS revised 107→88. Added POA&M-044, 045. Consolidated SPRS-1 into 004. |
| 02/15/2026 | 45 | 31 | 69% | v2.4: Gap analysis remediation. 5 DRAFT policies approved. USBGuard, session lock, login banners implemented on dc1. SPRS 88→91 (+3 points recovered). |
| 02/15/2026 | 45 | 31 | 69% | v2.5: Workstation deployment. Technical controls (USBGuard, session lock, login banners, SSH remote admin) deployed to labrat and engineering. Accounting out of service. 3 of 4 systems hardened. |
| 02/17/2026 | 45 | 32 | 71% | v2.6: Security awareness training program completed. 3 modules (General Awareness, Role-Based Technical, Insider Threat). Self-study with assessment quiz. SPRS 91→98 (+7 points: 3.2.1 +3, 3.2.2 +3, 3.2.3 +1). |
| 02/17/2026 | 45 | 33 | 73% | v2.7: Security control assessment program established (POA&M-011). Centralized OpenSCAP CUI assessment: 12-hour automated scans on all 4 CPN systems, daily collection to dc1, consolidated HTML dashboard. Combined with independent CMMC L2 gap analysis (02/09/2026) satisfies 3.12.1. SPRS 98→101 (+3 points: 3.12.1 +3). |
| 02/17/2026 | 45 | 34 | 76% | v2.7: Wazuh Dashboard (POA&M-013) operational. Root cause: file permission on wazuh.yml preventing dashboard startup (40,000+ crash-loops). Fixed ownership to wazuh-dashboard user. Dashboard 4.14.3 running on port 5601, OpenSearch 2.19.4 backend, 7 agents monitored. No SPRS impact (SI-4 enhancement). |
| Projected 03/31/2026 | 45 | 35+ | 78%+ | Q1 target: MFA |
| Projected 06/30/2026 | 45 | 40+ | 89%+ | Most items complete |

---

## SPRS Impact Summary

### Remaining Deficits (as of February 17, 2026)

| POA&M ID | Req ID | Control Description | Weight | Target Date | Status |
|----------|--------|---------------------|--------|-------------|--------|
| POA&M-004 | 3.5.3 | Multifactor Authentication | -5 | 03/31/2026 | On Track |
| POA&M-035 | 3.11.1 | Periodic Risk Assessment | -3 | 04/30/2026 | On Track |
| POA&M-SPRS-2 | 3.6.3 | IR Testing | -1 | 06/30/2026 | On Track |
| **TOTAL REMAINING** | | | **-9** | | |

**Current SPRS (post-assessment program):** 101/110 (91.8%)
**Target SPRS Upon Completion:** 110/110 (100%)

*Note: Session lock (3.1.10, -1), login banners (3.1.9, -1), and removable media (3.8.7, -1) implemented on dc1, labrat, and engineering on 02/15/2026. 3 points recovered. Training program (3.2.1, 3.2.2, 3.2.3) completed 02/17/2026, 7 points recovered. Security control assessment program (3.12.1) completed 02/17/2026 via centralized OpenSCAP CUI assessment with consolidated dashboard, 3 points recovered. Accounting workstation pending (out of service for maintenance).*

### Completed SPRS Items

| POA&M ID | Control | Points Recovered | Completion Date |
|----------|---------|-----------------|-----------------|
| POA&M-011 | 3.12.1 (Security Control Assessment) | +3.0 | 02/17/2026 |
| POA&M-006 | 3.2.1 (Role-Based Risk Awareness) | +3.0 | 02/17/2026 |
| POA&M-006 | 3.2.2 (Role-Based Training) | +3.0 | 02/17/2026 |
| POA&M-006 | 3.2.3 (Insider Threat Awareness) | +1.0 | 02/17/2026 |
| POA&M-029 | 3.1.10 (Session Lock) | +1.0 | 02/15/2026 |
| POA&M-034 | 3.1.9 (Login Banners) | +1.0 | 02/15/2026 |
| POA&M-044 | 3.8.7 (Removable Media) | +1.0 | 02/15/2026 |
| POA&M-SPRS-3 | SI-8 (Spam Protection) | +2.0 | 02/03/2026 |

---

## Evidence Storage

All completed POA&M items have evidence stored in:
- **Policies:** `/home/dshannon/cyberhygiene-documentation/Certification and Compliance Evidence/Policies/`
- **Technical Documentation:** `/home/dshannon/cyberhygiene-documentation/`
- **Configuration Files:** System configuration directories
- **AI Security Documentation:** `/data/ai-workspace/sysadmin-agent/docs/`
- **Compliance Reports:** `/backup/compliance-scans/`
- **Assessment Reports:** `/home/dshannon/CyberSecurity/Current/Assessments/`
- **OpenSCAP Dashboard:** `https://dc1.cyberinabox.net/dashboard/openscap-dashboard.html`
- **OpenSCAP Reports:** `/home/dshannon/CyberSecurity/Current/Assessments/OpenSCAP/`

---

## Review Schedule

- **Quarterly POA&M Review:** January, April, July, October
- **Next Review:** April 30, 2026
- **POA&M Owner:** Donald E. Shannon, ISSO

---

## Document Control

**Classification:** Controlled Unclassified Information (CUI)
**Owner:** Donald E. Shannon, ISSO
**Distribution:** Owner/ISSO, Authorized Auditors, C3PAO Assessors

### Revision History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 1.0 | 10/26/2025 | D. Shannon | Initial POA&M with 14 items |
| 1.1 | 10/28/2025 | D. Shannon | Marked POA&M-003, 008, 009 complete |
| 1.2 | 10/31/2025 | D. Shannon | POA&M-014 advanced to 85% |
| 1.3 | 11/02/2025 | D. Shannon | Unified POA&M: Marked 13 policy items complete, added 8 new items |
| 2.0 | 12/26/2025 | D. Shannon | Added 3 SPRS assessment gaps (POA&M-SPRS-1, SPRS-2, SPRS-3) |
| 2.1 | 12/26/2025 | D. Shannon | System verification: Completed POA&M-001 (Samba), POA&M-010 (SSL), POA&M-SPRS-3 (SpamAssassin). Updated POA&M-014 to Blocked |
| 2.2 | 02/03/2026 | D. Shannon | **Major Update:** SSP reference updated v1.9→v2.0. Integrated 8 AI POA&M items (POA&M-036 through POA&M-043). Closed POA&M-014 with risk acceptance. Rescheduled all overdue items. Updated POA&M-SPRS-3 status (OpenDKIM/SpamAssassin not functional). Completed POA&M-002 (Email operational). Total items: 31→43. Metrics recalculated. |
| 2.3 | 02/11/2026 | D. Shannon | Reconciled with independent CMMC L2 Preliminary Gap Analysis (02/09/2026). SPRS score revised from 107 to 88 per independent assessment. Added 10 SPRS deficit items. New: POA&M-044 (USBGuard), POA&M-045 (SC Policy). Consolidated POA&M-SPRS-1 into POA&M-004. Corrected item counts (v2.2 understated total by 1). Updated all metrics and control family assignments. |
| 2.4 | 02/15/2026 | D. Shannon | **GAP ANALYSIS REMEDIATION:** Completed 8 items. 5 DRAFT policies formally approved with /s/ Donald E. Shannon signatures (POA&M-030, 031, 032-policy, 033, 045). Technical controls implemented on dc1: session lock via dconf (POA&M-029), DoD login banners (POA&M-034), USBGuard with device-specific policy and Wazuh monitoring (POA&M-044). Training (3.2.1-3.2.3) consolidated under POA&M-006. SPRS improved 88→91 (+3 points). ws1-ws3 deployment pending (offline). SSP reference updated to v2.3. |
| 2.5 | 02/15/2026 | D. Shannon | **WORKSTATION DEPLOYMENT:** Extended technical controls (session lock, login banners, USBGuard, SSH remote administration) to labrat and engineering workstations. PermitRootLogin and firewall corrected on workstations. All controls verified via SSH from dc1. Accounting workstation out of service for maintenance — deployment pending return. 3 of 4 systems now hardened. POA&M-029, 034, 044 status updated from COMPLETED (dc1) to COMPLETED. |
| 2.6 | 02/17/2026 | D. Shannon | **TRAINING PROGRAM COMPLETED:** POA&M-006 closed. Security awareness training program executed: TCC-SAT-FY2026 (3 modules: General Security Awareness, Role-Based Technical Training, Insider Threat Awareness), TCC-SAT-QUIZ-FY2026 (20-question assessment, 80% passing), TCC-SAT-RECORD-FY2026 (completion record). Self-study delivery validated per gap analysis (solopreneur with TS clearance). Training records directory created at /srv/hr/training-records/. SPRS improved 91→98 (+7 points: 3.2.1 +3, 3.2.2 +3, 3.2.3 +1). Remaining SPRS deficit: -12. |
| 2.7 | 02/17/2026 | D. Shannon | **SECURITY CONTROL ASSESSMENT PROGRAM ESTABLISHED:** POA&M-011 closed. Centralized OpenSCAP security control assessment deployed: automated CUI profile scans every 12 hours on all 4 CPN systems (dc1, labrat, engineering, accounting), daily centralized collection via collect_openscap_results.sh (systemd timer at 06:00), consolidated HTML compliance dashboard at /dashboard/openscap-dashboard.html with per-system pass/fail scoring and drill-down to full OpenSCAP reports. Combined with independent CMMC L2 Preliminary Gap Analysis (02/09/2026) covering all 110 NIST 800-171 requirements. SSP reference updated to v2.4. SPRS improved 98→101 (+3 points: 3.12.1 +3). Remaining SPRS deficit: -9. **WAZUH DASHBOARD (POA&M-013) COMPLETED:** Fixed file permission on /usr/share/wazuh-dashboard/data/wazuh/config/wazuh.yml (root:root → wazuh-dashboard:wazuh-dashboard). Dashboard 4.14.3 now operational at https://dc1.cyberinabox.net:5601 with OpenSearch 2.19.4 backend, monitoring 7 agents. No SPRS impact (SI-4 enhancement). |

---

*END OF UNIFIED POA&M v2.7*
