# FIPS 140-2 Verification Report
## Evidence Artifact for SC-13 Control

**Export Date:** February 3, 2026
**System:** dc1.cyberinabox.net
**Control:** SC-13 (Cryptographic Protection)

---

## Verification Status

**FIPS Mode Status:** ENABLED

Command executed: `fips-mode-setup --check`
Result: `FIPS mode is enabled.`

---

## System Configuration

| Setting | Value |
|---------|-------|
| Operating System | Rocky Linux 9.6 (Blue Onyx) |
| Kernel | 5.14.0-611.24.1.el9_7.x86_64 |
| OpenSSL Version | 3.0.7 |
| FIPS Provider | OpenSSL 3.0.7 FIPS Provider |

---

## Cryptographic Configuration

### Approved Cipher Suites (TLS)

- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
- TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384

### Disk Encryption

| Volume | Encryption | Algorithm |
|--------|------------|-----------|
| /dev/mapper/datastore | LUKS2 | AES-256-XTS |
| /home | LUKS2 | AES-256-XTS |
| /var | LUKS2 | AES-256-XTS |
| swap | dm-crypt | AES-256-XTS |

---

## NIST SP 800-171 Compliance

| Control | Requirement | Implementation |
|---------|-------------|----------------|
| 3.13.8 (SC-13) | Employ cryptographic mechanisms to protect CUI | FIPS 140-2 validated cryptography enabled system-wide |
| 3.13.11 (SC-8) | Protect confidentiality of CUI at rest and in transit | LUKS encryption (rest), TLS (transit) |

---

## Verification Commands

```bash
# Check FIPS mode
fips-mode-setup --check

# Verify OpenSSL FIPS provider
openssl list -providers

# Check enabled ciphers
openssl ciphers -s -tls1_2 -tls1_3

# Verify LUKS encryption
cryptsetup luksDump /dev/sda4
```

---

**Collected By:** D. Shannon
**Classification:** CUI Evidence Artifact
