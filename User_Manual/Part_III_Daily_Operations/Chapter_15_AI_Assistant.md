# Chapter 15: Working with AI Assistant

## 15.1 Claude Code Overview

### What is Claude Code?

**Claude Code** is an AI assistant developed by Anthropic and integrated into the CyberHygiene Production Network to provide 24/7 support, guidance, and assistance to users and administrators.

**Key Capabilities:**
- Answer questions about system usage
- Explain documentation and procedures
- Troubleshoot common issues
- Provide command syntax and examples
- Generate code snippets and scripts
- Analyze log files and error messages
- Guide security best practices

**How It Works:**
- Large Language Model (LLM) trained on vast knowledge
- Context-aware (understands CyberHygiene environment)
- Access to system documentation
- Provides explanations in plain language
- Can understand and generate code

**What Makes It Special:**
- Available 24/7 (no waiting for business hours)
- Patient and non-judgmental
- Can explain complex topics simply
- Remembers context within conversation
- Provides step-by-step guidance

### Integration with CyberHygiene

**Claude Code Knows About:**
- ✅ CyberHygiene system architecture
- ✅ All 6 production servers
- ✅ NIST 800-171 compliance requirements
- ✅ FreeIPA, Kerberos, and authentication
- ✅ Monitoring systems (Prometheus, Grafana, Wazuh)
- ✅ Security tools (Suricata, YARA, ClamAV)
- ✅ This User Manual and all documentation
- ✅ Common troubleshooting procedures

**Claude Code Does NOT:**
- ❌ Execute commands directly (security restriction)
- ❌ Access your files or data
- ❌ Make system changes
- ❌ Store conversations permanently
- ❌ Share information between users

**Privacy:**
- Conversations are ephemeral (not stored long-term)
- Don't share sensitive data (passwords, keys, CUI)
- Use for learning and guidance, not data processing

## 15.2 Common AI Tasks

### Getting System Information

**Question:** "What servers are in the CyberHygiene network?"

**Claude Response:**
```
The CyberHygiene Production Network consists of 6 servers:

1. dc1.cyberinabox.net (192.168.1.10)
   - Domain Controller
   - FreeIPA, Kerberos, DNS, CA
   - Rocky Linux 9.5 (FIPS mode)

2. dms.cyberinabox.net (192.168.1.20)
   - Document Management Server
   - File sharing (Samba/NFS)
   - Backup repository

3. graylog.cyberinabox.net (192.168.1.30)
   - Log Management
   - Centralized logging with Elasticsearch

4. proxy.cyberinabox.net (192.168.1.40)
   - Web Proxy
   - Suricata IDS/IPS
   - Content filtering

5. monitoring.cyberinabox.net (192.168.1.50)
   - Prometheus metrics collection
   - Grafana dashboards
   - Alert management

6. wazuh.cyberinabox.net (192.168.1.60)
   - SIEM (Security Information and Event Management)
   - Security monitoring and compliance

All systems run Rocky Linux 9.5 with FIPS 140-2 mode enabled.
```

### Understanding Error Messages

**Question:** "I got this error: 'Permission denied (publickey,gssapi-keyex,gssapi-with-mic)'. What does it mean?"

**Claude Response:**
```
This SSH authentication error means the server requires public key or
Kerberos authentication, but neither succeeded.

Common causes:
1. SSH key not uploaded to FreeIPA
2. No valid Kerberos ticket
3. Wrong username
4. Account disabled

Solutions:
1. Check for Kerberos ticket:
   klist

2. Get a new ticket if expired:
   kinit your_username

3. Upload SSH key to FreeIPA:
   - Login to https://dc1.cyberinabox.net
   - Navigate to your user profile
   - Add SSH public key

4. Try password authentication as fallback:
   ssh -o PreferredAuthentications=password username@host

If none of these work, contact the system administrator.
```

### Learning Commands

**Question:** "How do I check how much disk space is left on a server?"

**Claude Response:**
```
To check disk space, use the 'df' command:

df -h

Explanation:
- df: "disk free" command
- -h: "human readable" format (shows GB instead of bytes)

Output will look like:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       500G  180G  320G  36% /
/dev/sdb1       2.0T  750G  1.3T  37% /datastore

Columns explained:
- Filesystem: Device name
- Size: Total capacity
- Used: How much is used
- Avail: How much is free
- Use%: Percentage used
- Mounted on: Where it's mounted

For specific directory usage:
du -sh /path/to/directory

For interactive disk usage viewer:
ncdu /path/to/directory
```

### Security Best Practices

**Question:** "What should I do if I receive a suspicious email?"

