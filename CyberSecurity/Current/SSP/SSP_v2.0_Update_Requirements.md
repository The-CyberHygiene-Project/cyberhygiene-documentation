# SSP Version 2.0 Update Requirements

**Document:** System Security Plan
**From Version:** 1.9
**To Version:** 2.0
**Date:** February 3, 2026
**Author:** D. Shannon

---

## Summary of Changes

This document outlines all changes required to update the System Security Plan from Version 1.9 to Version 2.0 based on the CMMC Level 2 readiness analysis.

---

## Header Updates

| Section | Current Value | New Value |
|---------|---------------|-----------|
| Version | 1.9 | 2.0 |
| Date | January 31, 2026 | February 3, 2026 |
| Target Completion | December 31, 2025 | March 31, 2026 |
| Next Review Date | January 31, 2026 | April 30, 2026 |
| SPRS Score | 105/110 (97.6%) | 105/110 (97.6%) - Target 110/110 by Q2 2026 |

---

## Revision History Entry

Add to Document Revision History table:

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 2.0 | February 3, 2026 | D. Shannon | **CRITICAL SYNCHRONIZATION UPDATE:** Aligned with POA&M v2.2. Corrected malware protection section (removed ClamAV as planned - FIPS incompatible; YARA is primary control with risk acceptance memo). Integrated AI security controls (OpenClaw Gateway, Citadel Guard, Sudo Proxy). Updated email security status (OpenDKIM/SpamAssassin not functional). Added SSP Addendum reference for AI Controls. Updated POA&M metrics. Corrected all target dates. |

---

## Section 3.4 Malware Protection Architecture - CORRECTION REQUIRED

### Current Text (INCORRECT)
```
Layer 3: ClamAV 1.5.x FIPS (PLANNED ⏳)
├─ Version: 1.5.x (FIPS 140-2 compatible)
├─ Database: Signed verification (.cvd.sign)
├─ Monitoring: Automated weekly EPEL checks
└─ Target: December 2025
```

### Updated Text (CORRECT)
```
Layer 3: ClamAV - RISK ACCEPTED
├─ Status: NOT IMPLEMENTED - FIPS 140-2 incompatibility
├─ ClamAV 1.4.3 fails with FIPS mode enabled (OpenSSL 3 restriction)
├─ Risk accepted with compensating controls (see Risk_Acceptance_ClamAV_FIPS_Incompatibility.md)
├─ Compensating controls: YARA 4.5.2 (operational), Wazuh FIM, network IDS/IPS
└─ Risk acceptance signed: [PENDING SIGNATURE]
```

### Add Compensating Controls Note
After the malware protection architecture diagram, add:

> **ClamAV FIPS Incompatibility - Risk Accepted:**
> Due to a known incompatibility between ClamAV 1.4.3 and OpenSSL 3 in FIPS mode, traditional endpoint antivirus cannot be deployed without disabling FIPS 140-2 compliance. The residual risk has been formally accepted with documented compensating controls including YARA pattern-based detection, Wazuh file integrity monitoring, and network IDS/IPS. See Risk Acceptance Memorandum: `Risk_Acceptance_ClamAV_FIPS_Incompatibility.md`

---

## Section 3.2.6 AI-Assisted Administration Infrastructure - UPDATE REQUIRED

### Add New Subsection: OpenClaw AI Security Architecture

After the existing AI-Assisted Administration section, add:

```markdown
### OpenClaw AI Security Controls (NEW - February 2026)

The AI-assisted administration capability has been enhanced with comprehensive security controls implemented through the OpenClaw Gateway architecture:

**OpenClaw Gateway:**
- URL: 127.0.0.1:18789 (loopback only - no external access)
- Authentication: 256-bit Bearer token
- Tool controls: Allowlist/denylist for AI capabilities
- Service account: openclaw-svc (UID 379)
- Systemd unit: openclaw.service

**Citadel Guard (Prompt Injection Defense):**
- 20+ detection patterns for injection attacks
- Instruction override, role manipulation, DC-specific patterns
- Sanitize-and-flag action for detected injections
- Response scanning for indirect injection

**Sudo Approval Proxy (Human-in-the-Loop):**
- External trust boundary for all privileged operations
- HMAC-SHA256 signed approval responses
- 120-second timeout with automatic denial
- Command classification: ALLOWED, APPROVAL_REQUIRED, FORBIDDEN
- Socket: /run/sudo-proxy/sudo-proxy.sock

**Network Confinement:**
- nftables egress rules for AI service account
- UID-based filtering blocks external connections
- Allowed: loopback, 192.168.1.0/24 only
- Evidence: /etc/nftables/openclaw-egress.nft

**AI Audit Logging:**
- Gateway logs: /opt/openclaw/logs/openclaw.log
- Proxy audit: /opt/sudo-proxy/logs/audit.log
- Agent audit: /data/ai-workspace/sysadmin-agent/logs/agent_audit.log
- Correlation via request_id across all components

**Documentation:**
- Security Architecture: docs/OPENCLAW_AI_SECURITY_ARCHITECTURE.md
- Software BOM: docs/SBOM.json (CycloneDX format)
- SSP Addendum: SSP_ADDENDUM_AI_CONTROLS.md
- POA&M: POAM_AI_CONTROLS.md
```

