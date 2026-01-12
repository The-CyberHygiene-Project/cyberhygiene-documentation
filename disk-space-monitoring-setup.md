# Disk Space Monitoring Setup

**Server:** dc1.cyberinabox.net
**Date Configured:** 2026-01-10
**Administrator:** don@contract-coach.com

## Overview

A comprehensive disk space monitoring system has been configured to prevent future disk space emergencies. The system monitors all critical partitions and sends alerts when usage exceeds defined thresholds.

## Components

### 1. Monitoring Script

**Location:** `/usr/local/bin/check-disk-space.sh`

**Features:**
- Monitors all critical partitions (/var, /var/log, /, /home, /data, /backup)
- Configurable warning (80%) and critical (90%) thresholds
- Email alerts via Postfix/sendmail
- Logging to `/var/log/disk-alerts.log`
- Integration with syslog and Wazuh
- Manual report generation capability

**Configuration Variables:**
```bash
ADMIN_EMAIL="don@contract-coach.com"
WARNING_THRESHOLD=80
CRITICAL_THRESHOLD=90
ALERT_LOG="/var/log/disk-alerts.log"
```

### 2. Monitoring Schedule

#### Cron Job
**File:** `/etc/cron.d/disk-space-monitor`

**Schedule:**
- Hourly checks: Every hour on the hour
- Daily reports: 8:00 AM daily

**Logs:**
- Hourly: `/var/log/disk-monitor-cron.log`
- Daily: `/var/log/disk-monitor-daily.log`

#### Systemd Timer (Backup/Modern Alternative)
**Files:**
- Service: `/etc/systemd/system/disk-space-monitor.service`
- Timer: `/etc/systemd/system/disk-space-monitor.timer`

**Status:** Active and enabled
**Schedule:** Hourly with 5-minute randomized delay

### 3. Wazuh Integration

**Rules File:** `/var/ossec/etc/rules/local_rules.xml`

**Rule IDs:**
- 100400: Disk space warning (Level 7)
- 100401: Disk space critical (Level 12, email alert)
- 100402: No space left on device (Level 10, email alert)

### 4. Email Alerting

**Mail Server:** Postfix (active)
**Recipient:** don@contract-coach.com
**Alert Types:**
- **WARNING:** Sent when partition exceeds 80% usage
- **CRITICAL:** Sent when partition exceeds 90% usage
- **TEST:** Manual test alert capability

## Monitored Partitions

| Partition | Size | Current Usage | Status |
|-----------|------|---------------|--------|
| /var | 30GB | ~60% (18GB) | OK |
| /var/log | 15GB | ~77% (12GB) | OK |
| / | 90GB | ~24% (22GB) | OK |
| /home | 239GB | ~3% (6GB) | OK |
| /data | 350GB | ~4% (14GB) | OK |
| /backup | 931GB | ~1% (8GB) | OK |

## Alert Thresholds

### Warning Level (80%)
- **Action:** Email alert sent
- **Urgency:** Monitor and plan cleanup
- **Recipient:** don@contract-coach.com

### Critical Level (90%)
- **Action:** High-priority email alert sent
- **Urgency:** Immediate action required
- **Recipient:** don@contract-coach.com
- **Additional:** Logged to Wazuh for tracking

## Manual Operations

### Run Manual Check
```bash
sudo /usr/local/bin/check-disk-space.sh
```

### Generate Full Report
```bash
sudo /usr/local/bin/check-disk-space.sh --report
```

### Send Test Alert
```bash
sudo /usr/local/bin/check-disk-space.sh --test
```

### View Alert Log
```bash
sudo tail -f /var/log/disk-alerts.log
```

### Check Timer Status
```bash
systemctl status disk-space-monitor.timer
systemctl list-timers disk-space-monitor.timer
```

### View Cron Logs
```bash
sudo tail -f /var/log/disk-monitor-cron.log
sudo tail -f /var/log/disk-monitor-daily.log
```

## Troubleshooting

### Email Alerts Not Received

1. **Check Postfix Status:**
   ```bash
   systemctl status postfix
   ```

2. **Test Email:**
   ```bash
   echo "Test" | mail -s "Test Email" don@contract-coach.com
   ```

3. **Check Mail Queue:**
   ```bash
   mailq
   ```

4. **View Mail Logs:**
   ```bash
   sudo tail -f /var/log/maillog
   ```

### Script Not Running

1. **Check Cron Service:**
   ```bash
   systemctl status crond
   ```

