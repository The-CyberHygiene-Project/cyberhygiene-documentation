# SSP Version 2.5 Update Requirements

**Document:** System Security Plan
**From Version:** 2.4
**To Version:** 2.5
**Date:** February 21, 2026
**Author:** D. Shannon

---

## Summary of Changes

This document outlines all changes required to update the System Security Plan from Version 2.4 to Version 2.5 based on configuration changes to the AI inference server (192.168.1.7) and the SysAdmin Agent Dashboard.

**Key Changes:**
- SPRS score unchanged at 101/110 (no control status changes)
- AI server (192.168.1.7) Ollama service reconfigured to listen on all interfaces
- Port 11434/tcp opened in firewalld on the AI workstation
- Default inference model changed from `llama3.3:70b-instruct-q4_K_M` to `codellama:34b` (memory constraint)
- SysAdmin Agent Dashboard updated to use the `default` model alias for resilience
- AI server connectivity to SysAdmin Agent Dashboard confirmed operational

---

## Header Updates

| Section | Current Value | New Value |
|---------|---------------|-----------|
| Version | 2.4 | 2.5 |
| Date | February 17, 2026 | February 21, 2026 |
| SPRS Score | 101/110 | 101/110 (unchanged) |
| POA&M Reference | v2.7 | v2.7 (unchanged) |

---

## Revision History Entry

Add to Document Revision History table:

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 2.5 | February 21, 2026 | D. Shannon | **AI SERVER CONFIGURATION UPDATE:** Ollama inference server (192.168.1.7) reconfigured to listen on all interfaces (OLLAMA_HOST=0.0.0.0:11434). Firewall rule added for port 11434/tcp. Default model changed from llama3.3:70b-instruct-q4_K_M to codellama:34b due to memory constraints. SysAdmin Agent Dashboard updated to use `default` model alias. No SPRS impact. |

---

## System Inventory / Architecture Updates

### AI Inference Server — Configuration Change

Update the system component inventory and architecture documentation to reflect:

```markdown
#### AI Inference Server (ai.cyberinabox.net)

**Hostname:** ai.cyberinabox.net
**IP Address:** 192.168.1.7
**Role:** Local AI inference server — SysAdmin Agent Dashboard LLM backend
**OS:** (AI workstation OS)
**Network Segment:** 192.168.1.0/24 (internal only, no internet access)

**Ollama Service Configuration:**
- Listening address: 0.0.0.0:11434 (all interfaces, internal network only)
- Systemd override: /etc/systemd/system/ollama.service.d/override.conf
- Environment: OLLAMA_HOST=0.0.0.0:11434
- Firewall: port 11434/tcp open via firewalld (internal network only)

**Model Configuration:**
- Default model: codellama:34b (Q4_0, ~19GB)
- Previously configured: llama3.3:70b-instruct-q4_K_M — removed due to OOM (42.5GB exceeds available memory)
- Additional available models: codellama:7b-instruct, codellama:7b, nomic-embed-text (embeddings)
- Model alias `default` resolves to codellama:34b

**Network Accessibility:**
- Accessible from: 192.168.1.0/24 (internal) only
- Primary consumer: dc1.cyberinabox.net (192.168.1.10) — SysAdmin Agent Dashboard
- Apache reverse proxy on dc1 forwards /ai-api → http://ai.cyberinabox.net:11434
- No external/internet exposure
```

---

## Software / Service Configuration Updates

### SysAdmin Agent Dashboard — Model Reference Update

Update the SysAdmin Agent Dashboard configuration documentation:

```markdown
#### SysAdmin Agent Dashboard LLM Configuration

**Config file:** /data/ai-workspace/sysadmin-agent/config/config.py
**LLM_BASE_URL:** http://192.168.1.7:11434/v1
**LLM_MODEL:** default  (resolves to server-configured default model)
**Rationale:** Using the `default` model alias decouples the dashboard from
a specific model name, allowing the AI server administrator to change the
active model without requiring changes to dashboard configuration files.

**Previous value:** llama3.3:70b-instruct-q4_K_M
**Changed:** February 21, 2026
```

---

## Network / Firewall Documentation Updates

### AI Workstation Firewall Rule

Document the new firewall rule on the AI workstation (192.168.1.7):

| Rule | Protocol | Port | Direction | Purpose |
|------|----------|------|-----------|---------|
| ACCEPT | TCP | 11434 | Inbound | Ollama API — internal network clients |

**Configuration method:** `firewall-cmd --permanent --add-port=11434/tcp`
**Scope:** Internal network (192.168.1.0/24) — no external access
**CMMC relevance:** 3.1.3 (CUI flow control), 3.13.1 (boundary protection)

---

## System Interconnections Update

Update the system interconnections table to reflect the confirmed dc1 → AI server connection:

| Source | Destination | Protocol | Port | Purpose | Status |
|--------|-------------|----------|------|---------|--------|
| dc1.cyberinabox.net (192.168.1.10) | ai.cyberinabox.net (192.168.1.7) | HTTP | 11434 | Ollama LLM inference API | **Active** |
| dc1 Apache (/ai-api proxy) | ai.cyberinabox.net | HTTP | 11434 | Browser → AI dashboard inference | **Active** |

---

## No SPRS Impact

These changes are operational/configuration in nature. No NIST 800-171 control statuses are affected:
- All AI traffic remains within the internal 192.168.1.0/24 network segment (consistent with 3.1.3, 3.13.1)
- No new external connections introduced
- No CUI is processed by the AI system
- Access controls unchanged

---

## Verification Checklist

After implementing all updates, verify:

- [ ] SPRS score remains 101/110 in all document sections
- [ ] AI server listed in system component inventory with updated configuration
- [ ] Ollama listen address documented as 0.0.0.0:11434
- [ ] Default model documented as codellama:34b
- [ ] LLM_MODEL = "default" documented in dashboard config section
- [ ] Firewall rule for port 11434/tcp documented
- [ ] System interconnections table updated with dc1 → AI server entry
- [ ] SysAdmin Agent Dashboard confirmed operational (AI Connected status)

---

## Files Updated/Created

| File | Action | Notes |
|------|--------|-------|
| SSP_v2.5_Update_Requirements.md | Created | This document |
| /etc/systemd/system/ollama.service.d/override.conf | Created (on AI WS) | OLLAMA_HOST=0.0.0.0:11434 |
| /data/ai-workspace/sysadmin-agent/config/config.py | Updated | LLM_MODEL changed to "default" |

---

**Document Status:** Ready for Implementation
**Author:** D. Shannon
**Date:** February 21, 2026
