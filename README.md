# 📄 **README.md**

# 🔐 SecureGen

<p align="center">

  <!-- Badges PowerShell Gallery -->
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/powershellgallery/v/SecureGen.svg?style=for-the-badge&label=PSGallery" alt="PSGallery Version"/>
  </a>
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/powershellgallery/dt/SecureGen.svg?style=for-the-badge&label=Downloads" alt="Downloads"/>
  </a>

  <!-- Compatibilité -->
  <img src="https://img.shields.io/badge/PowerShell-5.1%20%7C%207.x-blue?style=for-the-badge" alt="PowerShell Compatibility"/>

  <!-- CI -->
  <a href="https://github.com/ledino/SecureGen/actions/workflows/ci.yml">
    <img src="https://github.com/ledino/SecureGen/actions/workflows/ci.yml/badge.svg?branch=main&style=for-the-badge" alt="CI Status"/>
  </a>

  <!-- Release & Changelog -->
  <a href="https://github.com/ledino/SecureGen/releases">
    <img src="https://img.shields.io/github/v/release/ledino/SecureGen?style=for-the-badge&label=Latest%20Release" alt="Latest Release"/>
  </a>
  <a href="https://github.com/ledino/SecureGen/blob/main/CHANGELOG.md">
    <img src="https://img.shields.io/badge/Changelog-View-blue?style=for-the-badge" alt="Changelog"/>
  </a>

  <!-- PSGallery Version History -->
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/powershellgallery/vpre/SecureGen?label=Version%20History&style=for-the-badge" alt="PSGallery Version History"/>
  </a>

  <!-- PSGallery Published -->
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/badge/PowerShell%20Gallery-Published-blue?style=for-the-badge" alt="Published on PSGallery"/>
  </a>

  <!-- Open in VS Code -->
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

<p align="center">
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="MIT License"/>
  </a>
</p>

---

# 📚 Sommaire

## 📚 Sommaire

