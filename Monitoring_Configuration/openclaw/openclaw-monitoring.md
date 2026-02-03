# OpenClaw AI Security Monitoring

**Version:** 1.0
**Date:** 2026-02-02
**NIST Controls:** 3.3.1, 3.3.4, 3.6.1, 3.14.6

---

## Overview

This document describes the monitoring configuration for the OpenClaw AI security components on dc1.cyberinabox.net.

## Components Monitored

| Component | Service | Port/Socket | Log File |
|-----------|---------|-------------|----------|
| OpenClaw Gateway | openclaw.service | 127.0.0.1:18789 | /opt/openclaw/logs/openclaw.log |
| Sudo Approval Proxy | sudo-proxy.service | Unix socket | /opt/sudo-proxy/logs/audit.log |
| SysAdmin Agent | sysadmin-agent.service | 127.0.0.1:8501 | /data/ai-workspace/sysadmin-agent/logs/agent_audit.log |
| CPM Dashboard | cpm-dashboard.service | 127.0.0.1:5000 | /opt/cpm-dashboard/logs/access.log |

---

## Wazuh Integration

### Log Collection

Add to `/var/ossec/etc/ossec.conf`:

```xml
<!-- OpenClaw AI Monitoring Logs -->
<localfile>
  <log_format>syslog</log_format>
  <location>/opt/openclaw/logs/openclaw.log</location>
</localfile>

<localfile>
  <log_format>json</log_format>
  <location>/opt/sudo-proxy/logs/audit.log</location>
</localfile>

<localfile>
  <log_format>json</log_format>
  <location>/data/ai-workspace/sysadmin-agent/logs/agent_audit.log</location>
</localfile>
```

### Custom Rules

Deploy `wazuh-rules.xml` to `/var/ossec/etc/rules/local_rules.xml`

Rule ID ranges:
- 100001-100009: Citadel Guard / Injection Detection
- 100010-100019: Sudo Approval Proxy
- 100020-100029: OpenClaw Gateway
- 100030-100039: SysAdmin Agent
- 100040-100049: Service Health

### Alert Levels

| Level | Description | Action |
|-------|-------------|--------|
| 3-5 | Informational | Log only |
| 7-9 | Warning | Review within 4 hours |
| 10-12 | High | Review within 1 hour |
| 13-15 | Critical | Immediate response |

---

## Key Events to Monitor

### Critical Events (Immediate Alert)

1. **SIGNATURE_INVALID (100016)**
   - HMAC signature verification failed
   - Possible approval response tampering
   - Action: Investigate immediately, disable AI if needed

2. **Multiple Injection Attempts (100002)**
   - 3+ injection attempts in 60 seconds
   - Active attack in progress
   - Action: Block source, investigate

3. **Sudo Proxy Down (100041)**
   - HITL enforcement disabled
   - Privileged operations blocked
   - Action: Restore service immediately

### High Priority Events

1. **Injection Detected (100001)**
   - Citadel Guard detected prompt injection
   - Action: Review content, update patterns if needed

2. **Auth Failure (100020)**
   - Invalid token used to access gateway
   - Action: Check for unauthorized access attempts

3. **Validation Failed (100014)**
   - Command not in allowlist
   - Action: Review if legitimate need, update allowlist

### Warning Events

1. **Approval Timeout (100013)**
   - Request auto-denied after 120 seconds
   - Action: Review if operator unavailable

2. **Command Blocked (100030)**
   - Agent attempted disallowed command
   - Action: Review agent behavior

---

## CLI Monitoring Commands

### Quick Status Check

```bash
# All AI services status
openclaw status

# Health check
openclaw health

# Recent logs
openclaw logs 50
```

### Systemd Status

```bash
systemctl status openclaw sudo-proxy sysadmin-agent cpm-dashboard
```

### Log Analysis

```bash
# Injection attempts today
grep -c "injection\|SANITIZED" /opt/openclaw/logs/openclaw.log

# Approval summary
grep "APPROVAL" /opt/sudo-proxy/logs/audit.log | \
  awk -F'"event":' '{print $2}' | cut -d'"' -f2 | sort | uniq -c

# Blocked commands
grep "BLOCKED\|FORBIDDEN" /data/ai-workspace/sysadmin-agent/logs/agent_audit.log
```

### Test Injection Detection

```bash
openclaw injection-test
# Expected: "PASS: Injection detected"
```

---

## Grafana Dashboard (Future)

A Grafana dashboard for AI monitoring is planned with:

- Real-time approval request tracking
- Injection detection rate
- Service uptime metrics
- Command execution history
- Approval vs denial ratio

---

## Alerting Contacts

| Alert Level | Contact | Method |
|-------------|---------|--------|
| Critical | ISSO | Email + SMS |
| High | Security Ops | Email |
| Warning | SysAdmin | Dashboard |

---

## Maintenance Tasks

### Daily
- [ ] Review Citadel Guard detections
- [ ] Check service health
- [ ] Verify audit logs being written

### Weekly
- [ ] Analyze approval patterns
- [ ] Review denied requests
- [ ] Check log disk usage

### Monthly
- [ ] Test HITL approval flow
- [ ] Verify Wazuh rules triggering
- [ ] Update injection patterns if needed

### Quarterly
- [ ] Full penetration test
- [ ] Pattern database update
- [ ] Security assessment

---

## Troubleshooting

### Gateway Not Responding

```bash
# Check service status
systemctl status openclaw

# View recent logs
journalctl -u openclaw -n 50

# Restart if needed
sudo systemctl restart openclaw
```

### Sudo Proxy Socket Missing

```bash
# Check socket
ls -la /run/sudo-proxy/

# Restart service
sudo systemctl restart sudo-proxy

# Verify permissions
ls -la /run/sudo-proxy/sudo-proxy.sock
# Should be: srw-rw---- root openclaw-svc
```

### Approvals Not Appearing in Dashboard

```bash
# Check CPM dashboard
systemctl status cpm-dashboard

# Check webhook connectivity
curl -X POST http://127.0.0.1:5000/api/sudo-approval \
  -H "Content-Type: application/json" \
  -d '{"type":"test"}'
```

---

## References

- OpenClaw Security Architecture: `/data/ai-workspace/sysadmin-agent/docs/OPENCLAW_AI_SECURITY_ARCHITECTURE.md`
- Continuous Monitoring Procedures: `/data/ai-workspace/sysadmin-agent/docs/CONTINUOUS_MONITORING_AI.md`
- Wazuh Documentation: https://documentation.wazuh.com/

---

*Last Updated: 2026-02-02*
