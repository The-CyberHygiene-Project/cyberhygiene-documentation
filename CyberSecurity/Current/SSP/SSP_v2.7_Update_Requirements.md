# SSP Version 2.7 Update Requirements

**Document:** System Security Plan
**From Version:** 2.6
**To Version:** 2.7
**Date:** February 21, 2026
**Author:** D. Shannon

---

## Summary of Changes

This document outlines changes required to update the System Security Plan from Version 2.6 to Version 2.7 based on completion of CMMC control deployment to the accounting workstation, bringing all 4 CPN systems to full compliance.

**Key Changes:**
- SPRS score unchanged at 101/110 (controls already credited at initial deployment)
- POA&M reference updated to v2.9
- 3.1.9 (Login Banners), 3.1.10 (Session Lock), and 3.8.7 (Removable Media) deployment scope updated from 3/4 to 4/4 systems
- "Pending: accounting" caveats removed from all three control sections

---

## Header Updates

| Section | Current Value | New Value |
|---------|---------------|-----------|
| Version | 2.6 | 2.7 |
| Date | February 21, 2026 | February 21, 2026 |
| SPRS Score | 101/110 | 101/110 (unchanged) |
| POA&M Reference | v2.8 | v2.9 |

---

## Revision History Entry

Add to Document Revision History table:

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 2.7 | February 21, 2026 | D. Shannon | **ACCOUNTING WORKSTATION DEPLOYMENT COMPLETE:** Accounting workstation (192.168.1.113) returned from maintenance. CMMC controls deployed: session lock (3.1.10), DoD login banners (3.1.9), USBGuard removable media enforcement (3.8.7). All 4 CPN systems now fully hardened. Deployment scope updated from 3/4 to 4/4 systems in sections 3.1.9, 3.1.10, and 3.8.7. No SPRS impact. POA&M reference updated to v2.9. |

---

## Control Status Updates

### 3.1.9 Login Banners — Scope Update

Update the deployment scope in SSP Section 3.1.9:

```markdown
#### 3.1.9 Limit System Use Notifications

**Status:** MET
**SPRS Impact:** Recovered +1 point (02/15/2026)

DoD-standard login banners deployed on all CPN systems.

**Deployment Scope:** All 4 CPN systems — dc1, labrat, engineering, accounting

| System | Banner File | SSH Banner | Deployed |
|--------|-------------|------------|---------|
| dc1.cyberinabox.net | /etc/issue, /etc/issue.net | Banner /etc/issue.net | 02/15/2026 |
| labrat.cyberinabox.net | /etc/issue, /etc/issue.net | Banner /etc/issue.net | 02/15/2026 |
| engineering.cyberinabox.net | /etc/issue, /etc/issue.net | Banner /etc/issue.net | 02/15/2026 |
| accounting.cyberinabox.net | /etc/issue, /etc/issue.net | Banner /etc/issue.net | 02/21/2026 |

**Remove previous caveat:** ~~Pending: accounting (out of service for maintenance)~~
```

---

### 3.1.10 Session Lock — Scope Update

Update the deployment scope in SSP Section 3.1.10:

```markdown
#### 3.1.10 Session Lock

**Status:** MET
**SPRS Impact:** Recovered +1 point (02/15/2026)

GNOME session lock configured via dconf on all CPN systems.

**Deployment Scope:** All 4 CPN systems — dc1, labrat, engineering, accounting

| System | Config File | Idle Delay | Lock Enabled | Deployed |
|--------|-------------|------------|--------------|---------|
| dc1.cyberinabox.net | /etc/dconf/db/local.d/01-screensaver | 900s | true | 02/15/2026 |
| labrat.cyberinabox.net | /etc/dconf/db/local.d/01-screensaver | 900s | true | 02/15/2026 |
| engineering.cyberinabox.net | /etc/dconf/db/local.d/01-screensaver | 900s | true | 02/15/2026 |
| accounting.cyberinabox.net | /etc/dconf/db/local.d/01-screensaver | 900s | true | 02/21/2026 |

Settings enforced via dconf locks — users cannot override.

**Remove previous caveat:** ~~Pending: accounting (out of service for maintenance)~~
```

---

### 3.8.7 Removable Media — Scope Update

Update the deployment scope in SSP Section 3.8.7:

```markdown
#### 3.8.7 Control Use of Removable Media

**Status:** MET
**SPRS Impact:** Recovered +1 point (02/15/2026)

USBGuard deployed on all CPN systems with device-specific allow policies.

**Deployment Scope:** All 4 CPN systems — dc1, labrat, engineering, accounting

| System | USBGuard Policy | Wazuh Monitoring | Deployed |
|--------|----------------|------------------|---------|
| dc1.cyberinabox.net | Device-specific allow rules | /var/log/usbguard/usbguard-audit.log | 02/15/2026 |
| labrat.cyberinabox.net | Device-specific allow rules | /var/log/usbguard/usbguard-audit.log | 02/15/2026 |
| engineering.cyberinabox.net | Device-specific allow rules | /var/log/usbguard/usbguard-audit.log | 02/15/2026 |
| accounting.cyberinabox.net | Device-specific allow rules | /var/log/usbguard/usbguard-audit.log | 02/21/2026 |

**Remove previous caveat:** ~~Pending: accounting (out of service for maintenance)~~
```

---

## No SPRS Impact

These changes complete the deployment of controls already credited in the SPRS score. No control statuses change:
- 3.1.9, 3.1.10, 3.8.7 remain MET — deployment scope is now 4/4 systems (was 3/4)
- SPRS score remains 101/110

---

## Verification Checklist

After implementing all updates, verify:

- [ ] SPRS score remains 101/110 in all document sections
- [ ] 3.1.9 deployment table shows all 4 systems including accounting (02/21/2026)
- [ ] 3.1.10 deployment table shows all 4 systems including accounting (02/21/2026)
- [ ] 3.8.7 deployment table shows all 4 systems including accounting (02/21/2026)
- [ ] "Pending: accounting" caveats removed from all three sections
- [ ] POA&M reference updated to v2.9

---

## Files Updated/Created

| File | Action | Notes |
|------|--------|-------|
| SSP_v2.7_Update_Requirements.md | Created | This document |
| CyberSecurity/Current/POAM/Unified_POAM_v2.9.md | Created | Accounting deployment, pending caveats removed |

---

**Document Status:** Ready for Implementation
**Author:** D. Shannon
**Date:** February 21, 2026
