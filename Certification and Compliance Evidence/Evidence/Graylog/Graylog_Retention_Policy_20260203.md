# Graylog Log Retention Policy
## Evidence Artifact for AU-11 Control

**Export Date:** February 3, 2026
**System:** dc1.cyberinabox.net
**Control:** AU-11 (Audit Record Retention)

---

## Configuration Status

**Note:** Graylog retention is currently using DEFAULT settings. Explicit configuration recommended.

### Current Default Settings

From `/etc/graylog/server/server.conf`:

```ini
# Default retention settings (commented/using defaults)
#elasticsearch_max_time_per_index = 1d
#elasticsearch_max_number_of_indices = 20
#retention_strategy = delete
#max_index_retention_period = P90d
disabled_retention_strategies = none,close
```

---

## Recommended Configuration

**Action Required:** Update `/etc/graylog/server/server.conf` with explicit retention policy:

```ini
# Explicit retention configuration for NIST 800-171 compliance
elasticsearch_max_time_per_index = 1d
elasticsearch_max_number_of_indices = 90
retention_strategy = delete
max_index_retention_period = P90D
```

**Effect:**
- 90 daily indices retained (90 days online retention)
- Older indices automatically deleted
- Meets NIST SP 800-171 requirement for audit log retention

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
**Target Date:** March 31, 2026
**Priority:** Medium

---

**Collected By:** D. Shannon
**Classification:** CUI Evidence Artifact
