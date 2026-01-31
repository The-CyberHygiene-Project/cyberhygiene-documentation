# SSP v1.9 Update Requirements

**Date:** January 31, 2026
**Source:** System_Security_Plan_v1.7.docx (January 24, 2026)
**Target:** System_Security_Plan_v1.9.docx
**Type:** Critical Corrections + Feature Additions

---

## Overview

This update addresses **critical inaccuracies** in the current SSP and incorporates new AI-assisted administration features:

### Critical Corrections Required
1. **RAID 5 Storage** - INCORRECT: Document references 5.5TB RAID 5 array that no longer exists
2. **Mail Server** - INCORRECT: Listed as "planned" but is operational since January 2026

### Feature Additions
3. **SysAdmin Agent Dashboard v2.0** - Explainable AI with compliance features
4. **AI Model Upgrade** - Llama 3.3 70B Instruct (replaces Code Llama 7B)
5. **AI Evaluation System** - Continuous model evaluation and compliance reporting

---

## CRITICAL CORRECTION 1: Remove RAID 5 References

### Current (INCORRECT) Text Locations

**Section 1.4 Key Findings:**
> "5.5TB encrypted RAID 5 storage array operational"

**Section 3.2 Domain Controller:**
> "Encrypted RAID 5 storage (5.5TB)"

**Section CP-9 System Backup:**
> "Target: /srv/samba/backups/ (RAID 5 encrypted)"

### Corrected Text

**Section 1.4 Key Findings - REPLACE:**
```
- 1.8TB SSD storage with LVM + LUKS encryption (AES-256-XTS)
```

**Section 3.2 Domain Controller - REPLACE:**
```
Storage Configuration:
- 1.8TB NVMe SSD (single drive)
- LVM logical volume management
- LUKS encryption on all data volumes (AES-256-XTS, FIPS 140-2)
- Partitions: root (100GB), home (100GB), var (100GB), var_log (50GB),
  var_log_audit (20GB), datastore (931GB), swap (16GB encrypted)
```

**Section CP-9 System Backup - REPLACE:**
```
Weekly Full System Backup:
- Tool: ReaR (Relax-and-Recover)
- Target: /srv/samba/backups/ (LUKS encrypted volume)
```

### Rationale
The RAID 5 array was decommissioned. Current storage is a single 1.8TB SSD with LVM volume management and LUKS encryption on all partitions containing CUI data.

---

## CRITICAL CORRECTION 2: Mail Server Status

### Current (INCORRECT) Text

**Section 1.4 Areas Requiring Completion:**
> "Email server deployment (Postfix/Dovecot with encryption)"

**Section 3.2 Item 5:**
> "5. Email Server (planned - mail.cyberinabox.net)"

**POA&M-002:**
> Status: "ON TRACK" Target: 12/20/2025

### Corrected Text

**Section 1.4 - MOVE to Strengths:**
```
- ✓ Email services operational (Postfix SMTP, Dovecot IMAP/POP3) with TLS encryption
```

**Section 3.2 Item 5 - REPLACE:**
```
5. Email Server (dc1.cyberinabox.net - integrated)
   - Postfix 3.5.25 SMTP with TLS enforcement
   - Dovecot 2.3.16 IMAP/POP3 with encryption
   - Domain: cyberinabox.net
   - Integration: FreeIPA authentication via LDAP
   - Status: Operational since January 2026
```

**POA&M-002 - MARK COMPLETE:**
```
POA&M-002 | Email server deployment | SC-8, SC-13, SI-3 | 01/26/2026 |
Postfix 3.5.25 and Dovecot 2.3.16 deployed with TLS encryption.
FreeIPA LDAP authentication integrated. | ✅ COMPLETED
```

### Evidence
```bash
$ systemctl status postfix dovecot
● postfix.service - Postfix Mail Transport Agent
     Active: active (running) since Mon 2026-01-26 02:24:24 MST
● dovecot.service - Dovecot IMAP/POP3 email server
     Active: active (running) since Mon 2026-01-26 02:24:30 MST

$ postconf myhostname mydomain
myhostname = dc1.cyberinabox.net
mydomain = cyberinabox.net
```

---

## FEATURE ADDITION: SysAdmin Agent Dashboard v2.0

### Add New Section: 3.2.6 AI-Assisted Administration Infrastructure

