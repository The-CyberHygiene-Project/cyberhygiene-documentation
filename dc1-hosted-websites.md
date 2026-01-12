# DC1 Hosted Websites

**Server:** dc1.cyberinabox.net (192.168.1.10)
**Date:** 2026-01-07 (Updated: 2026-01-11)

## Public-Facing Websites

### 1. CyberHygiene Project Website
- **URL:** https://cyberinabox.net
- **Aliases:** https://www.cyberinabox.net
- **Description:** Main CyberHygiene Project website
- **Document Root:** `/var/www/cyberhygiene`
- **Special Features:**
  - AI API proxy at `/ai-api` → http://ai.cyberinabox.net:11434
  - Aider API proxy at `/aider-api` → http://127.0.0.1:5001
- **Configuration:** `/etc/httpd/conf.d/cyberhygiene.conf`

#### CyberHygiene Website Pages

The following HTML pages are hosted on the main CyberHygiene website:

1. **Home Page**
   - **URL:** https://cyberinabox.net/index.html
   - **Title:** The CyberHygiene Project | Affordable NIST 800-171 Compliance
   - **File:** `/var/www/cyberhygiene/index.html`

2. **Control Center / Switchboard**
   - **URL:** https://cyberinabox.net/switchboard.html
   - **Title:** CyberHygiene Control Center
   - **Description:** Central navigation hub for all dashboards and tools
   - **File:** `/var/www/cyberhygiene/switchboard.html`

3. **CPM System Status Dashboard**
   - **URL:** https://cyberinabox.net/cpm-dashboard.html
   - **Title:** CPM System Status Dashboard - dc1.cyberinabox.net
   - **File:** `/var/www/cyberhygiene/cpm-dashboard.html`

4. **Legacy System Status Dashboard**
   - **URL:** https://cyberinabox.net/System_Status_Dashboard.html
   - **Title:** CPM System Status Dashboard - cyberinabox.net
   - **File:** `/var/www/cyberhygiene/System_Status_Dashboard.html`

5. **AI Administration Dashboard**
   - **URL:** https://cyberinabox.net/ai-dashboard.html
   - **Title:** CyberHygiene AI System Administration Dashboard
   - **Description:** AI-powered system administration interface
   - **File:** `/var/www/cyberhygiene/ai-dashboard.html`

6. **Workstation Monitoring Dashboard**
   - **URL:** https://cyberinabox.net/monitoring-dashboard.html
   - **Title:** Workstation Monitoring Dashboard - CyberHygiene Project
   - **File:** `/var/www/cyberhygiene/monitoring-dashboard.html`

7. **Cybersecurity Policy Index**
   - **URL:** https://cyberinabox.net/Policy_Index.html
   - **Title:** The Contract Coach - Cybersecurity Policy Index
   - **Description:** NIST 800-171 and CMMC policy documentation
   - **File:** `/var/www/cyberhygiene/Policy_Index.html`

8. **Legacy Policy Index**
   - **URL:** https://cyberinabox.net/policy-index.html
   - **Title:** Cybersecurity Policy Index - CyberHygiene Project
   - **File:** `/var/www/cyberhygiene/policy-index.html`

9. **Navigation Menu**
   - **URL:** https://cyberinabox.net/nav-menu.html
   - **Description:** Site navigation component
   - **File:** `/var/www/cyberhygiene/nav-menu.html`

10. **AI Connection Test**
    - **URL:** https://cyberinabox.net/test-ai.html
    - **Title:** AI Connection Test
    - **Description:** Testing page for AI API connectivity
    - **File:** `/var/www/cyberhygiene/test-ai.html`

### 2. Grafana Monitoring Dashboard
- **URL:** https://grafana.cyberinabox.net
- **Description:** Grafana monitoring and analytics platform
- **Backend:** Proxies to localhost:3001
- **Features:** WebSocket support for live features
- **Configuration:** `/etc/httpd/conf.d/grafana.conf`

### 3. Redmine Project Management
- **URL:** https://projects.cyberinabox.net
- **Description:** Redmine project management system
- **Backend:** Proxies to localhost:3000
- **Configuration:** `/etc/httpd/conf.d/redmine.conf`

### 4. Roundcube Webmail
- **URL:** https://webmail.cyberinabox.net
- **Description:** Web-based email client
- **Document Root:** `/usr/share/roundcubemail`
- **Configuration:** `/etc/httpd/conf.d/roundcube.conf`

## Internal Services