**Claude Response:**
```
If you receive a suspicious email, follow these steps:

1. DO NOT:
   - Click any links
   - Open attachments
   - Reply to the email
   - Forward to personal account

2. LOOK FOR WARNING SIGNS:
   - Unexpected sender
   - Requests for credentials
   - Urgent or threatening language
   - Misspellings or poor grammar
   - Generic greetings ("Dear user")
   - Suspicious links (hover to check)

3. VERIFY:
   - Contact sender through known channel
   - Check email headers (look for spoofing)
   - Verify sender domain is legitimate

4. REPORT:
   Email: security@cyberinabox.net
   Subject: [SECURITY] Suspicious Email
   Action: Forward as attachment (don't just forward)

5. DELETE:
   After reporting, delete the email
   Empty trash folder

The security team will:
- Analyze the email
- Block sender if malicious
- Alert other users if needed
- Update email filters

For more details, see Chapter 25: Reporting Security Issues.
```

### Troubleshooting Workflows

**Question:** "I can't access the Grafana dashboard. Where should I start?"

**Claude Response:**
```
Let's troubleshoot step by step:

Step 1: Can you reach the server?
ping grafana.cyberinabox.net

If ping fails:
- Network issue or server down
- Contact administrator immediately

If ping succeeds, continue to Step 2.

Step 2: Is the service listening?
telnet grafana.cyberinabox.net 3001
# Or
nc -zv grafana.cyberinabox.net 3001

If connection refused:
- Grafana service might be down
- Check with administrator

If connection succeeds, continue to Step 3.

Step 3: Try accessing in browser
https://grafana.cyberinabox.net

What error do you see?
- "Connection timed out" → Firewall or network issue
- "Connection refused" → Service not running
- "Certificate error" → Certificate problem
- "403 Forbidden" → Authentication/authorization issue
- Login page loads → Your credentials might be wrong

Step 4: Check your authentication
- Valid username/password?
- Kerberos ticket valid? (run: klist)
- Account locked? (check with admin)

Step 5: Try different browser
- Clear cache and cookies
- Try incognito mode
- Try different browser (Chrome vs Firefox)

Still not working? Contact support with:
- Exact error message
- Steps you've tried
- Browser and version
- Screenshot of error
```

## 15.3 Code Assistance

### Bash Script Examples

**Question:** "Can you write a script to backup a directory?"

**Claude Response:**
```bash
Here's a backup script with error checking:

#!/bin/bash
# backup_directory.sh - Backup a directory to timestamped archive

# Configuration
SOURCE_DIR="$1"
BACKUP_DIR="${2:-/datastore/backups}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create backup with progress
echo "Starting backup of $SOURCE_DIR..."
tar -czf "${BACKUP_DIR}/${BACKUP_NAME}" \
    --exclude='*.tmp' \
    --exclude='.cache' \
    -C "$(dirname "$SOURCE_DIR")" \
    "$(basename "$SOURCE_DIR")"

# Check if backup succeeded
if [ $? -eq 0 ]; then
    echo "Backup completed successfully!"
    echo "Location: ${BACKUP_DIR}/${BACKUP_NAME}"
    echo "Size: $(du -h "${BACKUP_DIR}/${BACKUP_NAME}" | cut -f1)"
else
    echo "Backup failed!"
    exit 1
fi

# Optional: Keep only last 7 backups
cd "$BACKUP_DIR"
ls -t backup_*.tar.gz | tail -n +8 | xargs -r rm

echo "Old backups cleaned up. Kept last 7 backups."
```

Usage:
```bash
chmod +x backup_directory.sh
./backup_directory.sh /path/to/source /path/to/backups
```

### Python Script Examples

**Question:** "How do I parse a log file and extract error messages in Python?"

**Claude Response:**
```python
Here's a Python script to extract errors from log files:

#!/usr/bin/env python3
"""
log_parser.py - Extract error messages from log files
"""

import re
import sys
from datetime import datetime
from collections import Counter

def parse_log_file(filename, pattern='ERROR'):
    """Parse log file and extract matching lines."""
    errors = []

    try:
        with open(filename, 'r') as f:
            for line_num, line in enumerate(f, 1):
                if pattern in line:
                    errors.append({
                        'line_number': line_num,
                        'timestamp': extract_timestamp(line),
                        'message': line.strip()
                    })
    except FileNotFoundError:
        print(f"Error: File not found: {filename}")
        sys.exit(1)
    except PermissionError:
        print(f"Error: Permission denied: {filename}")
        sys.exit(1)

    return errors

def extract_timestamp(line):
    """Extract timestamp from log line."""
    # Common log timestamp pattern
    pattern = r'\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}'
    match = re.search(pattern, line)
    return match.group(0) if match else "Unknown"

def analyze_errors(errors):
    """Analyze error patterns."""
    if not errors:
        print("No errors found!")
        return

    print(f"\n=== Found {len(errors)} errors ===\n")

    # Show first 10 errors
    for error in errors[:10]:
        print(f"Line {error['line_number']} [{error['timestamp']}]:")
        print(f"  {error['message']}\n")

    if len(errors) > 10:
        print(f"... and {len(errors) - 10} more errors\n")

    # Count unique error messages
    messages = [e['message'] for e in errors]
    counts = Counter(messages)

    print("=== Most common errors ===")
    for msg, count in counts.most_common(5):
        print(f"{count}x: {msg[:80]}...")

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python3 log_parser.py <logfile> [pattern]")
        print("Example: python3 log_parser.py /var/log/messages ERROR")
        sys.exit(1)

    logfile = sys.argv[1]
    pattern = sys.argv[2] if len(sys.argv) > 2 else 'ERROR'

    errors = parse_log_file(logfile, pattern)
    analyze_errors(errors)
```