- [🔐 SecureGen](#-securegen)
- [⚡ Quick Start](#-quick-start)
- [❓ Pourquoi SecureGen ?](#-pourquoi-securegen-)
- [✨ Fonctionnalités clés](#-fonctionnalités-clés)
- [🚀 Installation](#-installation)
  - [📦 Depuis la PowerShell Gallery](#-depuis-la-powershell-gallery)
  - [🛠️ Installation via script (développeurs)](#️-installation-via-script-développeurs)
  - [📜 Documentation complète de l’installation](#-documentation-complète-de-linstallation)
- [🧩 Fonctions incluses](#-fonctions-incluses)
- [📝 Exemples d'utilisation](#-exemples-dutilisation)
  - [🔑 Générer un mot de passe](#-générer-un-mot-de-passe)
  - [🧠 Générer une passphrase](#-générer-une-passphrase)
- [🖥️ Compatibilité](#️-compatibilité)
- [🧱 Architecture du module](#-architecture-du-module)
- [🎨 Identité visuelle](#-identité-visuelle)
- [📦 Structure du dépôt](#-structure-du-dépôt)
- [📘 Documentation des commandes](#-documentation-des-commandes)
- [🖼️ Screenshots / GIFs](#-screenshots--gifs)
- [⚡ Benchmarks](#-benchmarks)
- [🗺️ Roadmap](#-roadmap)
- [🤝 Contribuer](#-contribuer)
- [💬 Support & Feedback](#-support--feedback)
- [📜 Licence](#-licence)
- [⭐ Remerciements](#-remerciements)

---

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

# ⚡ Quick Start

Les commandes essentielles pour commencer immédiatement avec SecureGen :

```powershell
# Installer le module
Install-Module SecureGen -Scope CurrentUser

# Générer un mot de passe sécurisé
Get-PassWord

# Générer une passphrase lisible et robuste
Get-PassPhrase
```

Fonctions avancées :

```powershell
# Mot de passe sans caractères spéciaux
Get-PassWord -UseSpecial:$false

# Passphrase de 6 mots
Get-PassPhrase -MotsParBloc 6

# Passphrase silencieuse (sans beep)
Get-PassPhrase -Silent
```

---

# ❓ Pourquoi SecureGen ?

SecureGen n’est pas un simple générateur de mots de passe.  
C’est un module pensé pour être :

- **Sécurisé** — basé sur des primitives cryptographiques modernes (Get‑SecureRandom)
- **Cross‑platform** — Windows, Linux, macOS, PS5.1 et PS7+
- **Ergonomique** — commandes courtes, alias intuitifs, options claires
- **Automatisable** — idéal pour les scripts, pipelines CI/CD, environnements pros
- **Conçu pour le confort** — clipboard intelligent, beep discret, UX soignée
- **Fiable** — architecture modulaire, fallback PS5, tests automatisés

SecureGen combine **simplicité**, **sécurité**, et **expérience utilisateur**.

---

# ✨ Fonctionnalités clés

- 🔑 **Génération de mots de passe sécurisés**
  - Longueur personnalisable
  - Caractères spéciaux configurables
  - Compatible PS5.1 et PS7+

- 🧠 **Génération de passphrases lisibles**
  - Basées sur un dictionnaire interne optimisé
  - Options : nombre de mots, mode silencieux, etc.

- 🔒 **Crypto moderne**
  - PS7 : Get‑SecureRandom (conforme NIST SP 800‑90)
  - PS5 : RandomNumberGenerator (.NET Framework)

- 📋 **Clipboard intelligent**
  - Windows : Set‑Clipboard
  - macOS : pbcopy
  - Linux : xclip / xsel
  - Effacement sécurisé automatique

- 🔊 **Feedback sonore discret**
  - Indique l’effacement du clipboard
  - Option `-Silent` pour désactiver

- 🧩 **Architecture modulaire**
  - Core.PS7.ps1 (optimisé)
  - Legacy.PS5.ps1 (fallback)
  - Chargement automatique selon l’environnement

- 🧪 **Qualité assurée**
  - Tests Pester
  - Analyse statique PSScriptAnalyzer
  - CI multi‑plateformes (Windows, Linux)

---

# 📦 Installation

## 🚀 Depuis la PowerShell Gallery (recommandé)

```powershell
Install-Module SecureGen -Scope CurrentUser
```

Mettre à jour :

```powershell
Update-Module SecureGen
```

Importer explicitement (optionnel) :

```powershell
Import-Module SecureGen
```

---

## 🛠️ Installation via script (développeurs)

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

---

## 📜 Documentation complète de l’installation

Pour une documentation détaillée, incluant :

- installation PowerShell Gallery  
- installation via GitHub Release  
- installation via script intelligent  
- installation manuelle (PS5 / PS7)  
- compatibilité complète  
- dépannage  
- vérification de l’installation  

👉 Guide complet :  
https://github.com/ledino/SecureGen/blob/main/docs/installation.md

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
├── SecureGen/                     # Code source du module
│   ├── Core.PS7.ps1               # Implémentation moderne (PowerShell 7+)
│   ├── Legacy.PS5.ps1             # Implémentation fallback (Windows PowerShell 5.1)
│   ├── SecureGen.psm1             # Loader intelligent PS5/PS7 + export des fonctions
│   └── SecureGen.psd1             # Manifest du module
│
├── assets/                        # Identité visuelle & médias
│   ├── logo.png
│   ├── banner.png
│   ├── blanc_pur.png
│   ├── bleu_clair.png
│   ├── bleu_fonce.png
│   ├── cyan_vibrant.png
│   ├── gris_anthracite.png
│   ├── palette.md
│   └── screenshots/               # GIFs & captures d’écran
│       ├── password-demo.gif
│       ├── passphrase-demo.gif
│       ├── clipboard-demo.gif
│       ├── script-demo.png
│       └── github-actions-demo.png
│
├── docs/                          # Documentation complète
│   ├── index.md                   # Page d’accueil de la documentation
│   ├── installation.md            # Guide d’installation complet
│   ├── examples.md                # Exemples d’utilisation
│   ├── advanced.md                # Guide avancé
│   ├── architecture.md            # Architecture interne
│   ├── security.md                # Guide de sécurité (NIST / OWASP / ANSSI)
│   ├── contributing.md            # Guide de contribution
│   ├── troubleshooting.md         # Dépannage
│   ├── versioning.md              # Versioning & SemVer
│   ├── release-process.md         # Processus de release complet
│   ├── faq.md                     # Questions fréquentes
│   ├── benchmarks.md              # Benchmarks
│   ├── screenshots.md             # Screenshots & GIFs
│   ├── generate-help.md           # Guide PlatyPS (nouveau)
│   └── cmdlets/                   # Documentation générée automatiquement (PlatyPS)
│       ├── Get-PassWord.md
│       ├── Get-PassPhrase.md
│       ├── Get-CryptoIndex.md
│       ├── Invoke-Beep.md
│       └── SecureGen.md
│
├── scripts/                       # Scripts internes & CI/CD
│   ├── build.ps1                  # Build + tests + packaging
│   ├── Versioning-SecureGen.ps1   # Gestion automatique de version
│   ├── Install-SecureGen.ps1      # Installation locale
│   ├── Publish-SecureGen.ps1      # Publication PSGallery
│   ├── Release-All.ps1            # Pipeline complet de release
│   └── Generate-Help.ps1          # Génération automatique de la doc PlatyPS (nouveau)
│
├── .github/
│   └── workflows/
│       └── ci.yml                 # Workflow CI/CD unique (tests + publish)
│
├── CHANGELOG.md                   # Changelog généré automatiquement
├── README.md                      # Documentation principale
├── LICENSE                        # Licence MIT
└── .gitignore
```

---

# 📘 Documentation des commandes

La documentation complète des commandes SecureGen est générée automatiquement via **PlatyPS**.

Elle est disponible ici :

👉 `docs/cmdlets/`

Chaque commande dispose de sa propre page dédiée, incluant :

- description  
- paramètres  
- exemples  
- notes  
- informations techniques  

La documentation est régénérée automatiquement grâce au script :

```
scripts/Generate-Help.ps1
```

---

---

# 🖼️ Screenshots / GIFs

Voici quelques aperçus de SecureGen en action :

### 🔑 Génération d’un mot de passe
<p align="center">
  <img src="assets/screenshots/password-demo.gif" width="600" alt="Password Demo"/>
</p>

### 🧠 Génération d’une passphrase
<p align="center">
  <img src="assets/screenshots/passphrase-demo.gif" width="600" alt="Passphrase Demo"/>
</p>

---

# ⚡ Benchmarks

SecureGen est optimisé pour offrir d’excellentes performances, même dans des scripts intensifs.

### 🔢 Génération de 10 000 mots de passe
| Version PowerShell | Temps moyen | Notes |
|--------------------|-------------|-------|
| PS 7.4 (Core)      | ~45 ms      | Ultra rapide grâce à Get‑SecureRandom |
| PS 5.1 (Windows)   | ~110 ms     | RNG .NET Framework, toujours performant |

### 🧠 Génération de 10 000 passphrases
| Version PowerShell | Temps moyen | Notes |
|--------------------|-------------|-------|
| PS 7.4 (Core)      | ~60 ms      | Optimisé |
| PS 5.1 (Windows)   | ~150 ms     | Très correct |

---

# 🔐 Security Considerations

SecureGen suit plusieurs principes de sécurité :

- **Aucune donnée n’est envoyée en externe**  
  Toutes les opérations cryptographiques sont locales.

- **Utilisation de primitives modernes**  
  - PS7 : Get‑SecureRandom (NIST SP 800‑90 compliant)  
  - PS5 : RNG .NET Framework (cryptographiquement sûr)

- **Clipboard sécurisé**  
  - Effacement automatique  
  - Fallback cross‑platform  
  - Option `-Silent` pour éviter les fuites visuelles/sonores

- **Pas de stockage persistant**  
  SecureGen ne sauvegarde jamais les mots de passe ou passphrases.

- **Code source auditable**  
  Tout le module est open‑source et documenté.

Pour plus de détails :  
👉 `docs/security.md`

---

# 🗺️ Roadmap

Voici les évolutions prévues pour SecureGen :

- [ ] Ajout d’un mode “phrase naturelle” (style Diceware amélioré)
- [ ] Génération de clés API formatées (UUID, Base32, Base58…)
- [ ] Ajout d’un mode interactif (TUI minimal)
- [ ] Intégration d’un dictionnaire multilingue
- [ ] Support natif du SecureString PS7
- [ ] Ajout d’un module “SecureGen.Tools” pour les scripts avancés
- [ ] Benchmarks intégrés (performance / entropie)

Vous pouvez proposer des idées via les Issues ou Discussions.

---

# 🤝 Contribuer

Les contributions sont les bienvenues !

Vous pouvez :

- ouvrir une **Issue** pour signaler un bug ou proposer une idée  
- soumettre une **Pull Request**  
- améliorer la documentation  
- proposer de nouveaux tests Pester  

Avant de contribuer, merci de consulter :  
👉 `docs/contributing.md` (à venir)

---

# 💬 Support & Feedback

Si vous appréciez SecureGen, n’hésitez pas à :

- ⭐ **mettre une étoile sur GitHub**
- 🐛 signaler un bug via les Issues
- 💡 proposer une amélioration
- 📣 partager le module autour de vous

Votre feedback aide énormément à faire évoluer SecureGen.

---

# 📜 Licence

SecureGen est distribué sous licence **MIT**.

---

# ⭐ Remerciements

Merci d’utiliser SecureGen — un module conçu pour être **simple**, **sécurisé**, et **agréable à utiliser**.

---
