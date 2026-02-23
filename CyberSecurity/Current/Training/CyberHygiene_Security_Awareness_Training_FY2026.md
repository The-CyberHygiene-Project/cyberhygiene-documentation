# CyberHygiene Security Awareness Training — FY2026

**Document ID:** TCC-SAT-FY2026
**Version:** 1.0
**Effective Date:** February 17, 2026
**Classification:** Controlled Unclassified Information (CUI)
**Policy Reference:** TCC-ATP-001 v1.0 (Security Awareness and Training Policy)
**Prepared By:** Donald E. Shannon, ISSO / System Owner
**System:** CyberHygiene Production Network (CPN), cyberinabox.net

---

## Training Program Overview

This document constitutes the formal FY2026 Security Awareness Training Program for The Contract Coach's CyberHygiene Production Network. It fulfills the training requirements of NIST SP 800-171 Rev 2 controls 3.2.1, 3.2.2, and 3.2.3, as well as CMMC Level 2 assessment objectives AT.L2-3.2.1, AT.L2-3.2.2, and AT.L2-3.2.3.

**Delivery Method:** Self-study with documented assessment (per TCC-ATP-001 Section 3.1.4 and gap analysis finding that self-study is acceptable for a solopreneur with active TS clearance).

**Assessment Requirement:** Training Assessment Quiz (minimum 80% passing score per TCC-ATP-001 Section 3.1.5).

---

# Module 1 — General Security Awareness

**NIST SP 800-171 Rev 2 Control:** 3.2.1 — Ensure that managers, systems administrators, and users of organizational systems are made aware of the security risks associated with their activities and of the applicable policies, standards, and procedures related to the security of those systems.

**CMMC Assessment Objective:** AT.L2-3.2.1

---

## 1.1 CUI Handling and Marking

### What Is CUI?

Controlled Unclassified Information (CUI) is information the Government creates or possesses, or that an entity creates or possesses for or on behalf of the Government, that a law, regulation, or Government-wide policy requires or permits an agency to handle using safeguarding or dissemination controls.

### CUI Categories Relevant to The Contract Coach

- **Controlled Technical Information (CTI):** Technical data with military or space application subject to distribution controls
- **Export Controlled:** Information subject to ITAR/EAR restrictions
- **Procurement and Acquisition:** Contract data, proposals, source selection information
- **Privacy:** PII collected under federal contracts

### CUI Marking Requirements

All CUI documents must include:

1. **Banner Marking:** "CONTROLLED" or "CUI" at top and bottom of each page
2. **Category Marking:** Specific CUI category (e.g., "CUI//SP-CTI")
3. **Distribution Statement:** Limited dissemination control (e.g., "Distribution authorized to DoD components only")
4. **Designation Indicator:** Who designated the information as CUI

### CUI Storage Requirements

- **Digital CUI:** Stored only on authorized CPN systems with FIPS 140-2 validated encryption (LUKS for storage, TLS 1.2+ for transmission)
- **Physical CUI:** Stored in locked container or room with access control
- **Prohibited Locations:** Personal email, cloud storage (Dropbox, Google Drive, iCloud), unencrypted USB drives, personal devices

### CUI Destruction

- **Digital:** Secure deletion via `shred` command (minimum 3 passes) or LUKS volume destruction
- **Physical:** Cross-cut shredding (DIN 66399 Level P-4 or higher)

---

## 1.2 Password Policy and Multi-Factor Authentication

### Password Requirements (per TCC-IAP-001)

- **Minimum Length:** 14 characters
- **Complexity:** Mix of uppercase, lowercase, numbers, and special characters encouraged but not mandated if length exceeds 20 characters
- **Prohibited:** Dictionary words, usernames, sequential/repeated characters, previously breached passwords
- **Rotation:** Change every 60 days or immediately upon suspected compromise
- **Password Managers:** Encouraged (KeePassXC is approved)

### Multi-Factor Authentication (MFA)

- MFA is required for all privileged access and remote access
- FreeIPA OTP tokens are the approved MFA mechanism on CPN
- MFA tokens must be stored securely and never shared
- Report lost or stolen tokens to the ISSO immediately

