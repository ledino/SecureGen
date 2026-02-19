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

  <!-- Dev & Quality Badges -->
  <a style="text-decoration: none;">
    <img src="https://img.shields.io/badge/PSScriptAnalyzer-Clean-4CAF50?style=flat-square&logo=powershell" />
    <img src="https://img.shields.io/badge/Docs-PlatyPS%20Auto--Generated-4FC3F7?style=flat-square&logo=readthedocs" />
    <img src="https://img.shields.io/badge/TOC-Auto--Generated-00BCD4?style=flat-square&logo=markdown" />
    <img src="https://img.shields.io/badge/Developer%20Tools-Ready-0A2A4F?style=flat-square&logo=github" />
    <img src="https://img.shields.io/badge/PS5.1%20%7C%20PS7-Tested-4FC3F7?style=flat-square&logo=powershell" />
    <img src="https://img.shields.io/badge/Versioning-standard--version-0A2A4F?style=flat-square&logo=npm" />
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

<!-- TOC-START -->
## 📑 Table of Contents

- [📘 About](#-about)
- [⚡ Quick Start](#-quick-start)
- [✨ Key Features](#-key-features)
- [🧩 Execution Modes](#-execution-modes)
- [🔤 Special Characters in PowerShell](#-special-characters-in-powershell)
- [🚀 Installation](#-installation)
- [🧩 Included Functions](#-included-functions)
- [📝 Usage Examples](#-usage-examples)
- [🧱 Module Architecture](#-module-architecture)
- [⚙️ Versioning & Releases](#️-versioning--releases)
- [📚 Full Documentation](#-full-documentation)
- [🖼️ Screenshots](#-screenshots)
- [🗺️ Roadmap](#-roadmap)
- [🤝 Contributing](#-contributing)
- [💬 Support](#-support)
- [📜 License](#-license)
- [⭐ Acknowledgments](#-acknowledgments)
<!-- TOC-END -->

---

# 📘 About

**SecureGen** is a modern, ergonomic, cross‑platform PowerShell module designed to generate:

- secure passwords  
- robust passphrases  
- PKI‑grade secrets (with optional SecureString)  
- cryptographically safe random indices  

Compatible with:

- **Windows PowerShell 5.1**  
- **PowerShell 7+** (Windows, Linux, macOS)

SecureGen automatically loads:

- an optimized **PS7 implementation** (`Core.PS7.ps1`)  
- a secure **PS5 fallback** (`Legacy.PS5.ps1`)

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

# 🧩 Execution Modes

All SecureGen generators support **4 unified execution modes**:

| Mode | Display | Clipboard | Pipeline Output | Usage |
|------|---------|-----------|-----------------|-------|
| **Default** | Full UX | yes | none | interactive |
| **Quiet** | secret only | no | secret | minimal |
| **Raw** | nothing | no | secret | pipelines / APIs |
| **Silent** | nothing | no | secret | scripts / CI / PKI |

### Examples

```powershell
Get-PassWord -Quiet
Get-PassPhrase -Raw
Get-PKIPass -Silent -AsPlainText
```

---

# 🔤 Special Characters in PowerShell

PowerShell interprets some characters as operators:

- `/` → path  
- `*` → wildcard  
- `-` → parameter  
- `+` → operator  
- `&` → invocation  
- `_` → command name  

### ✔ Always wrap special characters in quotes

```powershell
Get-PassWord -SpecialChars "/*-+&_"
```

### ❌ Incorrect

```powershell
Get-PassWord -SpecialChars /*-+&_
```

---

# 🚀 Installation

```powershell
Install-Module SecureGen -Scope CurrentUser
Update-Module SecureGen
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

### Passwords

```powershell
Get-PassWord
Get-PassWord -Length 32 -Quiet
Get-PassWord -SpecialChars "/*-+&_"
```

### Passphrases

```powershell
Get-PassPhrase -Words 6 -Letters 10
Get-PassPhrase -Words 6 -Letters 10 -Separator "*"
```

### PKI Secrets

```powershell
# SecureString (default)
Get-PKIPass -Password -Length 32

# Plaintext
Get-PKIPass -Passphrase -Words 4 -Letters 8 -AsPlainText

# Advanced modes
Get-PKIPass -Raw
Get-PKIPass -Quiet
Get-PKIPass -Silent
```

---

# 🧱 Module Architecture

```
SecureGen/
├── Core.PS7.ps1
└── Legacy.PS5.ps1
```

---

# ⚙️ Versioning & Releases

SecureGen uses:

- **Conventional Commits**
- **standard-version** (automated)
- **automatic Git tags**
- **automatic PSGallery publishing**

---

# 📚 Full Documentation

👉 `docs/index.md`  
👉 `docs/scripts.md`  
👉 `docs/developer-guide.md`  
👉 `docs/structure.md`

---

# 🖼️ Screenshots

<p align="center">
  <img src="assets/screenshots/password-demo.png" width="600"/>
</p>

<p align="center">
  <img src="assets/screenshots/passphrase-demo.png" width="600"/>
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

<p>
    <a href="https://ko-fi.com/ledino_creator">
        <img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Ko-fi">
    </a>
<p\>

---

# 📜 License

SecureGen is released under the **MIT License**.

---

# ⭐ Acknowledgments

Thank you for using SecureGen — built to be **simple**, **secure**, and **pleasant to use**.

---
