# OpenSCAP Automated Compliance Scanning System
## Reference System #1 — dc1.cyberinabox.net

**Report Date:** February 21, 2026  
**Systems Scanned:** 4 (dc1, labrat, engineering, accounting)  
**Compliance Status:** 100% (104/104 checks passed, 0 failures)

---

## Executive Summary

The OpenSCAP automated scanning system provides continuous NIST SP 800-171 Rev 2 compliance monitoring across all CyberHygiene Production Network (CPN) systems. This is the **first time in RS1 history** that all systems achieved 100% compliance simultaneously (February 21, 2026).

**Key Metrics (Feb 21, 2026):**
- **Overall Compliance:** 100% across all systems
- **Total Checks:** 104 (per system)
- **Failures:** 0
- **Systems:** 4 (dc1 + 3 workstations)
- **Scan Frequency:** Every 12 hours (local scans) + Daily collection at 06:00

---

## Automated Scanning Mechanism

### Architecture

The system uses a **two-tier approach**:

1. **Local Scanning (Each System)**
   - Systemd timer triggers scans every 12 hours
   - Results saved locally to `/var/www/html/openscap/`
   - HTML reports generated automatically

2. **Centralized Collection (dc1 only)**
   - Daily collection at 06:00 via SSH
   - Aggregates results from all systems
   - Generates consolidated dashboard
   - Publishes to `/var/www/internal-dashboards/openscap-dashboard.html`

### Systemd Units

#### Scanning Units (on each system)

**`openscap-cui-scan.timer`**
```ini
[Timer]
OnBootSec=15min        # First scan 15 min after boot
OnUnitActiveSec=12h    # Repeat every 12 hours
Persistent=true        # Catch up missed scans
```

**`openscap-cui-scan.service`**
```ini
[Service]
Type=oneshot
ExecStart=/var/www/cyberhygiene/scripts/openscap_cui_scan.sh
```

**Script:** `/var/www/cyberhygiene/scripts/openscap_cui_scan.sh`
- Runs `oscap xccdf eval` with CUI profile
- Generates HTML report
- Saves to `/var/www/html/openscap/cui_report_<hostname>_<date>.html`

#### Collection Units (dc1 only)

**`openscap-collect.timer`**
```ini
[Timer]
OnCalendar=*-*-* 06:00:00    # Daily at 06:00
Persistent=true
RandomizedDelaySec=300        # ±5 min randomization
```

**`openscap-collect.service`**
```ini
[Service]
Type=oneshot
ExecStart=/home/dshannon/scripts/collect_openscap_results.sh --collect-only
User=root
TimeoutStartSec=300
```

**Script:** `/home/dshannon/scripts/collect_openscap_results.sh`
- SSH to each CPN system as dshannon@hostname
- Download latest HTML reports via scp
- Generate consolidated summary (Markdown + JSON)
- Update `/var/www/internal-dashboards/openscap-dashboard.html`

---

## Current Status (February 21, 2026)

### System-by-System Results

| System | IP | Pass | Fail | N/A | Score | Report |
|--------|-----------|------|------|-----|-------|--------|
| **dc1** | 192.168.1.10 | 104 | 0 | 35 | **100%** | cui_report_dc1_20260221.html |
| **labrat** | 192.168.1.115 | 104 | 0 | 35 | **100%** | cui_report_labrat_20260221.html |
| **engineering** | 192.168.1.104 | 104 | 0 | 35 | **100%** | cui_report_engineering_20260221.html |
| **accounting** | 192.168.1.113 | 104 | 0 | 35 | **100%** | cui_report_accounting_20260221.html |

**All Systems:** ✓ 104 checks passed, 0 failures

### Failed Rules

*No failed rules detected across any system.*

This is the **benchmark achievement** for RS1 — the first time all systems passed all checks simultaneously.

---

## Files in This Package

### Reports Directory (`reports/`)

1. **`cui_report_dc1_20260221.html`** (1.7 MB)
   - dc1.cyberinabox.net compliance report
   - 104/104 checks passed

2. **`cui_report_labrat_20260221.html`** (1.6 MB)
   - labrat.cyberinabox.net compliance report
   - 104/104 checks passed

3. **`cui_report_engineering_20260221.html`** (1.6 MB)
   - engineering.cyberinabox.net compliance report
   - 104/104 checks passed

