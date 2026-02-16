<!-- Titre -->
<div align="center">
  <h1 style="font-size:72px;">🔐 SecureGen</h1>
</div>

<!-- Sous-titre -->
<p align="center">
  <em>Modern, secure & ergonomic password generation for PowerShell</em>
</p>

<br>

<!-- Langues -->
<p align="center">
    <a href="README.md" style="text-decoration: none;">
        <img src="https://img.shields.io/badge/FRANÇAIS-1E88E5?style=for-the-badge&logo=github&logoColor=white">
    </a>
    <a href="README.en.md" style="text-decoration: none;">
        <img src="https://img.shields.io/badge/ENGLISH-000000?style=for-the-badge&logo=github&logoColor=white">
    </a>
</p>

<br>

<!-- Badges PSGallery / CI / Release -->
<p align="center">

  <!-- PSGallery -->
  <a href="https://www.powershellgallery.com/packages/SecureGen" style="text-decoration: none;">
    <img src="https://img.shields.io/powershellgallery/v/SecureGen.svg?style=flat-square&label=PSGallery&color=0A2A4F" />
  </a>
  <a href="https://www.powershellgallery.com/packages/SecureGen" style="text-decoration: none;">
    <img src="https://img.shields.io/powershellgallery/dt/SecureGen.svg?style=flat-square&label=Downloads&color=00BCD4" />
  </a>

  <!-- Compatibilité -->
  <img src="https://img.shields.io/badge/PowerShell-5.1%20%7C%207.x-4FC3F7?style=flat-square" />

  <!-- CI -->
  <a href="https://github.com/ledino/SecureGen/actions/workflows/ci.yml" style="text-decoration: none;">
    <img src="https://img.shields.io/github/actions/workflow/status/ledino/SecureGen/ci.yml?style=flat-square&label=CI&color=4FC3F7" />
  </a>

  <!-- Release -->
  <a href="https://github.com/ledino/SecureGen/releases" style="text-decoration: none;">
    <img src="https://img.shields.io/github/v/release/ledino/SecureGen?style=flat-square&label=Release&color=0A2A4F" />
  </a>

</p>

<br>

<!-- Logo -->
<p align="center">
  <img src="assets/logo.png" width="140" alt="SecureGen Logo"/>
</p>

<!-- Bannière -->
<p align="center">
  <img src="assets/banner.png" alt="SecureGen Banner"/>
</p>

<br>

<!-- Ko-fi -->
<p align="center">
    <a href="https://ko-fi.com/ledino_creator">
        <img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Ko-fi">
    </a>
</p>

---

<p align="center">

  <!-- Qualité & Maintenance -->
  <img src="https://img.shields.io/badge/Maintained-Yes-0A2A4F?style=for-the-badge&logo=github" alt="Maintained"/>
  <img src="https://img.shields.io/badge/PRs-Welcome-0A2A4F?style=for-the-badge&logo=github" alt="PRs Welcome"/>
  <img src="https://img.shields.io/badge/Contributions-Welcome-4CAF50?style=for-the-badge&logo=github" alt="Contributions Welcome"/>

  <!-- Technologies -->
  <img src="https://img.shields.io/badge/Made%20with-PowerShell-00BCD4?style=for-the-badge&logo=powershell&logoColor=white" alt="Made with PowerShell"/>
  <img src="https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-00BCD4?style=for-the-badge&logo=windows-terminal&logoColor=white" alt="Platforms"/>

  <!-- Sécurité & Qualité -->
  <img src="https://img.shields.io/badge/Security-Crypto%20Safe-00BCD4?style=for-the-badge&logo=shield" alt="Security"/>
  <img src="https://img.shields.io/badge/Static%20Analysis-PSScriptAnalyzer-4FC3F7?style=for-the-badge&logo=codefactor" alt="PSScriptAnalyzer"/>
  <img src="https://img.shields.io/badge/Tests-Pester-4FC3F7?style=for-the-badge&logo=testcafe" alt="Pester Tests"/>

  <!-- Licence & Docs -->
  <img src="https://img.shields.io/badge/License-MIT-4FC3F7?style=for-the-badge&logo=open-source-initiative&logoColor=white" alt="MIT License"/>
  <img src="https://img.shields.io/badge/Docs-Complete-4FC3F7?style=for-the-badge&logo=readthedocs" alt="Docs"/>

</p>

---

# 📚 Table of Contents

