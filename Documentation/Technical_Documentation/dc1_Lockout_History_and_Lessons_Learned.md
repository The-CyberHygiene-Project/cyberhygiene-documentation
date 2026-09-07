# dc1 Lockout History: Root Causes and Lessons Learned

**Author:** Donald E. Shannon, System Owner/ISSO — The Contract Coach
**Compiled:** 2026-09-07
**Scope:** every documented account-lockout / access-denial incident across the dc1 (cyberinabox.net, FreeIPA) restore project, consolidated from session memory, with root causes and the recurring structural themes behind them.

---

## 1. Purpose

This project has now accumulated enough independent lockout incidents, across enough different subsystems, that a pattern is visible and worth writing down deliberately rather than leaving scattered across session notes. The goal here is threefold:

1. Give a single chronological/causal record of every lockout-class incident to date.
2. Extract the structural (not just per-incident) root causes.
3. Record the two standing hypotheses driving the planned dc2 redesign: that **FreeIPA is over-specified for this environment**, and that **FIPS-mode cryptographic requirements introduce their own class of failure** independent of FreeIPA itself — and to honestly assess how much of this history each hypothesis actually explains.

This document is a companion to `dc1_identity_architecture_plan_2026-09-05.md` and the pre-restore `dc1-lessons-learned.md`; it does not replace either, it consolidates and updates the incident record specifically for lockouts, including everything found *during* the restore itself (which the original lessons-learned doc predates).

---

## 2. Incident Timeline

### 2.1 The catastrophic incident — 2026-08-13 (origin of this entire restore project)

**What happened:** A SELinux relabel-reversion bug — an atomic temp-file-then-rename operation losing the intended SELinux context — hit simultaneously across every login path on the box: GDM, console, and SSH (SSH compounded by a second, independent missing-`password-auth`-substack bug). With no working break-glass account configured at the time, recovery required **physically pulling the drive and repairing it offline on another machine**. This is almost certainly the direct origin of the very disk this restore project has been rebuilding ever since.

**Root cause:** SELinux context loss on a PAM-adjacent config file rewrite, compounding with an incomplete PAM stack (missing substack reference) and the total absence of a break-glass account.

**Structural lesson:** a single class of bug (SELinux relabel-reversion) was allowed to have unlimited blast radius because there was no independent, out-of-band recovery path. This is the direct cause of the project's `breakglass`-account design principle (see §4).

### 2.2 SSH MFA — never actually worked (POA&M-061)

**What happened:** SSH+MFA was credited MET in scoring, but it was discovered that *zero* SSH+MFA logins had ever actually succeeded. The same SELinux relabel-reversion bug as §2.1 was the cause, just manifesting as silent failure rather than total lockout because SSH wasn't the only login path at the time.

**Root cause:** same SELinux relabel-reversion bug as §2.1, hitting a `.google_authenticator` secret-file rewrite.

**Structural lesson:** a control can be "credited MET" on paper while having never actually functioned once, end-to-end, in practice — a self-attestation failure mode independent of any specific technology. This finding is part of why this project committed to empirical (live-tested), not self-reported, compliance evidence.

### 2.3 Console/GDM MFA (POA&M-073)

**What happened:** The same SELinux relabel-reversion bug, a third independent occurrence, this time on the console/GDM MFA path.

**Root cause:** identical to §2.1/§2.2 — same underlying bug, third distinct PAM service affected.

