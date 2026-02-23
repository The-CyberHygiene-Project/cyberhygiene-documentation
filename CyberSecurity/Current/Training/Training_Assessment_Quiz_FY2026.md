# Security Awareness Training Assessment Quiz — FY2026

**Document ID:** TCC-SAT-QUIZ-FY2026
**Version:** 1.0
**Date:** February 17, 2026
**Policy Reference:** TCC-ATP-001 v1.0
**Passing Score:** 80% (16 of 20 correct)
**Classification:** Controlled Unclassified Information (CUI)

---

## Instructions

- This quiz assesses comprehension of the FY2026 Security Awareness Training (TCC-SAT-FY2026).
- Select the single best answer for each question.
- A minimum score of 80% (16/20) is required to pass per TCC-ATP-001 Section 3.1.5.
- If you do not achieve a passing score, review the training material and retake the quiz.

---

## Questions

### Question 1 — [Control 3.2.1]

**What is the minimum password length required on CPN systems?**

A) 8 characters
B) 12 characters
C) 14 characters
D) 20 characters

---

### Question 2 — [Control 3.2.1]

**You receive an email that appears to be from your supervisor asking you to click a link and enter your CPN credentials. The email address doesn't match your supervisor's usual address. What should you do?**

A) Click the link to check if it's legitimate
B) Reply to the email asking if they sent it
C) Do not click the link, report it to the ISSO immediately
D) Forward the email to all colleagues as a warning

---

### Question 3 — [Control 3.2.1]

**Where should CUI documents be stored?**

A) Personal Google Drive for backup purposes
B) Only on authorized CPN systems with FIPS 140-2 validated encryption
C) Any system with a password
D) Personal USB drives if encrypted

---

### Question 4 — [Control 3.2.1]

**How quickly must CUI security incidents be reported to the DoD?**

A) 24 hours
B) 48 hours
C) 72 hours
D) 7 days

---

### Question 5 — [Control 3.2.1]

**What happens after 15 minutes of inactivity on CPN workstations?**

A) The system shuts down
B) The screen dims but remains unlocked
C) The session is automatically locked
D) A warning popup appears

---

### Question 6 — [Control 3.2.1]

**You find a USB drive in the parking lot. What should you do?**

A) Insert it into your workstation to identify the owner
B) Insert it into a non-CPN computer to check its contents
C) Do not insert it into any system — report it to the ISSO
D) Throw it away

---

### Question 7 — [Control 3.2.1]

**Which of the following is NOT a required element of CUI marking?**

A) Banner marking ("CUI" or "CONTROLLED")
B) Category marking
C) The author's security clearance level
D) Distribution statement

---

### Question 8 — [Control 3.2.2]

**What is the primary tool used for Security Information and Event Management (SIEM) on the CPN?**

A) Splunk
B) Wazuh
C) ClamAV
D) Nessus

---

### Question 9 — [Control 3.2.2]

**What is the remediation timeline for a critical vulnerability (CVSS 9.0+)?**

A) 30 days
B) 14 days
C) 72 hours
D) 90 days

---

### Question 10 — [Control 3.2.2]

**Which cryptographic standard must be used for protecting CUI on CPN systems?**

A) FIPS 140-2
B) PCI-DSS
C) SOC 2
D) ISO 27001

---

### Question 11 — [Control 3.2.2]

**How frequently are Wazuh File Integrity Monitoring (FIM) scans performed?**

A) Every hour
B) Every 6 hours
C) Every 12 hours
D) Every 24 hours

---

### Question 12 — [Control 3.2.2]

**Why should you NEVER use `kadmin.local ktadd` on FreeIPA user principals?**

A) It is too slow
B) It corrupts user keys
C) It requires a reboot
D) It is deprecated

---

### Question 13 — [Control 3.2.2]

**What is the SCAP compliance profile applied to CPN systems?**

A) PCI-DSS profile
B) HIPAA profile
C) NIST 800-171 CUI profile
D) CJIS profile

---

### Question 14 — [Control 3.2.2]

**What backup tool is used on the CPN and what is its backup schedule?**

A) Bacula — monthly full backups
B) ReaR — weekly full, daily incremental
C) Veeam — daily full backups
D) rsync — hourly incremental

---

### Question 15 — [Control 3.2.3]

**Which of the following is a category of insider threat?**

A) Malicious insider, negligent insider, compromised insider
B) External hacker, script kiddie, nation-state actor
C) Physical threat, logical threat, social threat
D) Virus, worm, trojan

---

### Question 16 — [Control 3.2.3]

