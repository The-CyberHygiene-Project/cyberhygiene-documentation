# Git Security Best Practices

**Created:** January 1, 2026
**Purpose:** Prevent accidental credential exposure in Git repositories
**Lesson Learned:** Even invalid credentials create security incidents

---

## 🚨 The Problem We Encountered

On January 1, 2026, we discovered that files containing credential-like information were committed to the public GitHub repository. While most credentials turned out to be invalid, this was a **process failure** that could have been serious.

**Files Exposed:**
- `Claude/CLAUDE.md` - Contained password placeholders
- `Claude/MFA_Configuration/dshannon_otp_token.txt` - MFA token template
- `Claude/Anti-Malware/Virus Total API` - API credentials
- `Certification and Compliance Evidence/back-up Key` - Encryption key

---

## ✅ Safeguards Now in Place

### 1. Enhanced .gitignore

**Location:** `/home/dshannon/Documents/.gitignore`

**Key Features:**
- Blocks files with "password", "secret", "credential", "token" in names
- Blocks specific files from the incident
- Explicit allow-list for safe documentation (no blanket `!*.md`)
- Pre-commit checklist reminder

### 2. Pre-Commit Hook (Secret Scanner)

**Location:** `/home/dshannon/Documents/.git/hooks/pre-commit`

**What It Does:**
- Scans all files being committed for potential secrets
- Checks for patterns like `password=`, `api_key=`, private keys
- Blocks forbidden filenames
- Prevents commit if secrets detected

**Test It:**
```bash
# Try to commit a file with a password (should be blocked)
echo "password=test123" > test.txt
git add test.txt
git commit -m "test"  # Will be BLOCKED by pre-commit hook
```

---

## 📋 Pre-Commit Checklist (Manual)

**BEFORE EVERY `git commit`:**

### Step 1: Review What You're Committing
```bash
git status
```
- ✅ Check: Are any unexpected files listed?
- ✅ Check: Any files with "password", "secret", "key" in name?

### Step 2: Inspect Changes
```bash
git diff --cached
```
- ✅ Read through EVERY changed line
- ✅ Look for: passwords, API keys, IP addresses, usernames
- ✅ Look for: connection strings, database credentials

### Step 3: Verify No Secrets
```bash
# Search for common secret patterns in staged files
git diff --cached | grep -iE "(password|secret|api.?key|token)"
```
- ✅ If this returns results, investigate!

### Step 4: Commit Safely
```bash
git commit -m "Descriptive message"
```
- ✅ Pre-commit hook will scan automatically
- ✅ If blocked, remove secrets before retrying

---

## 🔐 Where to Store Credentials

### ❌ NEVER Store Here:
- Git repositories (public OR private)
- Documentation files committed to Git
- Configuration files committed to Git
- Email
- Slack/Teams messages
- Unencrypted text files

### ✅ ALWAYS Store Here:

**Option 1: Password Manager (Recommended)**
```bash
# Install KeePassXC
sudo dnf install keepassxc

# Create encrypted database
keepassxc
# File → New Database → Set master password
# Add entries for each credential
```

**Option 2: Encrypted Files on System**
```bash
# Create encrypted file
gpg -c /root/passwords.txt
# Enter strong passphrase
# Original file deleted automatically

# To view later:
gpg -d /root/passwords.txt.gpg
```

**Option 3: Physical Storage**
- Print passwords and store in locked safe/filing cabinet
- Use for disaster recovery scenarios
- Store offsite backup in secure location

**Option 4: Environment Variables (For Scripts)**
```bash
# In ~/.bashrc or script:
export DB_PASSWORD="[load from secure location]"
export API_KEY="[load from secure location]"

# Never commit these to Git!
```

---

## 📝 Safe Documentation Practices

### Use Placeholders in Documentation

**❌ BAD:**
```markdown
## Database Connection
Username: admin
Password: MySecretP@ss123
Server: 192.168.1.50
```

**✅ GOOD:**
```markdown
## Database Connection
Username: [STORED_IN_KEEPASS]
Password: [STORED_IN_KEEPASS]
Server: [INTERNAL_IP - See Network Diagram]
```

### Template Files

**Create `-template` or `-example` versions:**

**Example:** `.env.template`
```bash
# Copy this to .env and fill in actual values
# .env is in .gitignore and will NOT be committed

DB_PASSWORD=[YOUR_PASSWORD_HERE]
API_KEY=[YOUR_API_KEY_HERE]
```

**Then in .gitignore:**
```
.env
!.env.template
```

---

## 🔍 Regular Security Audits

### Monthly Check (1st of Every Month)

**1. Scan Repository for Exposed Secrets**
```bash
cd /home/dshannon/Documents

# Search for potential secrets in all files
grep -r -i "password\s*=" . 2>/dev/null | grep -v ".git"
grep -r -i "api.?key\s*=" . 2>/dev/null | grep -v ".git"

# Check for files that shouldn't be tracked
git ls-files | grep -i "password\|secret\|credential"
```

**2. Review .gitignore Effectiveness**
```bash
# Check if any ignored files are being tracked
git ls-files -i --exclude-standard
```

**3. Verify Pre-Commit Hook is Active**
```bash
ls -l .git/hooks/pre-commit
# Should show: -rwxr-xr-x (executable)
```

---

## 🚑 Emergency Response: "I Committed Secrets!"

### If You Haven't Pushed Yet:

**Option 1: Amend the Commit**
```bash
# Remove the file
git rm --cached path/to/secret/file

# Add to .gitignore
echo "path/to/secret/file" >> .gitignore

# Amend the commit
git commit --amend -m "Fixed commit message"
```

**Option 2: Reset the Commit**
```bash
# Undo the commit (keeps changes in working directory)
git reset HEAD~1

# Fix the issue, then commit properly
```

### If You Already Pushed:

**🚨 CRITICAL - Follow These Steps Immediately:**

1. **Rotate ALL exposed credentials** (assume compromised)
2. **Remove from Git history** (use `git-filter-repo`)
3. **Force push** to overwrite remote history
4. **Notify team** to re-clone repository
5. **Document incident** for compliance

**See:** `/root/SECURITY_INCIDENT_SUMMARY.txt` for our example

---

## 🎓 Training Reminder

**For All Team Members:**

1. **Never commit secrets** - When in doubt, don't commit
2. **Use placeholders** in documentation
3. **Check before pushing** - Review `git diff` carefully
4. **Trust the tools** - Pre-commit hooks are your friend
5. **Report incidents** - If you commit secrets, report immediately

**Remember:** Even INVALID credentials create security incidents and audit findings. The process failure is the problem, not just the exposure.

---

## 📚 Additional Resources

- **Git Documentation:** https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
- **git-filter-repo:** https://github.com/newren/git-filter-repo
- **KeePassXC:** https://keepassxc.org/docs/
- **NIST 800-171 Controls:** SC-28 (Protection of Information at Rest)

---

## ✅ Quick Reference

**Before Commit:**
```bash
git status          # What am I committing?
git diff --cached   # What changed?
```

**After Incident:**
```bash
git-filter-repo --path path/to/file --invert-paths --force
git push origin --force --all
```

**Password Storage:**
```bash
keepassxc  # Launch password manager
```

---

**Last Updated:** January 1, 2026
**Next Review:** February 1, 2026