**Structural lesson:** by the third occurrence, this was clearly not a one-off misconfiguration but a systemic weakness in how this stack (SELinux + PAM + `pam_google_authenticator`'s file-rewrite pattern) interact. Fixing each occurrence individually never addressed the underlying pattern.

### 2.4 FreeIPA CA regeneration silently broke a workstation's trust chain

**What happened:** A past FreeIPA CA regeneration (from an earlier server reinstall) silently broke `labrat`'s certificate trust chain. The break went undetected for months, surfacing only incidentally while debugging something unrelated.

**Root cause:** FreeIPA's CA is tightly bundled with the rest of the identity stack; a change to it has effects that propagate silently to dependent systems with no built-in verification step.

**Structural lesson:** silent, undetected failure over long periods is the most dangerous failure shape for a compliance-driven system — a control can be "broken" for months without anyone knowing, which is functionally worse than an outage that at least announces itself.

### 2.5 Kerberos FAST/OTP preauth — inherently hard to debug

**What happened:** Not a discrete incident but a standing structural observation: Kerberos FAST/OTP preauth failures return deliberately generic `Preauthentication failed` errors, by design, for security reasons — making legitimate debugging materially harder even when the administrator has full access.

**Root cause:** a deliberate security/observability tradeoff baked into the Kerberos protocol itself.

**Structural lesson:** some of this project's pain is not a bug at all, but the inherent cost of a security-hardened protocol — worth distinguishing from genuine defects when assigning blame to "FreeIPA" as a product.

### 2.6 GSSAPI negotiation-loop / keytab drift (POA&M-054)

**What happened:** A full session was spent root-causing a GSSAPI negotiation loop. The directory server's Kerberos keytab had drifted from the KDC despite matching `kvno` (key version number) on both sides — a mismatch invisible to the normal verification check.

**Root cause:** keytab content drift that isn't caught by kvno comparison alone.

**Structural lesson:** the tooling's own health-check signal (`kvno` match) was insufficient to actually confirm keytab correctness — a false-negative in the diagnostic tooling itself, not just the underlying system.

### 2.7 2026-08-14 NIC failure entangled with a trust problem

**What happened:** A NIC (network interface) hardware failure was hard to disentangle from a genuine Kerberos/trust problem, because FreeIPA bundles DC + DNS + KDC + CA into one product — a failure in any one layer can present symptoms indistinguishable from failures in the others.

**Root cause:** architectural bundling concentrating blast radius and diagnostic ambiguity into one box.

**Structural lesson:** this is the clearest single illustration of the "FreeIPA over-specified for this scale" hypothesis — a hardware NIC failure should never look like an identity-trust failure, but it did here specifically because of how much is co-located in one FreeIPA server.

### 2.8 USBGuard KVM keyboard/mouse lockout — 2026-08-23

**What happened:** Existing USBGuard `allow` rules had correct vendor/product IDs but stale `via-port` values (`2-6`/`3-6`/`2-6.3`/`2-6.4`) that no longer matched dc1's real USB topology (`1-6`/`2-6`/`1-6.3`/`1-6.4`) — a leftover port-offset assumption from an earlier, undocumented incident. USBGuard matches `via-port` exactly, so the physical KVM hub (keyboard and mouse) kept getting denied at the console.

**Root cause:** a hardcoded physical-port mapping that silently went stale, with no verification step to catch drift between assumed and actual topology.

**Structural lesson:** any security control that fingerprints *physical* topology (USB ports, hardware serials) needs the mapping to be actively re-verified after any hardware change, or it becomes a self-inflicted lockout vector. This lesson was later formalized into the CPM Dashboard's USBGuard tile design (confirmed-only physical-port mapping, "unconfirmed" state shown rather than guessed).

### 2.9 `pam_faillock` lockout via GDM, triggered by Claude's own non-TTY sudo attempts — 2026-09-04

**What happened:** Between 10:25:14 and 10:27:11, several of Claude's own `sudo` calls (commands not yet on the NOPASSWD allowlist at that point) failed with a PAM conversation error (no TTY available to prompt for a password). At 10:27:04 this tripped `pam_faillock`'s `deny=3` threshold and locked the shared per-user failure tally for `sysadmin`. Four minutes later, the user's own **correct** GDM password was rejected by that same shared lockout, forcing a break-glass root login to work around it (open 10:30:23–10:42:26, almost exactly the configured 900-second `unlock_time`).

**Root cause:** `pam_faillock` is wired into both `sudo` and `gdm-password` via a shared per-user failure tally — an unrelated subsystem's automated retry behavior (an AI agent's own failed sudo attempts) was able to lock a human out of console login, because the two paths share fate.

**Structural lesson:** this was the control working *exactly as designed* — not a bug to fix, but a sharp reminder that shared-fate security mechanisms (one failure tally across multiple, otherwise-independent, auth paths) mean any automated/scripted actor operating on the box is a lockout risk to the human operator, even when behaving correctly by its own logic. This is a direct argument for **never running privileged automation with a non-interactive credential path against a system that shares its account-lockout counter with interactive human login** — worth carrying forward explicitly into dc2's design and into any future AI-agent tooling on this project.