4. **`cui_report_accounting_20260221.html`** (1.6 MB)
   - accounting.cyberinabox.net compliance report
   - 104/104 checks passed

### Systemd Units Directory (`systemd-units/`)

1. **`openscap-cui-scan.service`** - Local scan service
2. **`openscap-cui-scan.timer`** - 12-hour scan timer
3. **`openscap-collect.service`** - Central collection service
4. **`openscap-collect.timer`** - Daily 06:00 collection timer

### Root Directory

1. **`CUI_Compliance_Summary_20260221.md`** - Markdown summary
2. **`openscap-dashboard.html`** - Interactive HTML dashboard
3. **`README_OpenSCAP_Automation.md`** - This file

---

## Deployment to RS2 (SecureMac / diwai.org)

### Prerequisites

- OpenSCAP scanner installed on Rocky Linux VM
- SSH access configured (dshannon@hostname with key auth)
- Apache web server with `/var/www/internal-dashboards/` configured
- SCAP Security Guide (SSG) package installed

### Installation Steps

#### 1. Install OpenSCAP on Rocky VM

```bash
# On RS2 Rocky Linux VM
sudo dnf install -y openscap-scanner scap-security-guide

# Verify installation
oscap --version
```

#### 2. Deploy Systemd Units

```bash
# Copy unit files to RS2
sudo cp systemd-units/openscap-cui-scan.* /etc/systemd/system/
sudo cp systemd-units/openscap-collect.* /etc/systemd/system/

# Reload systemd
sudo systemctl daemon-reload

# Enable and start timers
sudo systemctl enable --now openscap-cui-scan.timer
sudo systemctl enable --now openscap-collect.timer

# Verify timers are active
systemctl list-timers | grep openscap
```

#### 3. Create Scan Script

```bash
# Create script directory
sudo mkdir -p /var/www/cyberhygiene/scripts
sudo cp /path/to/openscap_cui_scan.sh /var/www/cyberhygiene/scripts/
sudo chmod +x /var/www/cyberhygiene/scripts/openscap_cui_scan.sh
```

#### 4. Create Output Directories

```bash
# Create local output directory
sudo mkdir -p /var/www/html/openscap
sudo chown apache:apache /var/www/html/openscap

# Create centralized dashboard directory
sudo mkdir -p /var/www/internal-dashboards/openscap
sudo chown apache:apache /var/www/internal-dashboards/openscap
```

#### 5. Configure Collection Script

```bash
# Copy collection script
cp /path/to/collect_openscap_results.sh ~/scripts/
chmod +x ~/scripts/collect_openscap_results.sh

# Edit for RS2 environment:
vi ~/scripts/collect_openscap_results.sh

# Update SYSTEMS array for RS2:
# SYSTEMS=("diwai-services" "rs2-workstation1" ...)

# Update SSH keys and paths as needed
```

#### 6. Test Manual Scan

```bash
# Run manual scan
sudo /var/www/cyberhygiene/scripts/openscap_cui_scan.sh

# Check output
ls -lh /var/www/html/openscap/

# View report in browser:
# https://diwai.org/openscap/cui_report_<hostname>_<date>.html
```

#### 7. Test Collection

```bash
# Run manual collection
~/scripts/collect_openscap_results.sh

# Check dashboard
ls -lh /var/www/internal-dashboards/openscap-dashboard.html

# View dashboard:
# https://diwai.org/internal-dashboards/openscap-dashboard.html
```

---

## RS2 Adaptation Notes

### Architectural Differences

| Component | RS1 | RS2 |
|-----------|-----|-----|
| Host OS | Rocky Linux 9.7 (bare metal) | macOS Tahoe (host) |
| Services | Rocky Linux 9.7 (native) | Rocky Linux 9.7 (UTM VM) |
| Scans Run On | Native OS | VM only (not macOS host) |
| Systems Count | 4 (dc1 + 3 WS) | TBD (VM + workstations?) |

### Required Modifications

1. **System List**
   - RS1: dc1, labrat, engineering, accounting
   - RS2: Update to match RS2 architecture
   - Consider: Does RS2 scan macOS host separately?

2. **SSH Configuration**
   - RS1: dshannon@192.168.1.x with ECDSA-521 key
   - RS2: Verify SSH access from VM to target systems
   - May need UTM networking configuration

