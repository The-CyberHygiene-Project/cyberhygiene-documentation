---
name: dc1-lessons-learned-and-architecture-retrospective
description: "dc1 research-objective retrospective and the operational evidence behind the dc2/Kanidm architecture pivot"
metadata:
  node_type: memory
  type: project
  modified: 2026-08-15
---

# dc1 Lessons Learned — Research Success and the Case for dc2

## Part 1: The research objective was met

The primary research question behind dc1/cyberinabox.net was whether an **open-source stack, assisted by AI for both construction and assessment, could build a NIST SP 800-171 / CMMC Level 2 system and hold it to genuine NIST 800-171A assessment rigor** — not a self-attested checklist, but an empirically verified score with live evidence behind every claim.

That objective was met, and the evidence is unusually strong because the process actively worked against its own bias toward optimistic self-reporting:

- The system's self-reported SPRS score was **106/110**. A full empirical 800-171A sweep (started 2026-08-05) drove that number down to a **verified low of 56/110** before any credit was given for anything not backed by live evidence — every "MET" claim was re-tested against the running system, not read off a policy document.
- The score climbed back, wave by wave, only as each item was **actually fixed and re-verified live** — not re-labeled. Final state: **95/110 strict, 96/110 confirmed-only**, SSP v2.11, signed and reviewed by Don personally against live system state on 2026-08-07.
- The single discipline that made this trustworthy — *re-verify claims instead of accepting them once made* — caught real, previously invisible failures at every level: MFA that had never once completed a successful login in the system's history (a silent SELinux mislabeling bug), a GSSAPI/Kerberos negotiation bug that made SSO work for one account only, backup infrastructure that looked configured but had never actually run, and documentation (SSP, public website) describing infrastructure that didn't exist (a fictional RAID/ReaR backup architecture, a decommissioned AI server still described as live).
- **The pattern replicated independently on a second, architecturally different system** — RS#2/diwai.org (SecureMac-based, not Rocky/FreeIPA). Same failure shape ("controls that report success while doing nothing"), same recovery discipline, same score trajectory (self-reported high, empirical low, climbing back with real evidence). That's a materially stronger result than a single case study: it suggests the failure mode and the fix are general, not an artifact of one architecture's quirks.

This is the headline finding for the journal article: **empirical, AI-assisted, live-verified compliance assessment is achievable at VSB scale with open-source tooling, and it reliably surfaces real gaps that documentation-only review misses** — demonstrated twice, independently, on two different architectures.

## Part 2: What running dc1 for real actually cost, architecturally

The same discipline that proved the concept also generated a clear, evidence-based case that **FreeIPA is over-specified for a system this size** — one server, realistically 5-7 workstations. This is not a criticism of FreeIPA in the abstract (it's the right tool at enterprise scale, with hundreds of hosts and a dedicated identity team); it's a finding about the cost/benefit at VSB scale specifically, backed by concrete incidents rather than general reputation:

**1. The SELinux relabel-reversion bug — recurred four separate times.** `pam_google_authenticator` (and later FreeIPA's own file-rewrite paths) repeatedly hit the same underlying failure: a file needs to be rewritten atomically via a temp-file-then-rename, and the rename doesn't preserve the intended SELinux label, so the file silently falls back to a generic context and the write gets denied. This bit:
- SSH's MFA (POA&M-061) — discovered because *zero* SSH+MFA logins had ever actually succeeded in the system's history, despite MFA being credited as MET.
- Console/GDM's MFA (POA&M-073) — a second, separately-scoped SELinux module needed for the same bug in a different PAM service.
- **The catastrophic case (2026-08-13):** the same bug took down *every* login path on dc1 simultaneously — GDM, console, and (via a second, compounding bug — a missing `password-auth` substack) SSH — with no working break-glass account to fall back on. Recovery required physically pulling the disk and repairing it offline on a different machine, because dc1 itself was completely unreachable for login.
- **This class of bug is structural to how `pam_google_authenticator`-style file-based MFA interacts with SELinux's file-transition model**, not a one-off misconfiguration — the same root cause recurred three times across three different PAM services despite each prior instance being "fixed."

**2. A CA regeneration silently broke client trust for months, undetected.** dc1's FreeIPA CA had been regenerated (evidence points to a past server reinstall) at some point after a workstation (labrat) was originally enrolled in December 2025. Labrat kept trusting the old, now-stale CA — every attempt to re-fetch its machine keytab failed with a generic, unhelpful error, because the *real* problem (trust chain, not credentials) was one layer beneath where the tooling was looking. This went undetected for months because nothing in routine operation would have surfaced it — it only came to light while debugging an unrelated SSH breakage.

**3. Kerberos FAST/OTP preauth is expensive to debug even when it's working correctly.** A multi-hour debugging arc to verify SSSD honors OTP end-to-end ultimately came down to a one-line test-format mistake (the KDC wanted a bare OTP code, not a password+OTP concatenation) — but reaching that conclusion required reading raw `krb5_child` debug logs, understanding FAST armor negotiation, checking clock sync, and ruling out token-lock state, none of which is discoverable from ordinary error messages (`Preauthentication failed` is deliberately generic, by design, to avoid leaking information to an attacker — which is exactly right for security and exactly costly for legitimate debugging).

**4. A GSSAPI negotiation-loop bug (POA&M-054) consumed a full session** to root-cause: the directory server's own Kerberos keytab had drifted out of sync with the KDC's actual key material despite matching key version numbers on both sides — a failure mode invisible to every standard diagnostic (`kvno` checks, SELinux audit, LDAP config review) until a direct self-`kinit` test with the service's own keytab exposed it.

**5. A NIC failure on 2026-08-14 took hours to disentangle from a genuine trust problem** — not a FreeIPA bug per se, but illustrative of how much harder infrastructure debugging becomes when a domain controller is also the DNS server, the KDC, and the CA all at once: a routine hardware failure (dead NIC port) had cascading effects across DNS resolution, Kerberos ticket issuance, and every dependent service simultaneously, because they all live behind the same one integrated product.

## The conclusion this evidence supports

None of these five incidents is a "FreeIPA is bad" claim — each is individually explicable, and FreeIPA is mature, well-documented software doing exactly what it's designed to do. The pattern across all five is: **an all-in-one identity/CA/DNS/Kerberos product concentrates failure modes and debugging complexity in one place, and at VSB scale (1 server, single admin, no dedicated identity team) that concentration cost more operational time than the integration saved.** A system with separable components — an identity provider that doesn't also own the CA and DNS — would have let each of these five incidents be diagnosed and fixed in isolation, in its own, smaller blast radius.

This is the evidentiary basis for building **dc2**: a fresh Rocky Linux install with a SCAP/STIG baseline, using **Kanidm** for identity management instead of FreeIPA, with the CA and Kerberos-trust functions deliberately decoupled into separate, independently-replaceable components (see the companion Kanidm gap-analysis note for the specific design). Not a rejection of the FreeIPA-based approach's real success — dc1 proved the underlying research question — but a considered response to what running it for real actually cost.

## What carries forward regardless of the identity-system decision

Nothing above touches the parts of dc1's stack that have nothing to do with FreeIPA: USBGuard, YARA, fapolicyd, the backup pipeline (LUKS2 + TPM2-encrypted offsite), Wazuh/OpenSearch monitoring, the OpenSCAP evidence-collection automation, and the empirical 800-171A assessment methodology itself. All of that is architecture-agnostic and is the actual "good" being captured forward into dc2 — see the companion capture-tooling design for the mechanics.
