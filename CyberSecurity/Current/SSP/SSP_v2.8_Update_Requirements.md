# SSP Version 2.8 Update Requirements

**Document:** System Security Plan
**From Version:** 2.7
**To Version:** 2.8
**Date:** February 21, 2026
**Author:** D. Shannon

---

## Summary of Changes

This document outlines changes required to update the System Security Plan from Version 2.7 to Version 2.8 based on three operational changes completed February 21, 2026:

1. **Remote administration method switched from root SSH to named user (dshannon) with NOPASSWD sudo** — eliminates direct root SSH login to workstations in favor of accountable, auditable named-user access.
2. **PermitRootLogin no enforced on all 3 CPN workstations** — resolves the outstanding `sshd_disable_root_login` OpenSCAP finding on labrat, engineering, and accounting.
3. **Login banner updated** — replaced the USG/DoD government-system notice with a CyberHygiene Project company-appropriate Contractor Information System (CIS) access notice.

**Net Result:** All 4 CPN systems now score **100% on OpenSCAP CUI profile** (104/104 pass, 0 fail). First time all systems have achieved full CUI compliance simultaneously.

**SPRS Score:** Remains **101/110** — these changes improve operational security posture and eliminate the sshd_disable_root_login finding; they do not change NIST 800-171 control MET/NOT MET status.

---

## Header Updates

| Section | Current Value | New Value |
|---------|---------------|-----------|
| Version | 2.7 | 2.8 |
| Date | February 21, 2026 | February 21, 2026 |
| SPRS Score | 101/110 | 101/110 (unchanged) |
| POA&M Reference | v2.9 | v2.9 (unchanged) |

---

## Revision History Entry

Add to Document Revision History table:

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 2.8 | February 21, 2026 | D. Shannon | **ADMIN METHOD SWITCHOVER + FULL OPENSCAP COMPLIANCE:** Remote administration of CPN workstations changed from direct root SSH to named-user dshannon with NOPASSWD sudo (ECDSA-521 key auth). PermitRootLogin no enforced on all 3 workstations, resolving the sshd_disable_root_login OpenSCAP finding. Login banner updated from USG government notice to CyberHygiene Project CIS company access notice. Result: all 4 CPN systems now 100% OpenSCAP CUI compliant (104/104 pass, 0 fail). SPRS unchanged at 101/110. |

---

## Control Documentation Updates

### 3.1.1 / 3.1.2 — Authorized Access and Privilege Limitation

Update the remote administration section of SSP to reflect:

```markdown
#### Remote Administration of CPN Workstations

**Method:** SSH key-based authentication as named user `dshannon` with NOPASSWD sudo
**Previous Method:** Direct root SSH (deprecated 02/21/2026)
**Account:** D. Shannon — ISSO, System Administrator

**Authentication Chain:**
1. SSH key authentication using ECDSA-521 key pair
   - Private key: `/home/dshannon/.ssh/id_ecdsa` (on dc1.cyberinabox.net only)
   - Public key: Deployed to `/home/dshannon/.ssh/authorized_keys` on each workstation
2. Passwordless sudo via `/etc/sudoers.d/dshannon-admin`:
   - `dshannon ALL=(root) NOPASSWD: ALL`
   - SSSD sudo lookup disabled (`sudoers: files` in `/etc/nsswitch.conf`) to prevent IPA override
   - Session logging enabled (`Defaults:dshannon log_output`)

**Rationale for NOPASSWD sudo:**
- Remote non-interactive admin scripts cannot respond to interactive password prompts
- Authentication burden carried by SSH key (ECDSA-521 private key on dc1 only)
- All sudo sessions logged via `log_output` — full audit trail retained
- Named account (dshannon) provides accountability that root SSH did not

**Workstation Configuration:**

| System | Authorized Keys | Sudoers File | PermitRootLogin | Deployed |
|--------|----------------|--------------|-----------------|---------|
| labrat.cyberinabox.net | /home/dshannon/.ssh/authorized_keys | /etc/sudoers.d/dshannon-admin | no | 02/21/2026 |
| engineering.cyberinabox.net | /home/dshannon/.ssh/authorized_keys | /etc/sudoers.d/dshannon-admin | no | 02/21/2026 |
| accounting.cyberinabox.net | /home/dshannon/.ssh/authorized_keys | /etc/sudoers.d/dshannon-admin | no | 02/21/2026 |

**Admin Scripts Updated to Use dshannon@host:**
- `/home/dshannon/scripts/collect_openscap_results.sh`
- `/home/dshannon/scripts/trigger_all_openscap_scans.sh`
- `/home/dshannon/scripts/fix-engineering.sh`
- `/root/deploy-ws-controls.sh`
- `/root/ws-setup.sh` (bootstrap script for new workstations)
```

