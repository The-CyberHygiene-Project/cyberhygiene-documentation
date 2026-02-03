# FreeIPA Restore Test Evidence
## Evidence Artifact for CP-10 Control

**Export Date:** February 3, 2026
**System:** dc1.cyberinabox.net
**Control:** CP-10 (Information System Recovery and Reconstitution)

---

## Verification Status

**IPA Restore Log Found:** /var/log/iparestore.log
**Log Date:** January 18, 2026
**Log Size:** 20,701 bytes

---

## Test Summary

The FreeIPA directory service restore functionality has been successfully tested. The restore log at `/var/log/iparestore.log` documents a complete IPA restore operation.

### Restore Test Details

| Attribute | Value |
|-----------|-------|
| Test Date | January 18, 2026 |
| Log Location | /var/log/iparestore.log |
| Log Size | 20,701 bytes |
| Status | SUCCESSFUL |

---

## Backup Components Tested

| Component | Backed Up | Restored |
|-----------|-----------|----------|
| FreeIPA Directory (389-ds) | Yes | Tested |
| Kerberos Database | Yes | Tested |
| Certificate Authority (Dogtag) | Yes | Tested |
| DNS Configuration | Yes | Tested |

---

## Outstanding Items

### Full System Backup (ReaR)

**Status:** Implemented but not fully tested

- ReaR backup system operational with weekly full backups
- Component-level restores tested (IPA, files)
- Full bare-metal restore test scheduled for Q2 2026

**POA&M Reference:** POA&M-012 (Disaster recovery testing)
**Target Date:** April 30, 2026

---

## NIST SP 800-171 Compliance

| Control | Requirement | Implementation |
|---------|-------------|----------------|
| 3.8.9 (CP-9) | Conduct backups | Weekly full, daily incremental via ReaR |
| 3.8.10 (CP-10) | Provide for recovery | IPA restore tested, full DR test planned |

---

## Evidence Commands

```bash
# View IPA restore log
sudo head -100 /var/log/iparestore.log

# Check backup status
ls -la /var/lib/ipa/backup/

# List ReaR recovery images
ls -la /backup/rear/
```

---

**Collected By:** D. Shannon
**Classification:** CUI Evidence Artifact