### 2.10 Ambiguous recurrence — 2026-09-04, original (non-clone) drive boot

**What happened:** A boot attempt on the original (not clone) dc1 drive failed at the login prompt, described by the user as "the USB lockout problem that has been persistent." Two candidate root causes exist in the record (the USBGuard via-port mismatch from §2.8, or a fresh instance of the shared-faillock-tally issue from §2.9) and were never conclusively distinguished.

**Root cause:** unresolved — flagged in memory as needing direct follow-up ("ask the user directly which failure mode this matches") rather than assumed.

**Structural lesson:** by this point in the project, there were *two independent, previously-documented* lockout mechanisms capable of producing a similar-looking symptom at the login prompt — itself a sign of how much accumulated lockout-surface this stack carries.

### 2.11 Native FreeIPA OTP broken for any POSIX-enabled account — 2026-09-05

**What happened:** Root-caused via a controlled, reversible isolation test: a Kerberos-only (non-POSIX) test account with `ipaUserAuthType: otp` correctly validated combined password+TOTP. The instant POSIX attributes (`uidNumber`/`gidNumber`/`homeDirectory`/`loginShell`) were added to that *same* account — nothing else changed — the identical bind started failing (`Invalid credentials`). Removing the POSIX attributes immediately restored the working bind.

This explained every native-OTP failure across the whole project (`dshannon`/`donald.shannon`, `SysAdmin`, and a disposable test account) — **any real, login-capable account was structurally incapable of using native FreeIPA OTP on this server**, independent of configuration mistakes.

**Root cause:** an apparent 389-DS/FreeIPA plugin-level defect on the installed package version, not a misconfiguration — never fully traced into the actual plugin source, but cleanly and reproducibly isolated to the presence of POSIX attributes.

**Structural lesson:** this is a second, entirely independent contributing cause (distinct from the SELinux relabel bug of §2.1–2.3) behind this project's long-standing "MFA has essentially never worked end-to-end" pattern. Two unrelated, compounding root causes producing the same class of symptom across years of this project's history is itself the strongest evidence for the "FreeIPA is more complex than this environment can reliably operate" hypothesis (see §5).

### 2.12 FIPS/native-OTP incompatibility — root cause confirmed 2026-09-06 (POA&M-076)

**What happened:** Following on from §2.11, this system's FIPS mode (`fips-mode-setup --check` confirmed enabled) was found to be the deeper reason native OTP could never have worked correctly at all. This is a well-known, long-standing upstream FreeIPA/RHEL limitation (see Red Hat Bugzilla 1486286, 1510313, 1544679/1564390; FreeIPA Pagure #7168) — **native OTP is fundamentally incompatible with FIPS mode by design**, not a bug awaiting a fix. Upstream's actual "fix" was never to make OTP work under FIPS; it was to make the `ipa` CLI/API *refuse to let an administrator configure* OTP/RADIUS auth types at all when FIPS is enabled, converting a silent runtime failure into a clear setup-time error.

**Why it wasn't caught here:** this restore has never been able to use the `ipa` CLI at all (see §2.13, the SPNEGO bug) — every account/OTP operation went through raw LDAP instead, which has no awareness of the FIPS-aware refusal logic that lives *only* in the `ipa` command/API layer. A configuration the system would normally have refused outright to even create was silently created and silently broken, purely because the tool that would have stopped it was itself broken by an unrelated bug.

**Root cause:** a real, permanent, by-design FIPS/native-OTP incompatibility, compounded by an unrelated tooling outage that removed the one safety check that would have prevented the misconfiguration from ever being possible.

**Structural lesson:** this is the clearest documented case of the **FIPS hypothesis** (see §5) directly producing project pain — not a bug, an intentional design boundary that a NIST-800-171/CMMC-driven, FIPS-mandated deployment runs straight into. It is also a textbook case of two unrelated bugs compounding: neither the FIPS/OTP incompatibility nor the SPNEGO/`ipa`-CLI outage alone would have caused silent breakage; together, they did.