2. **Check Timer Status:**
   ```bash
   systemctl status disk-space-monitor.timer
   ```

3. **Verify Script Permissions:**
   ```bash
   ls -l /usr/local/bin/check-disk-space.sh
   # Should be: -rwxr-xr-x root root
   ```

4. **Check Cron Permissions:**
   ```bash
   ls -l /etc/cron.d/disk-space-monitor
   # Should be: -rw-r--r-- root root
   ```

### Wazuh Alerts Not Appearing

1. **Verify Rules Loaded:**
   ```bash
   sudo /var/ossec/bin/wazuh-logtest
   # Then paste a test log entry
   ```

2. **Check Wazuh Status:**
   ```bash
   systemctl status wazuh-manager
   ```

3. **View Wazuh Logs:**
   ```bash
   sudo tail -f /var/ossec/logs/ossec.log
   ```

## Maintenance

### Adjusting Thresholds

Edit `/usr/local/bin/check-disk-space.sh`:
```bash
WARNING_THRESHOLD=80   # Change as needed
CRITICAL_THRESHOLD=90  # Change as needed
```

### Adding Additional Partitions

Edit the MONITORED_PARTITIONS array in `/usr/local/bin/check-disk-space.sh`:
```bash
MONITORED_PARTITIONS=(
    "/var"
    "/var/log"
    "/"
    "/home"
    "/data"
    "/backup"
    "/new/partition"  # Add new partitions here
)
```

### Changing Alert Email

Edit `/usr/local/bin/check-disk-space.sh`:
```bash
ADMIN_EMAIL="new-email@example.com"
```

### Changing Check Frequency

**For Cron:**
Edit `/etc/cron.d/disk-space-monitor` and modify the schedule

**For Systemd Timer:**
Edit `/etc/systemd/system/disk-space-monitor.timer` and modify `OnCalendar=` value, then:
```bash
sudo systemctl daemon-reload
sudo systemctl restart disk-space-monitor.timer
```

## Log Rotation

The monitoring system generates several log files. Consider setting up log rotation:

**File:** `/etc/logrotate.d/disk-monitor`
```
/var/log/disk-alerts.log
/var/log/disk-monitor-cron.log
/var/log/disk-monitor-daily.log {
    daily
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
    create 0640 root root
}
```

## Recovery Actions

If a critical alert is received:

1. **Immediate Assessment:**
   ```bash
   df -h
   sudo du -sh /var/* | sort -hr | head -20
   ```

2. **Quick Wins:**
   ```bash
   # Clean package cache
   sudo dnf clean all

   # Remove old logs
   sudo journalctl --vacuum-time=7d

   # Find and review large files
   sudo find /var -type f -size +100M -exec ls -lh {} \;
   ```

3. **Long-term Solutions:**
   - Move large directories to /data or /backup (as done with OpenSearch)
   - Set up log rotation for application logs
   - Archive old data to backup partitions
   - Expand partition if consistently high usage

## Integration Points

### Grafana Dashboard
Consider adding disk space metrics to Grafana:
- Data source: Node Exporter or direct system metrics
- Alert channels: Link to existing email/Slack

### Wazuh Dashboard
- View alerts in Wazuh UI under "Security Events"
- Filter by rule ID: 100400, 100401, 100402
- Create custom dashboard for disk space trends

## Recent Changes

### 2026-01-10
- Initial setup completed
- OpenSearch moved to /data (freed 11GB on /var)
- Monitoring system deployed and tested
- Test alert successfully sent to don@contract-coach.com

## Contact

**System Administrator:** don@contract-coach.com
**Monitoring Alerts:** don@contract-coach.com
**Server:** dc1.cyberinabox.net (192.168.1.10)

## Files Reference

### Configuration Files
- `/usr/local/bin/check-disk-space.sh` - Main monitoring script
- `/etc/cron.d/disk-space-monitor` - Cron schedule
- `/etc/systemd/system/disk-space-monitor.service` - Systemd service
- `/etc/systemd/system/disk-space-monitor.timer` - Systemd timer
- `/var/ossec/etc/rules/local_rules.xml` - Wazuh rules (lines with disk_space group)

### Log Files
- `/var/log/disk-alerts.log` - Alert history
- `/var/log/disk-monitor-cron.log` - Cron execution log
- `/var/log/disk-monitor-daily.log` - Daily report log
- `/var/log/maillog` - Email delivery log

### Lock Files
- `/var/run/disk-monitor.lock` - Prevents multiple concurrent executions
