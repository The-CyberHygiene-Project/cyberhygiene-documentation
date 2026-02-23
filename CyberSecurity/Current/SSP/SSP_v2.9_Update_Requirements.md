# SSP Version 2.9 Update Requirements

**Document:** System Security Plan
**From Version:** 2.8
**To Version:** 2.9
**Date:** February 21, 2026
**Author:** D. Shannon

---

## Summary of Changes

This document outlines changes required to update the System Security Plan from Version 2.8 to Version 2.9 based on the completion of multi-factor authentication deployment on all CPN systems (POA&M-004 closed).

1. **Multi-factor authentication (3.5.3) fully implemented** — SSH publickey + TOTP via pam_google_authenticator deployed on all 4 CPN systems. Status changes from NOT MET to MET.
2. **SPRS score increases from 101/110 to 106/110** — +5 points recovered (3.5.3).
3. **IA-8 (non-organizational users) addressed** — same MFA implementation covers both organizational and non-organizational user requirements; POA&M-SPRS-1 absorbed into POA&M-004.

**SPRS Score:** **106/110** (up from 101/110). Remaining deficit: -4 (risk assessment -3, IR testing -1).

---

## Header Updates

| Section | Current Value | New Value |
|---------|---------------|-----------|
| Version | 2.8 | 2.9 |
| Date | February 21, 2026 | February 21, 2026 |
| SPRS Score | 101/110 | 106/110 |
| POA&M Reference | v2.10 | v2.11 |

---

## Revision History Entry

Add to Document Revision History table:

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 2.9 | February 21, 2026 | D. Shannon | **MFA DEPLOYMENT COMPLETE:** Multi-factor authentication (NIST 800-171 3.5.3) implemented on all 4 CPN systems. SSH publickey + TOTP (pam_google_authenticator, time-based, Microsoft Authenticator). AuthenticationMethods publickey,keyboard-interactive. DC1 admin exemption via pam_succeed_if.so. Bitdefender bdsecd removed from engineering and accounting. Status: 3.5.3 NOT MET → MET. SPRS improved 101→106 (+5 points). |

---

## Control Documentation Updates

### 3.5.3 — Multi-Factor Authentication

**Update status from NOT MET to MET.** Replace the existing 3.5.3 section with:

```markdown
#### 3.5.3 Use Multi-Factor Authentication for Local and Network Access

**Status:** MET
**SPRS Impact:** +5 points recovered (02/21/2026)
**Controls:** IA-2(1), IA-2(2), IA-8

Multi-factor authentication implemented on all CPN systems using SSH public key (first factor) combined with time-based one-time password via pam_google_authenticator (second factor).

**Authentication Flow:**
1. SSH client presents ECDSA-521 public key → sshd verifies against authorized_keys
2. PAM keyboard-interactive phase → pam_google_authenticator.so prompts for TOTP
3. User enters 6-digit code from Microsoft Authenticator app (30-second window, RFC 6238)
4. Both factors must succeed for access to be granted

**Deployment Scope:** All 4 CPN systems

| System | TOTP Configured | Deploy Date | Authenticator App |
|--------|----------------|-------------|-------------------|
| dc1.cyberinabox.net | Yes | 02/21/2026 | Microsoft Authenticator |
| labrat.cyberinabox.net | Yes | 02/21/2026 | Microsoft Authenticator |
| engineering.cyberinabox.net | Yes | 02/21/2026 | Microsoft Authenticator |
| accounting.cyberinabox.net | Yes | 02/21/2026 | Microsoft Authenticator |

**SSH Configuration** (`/etc/ssh/sshd_config.d/60-mfa.conf` on each system):

```
# MFA: pubkey + TOTP — DC1 exemption via PAM (pam_succeed_if rhost)
# NIST 800-171 3.5.3 — Deployed 2026-02-21
KbdInteractiveAuthentication yes
AuthenticationMethods publickey,keyboard-interactive
```

**PAM Configuration** (`/etc/pam.d/sshd` auth section on each system):

```
auth sufficient pam_succeed_if.so quiet rhost = 192.168.1.10
auth required pam_google_authenticator.so nullok
auth include postlogin
```

**DC1 Administrative Exemption:**
Connections originating from dc1.cyberinabox.net (192.168.1.10) bypass TOTP via `pam_succeed_if.so rhost = 192.168.1.10` with the `sufficient` control flag. This enables automated administrative scripts (OpenSCAP collection, deploy scripts) to operate without interactive TOTP prompts while preserving MFA for all other network connections. The dc1 exemption is IP-restricted to the management server only.

**SELinux Policy:**
Custom SELinux policy module `sshd_google_auth` deployed on all systems — grants `sshd_t` read/write access to `auth_home_t` context files (`.google_authenticator`), required for TOTP verification and scratch code management.

**Recovery Codes:**
Five single-use scratch codes generated per system. Stored in KeePass password vault (Passwords.kdbx) per TCC-IAP-001 key management requirements.

**IA-8 Coverage:**
The same MFA implementation satisfies IA-8 (Identification and Authentication for Non-Organizational Users). FreeIPA OTP and pam_google_authenticator enforce MFA for all SSH connections regardless of user classification.
```