### Account Security

- Accounts are locked after 3 consecutive failed login attempts
- Sessions are automatically locked after 15 minutes of inactivity
- Never share credentials with anyone, including IT support
- Never write passwords on sticky notes or whiteboards

---

## 1.3 Physical Security

### Facility Controls

- Server room access restricted to authorized personnel only
- Visitors must be escorted at all times in areas where CUI is accessible
- Challenge unrecognized individuals in restricted areas

### Clean Desk / Clear Screen Policy

- Clear all CUI from desks when leaving the work area
- Lock workstation when stepping away (Ctrl+L or Windows+L)
- Automatic screen lock activates after 15 minutes of inactivity (configured via dconf on all CPN workstations)
- Shred CUI documents after use — do not place in regular recycling

### Equipment Security

- Do not relocate CPN equipment without ISSO approval
- Secure laptops with cable locks when in public areas
- Report lost or stolen equipment immediately to the ISSO ([REDACTED-PHONE])

---

## 1.4 Acceptable Use

### Authorized Use (per TCC-AUP-001)

CPN systems are provided for authorized business purposes related to contract performance. Users must:

- Use systems only for authorized purposes
- Not install unauthorized software
- Not connect personal devices to the CPN
- Not use CPN systems for personal business, entertainment, or illegal activity
- Acknowledge the DoD-standard login banner before accessing any system

### System Monitoring Notice

All CPN system activity is monitored, logged, and subject to audit. The login banner states:

> "You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only. By using this IS, you consent to monitoring, recording, and auditing."

Users have no expectation of privacy when using CPN systems.

---

## 1.5 Incident Reporting Procedures

### What Is a Security Incident?

Any event that:
- Compromises the confidentiality, integrity, or availability of CUI
- Involves unauthorized access to CPN systems
- Involves loss or theft of CPN equipment or media
- Involves suspected malware infection
- Involves a policy violation

### How to Report

1. **Immediately contact the ISSO:** Donald E. Shannon — [REDACTED-PHONE]
2. **Do not attempt to investigate or remediate on your own** — this may destroy evidence
3. **Document what you observed:** Time, systems affected, actions taken, people involved
4. **Preserve evidence:** Do not power off systems, delete logs, or modify files

### Reporting Timeline (per TCC-IRP-001)

- **Internal:** Report to ISSO within 1 hour of discovery
- **DoD/DIBCAC:** CUI incidents reported within 72 hours via https://dibnet.dod.mil
- **Law Enforcement:** Engage if criminal activity suspected (ISSO initiates)

### Types of Reportable Events

- Phishing emails received (even if not clicked)
- Unauthorized access attempts (failed logins, social engineering)
- Malware detection alerts (Wazuh/YARA)
- Physical security breaches
- Lost or stolen equipment or media
- Policy violations observed

---

## 1.6 Social Engineering and Phishing Recognition

### Common Phishing Indicators

- **Urgency/Fear:** "Your account will be closed in 24 hours"
- **Authority Impersonation:** Appears to be from CEO, DoD, IRS
- **Suspicious Links:** Hover over links — does the URL match the claimed sender?
- **Attachments:** Unexpected .zip, .exe, .docm files
- **Grammar/Spelling:** Professional organizations use professional language
- **Mismatched Sender:** Display name says "Microsoft" but email is from a gmail.com address

### What to Do

1. **Do NOT click links or open attachments** in suspicious emails
2. **Do NOT reply** to the sender
3. **Report** to the ISSO immediately
4. **Forward** the suspicious email as an attachment (not inline) if instructed

### Social Engineering Beyond Email

- **Phone (Vishing):** Caller claims to be IT support, asks for password — never provide credentials by phone
- **In-Person (Pretexting):** Stranger claims to be a vendor, asks to access server room — verify with ISSO
- **USB Drops:** Unknown USB drives left in parking lot or common areas — never insert into any CPN system

---

## 1.7 Removable Media Controls

### USBGuard Policy (per TCC-ATP-001 and NIST 3.8.7)

- USBGuard is installed and active on all CPN systems
- Only pre-authorized USB devices are permitted (device-specific allowlist)
- Unauthorized USB devices are automatically blocked
- All USB connection/disconnection events are logged to Wazuh SIEM

