# SSP v1.7 Update Requirements
**Date:** January 24, 2026
**Source:** System_Security_Plan_v1.6.docx (December 26, 2025)
**Target:** System_Security_Plan_v1.7.docx

---

## Overview

This update incorporates two security addendums created after SSP v1.6:
1. **YARA Malware Detection System** (December 30, 2025)
2. **FIPS-Compliant Workstation Monitoring** (December 31, 2025)

Both addendums document significant security enhancements that strengthen multiple NIST 800-171 controls.

---

## Updates Required

### 1. Document Control

- [ ] Update version from 1.6 to 1.7
- [ ] Update date from December 26, 2025 to January 24, 2026
- [ ] Add revision history entry:
  ```
  Version 1.7 | January 24, 2026 | D. Shannon | Incorporated YARA malware detection and FIPS-compliant workstation monitoring systems
  ```

---

### 2. Executive Summary (Section 1)

#### 1.2 System Overview
- [ ] Update security monitoring description to include:
  - YARA malware detection (22 rules)
  - Prometheus/Node Exporter monitoring (6 systems)
  - Grafana visualization dashboards

#### 1.4 Key Findings
- [ ] Add to security capabilities:
  - "Real-time malware detection via YARA integration with Wazuh SIEM"
  - "FIPS 140-2 compliant infrastructure monitoring across all 6 systems"

---

### 3. System Description (Section 3)

#### 3.2 General System Description - Security Monitoring Subsection

Add new subsection: **Security Monitoring Infrastructure**

```markdown
#### Security Monitoring Infrastructure

**YARA Malware Detection:**
- YARA Engine v4.5.2 integrated with Wazuh SIEM
- 22 active detection rules (4 custom + 18 VirusTotal)
- Real-time scanning triggered by Wazuh FIM
- Alert forwarding to Graylog via GELF UDP
- Grafana dashboard visualization

**System Metrics Monitoring (Prometheus):**
- Prometheus 2.48.1 time-series database
- Node Exporter 1.7.0 on all 6 systems
- FIPS 140-2 compliant TLS encryption (AES-GCM cipher suites)
- 15-second collection interval, 15-day retention
- 864+ time-series metrics collected

**Monitored Systems:**
| System | IP Address | OS | Metrics Port |
|--------|------------|-----|--------------|
| dc1 (Server) | 192.168.1.10 | Rocky Linux 9.7 | 9100/HTTPS |
| engineering | 192.168.1.104 | Rocky Linux 9.7 | 9100/HTTPS |
| accounting | 192.168.1.113 | Rocky Linux 9.7 | 9100/HTTPS |
| labrat | 192.168.1.115 | Rocky Linux 9.6 | 9100/HTTPS |
| ai | 192.168.1.7 | macOS (Darwin) | 9100/HTTPS |
| prometheus | localhost | - | 9091/HTTPS |
```

#### 3.3 Network Topology
- [ ] Add Prometheus port 9091 (HTTPS) to service port matrix
- [ ] Add Node Exporter port 9100 (HTTPS) to service port matrix
- [ ] Add Graylog GELF port 12202 (UDP) to service port matrix
- [ ] Add Grafana port 3001 to service port matrix

---

### 4. Security Controls Assessment

#### SI-3: Malware Protection

**Add to existing implementation:**

```markdown
**YARA Malware Detection:**
- YARA Engine v4.5.2 provides signature-based malware detection
- 22 active detection rules:
  - 4 custom rules (backdoor, ransomware, webshell, persistence)
  - 18 VirusTotal community rules for Linux malware
- Coverage: /etc, /usr/bin, /usr/sbin, /bin, /sbin, /boot
- Scanning triggered automatically by Wazuh FIM (Rules 550, 554)
- Detection alerts generated at Wazuh Level 10 severity
- Integration with VirusTotal API for multi-engine validation

**Evidence:**
- YARA rules: /var/ossec/ruleset/yara/rules/
- Detection logs: /var/log/yara.log
- Wazuh rules: /var/ossec/etc/rules/local_rules.xml (100110-100115)
```

