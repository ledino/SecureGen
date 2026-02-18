# 📦 **Structure du dépôt SecureGen (Version enrichie)**

Ce document décrit l’architecture complète du dépôt SecureGen.  
Il sert de référence pour les développeurs, contributeurs et mainteneurs souhaitant comprendre rapidement l’organisation interne du projet.

---
# 📦 **Structure du dépôt SecureGen (Version enrichie)**

## 📑 Table des matières

- [🧱 Vue d’ensemble](#-vue-densemble)
- [🔐 1. `SecureGen/` — Code source du module](#-1-securegen--code-source-du-module)
- [🎨 2. `assets/` — Identité visuelle & médias](#-2-assets--identité-visuelle--médias)
- [📚 3. `docs/` — Documentation complète](#-3-docs--documentation-complète)
- [🛠️ 4. `scripts/` — Scripts développeurs](#️-4-scripts--scripts-développeurs)
- [🔧 Documentation complète des scripts](#-documentation-complète-des-scripts)
- [🔧 5. `.version-updaters/`](#-5-version-updaters)
- [🧩 6. `.github/` — GitHub Community Standards](#-6-github--github-community-standards)
- [🧪 7. `tests/` — Tests Pester](#-7-tests--tests-pester)
- [📄 8. Fichiers racine](#-8-fichiers-racine)
- [🎉 Structure prête pour un futur site statique](#-structure-prête-pour-un-futur-site-statique)

---

# 🧱 Vue d’ensemble

```
SecureGen/
│
├── SecureGen/                     # Code source du module PowerShell
├── assets/                        # Identité visuelle & médias
├── docs/                          # Documentation complète (utilisateur + technique)
├── scripts/                       # Scripts internes & outils développeurs
├── tests/                         # Tests Pester
├── .github/                       # Workflows CI/CD + community standards
├── .version-updaters/             # Updaters custom pour standard-version
├── node_modules/                  # Dépendances Node.js (standard-version)
│
├── CHANGELOG.md                   # Changelog généré automatiquement
├── README.md                      # Documentation principale (FR)
├── README.en.md                   # Documentation principale (EN)
├── ROADMAP.md                     # Roadmap du projet
├── SECURITY.md                    # Politique de sécurité
├── SUPPORT.md                     # Support utilisateur
├── CODE_OF_CONDUCT.md             # Code de conduite
├── GOVERNANCE.md                  # Gouvernance du projet
├── CONTRIBUTING.md                # Guide de contribution
├── MAINTAINERS.md                 # Mainteneurs officiels
├── LICENSE                        # Licence MIT
└── .gitignore
```

---

# 🔐 1. `SecureGen/` — Code source du module

Contient l’intégralité du code PowerShell :

| Fichier | Rôle |
|--------|------|
| `Core.PS7.ps1` | Implémentation moderne (PS7+), RNG sécurisé, clipboard moderne |
| `Legacy.PS5.ps1` | Implémentation fallback pour Windows PowerShell 5.1 |
| `SecureGen.psm1` | Loader intelligent PS5/PS7, export des cmdlets, alias |
| `SecureGen.psd1` | Manifest du module (version mise à jour automatiquement) |

Ce dossier est **exactement** celui publié sur la PowerShell Gallery.

---

# 🎨 2. `assets/` — Identité visuelle & médias

Contient les ressources graphiques du projet :

- `logo.png` — Logo officiel SecureGen  
- `banner.png` — Bannière du projet  
- `palette.md` — Palette de couleurs officielle  
- `screenshots/` — GIFs et captures d’écran pour la documentation  
- `diagrams/` — Diagrammes UML/SVG utilisés dans la doc  

---

# 📚 3. `docs/` — Documentation complète

Documentation utilisateur, avancée, technique et interne.

### 📘 Documentation utilisateur

- `index.md` — Page d’accueil  
- `installation.md` — Installation détaillée  
- `examples.md` — Exemples d’utilisation  
- `advanced.md` — Guide avancé  
- `faq.md` — FAQ  
- `benchmarks.md` — Benchmarks  
- `screenshots.md` — Aperçus visuels  

### 🧩 Documentation technique

- `architecture.md` — Architecture interne du module  
- `security.md` — Considérations de sécurité  
- `troubleshooting.md` — Dépannage  
- `versioning.md` — Versioning (Conventional Commits + standard-version)  
- `release-process.md` — Processus de release  
- `generate-help.md` — Documentation PlatyPS  
- `structure.md` — Structure du dépôt  
- `developer-guide.md` — Guide développeur  
- `workflow.md` — Workflow développeur  
- `context.md` — Mémoire humaine du projet  

### 📘 Documentation des commandes (`cmdlets/`)

Générée automatiquement via PlatyPS :

- `Get-PassWord.md`  
- `Get-PassPhrase.md`  
- `Get-PKIPass.md`  
- `Get-CryptoIndex.md`  
- `Invoke-Beep.md`  
- `SecureGen.md`  

### 🧩 Diagrammes (`diagrams/`)

Diagrammes UML et documentation technique :

- `overview.md`  
- `components.md`  
- `deployment.md`  
- `pipeline-ci-cd.md`  
- `sequence-get-password.md`  

---

# 🛠️ 4. `scripts/` — Scripts développeurs *(version mise à jour)*

Scripts internes pour automatiser le développement :

| Script | Rôle |
|--------|------|
| `build.ps1` | Build local du module |
| `Install-SecureGen.ps1` | Installation locale du module |
| `Publish-SecureGen.ps1` | Publication manuelle PSGallery |
| `Generate-Help.ps1` | Génération de la documentation PlatyPS |
| `Generate-PSGalleryReadme.ps1` | Génération du README pour PSGallery |
| `Versioning-SecureGen.ps1` | Wrapper local autour de standard-version |
| `Release-All.ps1` | Pipeline local de préparation de release |
| `Generate-All.ps1` | Script maître (génération + build + tests + installation) |

### 📘 Documentation complète des scripts

Tous les scripts internes sont documentés en détail ici :

👉 `docs/scripts.md`

---

# 🔧 5. `.version-updaters/`

Contient les updaters custom utilisés par `standard-version` :

- `psd1-updater.js` — Mise à jour automatique du ModuleVersion dans le manifest

---

# 🧩 6. `.github/` — GitHub Community Standards

### Templates & discussions

- `FUNDING.yml` — Plateformes de soutien (Ko‑fi)  
- `pull_request_template.md`  
- `ISSUE_TEMPLATE/` — Bug report, feature request  
- `DISCUSSION_TEMPLATE/` — Announcements, Ideas, Q&A  

### Workflows CI/CD

- `ci.yml` — CI multi‑plateformes (lint + tests)  
- `release.yml` — Publication automatique PSGallery via tag  

---

# 🧪 7. `tests/` — Tests Pester

Tests unitaires pour chaque commande :

- `Get-PKIPass.Tests.ps1`  
- `Get-PassWord.Tests.ps1`  
- `Get-PassPhrase.Tests.ps1`  
- `Get-CryptoIndex.Tests.ps1`  
- `Invoke-Beep.Tests.ps1`  
- `Clipboard.Tests.ps1`  

---

# 📄 8. Fichiers racine

- `README.md` — Documentation principale (FR)  
- `README.en.md` — Documentation principale (EN)  
- `CHANGELOG.md` — Généré automatiquement  
- `ROADMAP.md` — Roadmap du projet  
- `SECURITY.md` — Politique de sécurité  
- `SUPPORT.md` — Support utilisateur  
- `CODE_OF_CONDUCT.md` — Code de conduite  
- `GOVERNANCE.md` — Gouvernance  
- `CONTRIBUTING.md` — Contribution  
- `MAINTAINERS.md` — Mainteneurs  
- `LICENSE` — Licence MIT  

---

# 🎉 Structure prête pour un futur site statique

Cette organisation est compatible avec :

- MkDocs  
- Docusaurus  
- GitHub Pages  
- Docsify  

---
