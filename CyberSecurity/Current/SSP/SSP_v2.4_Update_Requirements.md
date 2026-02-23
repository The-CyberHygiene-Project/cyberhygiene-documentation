# SSP Version 2.4 Update Requirements

**Document:** System Security Plan
**From Version:** 2.3
**To Version:** 2.4
**Date:** February 17, 2026
**Author:** D. Shannon

---

## Summary of Changes

This document outlines all changes required to update the System Security Plan from Version 2.3 to Version 2.4 based on the establishment of a formal security control assessment program using centralized OpenSCAP CUI compliance scanning.

**Key Changes:**
- SPRS score updated from 98/110 to 101/110 (+3 points: 3.12.1 Security Control Assessment)
- 3.12.1 (CA-2) status changed from NOT MET to MET
- New section documenting centralized OpenSCAP assessment infrastructure
- POA&M reference updated to v2.7

---

## Header Updates

| Section | Current Value | New Value |
|---------|---------------|-----------|
| Version | 2.3 | 2.4 |
| Date | February 15, 2026 | February 17, 2026 |
| SPRS Score | 91/110 (corrected per v2.3 requirements) | 101/110 (91.8%) |
| POA&M Reference | v2.6 | v2.7 |

---

## Revision History Entry

Add to Document Revision History table:

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 2.4 | February 17, 2026 | D. Shannon | **SECURITY CONTROL ASSESSMENT PROGRAM:** 3.12.1 (CA-2) status changed to MET. Centralized OpenSCAP CUI profile assessment deployed across all 4 CPN systems with automated 12-hour scans, daily centralized collection, and consolidated HTML compliance dashboard. Combined with independent CMMC L2 Preliminary Gap Analysis (02/09/2026). Training controls (3.2.1, 3.2.2, 3.2.3) updated to MET per POA&M-006 completion. SPRS updated to 101/110. POA&M reference updated to v2.7. |

---

## SPRS Score Update

### Current SPRS Section (v2.3)

Per SSP v2.3 Update Requirements, the SPRS section reflects a corrected score of 88/110 with 10 NOT MET items. Several items have since been completed (v2.4 through v2.7).

### Updated SPRS Section (v2.4)

```markdown
### SPRS Score Status

**Current SPRS Score:** 101/110 (91.8%)
**Target SPRS Score:** 110/110 (100%)
**Assessment Basis:** Independent CMMC L2 Preliminary Gap Analysis, February 9, 2026
**Target Completion:** June 30, 2026

**Remaining SPRS Deficit (3 NOT MET Items, -9 points):**

| POA&M ID | Req ID | Control Description | Weight | Target Date | Status |
|----------|--------|---------------------|--------|-------------|--------|
| POA&M-004 | 3.5.3 | Multifactor Authentication | -5 | 03/31/2026 | On Track |
| POA&M-035 | 3.11.1 | Periodic Risk Assessment | -3 | 04/30/2026 | On Track |
| POA&M-SPRS-2 | 3.6.3 | IR Testing | -1 | 06/30/2026 | On Track |
| **TOTAL** | | | **-9** | | |

**Points Recovered Since Independent Assessment (02/09/2026):**

| Date | Control | Points | Evidence |
|------|---------|--------|----------|
| 02/15/2026 | 3.1.10 Session Lock | +1 | GNOME dconf, deployed dc1/labrat/engineering |
| 02/15/2026 | 3.1.9 Login Banners | +1 | DoD banner in /etc/issue, /etc/issue.net |
| 02/15/2026 | 3.8.7 Removable Media | +1 | USBGuard with Wazuh monitoring |
| 02/17/2026 | 3.2.1 Role-Based Risk Awareness | +3 | TCC-SAT-FY2026, training records |
| 02/17/2026 | 3.2.2 Role-Based Training | +3 | TCC-SAT-FY2026, quiz assessment |
| 02/17/2026 | 3.2.3 Insider Threat Awareness | +1 | TCC-SAT-FY2026, Module 3 |
| 02/17/2026 | 3.12.1 Security Control Assessment | +3 | OpenSCAP centralized assessment + gap analysis |
| **TOTAL RECOVERED** | | **+13** | **88 + 13 = 101** |
```

---

## Control Status Updates

### 3.12.1 Security Control Assessment — NOT MET → MET

**Update SSP Section 3.12.1 to reflect:**

