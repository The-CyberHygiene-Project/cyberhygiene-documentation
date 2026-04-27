# OpenClaw — DEPRECATED

**Status:** Flagged for decommission by the Principal Researcher on April 24, 2026.
**Disposition:** Retained in place pending removal; do not treat as current guidance.

## Why this is here

This directory carries three files describing a data-center hardening regime built around the OpenClaw control set:

- `OpenClaw_DC_Hardening_Guide.docx`
- `openclaw_control_layer_mapping.md`
- `openclaw_dc_hardened.json`

These files are byte-identical to the copies that existed on `/Volumes/Mac-Cyberhygene/CyberHygiene/OpenClaw/` as of the April 24 consolidation pass (MD5 match on all three). They represent the documentation layer of an approach the project has since stepped back from because the compliance risks outweighed the benefit of retaining the control surface in active use.

## What to do with this material

**Do not use as current guidance.** The Reference System #2 (Mac mini) and Reference System #1 (Rocky) baselines now documented elsewhere in this archive do not derive from the OpenClaw control mapping, and the mapping here should not be cited as authoritative for the project's current posture.

**Do not re-enable without a fresh review.** The Principal Researcher has indicated that the active OpenClaw footprint has been disabled in operational systems; residual traces may still exist and are being worked down separately.

## Why retained rather than deleted immediately

1. The material is documentation-only — no credentials, no live configuration, no active service binding is carried in these three files. The retention risk is conceptual rather than operational.
2. Git history preserves prior state regardless, but keeping the files visible until the first project-wide commit keeps the audit trail legible for readers working backward from current state.
3. If the decommission decision is revisited, the working copy is easier to recover from the file tree than by rebuilding from commit history.

## Path to removal

When the Principal Researcher authorizes the final decommission the removal will take two forms:

1. `git rm -r AI-Admin/OpenClaw/` in the `cyberhygiene-documentation` repository, committed with a message referencing this deprecation note.
2. Deletion of the mirror copy at `archive/git_mirrors/cyberhygiene-documentation/AI-Admin/OpenClaw/` (or migration to `_deadwood/openclaw_decommissioned/` first, per the standard deadwood policy).

This README will be removed with the rest of the directory at that time.