### Removable Media Rules

- **No personal USB devices** on CPN systems
- **Encryption required:** Any authorized removable media containing CUI must use FIPS 140-2 validated encryption
- **Sanitize before reuse:** Use `shred` or approved sanitization tool
- **Destruction:** Physically destroy media that held CUI when no longer needed

---

# Module 2 — Role-Based Technical Training

**NIST SP 800-171 Rev 2 Control:** 3.2.2 — Ensure that personnel are trained to carry out their assigned information security-related duties and responsibilities.

**CMMC Assessment Objective:** AT.L2-3.2.2

---

## 2.1 ISSO and System Administrator Responsibilities

### ISSO Duties (Donald E. Shannon)

As ISSO for the CyberHygiene Production Network, responsibilities include:

- Implementing and maintaining all 110 NIST SP 800-171 Rev 2 security controls
- Conducting periodic security assessments per NIST SP 800-53A methodology
- Maintaining the System Security Plan (SSP) and POA&M
- Managing security awareness training program (this document)
- Incident response coordination and DoD reporting
- Continuous monitoring via Wazuh SIEM
- Managing FreeIPA identity and access management
- Coordinating CMMC Level 2 assessment readiness

### System Administrator Duties

- Secure system configuration per NIST 800-171 CUI profile
- Patch management within 30 days of release (critical: 72 hours)
- Audit log review (daily automated, weekly manual review)
- Backup verification and disaster recovery testing
- User account lifecycle management via FreeIPA
- Vulnerability scanning and remediation

---

## 2.2 FreeIPA Administration

### Architecture

- **Server:** dc1.cyberinabox.net (192.168.1.10)
- **Domain:** cyberinabox.net
- **Realm:** CYBERINABOX.NET
- **Services:** Kerberos KDC, LDAP (389-DS), DNS, Certificate Authority (Dogtag PKI)

### Security Practices

- All user authentication centralized through FreeIPA
- Host-Based Access Control (HBAC) rules restrict system access by role
- Password policies enforced at the directory level
- OTP token management for MFA (when deployed)
- Audit all administrative actions via FreeIPA audit log

### Administrative Cautions

- **Never use `kadmin.local ktadd` on IPA user principals** — this corrupts user keys
- Password resets through IPA tools (`ipa passwd`) or `ldappasswd` via LDAPI EXTERNAL bind
- Always verify HBAC rules after modifying access policies
- Certificate operations through IPA CA (Dogtag) — do not use external tools on IPA-managed certs

---

## 2.3 FIPS 140-2 Compliance Requirements

### What Is FIPS 140-2?

Federal Information Processing Standard 140-2 specifies requirements for cryptographic modules used to protect sensitive (CUI) information. CMMC Level 2 requires FIPS-validated cryptography.

### CPN FIPS Implementation

- **Operating System:** Rocky Linux 9 with `fips-mode-setup --enable` (system-wide FIPS mode)
- **Disk Encryption:** LUKS with AES-256 (FIPS-validated via kernel crypto module)
- **TLS:** Version 1.2 minimum, configured via crypto-policies (`FIPS` profile)
- **SSH:** FIPS-compliant algorithms only (no arcfour, no MD5)
- **Certificates:** SSL.com wildcard cert with RSA-2048+ keys

### Verification

- Check FIPS mode: `fips-mode-setup --check` (must report "FIPS mode is enabled")
- Check crypto policy: `update-crypto-policies --show` (must report "FIPS")
- Audit crypto compliance: OpenSCAP FIPS profile scan

---

## 2.4 Audit Log Review Procedures

### Log Sources (Wazuh SIEM)

- **System Logs:** /var/log/messages, /var/log/secure (all CPN hosts)
- **Authentication:** FreeIPA/Kerberos authentication logs
- **File Integrity:** Wazuh FIM alerts (12-hour scan interval)
- **USBGuard:** /var/log/usbguard/usbguard-audit.log
- **Network IDS:** Suricata alerts via pfSense
- **Web/Email:** Postfix, Dovecot, Apache logs

### Review Schedule (per TCC-AAP-001)