---

### 3.1.9 — Login Banners: Banner Text Update

Update the banner content documented in SSP Section 3.1.9. The prior USG/DoD government-system notice has been replaced with a company-appropriate CIS notice reflecting the actual nature of the system (commercial contractor, not a government system):

```markdown
#### 3.1.9 Limit System Use Notifications

**Status:** MET
**SPRS Impact:** Recovered +1 point (02/15/2026)

Login banners deployed on all CPN systems — company Contractor Information System (CIS) access notice.

**Deployment Scope:** All 4 CPN systems — dc1, labrat, engineering, accounting

**Banner Text (effective 02/21/2026):**

> You are accessing a CyberHygiene Project Contractor Information System (CIS)
> that is provided for company-authorized use only.
>
> Unauthorized access or use is strictly prohibited and may be subject to
> civil and criminal penalties. All activity on this system is monitored
> and recorded. By continuing, you consent to this monitoring.

**Banner Files:**

| System | Console Banner | SSH Banner | Banner Updated |
|--------|---------------|------------|---------------|
| dc1.cyberinabox.net | /etc/issue | Banner /etc/issue.net | 02/21/2026 |
| labrat.cyberinabox.net | /etc/issue | Banner /etc/issue.net | 02/21/2026 |
| engineering.cyberinabox.net | /etc/issue | Banner /etc/issue.net | 02/21/2026 |
| accounting.cyberinabox.net | /etc/issue | Banner /etc/issue.net | 02/21/2026 |

**Previous banner:** USG/DoD government-system notice (replaced — system is a commercial contractor IS, not a government system)

**Bootstrap scripts updated** to deploy new banner text:
- `/root/ws-setup.sh` (new workstation setup)
- `/root/fix-engineering.sh` (workstation remediation script)
```

---

### 3.13.8 — SSH Hardening: PermitRootLogin no on All Workstations

Update the SSH configuration table in the SSP to reflect:

```markdown
#### SSH Configuration — CPN Workstations (updated 02/21/2026)

**PermitRootLogin:** `no` on all CPN systems

| System | PermitRootLogin | Config Location | Applied |
|--------|----------------|-----------------|---------|
| dc1.cyberinabox.net | no | /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf | Pre-existing |
| labrat.cyberinabox.net | no | /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf | 02/21/2026 |
| engineering.cyberinabox.net | no | /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf | 02/21/2026 |
| accounting.cyberinabox.net | no | /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf | 02/21/2026 |

**Note:** PermitRootLogin was previously set to `yes` on workstations to allow root SSH-based remote administration. Now that administration has moved to the `dshannon` named account with NOPASSWD sudo, direct root SSH is no longer required and has been disabled.

**OpenSCAP Result:** `sshd_disable_root_login` rule now PASS on all 4 systems.
```

---

### OpenSCAP Compliance Posture — Full Compliance Achieved

Update the OpenSCAP compliance summary in the SSP:

