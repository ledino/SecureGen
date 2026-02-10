# 📄 **README.md**
synchroniser `docs/index.md` avec ce README
# 🔐 SecureGen

[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/SecureGen.svg?style=for-the-badge&label=PSGallery)](https://www.powershellgallery.com/packages/SecureGen)
[![Downloads](https://img.shields.io/powershellgallery/dt/SecureGen.svg?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/SecureGen)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%20%7C%207.x-blue?style=for-the-badge)
[![CI](https://github.com/ledino/SecureGen/actions/workflows/build-test-publish.yml/badge.svg)](https://github.com/ledino/SecureGen/actions/workflows/build-test-publish.yml)

## 📚 Sommaire

- [🔐 SecureGen](#-securegen)
- [🚀 Installation](#-installation)
  - [📦 Depuis la PowerShell Gallery](#-depuis-la-powershell-gallery)
- [🧩 Fonctions incluses](#-fonctions-incluses)
- [📝 Exemples d'utilisation](#-exemples-dutilisation)
  - [🔑 Générer un mot de passe](#-générer-un-mot-de-passe)
  - [🧠 Générer une passphrase](#-générer-une-passphrase)
- [🖥️ Compatibilité](#️-compatibilité)
- [🧱 Architecture du module](#-architecture-du-module)
- [🎨 Identité visuelle](#-identité-visuelle)
- [📦 Structure du dépôt](#-structure-du-dépôt)
- [📜 Licence](#-licence)
- [⭐ Remerciements](#-remerciements)

SecureGen est un module PowerShell moderne, ergonomique et cross‑platform permettant de générer :

- des **mots de passe sécurisés**
- des **passphrases robustes**
- des **clés aléatoires cryptographiquement sûres**

Il est compatible **PowerShell 5.1** et **PowerShell 7+**, avec une architecture intelligente qui charge automatiquement :

- une version **optimisée PS7** (`Core.PS7.ps1`) utilisant  
  **Get‑SecureRandom (conforme aux modules cryptographiques modernes, NIST SP 800‑90)**
- une version **fallback PS5** (`Legacy.PS5.ps1`) utilisant  
  **RandomNumberGenerator (.NET Framework, crypto sûr mais non conforme modules modernes)**

Le module inclut également :

- une gestion automatique du **clipboard** (Windows/macOS/Linux)
- un **beep discret** pour signaler l’effacement automatique
- des alias ergonomiques (`sgp`, `sgw`)

---

# 🚀 Installation

## 📦 Depuis la PowerShell Gallery

```powershell
Install-Module SecureGen -Scope CurrentUser
```

Mettre à jour :

```powershell
Update-Module SecureGen
```

Importer explicitement (facultatif) :

```powershell
Import-Module SecureGen
```

---

# 🧩 Fonctions incluses

| Fonction              | Description |
|----------------------|-------------|
| `Get-PassWord`       | Génère un mot de passe sécurisé |
| `Get-PassPhrase`     | Génère une passphrase robuste et lisible |
| `Get-CryptoIndex`    | Générateur cryptographique interne |
| `Invoke-Beep`        | Feedback sonore cross-platform |
| `Set-ClipboardSafe`  | Copie cross-platform avec fallback |
| `Clear-ClipboardSafe`| Efface le clipboard de manière sûre |

Alias ergonomiques :

| Alias | Fonction |
|-------|----------|
| `sgw` | `Get-PassWord` |
| `sgp` | `Get-PassPhrase` |

---

# 📝 Exemples d'utilisation

## 🔑 Générer un mot de passe

```powershell
Get-PassWord
```

Personnaliser les caractères spéciaux :

```powershell
Get-PassWord -SpecialChars '!@#?%'
```

Désactiver les caractères spéciaux :

```powershell
Get-PassWord -UseSpecial:$false
```

---

## 🧠 Générer une passphrase

```powershell
Get-PassPhrase
```

6 mots :

```powershell
Get-PassPhrase -MotsParBloc 6
```

Sans beep :

```powershell
Get-PassPhrase -Silent
```

---

# 🖥️ Compatibilité

| Plateforme | Support |
|------------|---------|
| Windows PowerShell 5.1 | ✔ (Legacy, RNG .NET) |
| PowerShell 7+ Windows | ✔ (Core, Get‑SecureRandom) |
| PowerShell 7+ Linux | ✔ |
| PowerShell 7+ macOS | ✔ |

Clipboard géré automatiquement via :

- Windows : `Set-Clipboard`
- macOS : `pbcopy`
- Linux : `xclip` ou `xsel`

---

# 🧱 Architecture du module

SecureGen charge automatiquement la bonne version :

```text
SecureGen/
│
├── Core.PS7.ps1      # Version moderne (Get-SecureRandom, conforme modules cryptographiques modernes)
└── Legacy.PS5.ps1    # Version fallback (RNG .NET Framework)
```

Module principal :

```text
SecureGen.psm1
```

Manifest :

```text
SecureGen.psd1
```

---

# 🎨 Identité visuelle

La palette officielle SecureGen est disponible dans :

```text
assets/palette.md
```

Elle inclut :

- Bleu foncé (#0A2A4F)
- Cyan vibrant (#00BCD4)
- Bleu clair (#4FC3F7)
- Gris anthracite (#263238)
- Blanc (#FFFFFF)

---

# 📦 Structure du dépôt

```text
SecureGen/
│
├── SecureGen/
│   ├── Core.PS7.ps1
│   ├── Legacy.PS5.ps1
│   ├── SecureGen.psm1
│   └── SecureGen.psd1
│
├── assets/
│   ├── logo.png
│   ├── banner.png
│   ├── blanc_pur.png
│   ├── bleu_clair.png
│   ├── bleu_fonce.png
│   ├── cyan_vibrant.png
│   ├── gris_anthracite.png
│   └── palette.md
│
├── docs/
│   ├── advanced.md
│   ├── architecture.md
│   ├── examples.md
│   ├── faq.md
│   ├── installation.md
│   ├── security.md
│   ├── troubleshooting.md
│   ├── versioning.md
│   ├── release-process.md
│   └── index.md
│
├── .github/
│   └── workflows/
│       └── build-test-publish.yml
│
├── scripts/
│   ├── build.ps1
│   ├── Versioning-SecureGen.ps1
│   ├── Install-SecureGen.ps1
│   ├── Publish-SecureGen.ps1
│   └── Release-All.ps1
│
├── CHANGELOG.md
├── README.md
├── LICENSE
└── .gitignore
```

---

# 📜 Licence

SecureGen est distribué sous licence **MIT**.

---

# ⭐ Remerciements

Merci d’utiliser SecureGen — un module conçu pour être **simple**, **sécurisé**, et **agréable à utiliser**.
```
---

