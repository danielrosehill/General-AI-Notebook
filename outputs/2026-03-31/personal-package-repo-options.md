# Personal Package Repository Options (Debian & Android APK)

**Prompt source**: [[personal-package-repo-options|prompts/run/personal-package-repo-options.md]]
**Executed**: 2026-03-31 IST

---

## Context

Options for setting up a personal (but public) package distribution platform for self-built `.deb` packages (Ubuntu) and `.apk` files (Android). Goal is personal convenience for pulling packages predictably across machines without a heavy review/CI pipeline.

## Debian/APT Repositories

### GitHub Pages + reprepro/aptly
Most common approach for personal use. Maintain a repo (e.g., `deb.danielrosehill.com`) backed by a GitHub repo. Run `reprepro` locally to sign and add `.deb` files, push, and GitHub Pages serves it as a valid APT source. Zero cost, fully public. On any Ubuntu machine: `apt update && apt install your-package`.

### Packagecloud.io
Hosted service with a free tier (limited packages/bandwidth). Upload with `package_cloud push` and it handles repo metadata. No GPG/reprepro setup needed. Provides a one-liner to add the repo on new machines.

### Cloudsmith
Similar to Packagecloud but more generous free tier (unlimited public repos). Supports both Debian and generic packages. REST API and CLI for uploads.

### Launchpad PPA
Ubuntu-native but requires building from source via their build farm, which adds friction. Not ideal for pre-built `.deb` files.

## Android APK Distribution

### Self-hosted F-Droid repo
F-Droid supports custom repos. Run `fdroidserver` to generate repo metadata from APKs, host the output on GitHub Pages or any static host. Users add the repo URL in the F-Droid app and get updates automatically.

### Obtainium
Android app that pulls APKs directly from GitHub Releases. No repo infrastructure needed — just publish releases on GitHub. Users point Obtainium at the GitHub repo and it handles updates. Very low friction for both sides.

## Recommended Setup

Given the goals of minimal overhead, public, and no review pipeline:

1. **Debs**: GitHub Pages repo with `aptly` or `reprepro`. One script to sign + add + push. Every machine just has the APT source configured.
2. **APKs**: Use GitHub Releases and **Obtainium** on Android devices. Zero server-side infrastructure.