---

## Email Server Section (5) - CORRECTION REQUIRED

### Current Text
```
#### 5. Email Server (dc1.cyberinabox.net - integrated) ✅ OPERATIONAL

-   Postfix 3.5.25 SMTP with TLS enforcement
-   Dovecot 2.3.16 IMAP/POP3 with encryption
-   Domain: cyberinabox.net
-   Integration: FreeIPA authentication via LDAP
-   Status: Operational since January 2026
-   Anti-spam (Rspamd) and anti-virus (ClamAV) - planned
-   SPF, DKIM, DMARC implementation - planned
-   Webmail interface (Roundcube/SOGo) - planned
```

### Updated Text
```
#### 5. Email Server (dc1.cyberinabox.net - integrated) - PARTIALLY OPERATIONAL

-   Postfix 3.5.25 SMTP with TLS enforcement - ✅ OPERATIONAL
-   Dovecot 2.3.16 IMAP/POP3 with encryption - ✅ OPERATIONAL
-   Domain: cyberinabox.net
-   Integration: FreeIPA authentication via LDAP - ✅ OPERATIONAL
-   Status: Core services operational since January 2026

**Deficiencies Identified (February 2026):**
-   OpenDKIM - ❌ NOT INSTALLED (milter socket missing)
-   SpamAssassin - ❌ INACTIVE (service not running)
-   Error evidence: Postfix logs show milter connection failures

**Remediation (Target: March 31, 2026 - POA&M-SPRS-3):**
-   Install OpenDKIM: `dnf install opendkim opendkim-tools`
-   Enable SpamAssassin: `systemctl enable --now spamassassin spamass-milter`
-   Configure SPF, DKIM, DMARC DNS records
-   See POA&M-SPRS-3 for detailed milestones
```

---

## Section 10: POA&M - UPDATE REQUIRED

Update all POA&M metrics to match Unified_POAM_v2.2:

### Summary Update
| Metric | Old Value | New Value |
|--------|-----------|-----------|
| Total Items | 31 | 43 |
| Completed | 16 (52%) | 25 (58%) |
| In Progress | 2 (7%) | - |
| On Track | 11 (35%) | 12 (28%) |
| Ongoing | - | 2 (5%) |
| Planned | 2 (6%) | 2 (5%) |
| Closed (Risk Accepted) | - | 2 (5%) |

### Key Updates
- Add note: "See Unified_POAM_v2.2 for detailed item tracking"
- Reference: POA&M now includes 8 AI security control items (POA&M-036 through POA&M-043)
- POA&M-014 status: CLOSED - Risk Accepted (was: In Progress/Blocked)

---

## Appendix E: SSP Addendums - ADD NEW ENTRY

Add to the SSP Addendums table:

| Addendum | Version | Date | Description |
|----------|---------|------|-------------|
| AI Security Controls (OpenClaw) | 1.0 | February 2, 2026 | Documents OpenClaw Gateway security architecture including Citadel Guard prompt injection defense, sudo approval proxy (HITL), network confinement, and AI audit logging. Addresses 3.1.1, 3.1.2, 3.1.5, 3.1.7, 3.3.1, 3.3.2, 3.4.1, 3.5.2, 3.6.1, 3.13.1, 3.13.5, 3.13.8, 3.14.1, 3.14.6. |

**Addendum Location:** `/data/ai-workspace/sysadmin-agent/docs/SSP_ADDENDUM_AI_CONTROLS.md`

---

## Implementation Metrics Section - UPDATE REQUIRED

### SPRS Score Section Update

```markdown
### SPRS Score Status

**Current SPRS Score:** 105/110 (97.6%)
**Target SPRS Score:** 110/110 (100%)
**Target Completion:** June 30, 2026

**Points Deficit Breakdown:**

| POA&M ID | Control | Points Impact | Status | Target |
|----------|---------|---------------|--------|--------|
| POA&M-SPRS-1 | IA-8 (MFA for contractors) | -3.0 | On Track | 03/31/2026 |
| POA&M-SPRS-2 | IR-3 (IR Testing) | -0.5 | On Track | 06/30/2026 |
| POA&M-SPRS-3 | SI-8 (Spam Protection) | -2.0 | On Track | 03/31/2026 |
| **Total** | | **-5.5** | | |
```

---

## Verification Checklist

After implementing all updates, verify:

- [ ] POA&M v2.2 references SSP v2.0
- [ ] All item counts reconcile between SSP and POA&M
- [ ] No items have past due dates without explanation
- [ ] ClamAV correctly documented as risk-accepted (not planned)
- [ ] Email security deficiencies correctly documented
- [ ] AI security controls addendum referenced
- [ ] SPRS score section updated

---

## Files to Update/Create

| File | Action | Notes |
|------|--------|-------|
| System_Security_Plan_v1.9.docx | Archive | Move to /SSP/Archive/ |
| System_Security_Plan_v2.0.docx | Create | Based on v1.9 with above changes |
| Unified_POAM_v2.1.docx | Archive | Move to /POAM/Archive/ |
| Unified_POAM_v2.2.md | Created | New version (this session) |
| SSP_v2.0_Update_Requirements.md | Created | This document |

---

**Document Status:** Ready for Implementation
**Author:** D. Shannon
**Date:** February 3, 2026