```markdown
#### 3.2.6 AI-Assisted Administration Infrastructure (NEW - January 2026)

**SysAdmin Agent Dashboard v2.0:**
- URL: https://dc1.cyberinabox.net/sysadmin/
- Framework: Streamlit 1.x with LangChain/LangGraph integration
- LLM: Llama 3.3 70B Instruct (Q4_K_M quantization) on Mac Mini M4 Pro
- Service: sysadmin-agent.service (systemd)
- Repository: https://github.com/dshannon46-jpg/sysadmin-agent

**Explainable AI Features (CMMC Compliance):**
| Feature | Description | NIST Control |
|---------|-------------|--------------|
| Confidence Scoring | HIGH/MEDIUM/LOW with 0-100% certainty | 3.3.1 |
| Evidence Logging | Supporting data for each recommendation | 3.3.2 |
| Human Review Flags | REQUIRED/RECOMMENDED/ROUTINE classification | 3.4.1 |
| Feedback Collection | Continuous evaluation and improvement | 3.12.1 |
| Compliance Reports | Automated daily reports for audit | 3.3.1 |

**Dashboard Capabilities:**
| Category | Features |
|----------|----------|
| Monitoring | Server health, disk usage, running services, update status |
| Security | Wazuh alerts, Suricata IDS, YARA malware, USB device control |
| Compliance | OpenSCAP scans, compliance reports, POA&M tracking |
| AI Analysis | Log synopsis, security assessment, threat analysis |
| Maintenance | Service restart, system updates (approval required) |

**Automated Abnormal Event Detection:**
- Failed login attempts (SSH, PAM, Kerberos brute force patterns)
- USB policy violations (USBGuard blocks, after-hours attempts)
- Suspicious data transfers (external destinations, large outbound flows)
- Security-sensitive SELinux denials (shadow, keys, sudoers access)

**AI Evaluation System:**
- SQLite feedback database for response tracking
- Confidence calibration analysis (compares stated vs actual accuracy)
- Daily automated reports (6:00 AM via systemd timer)
- 90-day report retention
- CMMC-compliant compliance report generation

**Human-in-the-Loop Approval Workflow:**
- All high-risk commands require explicit user approval
- Complete audit logging to JSON (agent_audit.log)
- Command whitelist with forbidden command blocking
- No arbitrary command execution capability

**TLS Configuration:**
- All AI API traffic encrypted via HTTPS (port 11443)
- Self-signed certificate with CA validation
- TLS 1.2/1.3 with FIPS-approved cipher suites
- Traffic isolation: AI server on internal LAN only
```

### Update AI Server Section (3.2 Item 2)

**Current (OUTDATED):**
> "Code Llama 7B model (hardware-accelerated inference: 40-60 tokens/sec)"

**REPLACE WITH:**
```
AI Models Deployed:
| Model | Parameters | Size | Speed | Purpose |
|-------|------------|------|-------|---------|
| Llama 3.3 70B Instruct | 70B | ~40GB | 15-25 tok/s | Primary: SysAdmin Agent, security analysis |
| Code Llama 7B | 7B | 3.8GB | 40-60 tok/s | Secondary: Code assistance |

Llama 3.3 70B Instruct:
- Quantization: Q4_K_M (optimized for Apple Silicon)
- Context Window: 128K tokens
- License: Llama 3.3 Community License
- Use: System administration, log analysis, security assessment, compliance
```

---

## Security Control Updates

### AC-3: Access Enforcement - ADD:

```markdown
**AI-Assisted Administration Access Control:**
- SysAdmin Agent Dashboard restricted to authorized users via Apache proxy
- Human approval required for all file modifications and command execution
- Feedback system tracks all AI response accuracy
- Audit logging captures all AI interactions

**Evidence:**
- Dashboard config: /data/ai-workspace/sysadmin-agent/app.py
- Apache proxy: /etc/httpd/conf.d/sysadmin-agent.conf
```

### AU-2: Auditable Events - ADD:

```markdown
**AI-Assisted Administration Events:**
All AI actions generate audit records including:
- AI_RESPONSE - AI response with confidence level and human review flag
- FEEDBACK_SUBMITTED - User feedback on AI response accuracy
- COMMAND_APPROVED / COMMAND_REJECTED - Approval workflow decisions
- COMPLIANCE_REPORT_GENERATED - Automated report generation
- USB_BLOCKED - USBGuard device blocking via AI interface

**Audit Log Locations:**
- /data/ai-workspace/sysadmin-agent/logs/agent_audit.log
- /data/ai-workspace/sysadmin-agent/database/feedback.db

**Evidence:**
- Audit implementation: /data/ai-workspace/sysadmin-agent/app.py
- Feedback schema: /data/ai-workspace/sysadmin-agent/database/feedback_db.py
```

### SI-4: System Monitoring - ADD:

```markdown
**AI-Enhanced Security Monitoring:**
- SysAdmin Agent Dashboard provides AI-assisted log analysis
- Natural language queries for security events
- Intelligent alert triage with confidence scoring
- Automated abnormal event detection:
  - Failed login pattern analysis (brute force detection)
  - USB policy violation monitoring
  - Suspicious data transfer detection
  - SELinux security denial classification

**Explainable AI Monitoring:**
- All AI assessments include confidence scores (0-100%)
- Supporting evidence listed for each recommendation
- Alternative hypotheses presented for consideration
- Validation steps provided for human verification
- Human review flags: REQUIRED/RECOMMENDED/ROUTINE

**Continuous Model Evaluation:**
- User feedback collection (thumbs up/down, issue categories)
- Confidence calibration tracking
- Daily automated evaluation reports
- Trend analysis for model degradation detection

**Evidence:**
- Event detector: /data/ai-workspace/sysadmin-agent/tools/abnormal_event_detector.py
- Evaluation reports: /data/ai-workspace/sysadmin-agent/database/evaluation_reports.py
```

