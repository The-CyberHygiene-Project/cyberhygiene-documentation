# SSP Version 2.3 Update Requirements

**Document:** System Security Plan
**From Version:** 2.2
**To Version:** 2.3
**Date:** February 15, 2026
**Author:** D. Shannon

---

## Summary of Changes

This document outlines all changes required to update the System Security Plan from Version 2.2 to Version 2.3 based on the independent CMMC Level 2 Preliminary Gap Analysis (February 9, 2026) and subsequent remediation actions completed February 15, 2026.

**Key Changes:**
- SPRS score corrected from 107/110 to 88/110 per independent assessment
- 5 DRAFT policies formally approved (CMMC Guide v2.13 requires formally approved policies)
- Technical controls implemented: USBGuard, session lock, login banners (dc1)
- Training and risk assessment controls correctly marked as NOT MET with POA&M references
- MFA weight corrected from -3 (IA-8 only) to -5 (full 3.5.3)

---

## Header Updates

| Section | Current Value | New Value |
|---------|---------------|-----------|
| Version | 2.2 | 2.3 |
| Date | February 11, 2026 | February 15, 2026 |
| SPRS Score | 105/110 or 107/110 | 88/110 (80.0%) — per independent assessment |
| Target Score | 110/110 (100%) | 110/110 (100%) |
| Target Completion | March 31, 2026 (most), June 30, 2026 (IR) | No change |
| POA&M Reference | v2.3 | v2.4 |

---

## Revision History Entry

Add to Document Revision History table:

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 2.3 | February 15, 2026 | D. Shannon | **CMMC GAP ANALYSIS REMEDIATION:** SPRS score corrected to 88/110 per independent CMMC L2 Preliminary Gap Analysis (02/09/2026). 5 DRAFT policies formally approved (AU, CM, AT, IA, SC). Technical controls implemented on dc1: USBGuard (3.8.7), GNOME session lock (3.1.10), DoD login banners (3.1.9). Wazuh monitoring added for USBGuard. Training (3.2.1-3.2.3) and risk assessment (3.11.1) correctly marked NOT MET with POA&M references. MFA weight corrected to -5 for full 3.5.3. POA&M reference updated to v2.4. |

---

## Critical Correction: SPRS Score

### Current SPRS Section (INCORRECT)

The SSP currently reflects an incorrect SPRS score. Various sections may show 105/110, 107/110, or -5.5 / -3.5 deficit.

### Corrected SPRS Section

```markdown
### SPRS Score Status

**Current SPRS Score:** 88/110 (80.0%)
**Target SPRS Score:** 110/110 (100%)
**Assessment Basis:** Independent CMMC L2 Preliminary Gap Analysis, February 9, 2026
**Target Completion:** June 30, 2026

**SPRS Deficit Breakdown (10 NOT MET Items, -22 points total):**

| POA&M ID | Req ID | Control Description | Weight | Target Date | Status |
|----------|--------|---------------------|--------|-------------|--------|
| POA&M-004 | 3.5.3 | Multifactor Authentication | -5 | 03/31/2026 | On Track |
| POA&M-006 | 3.2.1 | Role-Based Risk Awareness | -3 | 03/31/2026 | On Track |
| POA&M-032 | 3.2.2 | Role-Based Training | -3 | 03/31/2026 | On Track |
| POA&M-032 | 3.2.3 | Insider Threat Awareness | -1 | 03/31/2026 | On Track |
| POA&M-035 | 3.11.1 | Periodic Risk Assessment | -3 | 04/30/2026 | On Track |
| POA&M-011 | 3.12.1 | Security Control Assessment | -3 | 03/31/2026 | On Track |
| POA&M-029 | 3.1.10 | Session Lock | -1 | 03/15/2026 | **COMPLETED 02/15/2026 (dc1)** |
| POA&M-034 | 3.1.9 | Login Banners | -1 | 03/15/2026 | **COMPLETED 02/15/2026 (dc1)** |
| POA&M-SPRS-2 | 3.6.3 | IR Testing | -1 | 06/30/2026 | On Track |
| POA&M-044 | 3.8.7 | Removable Media Enforcement | -1 | 03/31/2026 | **COMPLETED 02/15/2026 (dc1)** |
| **TOTAL** | | | **-22** | | |

**Points Recovered This Update:** +3 (session lock, login banners, USBGuard on dc1)
**Projected SPRS After ws1-ws3 Deployment:** 91/110 (82.7%)
```