| Frequency | Activity | Responsible |
|-----------|----------|-------------|
| Real-time | Wazuh alerts (critical/high severity) | Automated + ISSO |
| Daily | Automated log summary review | ISSO |
| Weekly | Manual audit log review (authentication failures, privilege escalation) | ISSO |
| Monthly | Comprehensive audit report generation | ISSO |
| Quarterly | Audit policy effectiveness review | ISSO |

### Key Events to Monitor

- Failed login attempts (>3 per account)
- Privilege escalation (`sudo`, `su`, `pkexec`)
- File integrity changes on critical system files
- USB device connection attempts (authorized and blocked)
- After-hours access to CPN systems
- Large data transfers or unusual network traffic
- Account creation, modification, or deletion

---

## 2.5 STIG/CIS Hardening Standards

### Applicable Baselines

- **DISA STIG:** Red Hat Enterprise Linux 9 STIG (applicable to Rocky Linux 9)
- **CIS Benchmark:** CIS Rocky Linux 9 Benchmark Level 2
- **SCAP Profile:** xccdf_org.ssgproject.content_profile_cui

### Hardening Implemented on CPN

- ComplianceAsCode hardening applied via `/etc/sshd_config.d/00-complianceascode-hardening.conf`
- Firewalld configured with minimum required services
- Unnecessary services disabled
- Root login restricted (PermitRootLogin limited to authorized hosts)
- SELinux enforcing mode
- Automatic security updates configured

### Compliance Scanning

- **Tool:** OpenSCAP (`oscap xccdf eval`)
- **Profile:** NIST 800-171 CUI profile
- **Frequency:** Monthly automated scan + after significant changes
- **Remediation:** Address findings within 30 days (critical: 72 hours)

---

## 2.6 Backup and Recovery

### Backup Architecture (per POA&M-003)

- **Tool:** ReaR (Relax-and-Recover)
- **Schedule:** Weekly full backups, daily incremental backups
- **Storage:** NAS with encrypted transport
- **Retention:** 30 days minimum

### Recovery Procedures

1. Boot from ReaR recovery media
2. Select appropriate backup snapshot
3. Restore system to known-good state
4. Verify FreeIPA services operational
5. Verify Wazuh SIEM reconnection
6. Run integrity check on restored data

### Testing Requirements

- **Frequency:** Annual disaster recovery test (POA&M-012, target Q2 2026)
- **Documentation:** Test results, recovery time, issues encountered
- **Success Criteria:** Full system restoration within 4 hours

---

## 2.7 Vulnerability Scanning and Patching

### Vulnerability Management (per TCC-RA-001 and TCC-SI-001)

- **Scanning Tools:** Wazuh vulnerability detection, OpenSCAP
- **Scan Frequency:** Continuous (Wazuh), monthly (OpenSCAP), on-demand
- **Scope:** All CPN systems (dc1, labrat, engineering, accounting, AI)

### Patching Policy

| Severity | Remediation Timeline | Approval |
|----------|---------------------|----------|
| Critical (CVSS 9.0+) | 72 hours | ISSO emergency approval |
| High (CVSS 7.0-8.9) | 14 days | ISSO approval |
| Medium (CVSS 4.0-6.9) | 30 days | Standard change process |
| Low (CVSS < 4.0) | 90 days | Scheduled maintenance |

### Patch Process

1. Monitor advisories: CISA KEV, Rocky Linux errata, vendor bulletins
2. Test patches on non-production system when possible
3. Apply patches: `dnf update --security`
4. Verify: Run OpenSCAP scan post-patching
5. Document: Log patch in configuration management system

---

# Module 3 — Insider Threat Awareness

**NIST SP 800-171 Rev 2 Control:** 3.2.3 — Provide security awareness training on recognizing and reporting potential indicators of insider threats.

**CMMC Assessment Objective:** AT.L2-3.2.3

---

## 3.1 What Is an Insider Threat?

An insider threat is the potential for an individual who has or had authorized access to an organization's assets to use that access — either maliciously or unintentionally — to act in a way that could negatively affect the organization.

### Categories of Insider Threats