**Disposition:** native OTP disabled permanently on both real human identities (`SysAdmin`, `donald.shannon`); PKINIT (smartcard/certificate-based Kerberos auth) adopted instead as the one MFA mechanism that is FIPS-compatible. Tracked as POA&M-076, risk-accepted pending the dc2/Kanidm rebuild.

### 2.13 `ipa` CLI/Web UI broken via SPNEGO/S4U2Proxy bug — open since 2026-08-24

**What happened:** Every `ipa` CLI/API call fails with `No valid Negotiate header in server response` (client-side) / `gss_acquire_cred_from() failed ... SPNEGO cannot find mechanisms to negotiate` (server-side, httpd error log). Confirmed **not** affecting SSH/console/GDM logins, the CPM dashboard's own SPNEGO login, or any other production service — scoped specifically to `ipa` CLI/API/WebUI usage. The S4U2Proxy/constrained-delegation ACL itself was directly verified intact via LDAP, ruling out the most likely suspect. Root cause was never fully pinned down; investigation was paused mid-session with gssproxy debug logging correctly reverted to normal.

**Root cause:** unresolved as of this writing — narrowed to something specific to the `ipa-api` gssproxy service's own `GSSX_ACQUIRE_CRED`/`GSSX_ACCEPT_SEC_CONTEXT` path, never actually caught in a debug trace.

**Structural lesson:** this single open bug is the direct cause of §2.12's silent misconfiguration (by removing the one safety check that lived in the `ipa` CLI layer) and forced this entire project onto a raw-LDAP workaround for every account/OTP/cert operation performed since 2026-08-24 — a single unresolved tooling bug had downstream compounding effects on multiple, otherwise-unrelated areas of the system (this is the same reason `ipa cert-request` also required a raw-Dogtag-RA-agent workaround during PKINIT profile work, see §2.14).

### 2.14 dc1 hardware/firmware bug in YubiKey PIV management-key auth — 2026-09-06/07

**What happened:** During PKINIT/YubiKey enrollment, one specific FIPS-validated YubiKey's PIV management-key authentication reproducibly failed on dc1 (confirmed via two independent tools, two key resets, two different USB ports) while working correctly on a separate machine (Mac) with the identical key and identical default credentials. Simple PIN authentication worked fine on dc1; only the management-key challenge-response step failed.

**Root cause:** dc1's own PC/SC/CCID USB stack mishandling the management-key challenge-response protocol specifically — this is the **second** time dc1's own USB hardware/firmware has been the direct root cause of an inexplicable failure on this project (the first being the CVE-2026-43284 kernel/USB regression documented separately in the clone-boot investigation).

**Structural lesson:** not every lockout-adjacent failure in this project's history traces back to FreeIPA or FIPS — some of it is this specific physical machine's own USB subsystem being unreliable, independent of any software architecture decision. Worth keeping distinct from the FreeIPA/FIPS narrative rather than folding it in as more evidence for either hypothesis.

### 2.15 PKINIT enforcement lockout, requiring breakglass recovery — 2026-09-07

**What happened:** After PKINIT enrollment for `SysAdmin` was completed and confirmed working (real physical-YubiKey GDM login succeeded, see §3), enforcement of PKINIT as the *required* (not merely available) authentication method was applied at some point on or after 2026-09-07 — despite an explicit, recorded decision earlier the same day to hold off on enforcement until `breakglass` existed and a second verified-working session could be kept open during the change (see the POA&M-077 entry in the Phase 8 project memory). This resulted in a real lockout of `SysAdmin`, and recovery required use of the `breakglass` account's credentials. Enforcement of the PKINIT method has since been reverted.

