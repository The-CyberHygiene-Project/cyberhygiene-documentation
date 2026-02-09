#!/bin/bash
# System Status Updater - Runs as root via cron to update status JSON
# Writes to /var/www/html/dashboard/status.json

STATUS_FILE="/var/www/internal-dashboards/status.json"
mkdir -p /var/www/internal-dashboards

# Helper functions
is_active() {
    systemctl is-active "$1" >/dev/null 2>&1 && echo "true" || echo "false"
}

get_status() {
    local result
    result=$(systemctl is-active "$1" 2>/dev/null)
    echo "${result:-unknown}"
}

# Get FreeIPA info (parse output regardless of exit code)
ipa_output=$(/usr/sbin/ipactl status 2>&1)
ipa_running=$(echo "$ipa_output" | grep -c "RUNNING")
ipa_total=$(echo "$ipa_output" | grep -c "Service:")
ipa_ok=$( [ "$ipa_running" -gt 0 ] && echo "true" || echo "false" )

# Get storage info
if mountpoint -q /datastore 2>/dev/null; then
    ds_info=$(df -h /datastore --output=size,used,avail,pcent 2>/dev/null | tail -1)
    ds_size=$(echo "$ds_info" | awk '{print $1}')
    ds_used=$(echo "$ds_info" | awk '{print $2}')
    ds_avail=$(echo "$ds_info" | awk '{print $3}')
    ds_pct=$(echo "$ds_info" | awk '{print $4}')
    ds_mounted="true"
else
    ds_size="N/A"
    ds_used="N/A"
    ds_avail="N/A"
    ds_pct="N/A"
    ds_mounted="false"
fi

# Check RAID
raid_exists=$(grep -q "active" /proc/mdstat 2>/dev/null && echo "true" || echo "false")

# Count LUKS volumes
luks_count=$(lsblk -o TYPE 2>/dev/null | grep -c crypt)

# System info
sys_uptime=$(uptime -p 2>/dev/null | sed 's/up //')
sys_fips=$(fips-mode-setup --check 2>&1 | grep -qi "enabled" && echo "true" || echo "false")
sys_selinux=$(getenforce 2>/dev/null || echo "Unknown")
sys_kernel=$(uname -r)

# Count running services
svc_count=0
for svc in postfix dovecot smb nmb wazuh-manager graylog-server grafana-server prometheus opensearch mongod httpd auditd firewalld; do
    systemctl is-active "$svc" >/dev/null 2>&1 && ((svc_count++))
done
# Add FreeIPA if running
[ "$ipa_running" -gt 0 ] && ((svc_count++))

# Generate JSON
cat > "$STATUS_FILE" << ENDJSON
{
  "timestamp": "$(date -Iseconds)",
  "services": {
    "postfix": {"running": $(is_active postfix), "status": "$(get_status postfix)"},
    "dovecot": {"running": $(is_active dovecot), "status": "$(get_status dovecot)"},
    "samba_smb": {"running": $(is_active smb), "status": "$(get_status smb)"},
    "samba_nmb": {"running": $(is_active nmb), "status": "$(get_status nmb)"},
    "wazuh": {"running": $(is_active wazuh-manager), "status": "$(get_status wazuh-manager)"},
    "freeipa": {"running": ${ipa_ok}, "services_up": ${ipa_running}, "services_total": ${ipa_total}},
    "graylog": {"running": $(is_active graylog-server), "status": "$(get_status graylog-server)"},
    "grafana": {"running": $(is_active grafana-server), "status": "$(get_status grafana-server)"},
    "prometheus": {"running": $(is_active prometheus), "status": "$(get_status prometheus)"},
    "opensearch": {"running": $(is_active opensearch), "status": "$(get_status opensearch)"},
    "mongodb": {"running": $(is_active mongod), "status": "$(get_status mongod)"},
    "httpd": {"running": $(is_active httpd), "status": "$(get_status httpd)"},
    "auditd": {"running": $(is_active auditd), "status": "$(get_status auditd)"},
    "firewalld": {"running": $(is_active firewalld), "status": "$(get_status firewalld)"},
    "yara": {"running": true, "status": "integrated"}
  },
  "storage": {
    "datastore": {"mounted": ${ds_mounted}, "size": "${ds_size}", "used": "${ds_used}", "available": "${ds_avail}", "percent": "${ds_pct}"},
    "raid": {"exists": ${raid_exists}},
    "luks_volumes": ${luks_count}
  },
  "system": {
    "uptime": "${sys_uptime}",
    "fips_enabled": ${sys_fips},
    "selinux": "${sys_selinux}",
    "kernel": "${sys_kernel}"
  },
  "summary": {
    "services_running": ${svc_count},
    "services_total": 14,
    "storage_ok": ${ds_mounted}
  }
}
ENDJSON

chmod 644 "$STATUS_FILE"
chown apache:apache "$STATUS_FILE" 2>/dev/null || true