```markdown
#### CUI Profile OpenSCAP Compliance — 2026-02-21

**Profile:** xccdf_org.ssgproject.content_profile_cui (NIST 800-171 CUI)
**Tool:** OpenSCAP 1.3.x / SCAP Security Guide (SSG) Rocky Linux 9

| System | Pass | Fail | N/A | Score | Date |
|--------|------|------|-----|-------|------|
| dc1.cyberinabox.net | 104 | 0 | 35 | 100% | 2026-02-21 |
| labrat.cyberinabox.net | 104 | 0 | 35 | 100% | 2026-02-21 |
| engineering.cyberinabox.net | 104 | 0 | 35 | 100% | 2026-02-21 |
| accounting.cyberinabox.net | 104 | 0 | 35 | 100% | 2026-02-21 |

**All 4 CPN systems: 100% — 0 failed rules.**

**Previous failures resolved:**

| Rule | Previous Status | Resolution | Date |
|------|----------------|------------|------|
| sshd_disable_root_login | FAIL (labrat, engineering, accounting) | PermitRootLogin no set; admin moved to dshannon+sudo | 02/21/2026 |
| sysctl_user_max_user_namespaces | FAIL (accounting) | `/etc/sysctl.d/99-user-namespaces.conf` deployed; sysctl applied | 02/21/2026 |

**Automated collection:** Results aggregated by `/home/dshannon/scripts/collect_openscap_results.sh` to `/home/dshannon/CyberSecurity/Current/Assessments/OpenSCAP/CUI_Compliance_Summary_20260221.md` and published to the OpenSCAP compliance dashboard.
```

---

## No SPRS Impact

These changes improve operational security posture but do not change NIST 800-171 control MET/NOT MET determinations:

- **3.1.1, 3.1.2** — Access control was already MET; the change to named-user admin further strengthens implementation but does not change the assessment
- **3.1.9** — Login Banners remain MET; banner text updated to reflect correct system classification
- **3.13.8** — SSH transmission security was MET; PermitRootLogin no removes a compensating-control caveat

**SPRS score remains 101/110.**

---

## Verification Checklist

After implementing all updates, verify:

- [ ] SPRS score remains 101/110 in all document sections
- [ ] Remote administration section updated: dshannon+sudo, ECDSA-521 key, sudoers file, PermitRootLogin no
- [ ] 3.1.9 banner text updated to CyberHygiene Project CIS notice
- [ ] SSH configuration table shows PermitRootLogin no on all 4 systems
- [ ] OpenSCAP compliance table updated: all 4 systems 100% as of 2026-02-21
- [ ] Previous OpenSCAP findings (sshd_disable_root_login, sysctl_user_max_user_namespaces) documented as resolved
- [ ] POA&M reference remains v2.9

---

## Files Updated/Created

| File | Action | Notes |
|------|--------|-------|
| SSP_v2.8_Update_Requirements.md | Created | This document |
| /etc/issue, /etc/issue.net | Modified (all 4 systems) | CyberHygiene Project CIS banner |
| /etc/sudoers.d/dshannon-admin | Created (labrat, engineering, accounting) | dshannon NOPASSWD: ALL |
| /home/dshannon/.ssh/authorized_keys | Created (labrat, engineering, accounting) | dshannon ECDSA-521 key |
| /etc/nsswitch.conf | Modified (labrat, engineering, accounting) | sudoers: files (sss removed) |
| /home/dshannon/scripts/collect_openscap_results.sh | Modified | dshannon@host + sudo |
| /home/dshannon/scripts/trigger_all_openscap_scans.sh | Modified | dshannon@host + sudo |
| /home/dshannon/scripts/fix-engineering.sh | Modified | PermitRootLogin no, dshannon key install |
| /root/ws-setup.sh | Modified | dshannon key + sudoers, new banner |
| /root/deploy-ws-controls.sh | Modified | dshannon@host + sudo |

---

**Document Status:** Ready for Implementation
**Author:** D. Shannon
**Date:** February 21, 2026
