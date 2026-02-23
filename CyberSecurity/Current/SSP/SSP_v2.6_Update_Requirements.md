# SSP Version 2.6 Update Requirements

**Document:** System Security Plan
**From Version:** 2.5
**To Version:** 2.6
**Date:** February 21, 2026
**Author:** D. Shannon

---

## Summary of Changes

This document outlines changes required to update the System Security Plan from Version 2.5 to Version 2.6 based on tuning of the Wazuh/VirusTotal integration to prevent API quota exhaustion.

**Key Changes:**
- SPRS score unchanged at 101/110 (no control status changes)
- Wazuh VirusTotal integration alert level threshold raised from 7 → 10
- MD5 hash deduplication cache added to VirusTotal integration script
- Daily API quota guard (490/500) added to VirusTotal integration script
- Documents root cause of quota exhaustion and resolution

---

## Header Updates

| Section | Current Value | New Value |
|---------|---------------|-----------|
| Version | 2.5 | 2.6 |
| Date | February 21, 2026 | February 21, 2026 |
| SPRS Score | 101/110 | 101/110 (unchanged) |
| POA&M Reference | v2.7 | v2.7 (unchanged) |

---

## Revision History Entry

Add to Document Revision History table:

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 2.6 | February 21, 2026 | D. Shannon | **VIRUSTOTAL INTEGRATION TUNING:** Wazuh/VT integration alert threshold raised from level 7 to level 10 to reduce excessive API calls from routine FIM events. MD5 hash deduplication cache and daily quota guard (490/day) added to virustotal.py integration script. Root cause: syscheck generating 2,500+ level-7 alerts/day across all agents, each triggering a VT API lookup, exhausting the 500/day free-tier limit. No SPRS impact. |

---

## Security Monitoring Documentation Updates

### VirusTotal Integration — Configuration Change

Update the VirusTotal/Wazuh integration section of the SSP to reflect:

```markdown
#### VirusTotal File Hash Reputation Integration

**Integration:** Wazuh → VirusTotal API v2
**Purpose:** Automated malware detection for files flagged by FIM (syscheck)
**Tier:** VirusTotal Free (500 API lookups/day)

**Trigger Configuration (ossec.conf):**

| Parameter | Previous Value | Current Value | Rationale |
|-----------|---------------|---------------|-----------|
| group | syscheck | syscheck | Unchanged — FIM events only |
| level | 7 | 10 | Raised to reduce routine file-change triggers |
| alert_format | json | json | Unchanged |

**Level Threshold Change:**
- Level 7: Any file integrity checksum change (routine modifications, log rotation, package updates)
- Level 10: High-severity FIM events (executable modifications, setuid/setgid changes, critical system file changes)
- Raising from 7→10 reduces trigger volume from ~2,500/day to <50/day while preserving detection of meaningful file changes

**Hash Deduplication Cache (/var/ossec/integrations/virustotal.py):**
- Cache file: /var/ossec/tmp/vt_hash_cache.json
- Scope: Per-day (resets at midnight)
- Behavior: If an MD5 hash has already been submitted to VT today, subsequent alerts for the same hash are skipped
- Quota guard: Stops all VT submissions once 490 lookups/day are reached (buffer below 500 hard limit)
- Prevents repeated lookups of the same file hash from multiple agent alerts

**Root Cause of Quota Exhaustion:**
- Wazuh syscheck running on 4 monitored systems (dc1, labrat, engineering, accounting)
- Each syscheck scan generates level-7 alerts for any file with a changed MD5 checksum
- Package updates, log rotation, and CUPS print service generated 2,500+ FIM alerts/day
- Zero deduplication in the default virustotal.py script — each alert fired a unique VT API call

**Files Modified:**

| File | Change | Date |
|------|--------|------|
| /var/ossec/etc/ossec.conf | VT integration level 7 → 10 | 2026-02-21 |
| /var/ossec/integrations/virustotal.py | Added hash cache + quota guard | 2026-02-21 |

**Ongoing Monitoring:**
- VT API usage visible in /var/ossec/tmp/vt_hash_cache.json (daily count)
- Quota exhaustion alerts surfaced via Wazuh rule (HTTP 204 from VT API)
```

---

## No SPRS Impact

These are operational tuning changes to an existing, functioning security control. No NIST 800-171 control statuses are affected:
- 3.14.2 (Malware protection) — VirusTotal integration remains active and operational
- 3.14.4 (Malware scanning) — syscheck FIM scanning unchanged; only VT trigger threshold adjusted
- The integration now operates sustainably within the free-tier API limit

---

## Verification Checklist

After implementing all updates, verify:

- [ ] SPRS score remains 101/110 in all document sections
- [ ] VirusTotal integration section updated with new level threshold (10)
- [ ] Hash deduplication cache documented with file path and behavior
- [ ] Daily quota guard (490/day) documented
- [ ] Root cause of previous exhaustion documented
- [ ] Modified files table included
- [ ] Wazuh manager confirmed running after config change

---

## Files Updated/Created

| File | Action | Notes |
|------|--------|-------|
| SSP_v2.6_Update_Requirements.md | Created | This document |
| /var/ossec/etc/ossec.conf | Modified | VT alert level 7 → 10 |
| /var/ossec/integrations/virustotal.py | Modified | Hash cache + quota guard added |

---

**Document Status:** Ready for Implementation
**Author:** D. Shannon
**Date:** February 21, 2026