#### SI-4: Information System Monitoring

**Add to existing implementation:**

```markdown
**YARA Integration:**
- Real-time malware detection alerts forwarded to:
  - Graylog (GELF UDP port 12202)
  - Elasticsearch for indexing and search
  - Grafana dashboard for visualization
- Alert response time: < 5 seconds from detection to dashboard

**Prometheus Infrastructure Monitoring:**
- Comprehensive system metrics collection across 6 systems
- Metrics categories:
  - CPU: usage, load averages (1/5/15 min), context switches
  - Memory: total, free, available, cached, swap
  - Disk: I/O rates, queue depth, space usage, inode usage
  - Network: bytes sent/received, errors, drops, connections
  - Filesystem: mount points, space, read-only status
  - Processes: count, states, CPU time, memory, file descriptors
- 15-second collection interval provides near real-time visibility
- 15-day historical retention for trend analysis
- Grafana dashboards for visualization and alerting

**Evidence:**
- Prometheus config: /etc/prometheus/prometheus.yml
- Prometheus targets: https://dc1.cyberinabox.net:9091/targets
- Grafana dashboards: http://dc1.cyberinabox.net:3001
```

#### SC-8: Transmission Confidentiality and Integrity

**Add to existing implementation:**

```markdown
**Prometheus/Node Exporter Encryption:**
- All metrics transmission encrypted with TLS 1.2/1.3
- Certificate: SSL.com wildcard (*.cyberinabox.net)
- FIPS 140-2 compliant cipher suites:
  - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
  - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
  - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
  - TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
- Certificate validation enabled (insecure_skip_verify: false)
- Firewall rules restrict Node Exporter access to Prometheus server IP only

**Evidence:**
- Node Exporter TLS config: /etc/node_exporter/web-config.yml
- Prometheus TLS config: /etc/prometheus/web-config.yml
- TLS verification: openssl s_client -connect dc1.cyberinabox.net:9091
```

#### SC-13: Cryptographic Protection

**Add to evidence:**
- [ ] "FIPS 140-2 mode enabled on all Rocky Linux systems"
- [ ] "OpenSSL 3.0.7 FIPS provider active for all cryptographic operations"
- [ ] "All Prometheus/Node Exporter communications use FIPS-approved cipher suites"

#### AU-2: Auditable Events

**Add to existing implementation:**

```markdown
**YARA Detection Events:**
All malware detections generate audit records including:
- Detection timestamp (millisecond precision)
- YARA rule name and file
- Detected file path and SHA-256 hash
- Match count and severity level
- Agent/host information
- Wazuh rule ID (100110-100115)

**Prometheus Metrics Events:**
System performance events captured:
- CPU/memory utilization thresholds
- Disk space alerts
- Network anomalies
- Process state changes
```

#### AU-6: Audit Review, Analysis, and Reporting

**Add to existing implementation:**

```markdown
**YARA Detection Dashboard (Grafana):**
- Real-time visualization of malware detections
- Panels: Detection timeline, total count, critical count, detailed table
- Auto-refresh every 30 seconds
- Color-coded thresholds for risk indication

**Prometheus Metrics Dashboard:**
- System health overview across all 6 monitored systems
- Historical trend analysis (15-day window)
- Query builder for custom analysis
```

#### CM-3: Configuration Change Control

**Add to existing implementation:**

```markdown
**Prometheus Baseline Monitoring:**
- System metrics establish performance baselines
- Monitoring detects:
  - Unexpected process launches (process count changes)
  - Service state changes (systemd unit metrics)
  - Resource consumption anomalies
  - Filesystem changes (mount points, space usage)
  - Network configuration changes
```

---

### 5. Appendices

#### Appendix A: System Inventory

Add to inventory:

| Component | Version | Purpose | Location |
|-----------|---------|---------|----------|
| YARA | 4.5.2 | Malware detection engine | /usr/local/bin/yara |
| Prometheus | 2.48.1 | Time-series metrics database | dc1:9091 |
| Node Exporter | 1.7.0 | System metrics exporter | All systems:9100 |