1. **Malicious Insider:** Intentionally steals data, sabotages systems, or assists external adversaries
2. **Negligent Insider:** Causes harm through carelessness, policy violations, or lack of awareness
3. **Compromised Insider:** Account or credentials have been taken over by an external threat actor

---

## 3.2 Insider Threat Indicators and Behavioral Cues

### Technical Indicators

- Accessing systems or data outside normal job duties
- Large or unusual data downloads or transfers
- Attempts to access restricted/classified systems
- Using unauthorized removable media or cloud storage
- Disabling security tools (antivirus, logging, FIM)
- Accessing systems during unusual hours without business justification
- Multiple failed access attempts on systems they do not normally use

### Behavioral Indicators

- Expressed disgruntlement with the organization or government
- Unexplained affluence or financial difficulties
- Attempts to obtain access beyond what their role requires
- Resistance to security procedures or audits
- Working unusual hours without clear need
- Discussing sensitive information in unsecured settings
- Foreign travel or contacts inconsistent with duties

### Contextual Risk Factors

- Personnel in transition (termination, transfer, contract end)
- Access to high-value CUI or critical systems
- Lone workers with minimal oversight
- Prior security violations or policy infractions

---

## 3.3 Reporting Procedures and Channels

### Who to Report To

- **Primary:** ISSO — Donald E. Shannon, [REDACTED-PHONE]
- **Alternative:** System Owner (same individual in current organization)
- **DoD Channels:** Defense Counterintelligence and Security Agency (DCSA) if espionage suspected
- **Anonymous:** Written reports accepted (place in sealed envelope to ISSO)

### What to Report

- Any of the indicators listed in Section 3.2
- Unusual requests for access or information
- Observed policy violations
- Suspected compromise of credentials or systems
- Concerns about a colleague's behavior or intentions

### Reporting Protections

- **Whistleblower Protection:** Federal whistleblower statutes protect good-faith reporters from retaliation
- **No Retaliation Policy:** TCC policy prohibits retaliation against anyone who reports concerns in good faith
- **Confidentiality:** Reports are handled confidentially to the extent possible
- **Duty to Report:** All personnel have an obligation to report — failure to report known threats is itself a security violation

---

## 3.4 Real-World Case Studies

### Case Study 1: The Negligent Contractor

**Scenario:** A cleared contractor copied CUI files to a personal USB drive to "work from home." The USB drive was lost in a coffee shop.

**Impact:** CUI spillage incident, 72-hour DoD notification required, contract performance review, potential debarment.

**Lesson:** Never transfer CUI to unauthorized media. Use only approved systems and storage locations. This is why USBGuard is deployed on all CPN systems — technical controls prevent this even if users forget policy.

### Case Study 2: The Disgruntled Employee (Reality Winner, 2017)

**Scenario:** An NSA contractor printed a classified report and mailed it to a journalist. She was identified through printer steganography (tracking dots) and access logs.

**Impact:** Convicted under the Espionage Act, sentenced to 63 months in federal prison.

**Lesson:** All system access is logged and auditable. The CPN's Wazuh SIEM captures authentication, file access, and print activity. Unauthorized disclosure of CUI has severe criminal consequences under 18 U.S.C. 793 and 798.

### Case Study 3: The Phished Administrator (SolarWinds, 2020)

**Scenario:** A sophisticated supply chain attack compromised the build system of a widely-used IT management tool. Thousands of organizations, including federal agencies, were affected.

**Impact:** Multi-agency breach, years of remediation, congressional investigations.

**Lesson:** Even trusted software can be compromised. Apply defense-in-depth: network segmentation, least privilege, FIPS-validated crypto, file integrity monitoring, and continuous monitoring. This is why CPN uses layered defenses (Wazuh, Suricata, FIM, USBGuard).

### Case Study 4: The Compromised Credentials (OPM Breach, 2015)

**Scenario:** Attackers used stolen credentials to access the Office of Personnel Management systems containing 21.5 million security clearance background investigation files.

**Impact:** Massive PII exposure including SF-86 data, fingerprints, and clearance adjudication information.

**Lesson:** Credential security is paramount. Use strong passwords, MFA, and never reuse credentials across systems. Report any suspected credential compromise immediately.

