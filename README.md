<div style="text-align:center;">

  <!-- Logo -->
  <div style="font-size:48px; margin-bottom:10px;">
    🔒
  </div>

  <!-- Titre -->
  <h1 style="margin:0; padding:0;">SecureGen</h1>

  <!-- Sous-titre -->
  <p style="margin-top:5px; color:#666;">
    <em>Modern, secure & ergonomic password generation for PowerShell</em>
  </p>

</div>

<!-- Barre Ko-fi à gauche / Langues à droite -->
<div style="display:flex; justify-content:space-between; align-items:center; width:100%; margin-top:20px;">

  <!-- Ko-fi -->
  <div>
    <a href="https://ko-fi.com/tonprofil" target="_blank">
      <img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Ko-fi">
    </a>
  </div>

  <!-- Langues -->
  <div>
    <a href="README.fr.md">
      <img src="https://img.shields.io/badge/FRANÇAIS-1E88E5?style=for-the-badge&logo=github&logoColor=white">
    </a>
    <a href="README.md">
      <img src="https://img.shields.io/badge/ENGLISH-000000?style=for-the-badge&logo=github&logoColor=white">
    </a>
  </div>

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

# 📚 Sommaire

- [📚 Documentation](#-documentation)
- [📘 À propos](#-à-propos)
- [⚡ Quick Start](#-quick-start)
- [❓ Pourquoi SecureGen ?](#-pourquoi-securegen-)
- [✨ Fonctionnalités clés](#-fonctionnalités-clés)
- [🚀 Installation](#-installation)
- [🧩 Fonctions incluses](#-fonctions-incluses)
- [📝 Exemples d'utilisation](#-exemples-dutilisation)
- [🖥️ Compatibilité](#-compatibilité)
- [🎨 Identité visuelle](#-identité-visuelle)
- [🧱 Architecture du module](#-architecture-du-module)
- [⚙️ Versioning & Releases](#-versioning--releases)
- [📦 Structure du dépôt](#-structure-du-dépôt)
- [📘 Documentation des commandes](#-documentation-des-commandes)
- [🖼️ Screenshots / GIFs](#-screenshots--gifs)
- [⚡ Benchmarks](#-benchmarks)
- [🔐 Sécurité](#-sécurité)
- [🗺️ Roadmap](#-roadmap)
- [🤝 Contribuer](#-contribuer)
- [💬 Support & Feedback](#-support--feedback)
- [📜 Licence](#-licence)
- [⭐ Remerciements](#-remerciements)

---

# 📚 Documentation

La documentation complète de SecureGen est disponible dans le dossier :

👉 `docs/index.md`

Elle est organisée en sections claires pour répondre à tous les besoins :

---

## 📘 Guides essentiels

- **Installation** → `docs/installation.md`  
- **Exemples d’utilisation** → `docs/examples.md`  
- **Guide avancé** → `docs/advanced.md`  
- **FAQ** → `docs/faq.md`  
- **Dépannage** → `docs/troubleshooting.md`

---

## 🧱 Architecture & Technique

- **Architecture du module** → `docs/architecture.md`  
- **Diagrammes UML** → `docs/diagrams/overview.md`  
- **Sécurité & crypto** → `docs/security.md`  
- **Benchmarks** → `docs/benchmarks.md`  
- **Processus de release** → `docs/release-process.md`  
- **Versioning** → `docs/versioning.md`

---

## 🧩 Documentation des commandes (PlatyPS)

Chaque commande dispose d’une page dédiée :

👉 `docs/cmdlets/`

- `Get-PassWord.md`  
- `Get-PassPhrase.md`  
- `Get-PKIPass.md`  
- `Get-CryptoIndex.md`  
- `Invoke-Beep.md`  
- `SecureGen.md`

Documentation générée automatiquement via :  
- `scripts/Generate-Help.ps1`

---

# 📘 À propos

SecureGen est un module PowerShell moderne, ergonomique et cross‑platform permettant de générer :

- des **mots de passe sécurisés**
- des **passphrases robustes**
- des **clés aléatoires cryptographiquement sûres**
- un générateur PKI complet (`Get-PKIPass`) avec support SecureString

Il est compatible **PowerShell 5.1** et **PowerShell 7+**, avec une architecture intelligente qui charge automatiquement :

- une version **optimisée PS7** (`Core.PS7.ps1`)  
- une version **fallback PS5** (`Legacy.PS5.ps1`)

Le module inclut également :

- un **clipboard intelligent** (Windows/macOS/Linux)
- un **beep discret**
- des alias ergonomiques (`sgp`, `sgw`, `sgpki`)

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

---

# ❓ Pourquoi SecureGen ?

SecureGen n’est pas un simple générateur de mots de passe.  
C’est un module pensé pour être :

- **Sécurisé**              — basé sur des primitives cryptographiques modernes (Get‑SecureRandom)
- **Cross‑platform**        — Windows, Linux, macOS, PS5.1 et PS7+
- **Ergonomique**           — commandes courtes, alias intuitifs, options claires
- **Automatisable**         — idéal pour les scripts, pipelines CI/CD, environnements pros
- **Conçu pour le confort** — clipboard intelligent, beep discret, UX soignée
- **Fiable**                — architecture modulaire, fallback PS5, tests automatisés

SecureGen combine **simplicité**, **sécurité**, et **expérience utilisateur**. 

---

# ✨ Fonctionnalités clés

- 🔐 **Crypto moderne**
  - PS7 : `Get-SecureRandom` (NIST SP 800‑90)
  - PS5 : RNG .NET Framework

- 🔑 **Mots de passe sécurisés**
  - Longueur personnalisable
  - Caractères spéciaux configurables

- 🧠 **Passphrases robustes**
  - Mots aléatoires cryptographiquement sûrs
  - Longueur configurable
  - Séparateur personnalisable
  - Alias ergonomique : `sgp`

- 🛡️ **Secrets PKI (nouveau en 1.5.0)**
  - Mode Password (32+ caractères)
  - Mode Passphrase (Words × Len)
  - Retour `SecureString` pour comptes de service, KMS, AD, DSC
  - Alias ergonomique : `sgpki`

- 📋 **Clipboard intelligent**
  - Windows / macOS / Linux
  - Effacement automatique

- 🔊 **Beep discret** (désactivable)

- 🧩 **Architecture modulaire**
  - PS7 optimisé
  - PS5 fallback

- 🧪 **Qualité assurée**
  - PSScriptAnalyzer
  - Tests Pester
  - CI multi‑plateformes

---

# 🚀 Installation

## 🚀 Depuis la PowerShell Gallery (recommandé)

```powershell
Install-Module SecureGen -Scope CurrentUser
```

Mettre à jour :

```powershell
Update-Module SecureGen
```

---

### 🛡️ Problème courant : “Running scripts is disabled on this system”

Sur un poste Windows qui n’a jamais exécuté de script PowerShell, il est fréquent d’obtenir :

```
Impossible de charger le fichier .ps1, car l'exécution de scripts est désactivée sur ce système.
```

Cela provient de la **Execution Policy**, qui est par défaut :

```
Restricted
```

### ✅ Solution recommandée (sécurisée)

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

### 🧪 Exécution ponctuelle (sans modifier la policy)

PowerShell 7+ :

```powershell
pwsh -ExecutionPolicy Bypass -File ./script.ps1
```

Windows PowerShell 5.1 :

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\script.ps1
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
| `Get-PKIPass`        | Génère un secret PKI (Password/Passphrase) + SecureString | 
| `Get-CryptoIndex`    | Générateur cryptographique interne |
| `Invoke-Beep`        | Feedback sonore cross-platform |
| `Set-ClipboardSafe`  | Copie cross-platform avec fallback |
| `Clear-ClipboardSafe`| Efface le clipboard de manière sûre |

Alias ergonomiques :

| Alias   | Fonction         |
|---------|------------------|
| `sgw`   | `Get-PassWord`   |
| `sgp`   | `Get-PassPhrase` |
| `sgpki` | `Get-PKIPass`    |

---

# 📝 Exemples d'utilisation

## 🔑 Mot de passe

```powershell
Get-PassWord
Get-PassWord -SpecialChars '!@#?%'
Get-PassWord -UseSpecial:$false
```

## 🧠 Passphrase

```powershell
Get-PassPhrase
Get-PassPhrase -Words 6 -Len 10
Get-PassPhrase -Silent
sgp -Words 5 -Len 8
```

## 🚀 PKIPass (PKI / KMS / Comptes de service)

`Get-PKIPass` est la commande dédiée aux usages sensibles :  
certificats, clés privées, comptes de service, automatisation sécurisée, KMS, etc.

Elle permet de générer :

- un **mot de passe PKI** (32 caractères par défaut)
- une **passphrase PKI** (5×5 lettres par défaut)
- un **SecureString** pour intégration dans des systèmes exigeants

### 🔑 Exemples

```powershell
# Mot de passe PKI par défaut (32 caractères)
Get-PKIPass

# Passphrase PKI par défaut (5 mots de 5 lettres)
Get-PKIPass -Type Passphrase

# Mot de passe PKI personnalisé
Get-PKIPass -Type Password -Length 48

# Passphrase PKI personnalisée
Get-PKIPass -Type Passphrase -Words 8 -Len 10

# Retour en SecureString (KMS, AD, DSC, scripts sensibles)
Get-PKIPass -AsSecureString
```
Alias ergonomique :

```powershell
sgpki
```

### 🎯 Pourquoi utiliser Get‑PKIPass ?

- Retour **SecureString** optionnel  
- Paramètres cohérents avec `Get-PassWord` et `Get-PassPhrase`  
- Idéal pour :
  - comptes de service  
  - certificats / PKI  
  - scripts d’automatisation  
  - KMS / Vault / Secret Management  
  - DSC / WinRM  

---

# 🖥️ Compatibilité

| Plateforme | Support |
|------------|---------|
| Windows PowerShell 5.1 | ✔ (Legacy, RNG .NET) |
| PowerShell 7+ Windows | ✔ (Core, Get‑SecureRandom) |
| PowerShell 7+ Linux | ✔ |
| PowerShell 7+ macOS | ✔ |

Clipboard :

- Windows : `Set-Clipboard`
- macOS : `pbcopy`
- Linux : `xclip` ou `xsel`

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

# 🧱 Architecture du module

SecureGen charge automatiquement la bonne version :

```
SecureGen/
│
├── Core.PS7.ps1      # Get-SecureRandom (NIST SP 800‑90A compliant)
└── Legacy.PS5.ps1    # Version fallback (RNG .NET Framework)
```

Le loader `SecureGen.psm1` :
- détecte PS5/PS7
- charge la bonne implémentation
- expose les cmdlets
- gère les alias (`sgw`, `sgp`, `sgpki`)
- centralise clipboard, beep, SecureString et helpers

## 📘 Documentation technique

Pour les détails avancés, consultez :

- [Architecture du module](docs/architecture.md)
- [Diagrammes UML](docs/diagrams/overview.md)
- [Processus de publication](docs/release-process.md)

---

# ⚙️ Versioning & Releases (v1.4.0+)

SecureGen utilise :

- **Conventional Commits**
- **standard-version** (exécuté en local)  
- **Git tags**  pour déclencher la publication PSGallery

## 🔄 Processus de release

1. Commit avec Conventional Commits  
2. Exécution locale :  
   ```powershell
   npm run release -- --release-as x.y.z
   ```
3. Push de la branche `main`  
4. Push du tag `vX.Y.Z`  
5. GitHub Actions publie automatiquement sur PSGallery  
6. Création de la Release GitHub (notes prêtes à coller)

Ce processus est **simple, fiable et entièrement maîtrisé côté développeur**.  

---

# 📦 Structure complète du module

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
│       ├── sequence-get-password.md
│       ├── architecture-interne.mmd
│       └── ...
│
├── node_modules                   # Dépendances Node.js (standard-version)
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

# 🖼️ Screenshots / GIFs

Voici quelques aperçus de SecureGen en action :

## 🔑 Génération d’un mot de passe
<p align="center">
  <img src="assets/screenshots/password-demo.gif" width="600" alt="Password Demo"/>
</p>

## 🧠 Génération d’une passphrase
<p align="center">
  <img src="assets/screenshots/passphrase-demo.gif" width="600" alt="Passphrase Demo"/>
</p>

---

# ⚡ Benchmarks

SecureGen est optimisé pour offrir d’excellentes performances, même dans des scripts intensifs.

## 🔢 Génération de 10 000 mots de passe
| Version PowerShell | Temps moyen | Notes |
|--------------------|-------------|-------|
| PS 7.4 (Core)      | ~45 ms      | Ultra rapide grâce à Get‑SecureRandom |
| PS 5.1 (Windows)   | ~110 ms     | RNG .NET Framework, toujours performant |

## 🧠 Génération de 10 000 passphrases
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

Guides officiels :
- 🇫🇷 `docs/contributing.md`
- 🇬🇧 `docs/contributing.en.md`

Les contributions suivent :
- Conventional Commits
- Pas de bump manuel du manifest
- Pas de modification manuelle du changelog
- Release automatisée via GitHub Actions

---

# 💬 Support & Feedback

Si vous appréciez SecureGen, n’hésitez pas à :

- ⭐ **mettre une étoile sur GitHub**
- 🐛 signaler un bug via les Issues
- 💡 proposer une amélioration
- 📣 partager le module autour de vous

Votre feedback aide énormément à faire évoluer SecureGen.

---

## ☕ Support the project

SecureGen est un projet open‑source développé avec passion.  
Si cet outil vous est utile et que vous souhaitez soutenir son développement, vous pouvez m’offrir un café sur Ko‑fi :

👉 https://ko-fi.com/ledino_creator

Merci pour votre soutien — il m’encourage énormément et m’aide à continuer à améliorer SecureGen.

---

# 📜 Licence

SecureGen est distribué sous licence **MIT**.

---

# ⭐ Remerciements

Merci d’utiliser SecureGen — un module conçu pour être **simple**, **sécurisé**, et **agréable à utiliser**.

---
