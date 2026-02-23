# SSP v1.8 Update Requirements
**Date:** January 29, 2026
**Source:** System_Security_Plan_v1.7.docx (January 24, 2026)
**Target:** System_Security_Plan_v1.8.docx

---

## Overview

This update incorporates the AI-Assisted Administration enhancements deployed in January 2026:
1. **SysAdmin Agent Dashboard** (January 2026)
2. **Code Assistant (Terminal AI Integration)** (January 2026)
3. **TLS Encryption for AI API Communications** (January 29, 2026)

These enhancements provide Claude Code-like AI integration capabilities entirely on the local network while maintaining NIST 800-171 compliance through human-in-the-loop approval workflows and comprehensive audit logging.

---

## Updates Required

### 1. Document Control

- [ ] Update version from 1.7 to 1.8
- [ ] Update date from January 24, 2026 to January 29, 2026
- [ ] Add revision history entry:
  ```
  Version 1.8 | January 29, 2026 | D. Shannon | Incorporated AI-assisted administration (SysAdmin Agent Dashboard, Code Assistant) with TLS encryption
  ```

---

### 2. Executive Summary (Section 1)

#### 1.2 System Overview
- [ ] Update AI infrastructure description to include:
  - SysAdmin Agent Dashboard (web-based AI administration)
  - Code Assistant (terminal AI integration)
  - TLS-encrypted API communications to AI server

#### 1.4 Key Findings
- [ ] Add to capabilities:
  - "AI-assisted system administration with human approval workflow"
  - "Code analysis and editing with full audit trail"
  - "TLS-encrypted AI API communications (NIST SC-8 compliant)"

---

### 3. System Description (Section 3)

#### 3.2 General System Description - AI Infrastructure Subsection

Add new subsection: **AI-Assisted Administration Infrastructure**

```markdown
#### AI-Assisted Administration Infrastructure

**SysAdmin Agent Dashboard:**
- Web-based dashboard at https://dc1.cyberinabox.net/sysadmin/
- Powered by Streamlit 1.32+ with LangChain integration
- Connected to Llama 3.3 70B Instruct on Mac Mini M4 Pro (64GB RAM)
- Human-in-the-loop approval for all high-risk operations
- Complete audit logging for NIST 800-171 compliance

**Dashboard Capabilities:**
| Category | Features |
|----------|----------|
| Monitoring | Server health, disk usage, running services, update status |
| Security | Wazuh alerts, Suricata IDS, YARA malware, USB device control |
| Compliance | OpenSCAP scans, compliance reports, POA&M tracking |
| Maintenance | Service restart, system updates (approval required) |
| Dashboards | Direct links to Grafana, Wazuh, Graylog, FreeIPA |

**Code Assistant (Terminal AI Integration):**
- AI-powered code questions and analysis (read-only, no approval needed)
- File browsing in whitelisted directories only
- Log analysis with whitelisted command execution (approval required)
- File editing with AI assistance (approval required)
- Backend API service on port 5001 (localhost only)

**TLS Configuration:**
- Nginx TLS reverse proxy on Mac Mini (port 11443)
- Self-signed certificate for internal network
- TLS 1.2/1.3 with FIPS-approved cipher suites
- All AI API traffic encrypted in transit
```

#### 3.3 Network Topology
- [ ] Add AI infrastructure ports to service port matrix:

| Service | Port | Protocol | Purpose |
|---------|------|----------|---------|
| SysAdmin Agent | 8501 | HTTP (proxied) | Streamlit dashboard |
| Aider API | 5001 | HTTP (localhost) | Code Assistant backend |
| Ollama TLS Proxy | 11443 | HTTPS | Encrypted AI API |

---

### 4. Security Controls Assessment

#### AC-3: Access Enforcement

**Add to existing implementation:**