**Note:** Session lock (3.1.10), login banners (3.1.9), and USBGuard (3.8.7) are now implemented on dc1 but ws1-ws3 are currently offline. Full credit requires deployment to all systems.

---

## Policy Approval Status Updates

### 5 Policies Formally Approved (February 15, 2026)

The following policies were in DRAFT status, which per CMMC Assessment Guide v2.13 cannot be scored as MET. All 5 have been formally approved with signatures.

| Policy ID | Policy Title | Previous Status | New Status | File |
|-----------|-------------|-----------------|------------|------|
| TCC-AAP-001 | Audit and Accountability Policy v1.0 | DRAFT | **APPROVED** | Audit_and_Accountability_Policy_v1.0.md |
| TCC-CMP-001 | Configuration Management Policy v1.0 | DRAFT | **APPROVED** | Configuration_Management_Policy_v1.0.md |
| TCC-ATP-001 | Security Awareness and Training Policy v1.0 | DRAFT | **APPROVED** | Security_Awareness_and_Training_Policy_v1.0.md |
| TCC-IAP-001 | Identification and Authentication Policy v1.0 | DRAFT | **APPROVED** | Identification_and_Authentication_Policy_v1.0.md |
| TCC-SCP-001 | System and Communications Protection Policy v1.0 | DRAFT | **APPROVED** | System_and_Communications_Protection_Policy_v1.0.md |

**Approval Details:**
- Approved By: Donald E. Shannon (System Owner / ISSO)
- Signature: /s/ Donald E. Shannon
- Effective Date: February 15, 2026
- Name corrected from "Daniel Shannon" to "Donald E. Shannon" in all documents

### SSP Section Updates for Policies

For each control family covered by the newly approved policies, update the SSP to reference the approved policy document:

1. **AU Controls (3.3.1-3.3.9):** Reference TCC-AAP-001 (was "draft" or "planned")
2. **CM Controls (3.4.1-3.4.9):** Reference TCC-CMP-001 (was "planned")
3. **AT Controls (3.2.1-3.2.3):** Reference TCC-ATP-001 (was "draft")
4. **IA Controls (3.5.1-3.5.11):** Reference TCC-IAP-001 (was "planned")
5. **SC Controls (3.13.1-3.13.16):** Reference TCC-SCP-001 (was "planned")

---

## Technical Implementation Updates

### USBGuard (3.8.7 — Removable Media Control)

**Update SSP Section 3.8.7 to reflect:**

```markdown
#### 3.8.7 Removable Media Technical Enforcement

**Status:** IMPLEMENTED (dc1) / PENDING (ws1-ws3)

USBGuard deployed to enforce removable media policy:
- Package: usbguard-1.0.0-16.el9.x86_64
- Policy: Device-specific allow rules (generated from connected devices)
- Default action: Block unrecognized USB devices
- Monitoring: Wazuh SIEM integration via /var/log/usbguard/usbguard-audit.log
- Evidence: `usbguard list-devices` shows device-level enforcement

**Configuration:**
- Rules: /etc/usbguard/rules.conf (9 device-specific rules)
- Service: systemctl enabled, active since February 14, 2026
- Audit: AuditFilePath=/var/log/usbguard/usbguard-audit.log

**Pending:** Deploy to ws1 (192.168.1.21), ws2 (192.168.1.22), ws3 (192.168.1.23) when online
```

### Session Lock (3.1.10 — AC-11)

**Update SSP Section 3.1.10 to reflect:**