Usage:
```bash
python3 log_parser.py /var/log/messages ERROR
python3 log_parser.py /var/log/secure "Failed password"
```

### SQL Query Examples

**Question:** "How do I query the Wazuh database for failed login attempts?"

**Claude Response:**
```sql
-- Query Wazuh alerts for failed authentication attempts
-- (This is an example query - actual schema may vary)

-- Failed SSH login attempts in last 24 hours
SELECT
    timestamp,
    agent_name,
    data->>'srcip' as source_ip,
    data->>'dstuser' as target_user,
    rule_description
FROM alert
WHERE
    rule_id IN ('5503', '5551', '5710')  -- SSH authentication failures
    AND timestamp >= NOW() - INTERVAL '24 hours'
ORDER BY timestamp DESC
LIMIT 100;

-- Count failed attempts by source IP
SELECT
    data->>'srcip' as source_ip,
    COUNT(*) as attempt_count,
    MIN(timestamp) as first_attempt,
    MAX(timestamp) as last_attempt
FROM alert
WHERE
    rule_id = '5710'  -- Multiple auth failures
    AND timestamp >= NOW() - INTERVAL '7 days'
GROUP BY data->>'srcip'
HAVING COUNT(*) > 5
ORDER BY attempt_count DESC;

-- Failed attempts by user
SELECT
    data->>'dstuser' as username,
    COUNT(*) as failed_attempts,
    COUNT(DISTINCT data->>'srcip') as unique_sources
FROM alert
WHERE
    rule_description LIKE '%authentication failure%'
    AND timestamp >= NOW() - INTERVAL '30 days'
GROUP BY data->>'dstuser'
ORDER BY failed_attempts DESC
LIMIT 20;
```

Note: Access to Wazuh database requires appropriate permissions.
Query the Wazuh dashboard interface instead if direct DB access unavailable.

## 15.4 Documentation Queries

### Finding Information in Manual

**Question:** "Where can I find information about password requirements?"

**Claude Response:**
```
Password requirements are documented in Chapter 7, Section 7.1:

Location:
/home/dshannon/Documents/User_Manual/Part_II_Getting_Started/Chapter_07_Password_Authentication.md

Key requirements:
- Minimum length: 15 characters
- Complexity: 3 of 4 categories (upper, lower, numbers, symbols)
- Expiration: 90 days
- History: Cannot reuse last 24 passwords
- No common patterns or personal info

Quick access:
less /home/dshannon/Documents/User_Manual/Part_II_Getting_Started/Chapter_07_Password_Authentication.md

Or search all documentation:
grep -r "password" /home/dshannon/Documents/User_Manual/
```

### Understanding Compliance Requirements

**Question:** "What does NIST 800-171 control AC.2.016 require?"

**Claude Response:**
```
NIST 800-171 Control AC.2.016:

Control: "Control remote access sessions"

Requirements:
1. Monitor all remote access sessions
2. Limit session timeouts
3. Require authentication for remote access
4. Encrypt remote access connections
5. Log remote access events

CyberHygiene Implementation:
- SSH for remote access (encrypted)
- MFA required for privileged users
- Session timeout: 15 minutes idle, 24 hours maximum
- All sessions logged via auditd and Wazuh
- Connection attempts from authorized networks only

Evidence:
- SSH configuration: /etc/ssh/sshd_config
- Audit logs: /var/log/secure, Wazuh dashboard
- MFA enrollment: FreeIPA records
- Session monitoring: Grafana dashboards

For complete details, see:
- Chapter 4, Section 4.1 (Security Baseline)
- Chapter 39 (NIST 800-171 Overview)
- SSP documentation in Compliance folder
```

### Procedure Explanations

**Question:** "Walk me through the incident response process"