3. **macOS Host Scanning**
   - OpenSCAP does NOT scan macOS
   - Use **mSCP** (macOS Security Compliance Project) instead
   - Reference: NIST SP 800-219 profile
   - See RS2 SSP v1.2 for mSCP implementation

4. **File Paths**
   - RS1: `/var/www/` on bare metal
   - RS2: `/var/www/` inside UTM VM
   - Ensure Apache in VM is configured correctly

---

## Monitoring and Troubleshooting

### Check Timer Status

```bash
# List all timers
systemctl list-timers

# Check specific timer
systemctl status openscap-cui-scan.timer
systemctl status openscap-collect.timer

# View timer logs
journalctl -u openscap-cui-scan.timer -n 50
journalctl -u openscap-collect.timer -n 50
```

### Check Service Status

```bash
# Check last scan execution
systemctl status openscap-cui-scan.service
journalctl -u openscap-cui-scan.service -n 100

# Check last collection
systemctl status openscap-collect.service
journalctl -u openscap-collect.service -n 100
```

### Manual Execution

```bash
# Trigger scan manually
sudo systemctl start openscap-cui-scan.service

# Trigger collection manually
sudo systemctl start openscap-collect.service

# Or run scripts directly:
sudo /var/www/cyberhygiene/scripts/openscap_cui_scan.sh
~/scripts/collect_openscap_results.sh
```

### Common Issues

**Scan service fails:**
- Check SSG package installed: `rpm -qa | grep scap-security-guide`
- Verify profile path: `/usr/share/xml/scap/ssg/content/`
- Check permissions on output directory
- Review journalctl logs

**Collection service fails:**
- Verify SSH key authentication works
- Check dshannon user exists on target systems
- Verify target systems have reports available
- Check SSH config and firewall rules

**Dashboard not updating:**
- Check Apache serving `/var/www/internal-dashboards/`
- Verify file permissions (apache:apache ownership)
- Check SELinux context if enabled
- Review Apache error logs

---

## Integration with POA&M

The OpenSCAP automated scanning directly supports:

- **POA&M-011:** Security Control Assessment (3.12.1)
  - Automated 12-hour scans = continuous assessment
  - Centralized dashboard = management visibility
  - HTML reports = audit evidence

- **SPRS Calculation:** OpenSCAP 100% = baseline for control verification
  - 104/104 checks = all automated controls MET
  - Failed checks = POA&M items
  - Trending = progress tracking

---

## Historical Context

**First 100% Achievement:** February 21, 2026

This milestone coincided with:
- MFA deployment completion (POA&M-004)
- SSH hardening (dshannon+sudo, PermitRootLogin no)
- Login banner updates (CyberHygiene Project CIS notice)
- Session lock configuration (15 min timeout)
- USBGuard deployment on all workstations

**Previous Status:**
- December 2025: Some systems had 1-2 failures
- January 2026: Incremental improvements
- February 15-21: Final remediation push
- February 21: First simultaneous 100% across all systems

---

## Related Documentation

**On M.2 Drive:**
- `Session_Notes/RS1_Status_Comparison.md` - Current status analysis
- `Session_Notes/Manuscript_Update_Checklist.md` - Documentation updates
- `RS2_Deployment/scripts/` - Collection and scanning scripts
- `RS2_Deployment/dashboards/` - Dashboard HTML

**On RS1 (/home/dshannon/CyberSecurity/):**
- `Current/Assessments/OpenSCAP/` - All historical reports
- `Current/POAM/Unified_POAM_v2.11.md` - POA&M with assessment reference
- `Current/SSP/SSP_v2.9_Update_Requirements.md` - SSP updates

**On APFS USB Drive:**
- Manuscript Chapter 5: RS1 Status (needs OpenSCAP count correction)
- Manuscript Chapter 4: RS1 Architecture (needs OpenSCAP count correction)

---

## Version History

**February 21, 2026 Reports:**
- First simultaneous 100% compliance across all CPN systems
- 104/104 checks passed (0 failures) on all 4 systems
- POA&M v2.11 reflects completion of gap remediation
- SPRS score 106/110 (OpenSCAP validates 103 automated controls)

---

*Package prepared: 2026-04-26 by Claude Code*  
*Source: dc1.cyberinabox.net OpenSCAP automation system*  
*Reports Date: 2026-02-21 (latest 100% compliant scan)*