### 5. FreeIPA Identity Management
- **URL:** https://dc1.cyberinabox.net/ipa
- **Description:** FreeIPA identity management interface
- **Authentication:** Kerberos/GSSAPI
- **Type:** WSGI application
- **Configuration:** `/etc/httpd/conf.d/ipa.conf`

### 6. CPM System Status Dashboard
- **URL:** https://dc1.cyberinabox.net/dashboard
- **Description:** CPM system monitoring dashboard
- **Backend:** Flask application on localhost:5000
- **Configuration:** `/etc/httpd/conf.d/zz-cpm-dashboard-proxy.conf`

### 7. Nextcloud
- **URL:** https://dc1.cyberinabox.net/nextcloud
- **Description:** File sharing and collaboration platform
- **Document Root:** `/var/www/html/nextcloud/`
- **Type:** Alias-based configuration
- **Configuration:** `/etc/httpd/conf.d/nextcloud.conf`

## Hardware Management Interfaces

### 8. dc1 iLO5 Management
- **URL:** https://192.168.1.129
- **Description:** HP iLO 5 out-of-band management for dc1 server
- **MAC Address:** 94:40:c9:ef:f4:ae
- **Server:** dc1.cyberinabox.net (192.168.1.10)
- **Features:**
  - Remote console (graphical and text)
  - Remote power management
  - Virtual media mounting
  - Hardware monitoring (temperature, fans, voltages)
  - BIOS configuration
  - Firmware updates
- **Access:** SSH available at ssh administrator@192.168.1.129
- **Authentication:** Separate credentials from server OS

### 9. LabRat iLO5 Management
- **URL:** https://192.168.1.130
- **Description:** HP iLO 5 out-of-band management for LabRat workstation
- **MAC Address:** 94:40:c9:ed:5f:66
- **Server:** labrat.cyberinabox.net (192.168.1.115)
- **Features:**
  - Remote console (graphical and text)
  - Remote power management
  - Virtual media mounting
  - Hardware monitoring (temperature, fans, voltages)
  - BIOS configuration
  - Firmware updates
- **Access:** SSH available at ssh administrator@192.168.1.130
- **Authentication:** Separate credentials from server OS

## Remote Desktop Services

### 10. VNC Remote Desktop (XFCE)
- **Protocol:** VNC (Virtual Network Computing)
- **Port:** 5902 (Display :2)
- **Connection:** vnc://192.168.1.10:5902
- **Server:** dc1.cyberinabox.net (192.168.1.10)
- **Desktop Environment:** XFCE 4.18
- **Resolution:** 1920x1080, 24-bit color
- **Service:** vncserver-dshannon.service (systemd managed)
- **Features:**
  - Full XFCE desktop environment
  - File manager (Thunar)
  - Terminal access (xfce4-terminal)
  - System administration
  - Much faster than iLO console
  - Auto-restart on failure
- **Security:**
  - VNC password authentication required
  - Access restricted to 192.168.1.0/24 network only
  - Firewall enforced (no external access)
  - SELinux enforcing mode
- **Authentication:** VNC password (separate from Linux password)
- **Use Case:** Primary remote desktop for system administration
- **Documentation:** `/home/dshannon/Documents/vnc-setup-final.md`

## SSL/TLS Configuration

All websites use:
- **Certificate:** Commercial SSL.com wildcard certificate
- **Certificate Location:** `/etc/pki/tls/certs/commercial/wildcard.crt`
- **Key Location:** `/etc/pki/tls/private/commercial/wildcard.key`
- **Chain File:** `/etc/pki/tls/certs/commercial/chain.pem`
- **Protocols:** TLS 1.2 and TLS 1.3 only
- **HSTS:** Enabled with max-age=31536000

## Security Features

- HTTP to HTTPS redirection on all sites
- FIPS-compliant SSL cipher suites
- Security headers (X-Frame-Options, X-Content-Type-Options, X-XSS-Protection)
- Strict Transport Security (HSTS)
- Content Security Policy on IPA

## Notes

- All HTTP traffic is automatically redirected to HTTPS
- Server is running Apache httpd with multiple virtual hosts
- PHP-FPM is configured for PHP applications
- mod_wsgi is used for Python applications (FreeIPA)
- iLO management interfaces use dedicated out-of-band network ports (added 2026-01-11)
- iLO interfaces provide hardware-level access independent of server OS
- VNC remote desktop service configured for local network access only (added 2026-01-11)
- VNC uses XFCE desktop for better performance than GNOME in remote sessions
- VNC auto-restarts on failure via systemd service
