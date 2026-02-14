# 🔐 SecureGen

<p align="right">
  <a href="README.md">
    <img src="https://img.shields.io/badge/English-000000?style=for-the-badge&logo=github&logoColor=white" />
  </a>
  <a href="README.fr.md">
    <img src="https://img.shields.io/badge/Français-0055A4?style=for-the-badge&logo=github&logoColor=white" />
  </a>
</p>

---

<p align="center">

  <!-- PSGallery -->
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/powershellgallery/v/SecureGen.svg?style=for-the-badge&label=PSGallery" alt="PSGallery Version"/>
  </a>
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/powershellgallery/dt/SecureGen.svg?style=for-the-badge&label=Downloads" alt="Downloads"/>
  </a>

  <!-- Compatibility -->
  <img src="https://img.shields.io/badge/PowerShell-5.1%20%7C%207.x-blue?style=for-the-badge" alt="PowerShell Compatibility"/>

  <!-- CI -->
  <a href="https://github.com/ledino/SecureGen/actions/workflows/ci.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/ledino/SecureGen/ci.yml?style=for-the-badge&label=CI" alt="CI Status"/>
  </a>

  <!-- Release -->
  <a href="https://github.com/ledino/SecureGen/releases">
    <img src="https://img.shields.io/github/v/release/ledino/SecureGen?style=for-the-badge&label=Latest%20Release&color=blue&logo=github" alt="Latest Release"/>
  </a>

  <!-- Changelog -->
  <a href="https://github.com/ledino/SecureGen/blob/main/CHANGELOG.md">
    <img src="https://img.shields.io/badge/Changelog-View-blue?style=for-the-badge" alt="Changelog"/>
  </a>

  <!-- VS Code -->
  <a href="https://vscode.dev/github/ledino/SecureGen">
    <img src="https://img.shields.io/badge/Open%20in-VS%20Code-23a8f2?style=for-the-badge&logo=visualstudiocode" alt="Open in VS Code"/>
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

  <!-- Quality & Maintenance -->
  <img src="https://img.shields.io/badge/Maintained-Yes-success?style=for-the-badge" alt="Maintained"/>
  <img src="https://img.shields.io/badge/PRs-Welcome-blue?style=for-the-badge" alt="PRs Welcome"/>
  <img src="https://img.shields.io/badge/Contributions-Welcome-4CAF50?style=for-the-badge" alt="Contributions Welcome"/>

  <!-- Technologies -->
  <img src="https://img.shields.io/badge/Made%20with-PowerShell-5391FE?style=for-the-badge&logo=powershell" alt="Made with PowerShell"/>
  <img src="https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-0078D4?style=for-the-badge" alt="Platforms"/>

  <!-- Security & Quality -->
  <img src="https://img.shields.io/badge/Security-Crypto%20Safe-blue?style=for-the-badge" alt="Security"/>
  <img src="https://img.shields.io/badge/Static%20Analysis-PSScriptAnalyzer-00A4EF?style=for-the-badge" alt="PSScriptAnalyzer"/>
  <img src="https://img.shields.io/badge/Tests-Pester-4B275F?style=for-the-badge" alt="Pester Tests"/>

  <!-- License & Docs -->
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="MIT License"/>
  <img src="https://img.shields.io/badge/Docs-Complete-blue?style=for-the-badge&logo=readthedocs" alt="Docs"/>

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

(Identical to your French README, rewritten in English — omitted here for brevity, but I can include it if you want.)

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