---

### 3.5.2 — Authenticate Users, Processes, and Devices

Update to note MFA reinforces 3.5.2 compliance (already MET):

```markdown
**Note (02/21/2026):** Multi-factor authentication deployment (3.5.3) further strengthens 3.5.2 compliance. SSH public key authentication (ECDSA-521) serves as the primary identity authenticator; TOTP provides the second factor. Both are required for access to all CPN systems from non-administrative sources.
```

---

### SPRS Score Update

Update all SPRS score references throughout the SSP:

| Section | Current Value | New Value |
|---------|---------------|-----------|
| Executive Summary SPRS | 101/110 | 106/110 |
| SPRS Scorecard | 101/110 | 106/110 |
| 3.5.3 status | NOT MET / -5 | MET / 0 |
| Remaining deficit | -9 | -4 |

**Remaining SPRS deficits after this update:**

| Requirement | Control | Weight | Target |
|-------------|---------|--------|--------|
| 3.11.1 | Periodic Risk Assessment | -3 | 04/30/2026 |
| 3.6.3 | IR Tabletop Exercise | -1 | 06/30/2026 |
| **Total** | | **-4** | |

---

## Verification Checklist

After implementing all updates, verify:

- [ ] SPRS score updated to 106/110 in all document sections
- [ ] 3.5.3 status updated from NOT MET to MET
- [ ] 3.5.3 section documents SSH publickey + TOTP implementation details
- [ ] DC1 admin exemption documented (pam_succeed_if.so rhost = 192.168.1.10)
- [ ] Deployment table shows all 4 systems with 02/21/2026 date
- [ ] SELinux policy module documented
- [ ] Recovery code storage documented (KeePass)
- [ ] IA-8 coverage noted
- [ ] POA&M reference updated to v2.11
- [ ] Remaining SPRS deficit updated to -4

---

## Files Updated/Created

| File | Action | Notes |
|------|--------|-------|
| SSP_v2.9_Update_Requirements.md | Created | This document |
| /etc/ssh/sshd_config.d/60-mfa.conf | Created (all 4 systems) | AuthenticationMethods publickey,keyboard-interactive |
| /etc/pam.d/sshd | Modified (all 4 systems) | pam_succeed_if + pam_google_authenticator |
| /home/dshannon/.google_authenticator | Created (all 4 systems) | TOTP secrets (chmod 600) |
| /root/sshd_google_auth.te | Created (dc1) | SELinux policy source |
| SELinux sshd_google_auth module | Compiled/installed (all 4 systems) | sshd_t → auth_home_t access |

---

**Document Status:** Ready for Implementation
**Author:** D. Shannon
**Date:** February 21, 2026