- [📘 About](#-about)
- [⚡ Quick Start](#-quick-start)
- [✨ Key Features](#-key-features)
- [🚀 Installation](#-installation)
- [🧩 Included Functions](#-included-functions)
- [📝 Usage Examples](#-usage-examples)
- [🧱 Module Architecture](#-module-architecture)
- [⚙️ Versioning & Releases](#-versioning--releases)
- [📚 Full Documentation](#-full-documentation)
- [🖼️ Screenshots](#-screenshots)
- [🗺️ Roadmap](#-roadmap)
- [🤝 Contributing](#-contributing)
- [💬 Support](#-support)
- [📜 License](#-license)

---

# 📘 About

**SecureGen** is a modern, ergonomic, cross‑platform PowerShell module designed to generate:

- secure passwords  
- robust passphrases  
- PKI‑grade secrets (with optional SecureString)  
- cryptographically safe random indices  

It supports:

- **Windows PowerShell 5.1**  
- **PowerShell 7+** (Windows, Linux, macOS)

SecureGen automatically loads:

- an optimized **PS7 implementation** (`Core.PS7.ps1`)  
- a secure **PS5 fallback** (`Legacy.PS5.ps1`)

It also includes:

- a cross‑platform clipboard system  
- a discreet beep utility  
- ergonomic aliases (`sgw`, `sgp`, `sgpki`)

---

# ⚡ Quick Start

```powershell
Install-Module SecureGen -Scope CurrentUser

Get-PassWord
Get-PassPhrase
Get-PKIPass
```

---

# ✨ Key Features

- 🔐 **Modern cryptography** (Get‑SecureRandom, RNGCryptoServiceProvider)
- 🔑 **Secure passwords** (length, special chars)
- 🧠 **Robust passphrases** (Words × Len)
- 🛡️ **PKI secrets** (Password / Passphrase + SecureString)
- 📋 **Smart clipboard** (Windows/macOS/Linux)
- 🔊 **Discreet beep**
- 🧩 **Modular PS5/PS7 architecture**
- 🧪 **Pester + PSScriptAnalyzer**
- 🚀 **Automated release pipeline**

---

# 🚀 Installation

```powershell
Install-Module SecureGen -Scope CurrentUser
Update-Module SecureGen
```

For developers:

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

---

# 🧩 Included Functions

| Function | Description |
|---------|-------------|
| `Get-PassWord` | Generates a secure password |
| `Get-PassPhrase` | Generates a robust passphrase |
| `Get-PKIPass` | Generates PKI‑grade secrets + SecureString |
| `Get-CryptoIndex` | Cryptographically secure index generator |
| `Invoke-Beep` | Cross‑platform beep |
| `Set-ClipboardSafe` | Secure clipboard copy |
| `Clear-ClipboardSafe` | Secure clipboard clearing |

Aliases:

| Alias | Function |
|-------|----------|
| `sgw` | Get-PassWord |
| `sgp` | Get-PassPhrase |
| `sgpki` | Get-PKIPass |

---

# 📝 Usage Examples

## Passwords

```powershell
Get-PassWord
Get-PassWord -UseSpecial:$false
```

## Passphrases

```powershell
Get-PassPhrase -Words 6 -Len 10
```

## PKI Secrets

```powershell
Get-PKIPass -Type Passphrase -Words 8 -Len 10
Get-PKIPass -AsSecureString
```

---

# 🧱 Module Architecture

```
SecureGen/
├── Core.PS7.ps1
└── Legacy.PS5.ps1
```

The loader `SecureGen.psm1`:

- detects PS5/PS7  
- loads the correct implementation  
- exposes cmdlets  
- manages clipboard, beep, SecureString helpers  

Full technical documentation:  
👉 `docs/architecture.md`

---

# ⚙️ Versioning & Releases

SecureGen uses:

- **Conventional Commits**
- **standard-version (automated in GitHub Actions)**
- **automatic Git tags**
- **automatic PSGallery publishing**

Full pipeline documentation:  
👉 `docs/release-process.md`  
👉 `docs/release.md`  
👉 `docs/versioning.md`

---

# 📚 Full Documentation

All documentation is available here:  
👉 `docs/index.md`

---

# 🖼️ Screenshots

<p align="center">
  <img src="assets/screenshots/password-demo.gif" width="600"/>
</p>

<p align="center">
  <img src="assets/screenshots/passphrase-demo.gif" width="600"/>
</p>

---

# 🗺️ Roadmap

- Natural‑language passphrases  
- API key generators  
- Minimal TUI  
- Multilingual dictionary  
- Native PS7 SecureString  
- SecureGen.Tools module  

---

# 🤝 Contributing

Contribution guides:

- 🇫🇷 `docs/contributing.md`
- 🇬🇧 `docs/contributing.en.md`

---

# 💬 Support

Issues, discussions, and PRs are welcome.

Support the project:  
👉 `https://ko-fi.com/ledino_creator` [(ko-fi.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fko-fi.com%2Fledino_creator")

---

# 📜 License

SecureGen is released under the **MIT License**.

---

# ⭐ Acknowledgments

Thank you for using SecureGen — built to be **simple**, **secure**, and **pleasant to use**.

---