---

## Document Control Updates

### Version History - ADD:

```
Version 1.8 | January 29, 2026 | D. Shannon | Incorporated AI-assisted administration
(SysAdmin Agent Dashboard, Code Assistant) with TLS encryption

Version 1.9 | January 31, 2026 | D. Shannon | CRITICAL CORRECTIONS: Removed incorrect
RAID 5 references (storage is LVM+LUKS on single SSD). Updated mail server status
from "planned" to "operational" (Postfix 3.5.25, Dovecot 2.3.16). Added SysAdmin
Agent Dashboard v2.0 with Explainable AI features. Upgraded AI model documentation
(Llama 3.3 70B). Added AI evaluation and compliance reporting system.
```

### Update Version Number:
- Header/Footer: 1.7 → 1.9
- Cover Page: Version 1.7 → Version 1.9
- Date: January 24, 2026 → January 31, 2026

---

## POA&M Updates

### Mark as COMPLETED:

| POA&M ID | Item | Completion Date | Evidence |
|----------|------|-----------------|----------|
| POA&M-002 | Email server deployment | 01/26/2026 | Postfix 3.5.25, Dovecot 2.3.16 operational |

### Update Metrics:

```
Total Items: 30
Completed: 25 (83%)  ← was 24 (80%)
In Progress: 2 (7%)
On Track: 3 (10%)   ← was 4 (13%)
```

---

## Appendix Updates

### Appendix A: System Inventory - ADD:

| Component | Version | Purpose | Location |
|-----------|---------|---------|----------|
| Streamlit | 1.x | SysAdmin Dashboard UI | dc1:8501 |
| LangChain | 0.3.x | AI orchestration framework | dc1 |
| LangGraph | 0.2.x | Stateful AI workflows | dc1 |
| SQLite | 3.x | Feedback database | dc1 |
| Llama 3.3 70B | Q4_K_M | Primary AI model | ai:11443 |
| Postfix | 3.5.25 | SMTP mail server | dc1:25 |
| Dovecot | 2.3.16 | IMAP/POP3 server | dc1:143,993 |

### Appendix E: SSP Addendums - ADD:

| Addendum | Version | Date | Description |
|----------|---------|------|-------------|
| AI-Assisted Administration | 1.0 | January 31, 2026 | SysAdmin Agent Dashboard v2.0 with Explainable AI, feedback collection, evaluation reporting, and CMMC compliance features |

---

## Verification Checklist

After updates:
- [ ] All RAID 5 references removed (search for "RAID")
- [ ] Mail server moved from "planned" to "operational"
- [ ] POA&M-002 marked COMPLETED
- [ ] AI infrastructure section added (3.2.6)
- [ ] Llama 3.3 70B documented (replaces Code Llama 7B as primary)
- [ ] Explainable AI features documented
- [ ] Security controls updated (AC-3, AU-2, SI-4)
- [ ] Version number updated to 1.9
- [ ] Date updated to January 31, 2026
- [ ] Table of contents regenerated
- [ ] Document saved as System_Security_Plan_v1.9.docx
- [ ] Previous version (v1.7) moved to Archives folder

---

## Summary of Changes

| Area | Change Type | Description |
|------|-------------|-------------|
| Storage | CORRECTION | RAID 5 → LVM+LUKS single SSD |
| Mail Server | CORRECTION | Planned → Operational |
| AI Model | UPDATE | Code Llama 7B → Llama 3.3 70B (primary) |
| Dashboard | NEW | SysAdmin Agent v2.0 with Explainable AI |
| Evaluation | NEW | Continuous AI model evaluation system |
| POA&M-002 | COMPLETE | Email server operational |
| Version | UPDATE | 1.7 → 1.9 |

---

## Source Documents

- System_Security_Plan_v1.7.docx (January 24, 2026)
- SSP_v1.8_Update_Requirements.md (January 29, 2026)
- SysAdmin Agent README.md (January 31, 2026)
- AI_FUNCTIONS_REFERENCE.md (January 31, 2026)
- Software_Bill_of_Materials_v2.2.md (January 31, 2026)

---

**Document Control**
- **Classification:** Controlled Unclassified Information (CUI)
- **Owner:** Donald E. Shannon, ISSO
- **Purpose:** Instructions for updating SSP to Version 1.9
- **Created:** January 31, 2026
