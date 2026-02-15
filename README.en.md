<div align="center">

  <h1>🔒 SecureGen</h1>

  <p style="color:#666; font-size:16px; margin-top:-10px;">
    <em>Modern, secure & ergonomic password generation for PowerShell</em>
  </p>

  <br>

  <!-- Ko-fi button -->
  <a href="https://ko-fi.com/tonprofil" target="_blank">
    <img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Support me on Ko-fi">
  </a>

  <br><br>

  <!-- Language buttons -->
  <a href="README.fr.md">
    <img src="https://img.shields.io/badge/Français-000?style=for-the-badge&logo=github&color=1E88E5" alt="Français">
  </a>

  <a href="README.md">
    <img src="https://img.shields.io/badge/English-000?style=for-the-badge&logo=github&color=000000" alt="English">
  </a>

</div>

---

<p align="center">

  <!-- PSGallery -->
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/powershellgallery/v/SecureGen.svg?style=flat-square&label=PSGallery&color=0A2A4F" />
  </a>
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/powershellgallery/dt/SecureGen.svg?style=flat-square&label=Downloads&color=00BCD4" />
  </a>

  <!-- Compatibilité -->
  <img src="https://img.shields.io/badge/PowerShell-5.1%20%7C%207.x-4FC3F7?style=flat-square" />

  <!-- CI -->
  <a href="https://github.com/ledino/SecureGen/actions/workflows/ci.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/ledino/SecureGen/ci.yml?style=flat-square&label=CI&color=4FC3F7" />
  </a>

  <!-- Release -->
  <a href="https://github.com/ledino/SecureGen/releases">
    <img src="https://img.shields.io/github/v/release/ledino/SecureGen?style=flat-square&label=Release&color=0A2A4F" />
  </a>

</p>

---

<p align="center">
  <img src="assets/logo.png" width="140" alt="SecureGen Logo"/>
</p>