```markdown
#### 3.1.10 Session Lock

**Status:** IMPLEMENTED (dc1) / PENDING (ws1-ws3)

GNOME screen lock configured at 15-minute idle timeout:
- Configuration: /etc/dconf/db/local.d/01-screensaver
- Settings locked: /etc/dconf/db/local.d/locks/screensaver
- idle-delay: 900 seconds (15 minutes)
- lock-enabled: true
- lock-delay: 0 seconds (immediate lock on activation)
- idle-activation-enabled: true
- Users cannot override these settings (dconf locks applied)

**Pending:** Deploy to ws1, ws2, ws3 when online
```

### Login Banners (3.1.9 — AC-8)

**Update SSP Section 3.1.9 to reflect:**

```markdown
#### 3.1.9 System Use Notification (Login Banners)

**Status:** IMPLEMENTED (dc1) / PENDING (ws1-ws3)

DoD-standard warning banner deployed:
- Console banner: /etc/issue
- SSH banner: /etc/issue.net
- SSH configuration: Banner /etc/issue (via 00-complianceascode-hardening.conf)
- Banner text: Standard USG Information System warning per DoD guidance
- Verification: `sshd -T | grep banner` confirms configuration

**Pending:** Deploy to ws1, ws2, ws3 when online
```

### Wazuh Integration Update

**Update SSP Wazuh/SIEM section to add:**

```markdown
#### USBGuard Monitoring (NEW - February 2026)

Wazuh SIEM configured to monitor USBGuard audit events:
- Log source: /var/log/usbguard/usbguard-audit.log
- Integration: Added to ossec.conf localfile monitoring
- Purpose: Alert on unauthorized USB device connection attempts
```

---

## Controls Correctly Marked as NOT MET

### Training (3.2.1, 3.2.2, 3.2.3) — NOT MET

**Update SSP to reflect:**

These controls were incorrectly self-assessed as MET. The independent assessment correctly identifies them as NOT MET:

| Req ID | Control | Status | SPRS Impact | POA&M Reference | Notes |
|--------|---------|--------|-------------|-----------------|-------|
| 3.2.1 | Role-Based Risk Awareness | **NOT MET** | -3 | POA&M-006 | AUP acknowledgment ≠ role-based training per CMMC Guide v2.13 |
| 3.2.2 | Role-Based Training | **NOT MET** | -3 | POA&M-032 | Training policy approved but training not yet conducted |
| 3.2.3 | Insider Threat Awareness | **NOT MET** | -1 | POA&M-032 | No insider threat awareness training delivered |

**Rationale:** Per CMMC Assessment Guide v2.13, training controls require evidence of training being conducted and documented, not merely that a policy exists. TCC-ATP-001 is now approved (February 15, 2026), but the actual training program has not been executed. Target: March 31, 2026.

### Risk Assessment (3.11.1) — NOT MET

**Update SSP to reflect:**

| Req ID | Control | Status | SPRS Impact | POA&M Reference | Notes |
|--------|---------|--------|-------------|-----------------|-------|
| 3.11.1 | Periodic Risk Assessment | **NOT MET** | -3 | POA&M-035 | Policy approved (TCC-RA-001) but first formal assessment not conducted |

**Rationale:** TCC-RA-001 establishes NIST SP 800-30 methodology, but the first formal periodic risk assessment has not been performed. Ongoing risk monitoring via Wazuh/POA&M does not substitute for a formal risk assessment. The February 9, 2026 preliminary gap analysis itself contributes toward satisfying 3.12.1 (Security Control Assessment) but not 3.11.1 (Risk Assessment). Target: April 30, 2026.

### MFA (3.5.3) — NOT MET, Corrected Weight

**Update SSP to reflect:**

| Req ID | Control | Status | SPRS Impact | POA&M Reference | Notes |
|--------|---------|--------|-------------|-----------------|-------|
| 3.5.3 | Multifactor Authentication | **NOT MET** | **-5** | POA&M-004 | Full 3.5.3 weight, not -3 for IA-8 only |