**Root cause:** not yet fully established — under investigation via the parallel "IPA account recovery with breakglass password" session. Preliminary framing: the safeguard that was explicitly designed in (don't enforce until breakglass exists + a second session is verified-open) was apparently insufficient or was bypassed, since breakglass evidently did exist and was successfully used for recovery — meaning the actual failure mode was something enforcement itself did (e.g., a login-path interaction not anticipated by the "just flip `--user-auth-type=pkinit`" plan), not the absence of a safety net. **This document will be updated once the root-cause session reports back.**

**Structural lesson (preliminary):** even a change that was correctly identified in advance as high-risk, with a documented mitigation plan (breakglass account, second open session), still produced a real lockout — suggesting the actual failure surface of "enforce PKINIT" was broader than the specific precondition (breakglass existing) that was being guarded against. This reinforces §5's broader point: this stack has enough interacting subsystems (authselect profiles, per-account `ipaUserAuthType`, PAM service selection between `gdm-password` and `gdm-smartcard`, SSSD) that even a single-line intended change can have effects not fully predictable in advance from documentation alone — it has to be tested empirically, ideally with an even more conservative rollout than "one precondition satisfied."

---

## 3. What has actually worked (for balance)

Not every finding in this history is a failure. A few things are worth recording as evidence the underlying identity model does work when the traps above are avoided:

- `SysAdmin`'s PKINIT/YubiKey smartcard GDM login was confirmed working end-to-end (real physical key, no password/OTP) on 2026-09-07, before the enforcement incident in §2.15.
- Nested IPA group resolution (`cui_users` containing `admins`) was verified to work correctly, not just assumed.
- The `ldapmodify changetype: modrdn` account-rename mechanism preserved UID, home directory, Kerberos keys, and the (then-live) OTP token correctly, with IPA's own rename-cascade logic updating `krbPrincipalName`/`krbCanonicalName`/private-group links automatically — only one attribute (`ipatokenOwner`) needed a manual fix.
- The raw-LDAP and raw-Dogtag-RA-agent workarounds for the still-open SPNEGO bug (§2.13) have been reliable substitutes in practice, even though they're not the intended tooling path.

---

## 4. Recurring structural themes across all incidents

1. **Shared-fate mechanisms turn unrelated failures into lockouts.** `pam_faillock`'s shared per-user tally (§2.9) and the SELinux relabel bug hitting three independent PAM services (§2.1–2.3) are both instances of one subsystem's failure propagating into another's blast radius, because they share a resource (a failure counter, a file-relabeling code path) that wasn't designed with that coupling in mind.
2. **Silent, undetected breakage is worse than a loud outage.** The CA trust-chain break (§2.4), the credited-but-never-working SSH MFA (§2.2), and the FIPS/OTP silent misconfiguration (§2.12) all persisted for extended periods specifically because nothing surfaced the failure — this is the direct argument for this project's empirical (live-tested), not self-reported, verification discipline.
3. **Physical/hardware assumptions silently go stale.** The USBGuard via-port mismatch (§2.8) and dc1's own USB/PIV firmware bug (§2.14) are both cases where a mapping between software config and physical reality drifted or was simply wrong, with no automatic way to detect the drift.
4. **Breakglass/out-of-band recovery is not optional — but is not sufficient by itself either.** §2.1 shows what happens with no breakglass path at all (physical disk removal). §2.15 shows that even *with* a breakglass account correctly in place, a bad enforcement change can still cause a real lockout — breakglass limits the blast radius (recovery took an account reset, not a physical drive pull) but does not prevent the incident.
5. **Tooling health checks can lie.** The keytab-drift bug (§2.6) passed its own `kvno`-match verification while still being broken; the `ipa` CLI's FIPS-aware refusal logic (§2.12) simply wasn't in the code path actually being used (raw LDAP), so its absence was invisible until the damage was already done.

---

## 5. Assessing the two standing hypotheses

### 5.1 "FreeIPA is over-specified for this environment"

This hypothesis is well-supported by the incident record, and is the explicit, already-documented rationale for the dc2/Kanidm redesign:

- §2.4 (CA regeneration silently breaking a workstation trust chain) and §2.7 (NIC failure indistinguishable from a trust problem) are the clearest direct evidence: FreeIPA bundles DC + DNS + KDC + CA into one product, concentrating both blast radius and diagnostic ambiguity in a way a 1-server/5–7-workstation shop with no dedicated identity team does not need and cannot easily reason about.
- §2.6 (keytab drift) and §2.13 (the still-unresolved SPNEGO bug) are consistent with this too: both are deep, FreeIPA/Kerberos-internals-level failures that took (or are still taking) disproportionate specialist effort to diagnose relative to the size of this deployment.
- §2.11 (native OTP structurally broken for POSIX accounts) reads as an under-tested corner of FreeIPA's own feature surface — the kind of gap a small-scale, non-specialist operator is unlikely to catch before it causes real damage, and did not catch here until deliberate isolation testing.

**However**, it is worth being honest that not everything in this history is fairly attributed to FreeIPA specifically:
- §2.1–2.3 (the SELinux relabel-reversion bug) is a PAM/`pam_google_authenticator`/SELinux interaction — it would recur on any SELinux-enforcing RHEL-family box using the same TOTP tool, with or without FreeIPA in the picture.
- §2.9 (shared faillock tally) is generic PAM behavior, not FreeIPA-specific.
- §2.14 (YubiKey management-key bug) is this specific physical machine's USB stack, unrelated to any identity software choice.

So the fair statement is: **FreeIPA's bundled architecture is a real, demonstrated contributor to several of the worst incidents (especially the ones with long undetected duration or wide blast radius), but it is not the sole or even majority cause of this project's total lockout history** — a meaningful fraction of the pain would follow this deployment onto a differently-architected identity system on the same OS/hardware.

### 5.2 "FIPS-mode cryptographic requirements are an independent contributing factor"

This hypothesis has one very clean, fully root-caused piece of direct evidence: §2.12, the native-OTP/FIPS incompatibility. That incident is a textbook case — a well-documented, by-design upstream limitation, not a bug — and it directly explains a real portion of "MFA has never actually worked" history that would otherwise be wrongly blamed entirely on FreeIPA implementation quality.

It's also indirectly implicated in §2.15 (PKINIT was adopted specifically *because* it is the one FIPS-compatible Kerberos-native MFA mechanism — meaning the whole PKINIT enrollment effort, and therefore the whole enforcement-lockout incident, exists downstream of the FIPS requirement in the first place). Had FIPS not been mandatory, the project could plausibly have stayed on a hardware-YubiKey-as-generic-2FA approach or native OTP, sidestepping both §2.12 and the entire PKINIT-specific incident chain (§2.14, §2.15).

**Caveat:** FIPS itself is non-negotiable given this project's NIST 800-171/CMMC CUI-compliance purpose (already recorded elsewhere as load-bearing — disabling it to simplify MFA is not a real option and should not be revisited). So while FIPS is a genuine root-cause contributor to this incident history, it is also a fixed constraint, not a design mistake to correct — the correct response is "choose FIPS-compatible mechanisms and test them more conservatively" (as already done, moving to PKINIT), not "avoid FIPS."

### 5.3 Combined view

The two hypotheses are not competing explanations — they compound. FreeIPA's architectural complexity determines *how hard problems are to diagnose and how far they propagate*; FIPS determines *which mechanisms are even eligible to use in the first place*, and the PKINIT path chosen specifically because of FIPS carries its own real hardware/firmware risk (§2.14) and its own enforcement-rollout risk (§2.15) independent of FreeIPA per se. The dc2/Kanidm redesign addresses the first factor directly; the second factor (FIPS) will remain a fixed constraint under dc2 as well, so dc2's design should assume FIPS-compatible-only mechanisms from day one rather than treating PKINIT-style lessons as dc1-specific.

---

## 6. Open items as of this writing

- **§2.15 root cause is still pending** — the "IPA account recovery with breakglass password" session is actively being consulted; this document should be updated once that root cause is confirmed, and POA&M-077 should remain PLANNED (not MET) until enforcement is both reapplied and verified safe.
- **§2.13 (SPNEGO/`ipa`-CLI bug) remains open** and should be considered a standing risk multiplier for any future account/credential work, since it forces every such operation through the raw-LDAP/raw-Dogtag workaround path that lacks the tooling's own built-in safety checks (as directly demonstrated by §2.12).
- **§2.10 was never conclusively resolved** to one specific root cause — worth closing out if it recurs.

---

*Companion documents: `dc1_identity_architecture_plan_2026-09-05.md` (target end-state architecture), `dc1-lessons-learned.md` (pre-restore incident history and the original dc2/Kanidm rationale), Unified SSP/POA&M (current version tracks POA&M-075/076/077 referenced throughout this document).*