```markdown
#### 3.12.1 Periodically Assess Security Controls

**Status:** MET
**SPRS Impact:** Recovered +3 points (02/17/2026)

Security controls are periodically assessed through two complementary mechanisms:

**1. Independent Formal Assessment**
- CMMC Level 2 Preliminary Gap Analysis conducted February 9, 2026
- Assessor: Independent C3PAO Preliminary Reviewer
- Methodology: CMMC Assessment Guide Level 2, Version 2.13
- Scope: All 110 NIST SP 800-171 Rev 2 requirements
- Findings documented in POA&M v2.7 with remediation tracking

**2. Automated Technical Control Assessment (Ongoing)**
- Tool: OpenSCAP with SCAP Security Guide (SSG) for Rocky Linux 9
- Profile: xccdf_org.ssgproject.content_profile_cui (NIST 800-171 CUI)
- Datastream: /usr/share/xml/scap/ssg/content/ssg-rl9-ds.xml
- Scope: All 4 CPN systems (dc1, labrat, engineering, accounting)
- Frequency: Every 12 hours via systemd timers on each host
- Collection: Daily centralized collection at 06:00 via openscap-collect.timer
- Script: /home/dshannon/scripts/collect_openscap_results.sh
- Dashboard: https://dc1.cyberinabox.net/dashboard/openscap-dashboard.html
- Reports: Per-system HTML reports with full rule-level detail
- Summary: Consolidated Markdown and HTML with cross-system pass/fail matrix
- Storage: /home/dshannon/CyberSecurity/Current/Assessments/OpenSCAP/

**Assessment Infrastructure:**

| Component | Location | Purpose |
|-----------|----------|---------|
| Scan script | /usr/local/bin/openscap_cui_scan.sh | Runs OpenSCAP CUI eval, logs for Wazuh |
| Collection script | /home/dshannon/scripts/collect_openscap_results.sh | Collects results, generates reports |
| Collection timer | openscap-collect.timer (systemd) | Daily 06:00 collection trigger |
| HTML dashboard | /var/www/internal-dashboards/openscap-dashboard.html | Consolidated compliance view |
| Per-host reports | /var/www/internal-dashboards/openscap/ | Drill-down HTML reports |
| Assessments archive | CyberSecurity/Current/Assessments/OpenSCAP/ | Historical reports and summaries |

**Modes of Operation:**
- `--collect-only` (default, daily timer): Fetches latest scan results from all systems
- `--scan-and-collect` (on-demand): Triggers fresh scans, waits, then collects

**Evidence:**
- OpenSCAP dashboard accessible at /dashboard/openscap-dashboard.html
- Daily CUI_Compliance_Summary_YYYYMMDD.md generated automatically
- Per-host cui_report_<hostname>_YYYYMMDD.html reports archived
- Independent gap analysis report (February 9, 2026)
- POA&M v2.7, POA&M-011 (COMPLETED)
```

### 3.2.1, 3.2.2, 3.2.3 Training Controls — NOT MET → MET

**Update SSP Sections 3.2.1, 3.2.2, 3.2.3 to reflect:**

Per SSP v2.3 Update Requirements, these controls were correctly marked NOT MET. They are now MET as of February 17, 2026 per POA&M-006 completion.

```markdown
#### 3.2.1 Role-Based Risk Awareness

**Status:** MET (02/17/2026)
**Evidence:** TCC-SAT-FY2026 v1.0 Module 1 (General Security Awareness), completion record TCC-SAT-RECORD-FY2026. Self-study delivery validated per gap analysis for solopreneur with TS clearance. POA&M-006.

#### 3.2.2 Role-Based Training

**Status:** MET (02/17/2026)
**Evidence:** TCC-SAT-FY2026 v1.0 Module 2 (Role-Based Technical Training), assessment quiz TCC-SAT-QUIZ-FY2026 (20 questions, 80% passing threshold). POA&M-006.

#### 3.2.3 Insider Threat Awareness

**Status:** MET (02/17/2026)
**Evidence:** TCC-SAT-FY2026 v1.0 Module 3 (Insider Threat Awareness), completion record TCC-SAT-RECORD-FY2026. Training records stored at /srv/hr/training-records/. POA&M-006.
```

---

## POA&M Section Update

Update SSP Section 10 (POA&M) to reference POA&M v2.7:

### Summary Update

| Metric | Old Value (v2.6) | New Value (v2.7) |
|--------|-------------------|-------------------|
| Total Items | 45 | 45 |
| Completed | 32 (71%) | 33 (73%) |
| On Track | 6 (13%) | 5 (11%) |
| Ongoing | 2 (4%) | 2 (4%) |
| Closed (Risk Accepted) | 1 (2%) | 1 (2%) |
| Planned | 2 (4%) | 2 (4%) |
| SPRS Remaining Deficit | -12 | -9 |

### Newly Completed Item (February 17, 2026)

| POA&M ID | Description | SPRS Impact |
|----------|-------------|-------------|
| POA&M-011 | Security control assessment program established | +3 points (3.12.1) |

---

## Verification Checklist

After implementing all updates, verify:

- [ ] SPRS score reads 101/110 in all document sections
- [ ] 3.12.1 (Security Control Assessment) marked MET with full evidence
- [ ] 3.2.1, 3.2.2, 3.2.3 (Training) marked MET with evidence references
- [ ] Remaining deficit shows 3 items / -9 points (MFA, Risk Assessment, IR Testing)
- [ ] OpenSCAP assessment infrastructure fully documented
- [ ] Dashboard URL referenced: /dashboard/openscap-dashboard.html
- [ ] POA&M reference updated to v2.7
- [ ] Points recovered table shows all 13 points recovered since assessment

---

## Files Updated/Created

| File | Action | Notes |
|------|--------|-------|
| Unified_POAM_v2.7.md | Created | Updated from v2.6, POA&M-011 closed |
| SSP_v2.4_Update_Requirements.md | Created | This document |
| /home/dshannon/scripts/collect_openscap_results.sh | Created | Centralized collection + reporting |
| /etc/systemd/system/openscap-collect.timer | Created | Daily 06:00 collection trigger |
| /etc/systemd/system/openscap-collect.service | Created | Collection service unit |
| /var/www/internal-dashboards/openscap-dashboard.html | Created | HTML compliance dashboard |
| /var/www/internal-dashboards/openscap/ | Created | Per-host drill-down reports |
| /var/www/internal-dashboards/switchboard.html | Updated | Added OpenSCAP dashboard card |

---

**Document Status:** Ready for Implementation
**Author:** D. Shannon
**Date:** February 17, 2026