**Rationale:** The original self-assessment scored MFA at -3 points, applying it only to IA-8 (non-organizational users). The independent assessment correctly applies the full 3.5.3 weight of -5 points, as MFA is not implemented for any user category. FreeIPA OTP deployment will address both organizational and non-organizational user MFA. POA&M-SPRS-1 has been consolidated into POA&M-004.

---

## POA&M Section Update

Update SSP Section 10 (POA&M) to reference POA&M v2.4:

### Summary Update

| Metric | Old Value (v2.3) | New Value (v2.4) |
|--------|-------------------|-------------------|
| Total Items | 45 | 45 |
| Completed | 26 (58%) | 31 (69%) |
| On Track | 14 (31%) | 9 (20%) |
| Ongoing | 2 (4%) | 2 (4%) |
| Closed (Risk Accepted) | 1 (2%) | 1 (2%) |
| Planned | 2 (4%) | 2 (4%) |

### Newly Completed Items (February 15, 2026)

| POA&M ID | Description | SPRS Impact |
|----------|-------------|-------------|
| POA&M-029 | Session lock configured (dc1) | +1 point |
| POA&M-030 | Audit & Accountability Policy approved | — (maturity) |
| POA&M-031 | Configuration Management Policy approved | — (maturity) |
| POA&M-032 | Security Awareness & Training Policy approved (policy component) | — (training still NOT MET) |
| POA&M-033 | Identification & Authentication Policy approved | — (maturity) |
| POA&M-034 | Login banners configured (dc1) | +1 point |
| POA&M-044 | USBGuard deployed (dc1) | +1 point |
| POA&M-045 | System & Communications Protection Policy approved | — (maturity) |

---

## Verification Checklist

After implementing all updates, verify:

- [x] SPRS score reads 88/110 in all document sections (not 105, 107, or other values)
- [x] Full 10-item NOT MET list with correct SPRS weights documented
- [x] 5 DRAFT policies renamed and referenced as APPROVED
- [x] MFA weight shows -5 for 3.5.3 (not -3 for IA-8)
- [x] Training (3.2.1-3.2.3) marked NOT MET with POA&M references
- [x] Risk assessment (3.11.1) marked NOT MET with POA&M reference
- [x] USBGuard implementation documented (dc1)
- [x] Session lock implementation documented (dc1)
- [x] Login banners implementation documented (dc1)
- [x] POA&M reference updated to v2.4
- [x] Wazuh USBGuard monitoring documented
- [ ] ws1-ws3 deployment noted as pending (systems offline)

---

## Files Updated/Created

| File | Action | Notes |
|------|--------|-------|
| Audit_and_Accountability_Policy_v1.0.md | Renamed & Approved | Removed _DRAFT suffix |
| Configuration_Management_Policy_v1.0.md | Renamed & Approved | Removed _DRAFT suffix |
| Security_Awareness_and_Training_Policy_v1.0.md | Renamed & Approved | Removed _DRAFT suffix |
| Identification_and_Authentication_Policy_v1.0.md | Renamed & Approved | Removed _DRAFT suffix |
| System_and_Communications_Protection_Policy_v1.0.md | Renamed & Approved | Removed _DRAFT suffix |
| Unified_POAM_v2.4.md | Created | Updated from v2.3 |
| SSP_v2.3_Update_Requirements.md | Created | This document |
| SSP_POAM_Synchronization_Verification_20260215.md | Created | Updated verification |
| Control_to_Policy_Quick_Reference.md | Updated | Policy approvals, status corrections |
| /etc/usbguard/rules.conf | Updated | Device-specific policy |
| /etc/dconf/db/local.d/01-screensaver | Created | Session lock config |
| /etc/dconf/db/local.d/locks/screensaver | Created | Lock settings |
| /etc/issue | Updated | DoD warning banner |
| /etc/issue.net | Updated | DoD warning banner |
| /etc/ssh/sshd_config | Updated | Banner directive |
| /var/ossec/etc/ossec.conf | Updated | USBGuard log monitoring |

---

**Document Status:** Ready for Implementation
**Author:** D. Shannon
**Date:** February 15, 2026