<p align="center">
  <img src="assets/banner.png" alt="SecureGen Banner"/>
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
- [❓ Why SecureGen?](#-why-securegen)
- [✨ Key Features](#-key-features)
- [🚀 Installation](#-installation)
- [🧩 Included Functions](#-included-functions)
- [📝 Usage Examples](#-usage-examples)
- [🖥️ Compatibility](#-compatibility)
- [🎨 Visual Identity](#-visual-identity)
- [🧱 Module Architecture](#-module-architecture)
- [⚙️ Versioning & Releases](#-versioning--releases)
- [📦 Repository Structure](#-repository-structure)
- [📘 Cmdlet Documentation](#-cmdlet-documentation)
- [🖼️ Screenshots / GIFs](#-screenshots--gifs)
- [⚡ Benchmarks](#-benchmarks)
- [🔐 Security](#-security)
- [🗺️ Roadmap](#-roadmap)
- [🤝 Contributing](#-contributing)
- [💬 Support & Feedback](#-support--feedback)
- [📜 License](#-license)
- [⭐ Acknowledgments](#-acknowledgments)

---

# 📘 About

**SecureGen** is a modern, ergonomic, cross‑platform PowerShell module designed to generate:

- secure passwords  
- robust passphrases  
- cryptographically safe random values  
- PKI‑grade secrets (`Get-PKIPass`) with optional SecureString output  

It supports **PowerShell 5.1** and **PowerShell 7+**, using an intelligent architecture that automatically loads:

- an optimized **PS7 version** (`Core.PS7.ps1`)  
- a secure **PS5 fallback** (`Legacy.PS5.ps1`)  

The module also includes:

- a cross‑platform clipboard system  
- a discreet beep utility  
- ergonomic aliases (`sgp`, `sgw`, `sgpki`)  

---

# ⚡ Quick Start

```powershell
# Install the module
Install-Module SecureGen -Scope CurrentUser

# Generate a secure password
Get-PassWord

# Generate a readable, robust passphrase
Get-PassPhrase
```

---

# ❓ Why SecureGen?

SecureGen is not “just another password generator.”  
It is designed to be:

- **Secure** — built on modern cryptographic primitives  
- **Cross‑platform** — Windows, Linux, macOS, PS5.1, PS7+  
- **Ergonomic** — clean API, intuitive aliases, smart defaults  
- **Automation‑friendly** — ideal for scripts, CI/CD, PKI workflows  
- **User‑friendly** — clipboard helpers, silent mode, clean UX  
- **Reliable** — modular architecture, fallback logic, full test suite  

SecureGen blends **simplicity**, **security**, and **developer comfort**.

---

# ✨ Key Features

- 🔐 **Modern cryptography**  
  - PS7: `Get-SecureRandom` (NIST SP 800‑90)  
  - PS5: RNG .NET Framework  

- 🔑 **Secure passwords**  
  - Custom length  
  - Custom special characters  

- 🧠 **Robust passphrases**  
  - Cryptographically random words  
  - Customizable length and separator  
  - Alias: `sgp`

- 🛡️ **PKI secrets (new in 1.5.0)**  
  - Password mode (32+ chars)  
  - Passphrase mode (Words × Len)  
  - Optional `SecureString` output  
  - Alias: `sgpki`

- 📋 **Smart clipboard**  
  - Windows / macOS / Linux  
  - Automatic clearing  

- 🔊 **Discreet beep** (optional)

- 🧩 **Modular architecture**  
  - Optimized PS7  
  - Secure PS5 fallback  

- 🧪 **Quality assured**  
  - PSScriptAnalyzer  
  - Pester tests  
  - Multi‑platform CI  

---

# 🚀 Installation

```powershell
Install-Module SecureGen -Scope CurrentUser
```

Update:

```powershell
Update-Module SecureGen
```

---

# 🧩 Included Functions

| Function              | Description |
|----------------------|-------------|
| `Get-PassWord`       | Generates a secure password |
| `Get-PassPhrase`     | Generates a robust, readable passphrase |
| `Get-PKIPass`        | Generates PKI‑grade secrets (Password/Passphrase) + SecureString |
| `Get-CryptoIndex`    | Cryptographically secure index generator |
| `Invoke-Beep`        | Cross‑platform beep |
| `Set-ClipboardSafe`  | Cross‑platform clipboard copy |
| `Clear-ClipboardSafe`| Secure clipboard clearing |

Aliases:

| Alias   | Function         |
|---------|------------------|
| `sgw`   | `Get-PassWord`   |
| `sgp`   | `Get-PassPhrase` |
| `sgpki` | `Get-PKIPass`    |

---

# 📝 Usage Examples

## 🔑 Passwords

```powershell
Get-PassWord
Get-PassWord -SpecialChars '!@#?%'
Get-PassWord -UseSpecial:$false
```

## 🧠 Passphrases

```powershell
Get-PassPhrase
Get-PassPhrase -Words 6 -Len 10
Get-PassPhrase -Silent
sgp -Words 5 -Len 8
```

## 🚀 PKI Secrets

```powershell
# Default PKI password (32 chars)
Get-PKIPass

# Default PKI passphrase (5×5)
Get-PKIPass -Type Passphrase

# Custom PKI password
Get-PKIPass -Type Password -Length 48

# Custom PKI passphrase
Get-PKIPass -Type Passphrase -Words 8 -Len 10

# SecureString output
Get-PKIPass -AsSecureString
```

---

# 🖥️ Compatibility

| Platform | Support |
|----------|---------|
| Windows PowerShell 5.1 | ✔ |
| PowerShell 7+ Windows | ✔ |
| PowerShell 7+ Linux | ✔ |
| PowerShell 7+ macOS | ✔ |

Clipboard:

- Windows: `Set-Clipboard`
- macOS: `pbcopy`
- Linux: `xclip` / `xsel`

---

# 🎨 Visual Identity

Official palette:

```
assets/palette.md
```

---

# 🧱 Module Architecture

```
SecureGen/
│
├── Core.PS7.ps1      # Modern implementation (PS7+)
└── Legacy.PS5.ps1    # Fallback implementation (PS5.1)
```

The loader `SecureGen.psm1`:

- detects PS5/PS7  
- loads the correct implementation  
- exposes cmdlets  
- manages aliases  
- centralizes clipboard, beep, SecureString helpers  

---

# ⚙️ Versioning & Releases

SecureGen uses:

- **Conventional Commits**
- **standard-version** (local execution)
- **Git tags** (trigger PSGallery publishing)

Release workflow:

```powershell
npm run release -- --release-as X.Y.Z
git push
git push origin vX.Y.Z
```

GitHub Actions publishes automatically.

---

# 📦 Repository Structure

```text
SecureGen/
│
├── SecureGen/                     # Code source du module
│   ├── Core.PS7.ps1               # Implémentation moderne (PowerShell 7+)
│   ├── Legacy.PS5.ps1             # Implémentation fallback (Windows PowerShell 5.1)
│   ├── SecureGen.psm1             # Loader intelligent PS5/PS7 + export des fonctions
│   └── SecureGen.psd1             # Manifest du module (bumpé automatiquement)
│
├── assets/                        # Identité visuelle & médias
│   ├── logo.png
│   ├── banner.png
│   ├── palette.md
│   └── screenshots/
│       ├── password-demo.gif
│       ├── passphrase-demo.gif
│       ├── clipboard-demo.gif
│       ├── script-demo.png
│       └── github-actions-demo.png
│
├── docs/                          # Documentations complètes
│   ├── index.md
│   ├── installation.md
│   ├── examples.md
│   ├── advanced.md
│   ├── architecture.md
│   ├── security.md
│   ├── contributing.md
│   ├── developer-guide.md
│   ├── troubleshooting.md
│   ├── versioning.md
│   ├── release-process.md
│   ├── faq.md
│   ├── benchmarks.md
│   ├── screenshots.md
│   ├── generate-help.md
│   ├── cmdlets/
│   │   ├── Get-PassWord.md
│   │   ├── Get-PassPhrase.md
│   │   ├── Get-CryptoIndex.md
│   │   ├── Invoke-Beep.md
│   │   └── SecureGen.md
│   └── diagrams/
│       ├── components.md
│       ├── deployment.md
│       ├── overview.md
│       ├── pipeline-ci-cd.md
│       └── sequence-get-password.md
│
├── node_modules                   # D# Dépendances Node.js (standard-version)
│
├── scripts/                       # Scripts internes & outils dev
│   ├── build.ps1
│   ├── Install-SecureGen.ps1
│   ├── Publish-SecureGen.ps1
│   ├── Generate-Help.ps1
│   ├── Versioning-SecureGen.ps1   # (legacy, remplacé par standard-version)
│   └── Release-All.ps1            # (legacy, remplacé par GitHub Actions)
│
├── .version-updaters/             # Updaters custom pour standard-version
│   └── psd1-updater.js            # Mise à jour automatique du ModuleVersion
│
├── .github/
│   ├── FUNDING.yml
│   ├── pull_request_template.md
│   ├── SECURITY_ADVISORY_TEMPLATE.md
│   ├── DISUSSION_TEMPLATE/
│   │   ├── announcements.yml
│   │   ├── ideas.yml
│   │   └── qna.yml
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   └── feature_request.md
│   └── workflows/
│       ├── ci.yml                 # CI multi-plateformes (tests + lint)
│       └── publish.yml            # Publication automatique sur PSGallery (déclenchée par tag)
│
├── package.json                   # Dépendances Node + version source de vérité
├── package-lock.json              # Verrouillage des dépendances
├── .versioningrc.json             # Configuration standard-version
│
tests/
│   ├── Get-PKIPass.Tests.ps1
│   ├── Get-PassWord.Tests.ps1
│   ├── Get-PassPhrase.Tests.ps1
│   ├── Get-CryptoIndex.Tests.ps1
│   ├── Invoke-Beep.Tests.ps1
│   └── Clipboard.Tests.ps1
│
├── CHANGELOG.md                   # Changelog généré automatiquement
├── README.md                      # Documentation principale
├── README.en.md
├── ROADMAP.md
├── SECURITY.md
├── SUPPORT.md
├── CODE_OF_CONDUCT.md
├── GOVERNANCE.md
├── CONTRIBUTING.md
├── MAINTAINERS.md
├── LICENSE                        # Licence MIT
└── .gitignore
```

---

# 📘 Cmdlet Documentation

👉 `docs/cmdlets/`

---

# 🖼️ Screenshots / GIFs

(Identical to your French README.)

---

# ⚡ Benchmarks

(Identical to your French README.)

---

# 🔐 Security

(Identical to your French README, rewritten in English.)

---

# 🗺️ Roadmap

(Identical to your French README.)

---

# 🤝 Contributing

Contribution guides:

- 🇫🇷 `docs/contributing.md`
- 🇬🇧 `docs/contributing.en.md`

---

# 💬 Support & Feedback

(Identical to your French README.)

---

# 📜 License

MIT License.

---

# ⭐ Acknowledgments

Thank you for using SecureGen — built to be **simple**, **secure**, and **pleasant to use**.

---