**Claude Response:**
```
Incident Response Process (Overview):

Phase 1: DETECTION
- Automated alerts (Wazuh, Suricata, Prometheus)
- User reports
- Log analysis
- Anomaly detection

Phase 2: INITIAL ASSESSMENT (First 15 minutes)
1. Determine severity (Low/Medium/High/Critical)
2. Identify affected systems
3. Assess ongoing threat
4. Decide: contain now or investigate first?

Phase 3: CONTAINMENT (Next 1-4 hours)
- Isolate affected systems (firewall rules)
- Disable compromised accounts
- Block malicious IPs
- Preserve evidence (snapshots, logs)

Phase 4: INVESTIGATION (Parallel with containment)
- Gather logs and forensic data
- Timeline reconstruction
- Scope assessment
- Root cause analysis

Phase 5: ERADICATION
- Remove malware
- Close security gaps
- Patch vulnerabilities
- Rebuild systems if needed

Phase 6: RECOVERY
- Restore from backups
- Verify system integrity
- Re-enable services gradually
- Monitor for recurrence

Phase 7: POST-INCIDENT
- Document incident
- Lessons learned meeting
- Update procedures
- Improve controls

For detailed procedures, see Chapter 22: Incident Response.

Critical contacts:
- Security Team: security@cyberinabox.net
- System Admin: dshannon@cyberinabox.net
- Emergency: (See emergency contact card)
```

## 15.5 Best Practices

### Effective Communication with AI

**DO:**
- ✅ Be specific and clear
- ✅ Provide context (what you're trying to do)
- ✅ Include error messages (exact text)
- ✅ Ask follow-up questions
- ✅ Request examples or explanations

**DON'T:**
- ❌ Share passwords or sensitive data
- ❌ Paste CUI or classified information
- ❌ Assume AI can execute commands
- ❌ Use AI as only source for critical decisions
- ❌ Expect AI to remember across sessions

### Example Conversations

**Good Question:**
```
Me: I'm trying to mount the shared NFS export from dms.cyberinabox.net
to my local /mnt/shared directory using Kerberos authentication. I
ran "mount -t nfs dms:/exports/shared /mnt/shared" but got "access
denied". I have a valid Kerberos ticket (checked with klist). What
am I missing?

Claude: [Provides specific answer about missing -o sec=krb5 option]
```

**Poor Question:**
```
Me: mount doesn't work

Claude: [Has to ask many clarifying questions]
```

### When to Use AI vs. Human Support

**Use AI For:**
- ✅ Quick questions
- ✅ Command syntax
- ✅ Understanding concepts
- ✅ Finding documentation
- ✅ Learning new tools
- ✅ Non-urgent troubleshooting

**Use Human Support For:**
- ⚠️ Urgent issues
- ⚠️ Complex problems
- ⚠️ Account unlocks
- ⚠️ System failures
- ⚠️ Security incidents
- ⚠️ Policy exceptions

### Validating AI Responses

**Always Verify:**
- Critical commands before executing
- Security procedures
- Compliance requirements
- System configurations

**How to Verify:**
- Check official documentation
- Test in safe environment first
- Ask for references
- Consult with human expert for important decisions

**AI Can Be Wrong:**
- Information may be outdated
- May not know custom configurations
- Can misunderstand complex scenarios
- Use judgment and verify important information

---

**AI Assistant Summary:**

| Capability | Available | Notes |
|------------|-----------|-------|
| **24/7 Availability** | ✅ Yes | Always available via SSH |
| **System Knowledge** | ✅ Extensive | Knows CyberHygiene architecture |
| **Code Generation** | ✅ Yes | Scripts, queries, examples |
| **Troubleshooting** | ✅ Yes | Step-by-step guidance |
| **Documentation** | ✅ Yes | Can reference all manuals |
| **Command Execution** | ❌ No | Security restriction |
| **Data Access** | ❌ No | Privacy protection |
| **Conversation Memory** | ⚠️ Limited | Only current session |

**Best Uses:**
- Learning system features
- Understanding error messages
- Getting command syntax
- Finding documentation
- Troubleshooting workflows
- Generating code examples

**Limitations:**
- Cannot execute commands
- Cannot access your files
- Cannot make system changes
- May not know recent changes
- Requires verification for critical tasks

---

**Related Chapters:**
- Chapter 10: Getting Help & Support
- Chapter 5: Quick Reference Card
- Appendix C: Command Reference
- Appendix D: Troubleshooting Guide

**To Start Using Claude Code:**
```bash
ssh username@dc1.cyberinabox.net
claude
```

**Remember:**
- Claude is a tool to assist you, not replace human expertise
- Always verify critical information
- Don't share sensitive data in conversations
- Use human support for urgent or complex issues
- Provide feedback to help improve the system