```markdown
**AI-Assisted Administration Access Control:**
- SysAdmin Agent Dashboard restricted to authorized users via Apache proxy
- Code Assistant limited to whitelisted directories:
  - /data/ai-workspace
  - /etc/fapolicyd, /etc/usbguard, /etc/yara
  - /etc/httpd/conf.d, /var/www
  - /opt/aider-api, /home, /root, /tmp
- Forbidden directory protections prevent access to sensitive paths
- Human approval required for all file modifications and command execution

**Evidence:**
- Code assistant config: /data/ai-workspace/sysadmin-agent/tools/code_assistant.py
- Apache proxy config: /etc/httpd/conf.d/sysadmin-agent.conf
```

#### AU-2: Auditable Events

**Add to existing implementation:**

```markdown
**AI-Assisted Administration Events:**
All AI actions generate audit records including:
- CODE_ASSISTANT_QUERY - Code questions asked
- CODE_ASSISTANT_FILE_READ - File views
- CODE_ASSISTANT_APPROVED - Approved edit/execute actions
- CODE_ASSISTANT_REJECTED - Rejected actions
- CODE_ASSISTANT_EDIT_COMPLETE - Successful file edits
- SYSADMIN_AGENT_COMMAND - Dashboard command execution
- SYSADMIN_AGENT_APPROVAL - Approval workflow decisions

**Audit Log Location:**
- /data/ai-workspace/sysadmin-agent/logs/agent_audit.log

**Evidence:**
- Audit logging implementation: /data/ai-workspace/sysadmin-agent/app.py
```

#### SC-8: Transmission Confidentiality and Integrity

**Add to existing implementation:**

```markdown
**AI API Encryption:**
- All AI API communications encrypted with TLS 1.2/1.3
- Nginx reverse proxy on Mac Mini (192.168.1.7:11443)
- Self-signed certificate (acceptable for internal network)
- FIPS-compliant cipher suites:
  - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
  - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
- Traffic isolation: AI server on internal LAN only

**Evidence:**
- Nginx TLS config: /opt/homebrew/etc/nginx/servers/ollama-tls.conf
- SSL certificate: /opt/homebrew/etc/nginx/ssl/ollama.crt
- API configuration: /data/ai-workspace/sysadmin-agent/config/config.py
- Aider API config: /opt/aider-api/aider_service.py
```

#### SI-4: Information System Monitoring

**Add to existing implementation:**

```markdown
**AI-Enhanced Monitoring:**
- SysAdmin Agent Dashboard provides AI-assisted log analysis
- Natural language queries for security events
- Intelligent alert triage and prioritization
- Integration with Wazuh, Suricata, YARA alerts
- Real-time system health analysis with recommendations

**Capabilities:**
- Wazuh alert analysis with context-aware interpretation
- Failed login pattern detection and analysis
- SELinux AVC denial categorization
- Disk space and resource trend analysis
- Service status monitoring with remediation suggestions
```

#### CM-7: Least Functionality

**Add to existing implementation:**

```markdown
**AI Command Restrictions:**
- Code Assistant uses command whitelist (18 categories):
  - wazuh_alerts, secure_logs, audit_logs, system_messages
  - apache_errors, journal_errors, top_processes
  - disk_usage, memory_usage, cpu_usage, system_status
  - failed_logins, ipa_status, firewall_status, dns_check
  - httpd_restart (approval required), wazuh_alert_counts
  - secure_log_analysis
- Forbidden commands explicitly blocked
- All command execution requires human approval
- No arbitrary command execution capability

**Evidence:**
- Command whitelist: /opt/aider-api/aider_service.py (ALLOWED_COMMANDS)
- SysAdmin config: /data/ai-workspace/sysadmin-agent/config/config.py
```

---

### 5. Appendices

#### Appendix A: System Inventory

Add to inventory:

| Component | Version | Purpose | Location |
|-----------|---------|---------|----------|
| Streamlit | 1.32+ | SysAdmin Dashboard UI | dc1:8501 |
| LangChain | 0.1+ | AI orchestration framework | dc1 |
| Flask | 3.0+ | Aider API backend | dc1:5001 |
| Nginx | 1.29.4 | TLS reverse proxy | 192.168.1.7:11443 |
| Ollama | 0.13.5 | AI model server | 192.168.1.7:11434 |
| Llama 3.3 70B | Q4_K_M | AI language model | Mac Mini M4 Pro |

#### Appendix B: Configuration Files

Add entries:

**SysAdmin Agent Configuration:**
- `/data/ai-workspace/sysadmin-agent/app.py` - Main dashboard application
- `/data/ai-workspace/sysadmin-agent/config/config.py` - Configuration settings
- `/data/ai-workspace/sysadmin-agent/tools/code_assistant.py` - Code Assistant module
- `/data/ai-workspace/sysadmin-agent/graphs/common.py` - LLM client configuration
- `/etc/systemd/system/sysadmin-agent.service` - Systemd service definition

**Aider API Configuration:**
- `/opt/aider-api/aider_service.py` - API service implementation
- `/etc/systemd/system/aider-api.service` - Systemd service definition

**TLS Proxy Configuration:**
- `/opt/homebrew/etc/nginx/servers/ollama-tls.conf` - Nginx TLS proxy config
- `/opt/homebrew/etc/nginx/ssl/ollama.crt` - SSL certificate
- `/opt/homebrew/etc/nginx/ssl/ollama.key` - SSL private key

#### Appendix C: Service Port Matrix

Add entries:

| Service | Port | Protocol | Purpose |
|---------|------|----------|---------|
| SysAdmin Agent | 8501 | HTTP | Streamlit dashboard (proxied via Apache) |
| Aider API | 5001 | HTTP | Code Assistant backend (localhost only) |
| Ollama TLS | 11443 | HTTPS | Encrypted AI API endpoint |

---

### 6. SSP Addendums Reference

Update addendum section:

| Addendum | Version | Date | Description |
|----------|---------|------|-------------|
| YARA Malware Detection System | 1.0 | December 30, 2025 | YARA integration with Wazuh SIEM |
| FIPS-Compliant Workstation Monitoring | 1.0 | December 31, 2025 | Prometheus/Node Exporter deployment |
| AI-Assisted Administration | 1.0 | January 29, 2026 | SysAdmin Dashboard and Code Assistant |

---

## Verification Checklist

After updates:
- [ ] All section numbers and cross-references updated
- [ ] Table of contents regenerated
- [ ] Page numbers correct
- [ ] No broken references
- [ ] Version number in header/footer updated to 1.8
- [ ] Date updated throughout document
- [ ] Spell check completed
- [ ] Document saved as System_Security_Plan_v1.8.docx
- [ ] Previous version (v1.7) moved to Archives folder

---

## Summary of Changes

| Area | Change |
|------|--------|
| Version | 1.7 -> 1.8 |
| Date | January 24, 2026 -> January 29, 2026 |
| AC-3 | Added AI access controls and directory restrictions |
| AU-2 | Added AI audit events (CODE_ASSISTANT_*, SYSADMIN_AGENT_*) |
| SC-8 | Added TLS encryption for AI API (port 11443) |
| SI-4 | Added AI-enhanced monitoring capabilities |
| CM-7 | Added command whitelist and restrictions |
| Appendices | Added AI components to inventory |
| New Section | AI-Assisted Administration infrastructure |

---

## Source Documents

- SSP_v1.7_Update_Requirements.md (January 24, 2026)
- System_Security_Plan_v1.7.docx (January 24, 2026)
- User Manual v1.0.3 Release Notes (January 29, 2026)

---

## Next Review

**Quarterly Review:** March 31, 2026

---

**Document Control**
- **Classification:** Controlled Unclassified Information (CUI)
- **Owner:** Donald E. Shannon, ISSO
- **Purpose:** Instructions for updating SSP to Version 1.8
- **Created:** January 29, 2026
