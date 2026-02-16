# 🤝 Contributing to SecureGen  
*(Document harmonisé avec le pipeline moderne et la structure du projet)*

Thank you for your interest in contributing to SecureGen!  
This guide explains how to contribute code, documentation, tests, or ideas in a way that keeps the project clean, secure, and maintainable.

---

# 📚 Before You Start

Please read the following documents to understand the project’s expectations and workflow:

- `CODE_OF_CONDUCT.md`  
- `SECURITY.md`  
- `GOVERNANCE.md`  
- `SUPPORT.md`  
- `docs/contributing.md` *(French version)*  
- `docs/architecture.md`  
- `docs/versioning.md`  
- `docs/release-process.md`  
- `docs/release.md`  

These documents explain the project’s structure, rules, and automated release pipeline.

---

# 🐛 Reporting Bugs

Use the **Bug Report** template:

👉 GitHub → Issues → *Bug Report*

Include:

- reproduction steps  
- PowerShell version (`$PSVersionTable`)  
- SecureGen version (`(Get-Module SecureGen).Version`)  
- OS details  
- expected vs actual behavior  

⚠️ **Do not report security issues publicly.**  
See `SECURITY.md` for private disclosure instructions.

---

# ✨ Requesting Features

Use the **Feature Request** template:

👉 GitHub → Issues → *Feature Request*

Include:

- the problem you want to solve  
- why the feature is useful  
- example syntax  
- alternatives considered  

---

# 🛠 Development Setup

Clone the repository:

```powershell
git clone https://github.com/ledino/SecureGen
cd SecureGen
```

Install development dependencies:

```powershell
Install-Module Pester -Scope CurrentUser
Install-Module PSScriptAnalyzer -Scope CurrentUser
```

---

# 🧪 Testing

SecureGen uses **Pester** for testing.

Run all tests:

```powershell
Invoke-Pester -Path ./tests
```

Tests must pass on:

- Windows PowerShell 5.1  
- PowerShell 7+ (Windows, Linux, macOS)

If you add or modify a feature, you must:

- update existing tests  
- or add new tests  

---

# 🔍 Code Quality

SecureGen uses **PSScriptAnalyzer**.

Run static analysis:

```powershell
Invoke-ScriptAnalyzer -Path ./SecureGen -Recurse
```

All warnings must be resolved unless explicitly justified.

---

# 🧩 Coding Guidelines

### ✔ PowerShell 5.1 + 7 compatibility  
All code must work on both versions.

### ✔ No external dependencies  
SecureGen must remain self‑contained.

### ✔ No global variables  
Use local or module scope only.

### ✔ No Write-Host inside cmdlets  
Use `Write-Verbose`, `Write-Error`, or return values.

### ✔ Do NOT manually edit  
- `CHANGELOG.md`  
- `ModuleVersion` in `SecureGen.psd1`  

These files are managed automatically by the release pipeline.

### ✔ Follow the existing architecture  
- `Core.PS7.ps1` → modern implementation  
- `Legacy.PS5.ps1` → fallback  
- `SecureGen.psm1` → loader + shared utilities  

---

# 🧱 Adding or Modifying Cmdlets

If you add or modify a cmdlet:

1. Update the implementation (PS7 + PS5 if needed)  
2. Update or add Pester tests  
3. Update documentation in `docs/cmdlets/`  
4. Update examples if relevant  
5. Ensure aliases remain consistent  
6. Follow parameter naming conventions:
   - `-Words`
   - `-Len`
   - `-Length`
   - `-Type`
   - `-AsSecureString`

---

# 📝 Commit Messages

SecureGen uses **Conventional Commits**.

> **Important: the examples below are commit messages.**

Examples:

```
feat: add new PKI passphrase mode
fix: correct clipboard fallback on Linux
docs: update README with examples
refactor: simplify RNG selection logic
test: add Pester tests for Get-PKIPass
```

These messages determine the version bump (patch/minor/major).  
See `docs/versioning.md` for details.

---

# 🔀 Pull Requests

Before submitting a PR:

- run Pester tests  
- run PSScriptAnalyzer  
- update documentation  
- ensure compatibility with PS5.1 + PS7  
- use the PR template  
- keep PRs focused and small  

PRs that break compatibility or introduce regressions will be rejected.

---

# 🚀 Release Process

Releases are **fully automated** and handled by the maintainer.

The pipeline uses:

- **Conventional Commits**  
- **standard-version (executed in GitHub Actions)**  
- **automatic Git tags**  
- **automatic GitHub Releases**  
- **automatic PSGallery publishing**

Contributors do **not** modify:

- `CHANGELOG.md`  
- `ModuleVersion` in the manifest  
- Git tags  
- release notes  

See:

- `docs/release-process.md`  
- `docs/release.md`  

---

# 🙏 Thank You

Your contributions help make SecureGen better, safer, and more useful for everyone.  
Thank you for taking the time to contribute!

---
