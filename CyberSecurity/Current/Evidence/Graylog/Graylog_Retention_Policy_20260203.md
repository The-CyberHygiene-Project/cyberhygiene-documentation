# Graylog Log Retention Policy
## Evidence Artifact for AU-11 Control

**Export Date:** February 3, 2026 (Updated)
**System:** dc1.cyberinabox.net
**Control:** AU-11 (Audit Record Retention)

---

## Configuration Status

**Status:** CONFIGURED - 90 Day Retention Implemented

### Active Configuration

From `/etc/graylog/server/server.conf` (Updated February 3, 2026):

```ini
# Updated to 90 days retention per NIST 800-171 AU-11 requirement (February 3, 2026)
elasticsearch_max_number_of_indices = 90
disabled_retention_strategies = none,close
```

**Effect:**
- 90 daily indices retained (90 days online retention)
- Older indices automatically deleted
- Meets NIST SP 800-171 requirement for audit log retention
- Graylog service restarted to apply configuration

---

## Current Retention Architecture

| Component | Retention | Location |
|-----------|-----------|----------|
| Graylog/OpenSearch | 90 days (target) | /var/lib/opensearch |
| Local System Logs | 30 days | /var/log/audit/audit.log |
| Wazuh Alerts | 90 days | Wazuh Indexer |
| Backup Archive | 1 year | Encrypted backup media |

---

## NIST SP 800-171 Compliance

| Control | Requirement | Implementation |
|---------|-------------|----------------|
| 3.3.9 (AU-11) | Retain audit records per policy | 90 days online, 1 year archive |
| 3.3.7 (AU-9) | Protect audit information | OpenSearch data restricted to root/service accounts |

---

## POA&M Reference

**Item:** Configure explicit Graylog retention
**Status:** COMPLETED - February 3, 2026
**Configuration:** 90 days retention implemented

---

**Collected By:** D. Shannon
**Classification:** CUI Evidence Artifact
