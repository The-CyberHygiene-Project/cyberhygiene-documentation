# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains documentation and configuration for a **NIST 800-171 compliant FreeIPA Domain Controller** running on Rocky Linux 9.6.

**SECURITY NOTE:** This file previously contained actual passwords. All credentials have been removed and rotated as of January 1, 2026.

## Important Security Notes

⚠️ **NEVER COMMIT ACTUAL PASSWORDS TO GIT** ⚠️

- **Directory Manager Password:** [REDACTED - Stored in KeePass]
  - Required for CA cert operations, LDAP administrative tasks
  - Cannot be easily reset - backup securely in password manager

- **IPA Admin Password:** [REDACTED - Stored in KeePass]
  - Required for FreeIPA administrative tasks
  - Rotate every 90 days per policy

- **LUKS Passphrases:** [REDACTED - Stored in KeePass]
  - If lost, data is unrecoverable - maintain secure backups
  - Never commit to version control

- **CA Certificate:** `/root/cacert.p12` [REDACTED - Password in KeePass]
  - Must be backed up to secure offline location

- **Commercial SSL Certificate:** Installed 2025-12-10
  - Certificate: SSL.com wildcard (*.cyberinabox.net)
  - Expires: October 28, 2026
  - Private key password: [REDACTED - Stored in KeePass]

## Password Management Best Practices

1. **Use KeePass or similar password manager** for all credentials
2. **Never commit passwords to Git repositories**
3. **Use placeholder text** like `[REDACTED]`, `[PASSWORD_HERE]`, or `[STORED_IN_KEEPASS]` in documentation
4. **Rotate credentials immediately** if accidentally committed
5. **Use `.gitignore`** to prevent committing sensitive files

## Sensitive Files to Exclude from Git

Add these patterns to `.gitignore`:

```
# Credentials and secrets
*password*
*secret*
*token.txt
*api-key*
*.key
*.pem
*.p12
*.pfx

# Configuration with embedded credentials
**/config/*credentials*
**/.env
**/.env.*
```

---

**For complete FreeIPA documentation, see:**
- User Manual: `/home/dshannon/Documents/User_Manual/`
- Operations Guides: `/home/dshannon/Documents/Operations_Guides/`
- Setup Guides: `/home/dshannon/Documents/Setup_Guides/`

**For credential storage:**
- KeePass database: [Location specified by administrator]
- Backup encryption keys: Secure offline storage only
- Never in Git repositories
