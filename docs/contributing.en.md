# 🤝 Contributing to SecureGen  
*(Official Contributor Guide — Automated Pipeline v1.5.0+)*

Thank you for your interest in **SecureGen**!  
This document explains how to contribute effectively, follow project conventions, run tests, and work within SecureGen’s modern, automated development workflow.

---

# 🧱 Core Principles

SecureGen is built on three pillars:

1. **Modern security**  
   Only approved cryptographic APIs are used:  
   - PS7: `Get-SecureRandom`  
   - PS5: `RNGCryptoServiceProvider`

2. **Maximum compatibility (PS5.1 + PS7+)**  
   Two internal implementations, unified through a smart loader.

3. **Professional quality**  
   Multi‑platform CI, Pester tests, PlatyPS documentation, automated versioning and releases.

All contributions must respect these principles.

---

# 📦 1. Project Setup (Development)

Clone the repository:

```powershell
git clone https://github.com/ledino/SecureGen.git
cd SecureGen
```

Install development dependencies:

```powershell
Install-Module Pester -Scope CurrentUser
Install-Module PSScriptAnalyzer -Scope CurrentUser
```

No Node.js setup is required:  
👉 **standard-version runs automatically inside GitHub Actions.**

---

# 🧪 2. Running Tests & Static Analysis

## Static Analysis (PSScriptAnalyzer)

```powershell
Invoke-ScriptAnalyzer -Path ./SecureGen -Recurse
```

## Pester Tests

```powershell
Invoke-Pester -Path ./tests
```

The GitHub CI automatically runs:

- PSScriptAnalyzer  
- Pester  
- Windows PowerShell 5.1 tests  
- PowerShell 7 tests (Windows + Linux + macOS)  

Tests include full coverage for **Get‑PKIPass**, including:

- Password / Passphrase modes  
- SecureString output  
- internal forwarding  
- clipboard mocks  

---

# 🧩 3. Code Conventions

## PowerShell Style

- 4‑space indentation  
- no global variables  
- no `Write-Host` inside functions  
- no external dependencies  
- code must run on both PS5.1 **and** PS7+  
- avoid constructs unsupported by PS5.1  

## Architecture

SecureGen uses two implementations:

```
Core.PS7.ps1   → optimized for PowerShell 7+
Legacy.PS5.ps1 → fallback for Windows PowerShell 5.1
```

Any new feature must:

- work on PS5.1  
- leverage PS7+ when possible  
- be wired through the loader `SecureGen.psm1`  
- follow API consistency (Words / Len / Length / Type / AsSecureString)  
- include a Pester test  

---

# 🧪 4. Conventional Commits (Required)

SecureGen uses **Conventional Commits** to:

- determine version bumps  
- generate the changelog  
- create Git tags  
- trigger the automated release pipeline  

> **Important: the examples below are commit messages.**

Main types:

| Type | Effect |
|------|--------|
| `feat:` | new feature (MINOR) |
| `fix:` | bug fix (PATCH) |
| `docs:` | documentation only |
| `refactor:` | internal improvement |
| `perf:` | performance optimization |
| `BREAKING CHANGE:` | MAJOR |

Examples:

```
feat: add Get-PKIPass
fix: correct clipboard behavior on Linux
refactor: simplify PS7 loader logic
```

---

# 🔄 5. Release Process (Automated)

Since v1.5.0+, **releases are no longer generated locally**.

The modern pipeline:

1. A Conventional Commit is pushed to `main`  
2. GitHub Actions runs **standard-version**  
3. The version is bumped automatically  
4. The changelog is updated  
5. A `chore(release): X.Y.Z` commit is created  
6. The tag `vX.Y.Z` is created  
7. A GitHub Release is generated  
8. The module is published to PowerShell Gallery  

No local commands are required.

For details:  
👉 `docs/release-process.md`  
👉 `docs/release.md`

---

# 🚀 6. Submitting a Pull Request

## Mandatory Checklist:

- [ ] Code compatible with PS5.1 and PS7+  
- [ ] Pester tests added or updated  
- [ ] PSScriptAnalyzer passes  
- [ ] Documentation updated (`docs/cmdlets/`)  
- [ ] Commit messages follow Conventional Commits  
- [ ] No manual edits to the manifest version  
- [ ] No manual edits to the changelog  
- [ ] API consistency respected (Words / Len / Length / Type / AsSecureString)  

## Process:

1. Fork the repository  
2. Create a branch:

```powershell
git checkout -b feat/my-new-feature
```

3. Implement your changes  
4. Run tests  
5. Commit + push  
6. Open a Pull Request  

---

# 🧰 7. Useful Scripts

| Script | Purpose |
|--------|---------|
| `scripts/Generate-Help.ps1` | Generates PlatyPS documentation |
| `scripts/Install-SecureGen.ps1` | Local installation |
| `scripts/Publish-SecureGen.ps1` | Manual publish (rare) |
| `scripts/Versioning-SecureGen.ps1` | **Legacy — do not use** |

---

# 🛑 8. What Not To Do

- ❌ do not modify `ModuleVersion` manually  
- ❌ do not modify `CHANGELOG.md` manually  
- ❌ do not use `Release-All.ps1`  
- ❌ do not create tags manually  
- ❌ do not run standard-version locally  
- ❌ do not edit `SecureGen-help.xml` directly  
- ❌ do not introduce parameters unsupported by PS5.1  

---

# 📚 9. Related Resources

- `docs/versioning.md`  
- `docs/release-process.md`  
- `docs/release.md`  
- `docs/architecture.md`  
- `docs/diagrams/overview.md`  
- `README.md`  

---
