# USBGuard Configuration Export
## Evidence Artifact for AC-19/AC-20 Controls

**Export Date:** February 3, 2026
**System:** dc1.cyberinabox.net
**Control:** AC-19 (Control Connection of Mobile Devices), AC-20 (Use of External Systems)

---

## Verification Status

**USBGuard Status:** IMPLEMENTED AND VERIFIED

- Daemon running with `ImplicitPolicyTarget=block`
- Rules file present at `/etc/usbguard/rules.conf`
- Audit logging enabled via LinuxAudit backend
- IPC access restricted to root user and wheel group

---

## Configuration: /etc/usbguard/usbguard-daemon.conf

```ini
RuleFile=/etc/usbguard/rules.conf
RuleFolder=/etc/usbguard/rules.d/
ImplicitPolicyTarget=block
PresentDevicePolicy=apply-policy
PresentControllerPolicy=keep
InsertedDevicePolicy=apply-policy
RestoreControllerDeviceState=false
DeviceManagerBackend=uevent
IPCAllowedUsers=root
IPCAllowedGroups=wheel
IPCAccessControlFiles=/etc/usbguard/IPCAccessControl.d/
DeviceRulesWithPort=false
AuditFilePath=/var/log/usbguard/usbguard-audit.log
AuditBackend=LinuxAudit
```

---

## Rules: /etc/usbguard/rules.conf

```
allow with-interface match-all { 03:*:* 09:00:* }
```

**Rule Explanation:**
- Allows HID devices (class 03:*:*) such as keyboards and mice
- Allows USB hubs (class 09:00:*)
- All other device classes are blocked by default (ImplicitPolicyTarget=block)

---

## Security Configuration Summary

| Setting | Value | Security Impact |
|---------|-------|-----------------|
| ImplicitPolicyTarget | block | All unrecognized USB devices blocked by default |
| PresentDevicePolicy | apply-policy | Devices present at boot evaluated against rules |
| InsertedDevicePolicy | apply-policy | Hot-plugged devices evaluated against rules |
| AuditBackend | LinuxAudit | Events logged to Linux audit subsystem |
| IPCAllowedUsers | root | Only root can manage rules |
| IPCAllowedGroups | wheel | Wheel group can manage rules |

---

## NIST SP 800-171 Compliance Mapping

| Control | Requirement | Implementation |
|---------|-------------|----------------|
| 3.1.18 (AC-19) | Control connection of mobile devices | USBGuard blocks unauthorized USB devices |
| 3.1.20 (AC-20) | Control use of portable storage devices | Mass storage devices blocked unless explicitly allowed |
| 3.3.1 (AU-2) | Create audit logs | LinuxAudit backend logs all USB events |

---

## Evidence Collection Commands

```bash
# Verify USBGuard service status
systemctl status usbguard

# View current device policy
usbguard list-devices

# View current rules
usbguard list-rules

# Check audit logs
ausearch -m USER_DEVICE
```

---

**Collected By:** D. Shannon
**Classification:** CUI Evidence Artifact