**An employee begins accessing files and systems that are unrelated to their job duties and working unusual hours. This could indicate:**

A) A dedicated employee going above and beyond
B) A potential insider threat requiring reporting
C) Normal behavior during a busy period
D) An IT problem causing access errors

---

### Question 17 — [Control 3.2.3]

**What is the "need-to-know" principle?**

A) Everyone with a clearance can access all CUI
B) Access to CUI requires both authorization and a legitimate need for the information
C) Information should be shared widely so everyone knows what's happening
D) Only managers need to know about security policies

---

### Question 18 — [Control 3.2.3]

**In the Reality Winner case study, how was the leaker identified?**

A) A coworker reported suspicious behavior
B) Printer steganography (tracking dots) and access logs
C) Email monitoring detected the disclosure
D) She confessed voluntarily

---

### Question 19 — [Control 3.2.3]

**Who should you report suspected insider threat indicators to?**

A) Your coworkers first, then management
B) Local law enforcement directly
C) The ISSO (Donald E. Shannon, [REDACTED-PHONE])
D) Post about it on social media to warn others

---

### Question 20 — [Control 3.2.3]

**A foreign national you don't know contacts you on LinkedIn asking about the technical details of your defense contract work. What should you do?**

A) Share general information since LinkedIn is a professional network
B) Ignore the message — it's probably harmless
C) Accept the connection to network professionally
D) Do not share any information, report the contact to the ISSO and potentially DCSA

---

## End of Quiz

**Total Questions:** 20
**Required to Pass:** 16 correct (80%)

Record your score on the Training Completion Record (TCC-SAT-RECORD-FY2026).

---

## Answer Key

| # | Answer | Control | Explanation |
|---|--------|---------|-------------|
| 1 | **C** | 3.2.1 | TCC-IAP-001 requires minimum 14-character passwords |
| 2 | **C** | 3.2.1 | Never click suspicious links; report phishing to ISSO immediately |
| 3 | **B** | 3.2.1 | CUI must be stored only on authorized systems with FIPS 140-2 encryption |
| 4 | **C** | 3.2.1 | DoD CUI incidents must be reported within 72 hours per DFARS 252.204-7012 |
| 5 | **C** | 3.2.1 | Session lock activates after 15 minutes of inactivity (dconf idle-delay=900s) |
| 6 | **C** | 3.2.1 | Never insert unknown media; report to ISSO (USB drops are a social engineering vector) |
| 7 | **C** | 3.2.1 | Clearance level is not a CUI marking element; banner, category, and distribution are required |
| 8 | **B** | 3.2.2 | Wazuh v4.9.2 is the CPN SIEM with Suricata integration |
| 9 | **C** | 3.2.2 | Critical vulnerabilities (CVSS 9.0+) require remediation within 72 hours |
| 10 | **A** | 3.2.2 | FIPS 140-2 is required for cryptographic modules protecting CUI |
| 11 | **C** | 3.2.2 | Wazuh FIM runs 12-hour scan intervals on critical paths |
| 12 | **B** | 3.2.2 | kadmin.local ktadd corrupts IPA user keys due to keytab extraction behavior |
| 13 | **C** | 3.2.2 | xccdf_org.ssgproject.content_profile_cui (NIST 800-171 CUI profile) |
| 14 | **B** | 3.2.2 | ReaR with weekly full and daily incremental backups |
| 15 | **A** | 3.2.3 | The three insider threat categories: malicious, negligent, and compromised |
| 16 | **B** | 3.2.3 | Accessing unrelated files and unusual hours are insider threat behavioral indicators |
| 17 | **B** | 3.2.3 | Need-to-know requires both authorization AND legitimate business need |
| 18 | **B** | 3.2.3 | Printer tracking dots and system access logs identified Reality Winner |
| 19 | **C** | 3.2.3 | Report insider threat indicators to the ISSO |
| 20 | **D** | 3.2.3 | Unsolicited foreign contact requesting technical details is a CI concern — report it |

---

### Control Coverage Summary

| Control | Questions | Count |
|---------|-----------|-------|
| 3.2.1 (General Security Awareness) | 1, 2, 3, 4, 5, 6, 7 | 7 |
| 3.2.2 (Role-Based Technical Training) | 8, 9, 10, 11, 12, 13, 14 | 7 |
| 3.2.3 (Insider Threat Awareness) | 15, 16, 17, 18, 19, 20 | 6 |

---

**CLASSIFICATION:** CONTROLLED UNCLASSIFIED INFORMATION (CUI)
**DISTRIBUTION:** Official Use Only — Need to Know Basis

---

**END OF ASSESSMENT QUIZ**