---

## 3.5 Organizational Policies: Need-to-Know and Least Privilege

### Need-to-Know Principle

Access to CUI is granted only when the individual:
1. Has a legitimate need for the information to perform their duties
2. Has been granted appropriate authorization
3. Has completed required security training (this training)

Having a clearance alone does NOT grant access — need-to-know must also be established.

### Least Privilege (NIST 3.1.5, 3.1.6, 3.1.7)

- Users receive only the minimum system privileges necessary for their role
- Administrative access (`sudo`, root) is limited to authorized system administrators
- FreeIPA Host-Based Access Control (HBAC) restricts which users can access which systems
- Privilege escalation is logged and reviewed

### Separation of Duties

- Where possible, critical functions require multiple individuals (or compensating controls for solopreneur operations)
- Administrative actions are logged for post-hoc review
- AI agent actions require human-in-the-loop approval (Citadel Guard/HITL proxy)

---

## 3.6 Counter-Intelligence Awareness

### Foreign Intelligence Threats to Contractors

Defense contractors are high-value targets for foreign intelligence services. Common approaches include:

- **Social Media Elicitation:** LinkedIn connections from foreign nationals seeking technical information
- **Conference Approaches:** Unsolicited technical discussions at trade shows or conferences
- **Cyber Operations:** Targeted phishing, watering hole attacks, supply chain compromise
- **Recruitment Attempts:** Gradual relationship building with progression to information requests

### Reporting Requirements

- Report suspicious contacts to the ISSO and, if appropriate, to DCSA
- Report foreign travel that may create vulnerability
- Be cautious of unsolicited offers of "collaboration" or "partnership" from unknown foreign entities
- Social media profiles should not reveal specific program details or clearance status

### Protecting Sensitive Information

- Never discuss CUI in public settings (restaurants, airports, phone calls in public)
- Use TEMPEST/EMSEC awareness when working with sensitive displays
- Verify the identity of anyone requesting technical information
- When in doubt, do not share — ask the ISSO first

---

## Training Summary

### Key Takeaways

1. **CUI is your responsibility** — know how to identify, mark, store, and destroy it
2. **Strong authentication protects everyone** — 14+ character passwords, MFA, never share credentials
3. **Report everything** — incidents, suspicious behavior, phishing, policy violations
4. **Technical controls are your allies** — USBGuard, session lock, Wazuh, FIPS crypto are there to help
5. **Insider threats are real** — they come from negligence as often as malice
6. **Least privilege / need-to-know** — access only what you need, question requests for more
7. **Stay vigilant** — adversaries are persistent and creative

### Applicable Policies

| Policy ID | Title | Relevance |
|-----------|-------|-----------|
| TCC-ATP-001 | Security Awareness and Training Policy | This training program's governing policy |
| TCC-AUP-001 | Acceptable Use Policy | System usage rules |
| TCC-IRP-001 | Incident Response Policy | Reporting procedures |
| TCC-IAP-001 | Identification and Authentication Policy | Password and MFA requirements |
| TCC-AAP-001 | Audit and Accountability Policy | Monitoring and logging |
| TCC-CMP-001 | Configuration Management Policy | System hardening standards |
| TCC-SCP-001 | System and Communications Protection Policy | Encryption and network security |
| TCC-PSP-001 | Personnel Security Policy | Clearance and screening |
| TCC-RA-001 | Risk Management Policy | Vulnerability management |
| TCC-SI-001 | System and Information Integrity Policy | Malware and integrity controls |

### Regulatory References

- NIST SP 800-171 Rev 2 (Controls 3.2.1, 3.2.2, 3.2.3)
- CMMC Level 2 (AT.L2-3.2.1, AT.L2-3.2.2, AT.L2-3.2.3)
- 32 CFR Part 170
- DFARS 252.204-7012
- NIST SP 800-50 (Building an IT Security Awareness and Training Program)

---

**CLASSIFICATION:** CONTROLLED UNCLASSIFIED INFORMATION (CUI)
**DISTRIBUTION:** Official Use Only — Need to Know Basis

---

**END OF TRAINING DOCUMENT**
