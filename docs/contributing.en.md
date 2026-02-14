# 🤝 Contributing to SecureGen  
*(Official Contributor Guide — v1.5.0+)*

Thank you for your interest in **SecureGen**!  
This document explains how to contribute effectively, follow the project conventions, run tests, and participate in the release process.

---

# 🧱 Core Principles

SecureGen is built on three pillars:

1. **Modern security**  
   Only approved cryptographic APIs are used (PS7: Get‑SecureRandom, PS5: RNGCryptoServiceProvider).

2. **Maximum compatibility (PS5.1 + PS7+)**  
   Two internal implementations, unified through a smart loader.

3. **Professional quality**  
   Multi‑platform CI, Pester tests, PlatyPS documentation, automated versioning.

All contributions must respect these principles.

---

# 📦 1. Project Setup (Development)

Clone the repository:

```powershell
git clone https://github.com/ledino/SecureGen.git
cd SecureGen
```

Install Node dependencies (required for standard-version):

```powershell
npm ci
```

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
- PowerShell 7 tests (Windows + Linux)  

Tests now include full coverage for **Get‑PKIPass**, including:

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
- follow API consistency (Words / Len / Length / Type)  
- include a Pester test  

---

# 🧪 4. Conventional Commits (Required)

SecureGen uses **Conventional Commits** to:

- determine version bumps  
- generate the changelog  
- keep a clean history  

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

# 🔄 5. Release Process (v1.4.0+)

Releases are generated **locally**, then published automatically via GitHub Actions.

## Steps:

1. Ensure CI is green  
2. Generate the version:

```powershell
npm run release -- --release-as X.Y.Z
```

3. Push the branch:

```powershell
git push
```

4. Push the tag:

```powershell
git push origin vX.Y.Z
```

5. GitHub Actions publishes the module to PowerShell Gallery  
6. Create the GitHub Release (notes already generated in `CHANGELOG.md`)

---

# 🚀 6. Submitting a Pull Request

## Mandatory Checklist:

- [ ] Code compatible with PS5.1 and PS7+  
- [ ] Pester tests added or updated (clipboard mocks if needed)  
- [ ] PSScriptAnalyzer passes  
- [ ] Documentation updated (cmdlet + README if needed)  
- [ ] Commit messages follow Conventional Commits  
- [ ] No manual edits to the manifest version  
- [ ] No manual edits to the changelog  
- [ ] API consistency respected (Words / Len / Length / Type / AsSecureString)  
- [ ] For sensitive features → PKI + SecureString tests included  

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
| `scripts/Publish-SecureGen.ps1` | Manual publish (rarely used) |
| `scripts/Versioning-SecureGen.ps1` | **Legacy — do not use** |

---

# 🛑 8. What Not To Do

- ❌ do not modify `ModuleVersion` manually  
- ❌ do not modify `CHANGELOG.md` manually  
- ❌ do not use `Release-All.ps1`  
- ❌ do not create tags manually (except via local release)  
- ❌ do not run standard-version inside GitHub Actions  
- ❌ do not edit `SecureGen-help.xml` directly  
- ❌ do not introduce parameters unsupported by PS5.1  

---

# 📚 9. Related Resources

- `docs/versioning.md`  
- `docs/release-process.md`  
- `docs/architecture.md`  
- `docs/diagrams/overview.md`  
- `README.md`  

---

# 🎉 Thank You for Contributing to SecureGen!

Your contributions make the module more robust, more modern, and more enjoyable to use.  
Issues, discussions, and PRs are always welcome.

---