#### Appendix B: Configuration Files

Add entries:

**YARA/Wazuh Configuration:**
- `/var/ossec/ruleset/yara/rules/` - YARA rule sets
- `/var/ossec/active-response/bin/yara-scan.sh` - Active response script
- `/var/ossec/etc/rules/local_rules.xml` - Wazuh YARA rules (100110-100115)
- `/var/ossec/integrations/graylog.py` - Graylog integration script

**Prometheus Configuration:**
- `/etc/prometheus/prometheus.yml` - Prometheus scrape configuration
- `/etc/prometheus/web-config.yml` - Prometheus TLS configuration
- `/etc/node_exporter/web-config.yml` - Node Exporter TLS configuration
- `/etc/systemd/system/prometheus.service` - Prometheus service definition
- `/etc/systemd/system/node_exporter.service` - Node Exporter service definition

#### Appendix C: Service Port Matrix

Add entries:

| Service | Port | Protocol | Purpose |
|---------|------|----------|---------|
| Prometheus Web UI | 9091 | HTTPS | Metrics query and management |
| Node Exporter | 9100 | HTTPS | System metrics collection |
| Graylog GELF | 12202 | UDP | YARA alert forwarding |
| Grafana | 3001 | HTTP | Dashboard visualization |

---

### 6. SSP Addendums Reference

Add new section or appendix: **SSP Addendums**

```markdown
## SSP Addendums

The following addendums extend the SSP with detailed technical documentation:

| Addendum | Version | Date | Description |
|----------|---------|------|-------------|
| YARA Malware Detection System | 1.0 | December 30, 2025 | Comprehensive documentation of YARA integration with Wazuh SIEM, including detection rules, alert pipeline, and Grafana visualization |
| FIPS-Compliant Workstation Monitoring | 1.0 | December 31, 2025 | Documentation of Prometheus/Node Exporter deployment with FIPS 140-2 compliant TLS encryption across 6 systems |

**Addendum Locations:**
- /home/dshannon/Documents/SSP_Addendums/SSP_Addendum_YARA_Malware_Detection.md
- /home/dshannon/Documents/SSP_Addendums/SSP_Addendum_Workstation_Monitoring.md

These addendums provide detailed technical specifications, configuration files, operational procedures, and compliance evidence that supplement the control implementations documented in this SSP.
```

---

## Verification Checklist

After updates:
- [ ] All section numbers and cross-references updated
- [ ] Table of contents regenerated (Right-click → Update Field in Word)
- [ ] Page numbers correct
- [ ] No broken references
- [ ] Version number in header/footer updated to 1.7
- [ ] Date updated throughout document
- [ ] Spell check completed
- [ ] Document saved as System_Security_Plan_v1.7.docx
- [ ] Previous version (v1.6) moved to Archives folder

---

## Summary of Changes

| Area | Change |
|------|--------|
| Version | 1.6 → 1.7 |
| Date | December 26, 2025 → January 24, 2026 |
| SI-3 | Added YARA malware detection (22 rules, Wazuh integration) |
| SI-4 | Added Prometheus monitoring (6 systems, 864+ metrics) |
| SC-8 | Added FIPS TLS encryption for all metrics transmission |
| SC-13 | Added FIPS 140-2 cipher suite documentation |
| AU-2/AU-6 | Added YARA detection events and Grafana dashboards |
| CM-3 | Added Prometheus baseline monitoring capabilities |
| Appendices | Added YARA, Prometheus, Node Exporter to inventory |
| New Section | SSP Addendums reference section |

---

## Source Documents

- SSP_Addendum_YARA_Malware_Detection.md (December 30, 2025)
- SSP_Addendum_Workstation_Monitoring.md (December 31, 2025)
- System_Security_Plan_v1.6.docx (December 26, 2025)

---

## Next Review

**Quarterly Review:** March 31, 2026

---

**Document Control**
- **Classification:** Controlled Unclassified Information (CUI)
- **Owner:** Donald E. Shannon, ISSO
- **Purpose:** Instructions for updating SSP to Version 1.7
- **Created:** January 24, 2026
