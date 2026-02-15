# 📦 Structure du dépôt SecureGen

Ce document décrit l’architecture complète du dépôt SecureGen.  
Il permet aux nouveaux contributeurs, mainteneurs et utilisateurs avancés de comprendre rapidement l’organisation interne du projet.

---

# 🧱 Vue d’ensemble

```
SecureGen/
│
├── SecureGen/                     # Code source du module PowerShell
├── assets/                        # Identité visuelle & médias
├── docs/                          # Documentation complète
├── node_modules/                  # Dépendances Node.js (standard-version)
├── scripts/                       # Scripts internes & outils développeurs
├── .version-updaters/             # Updaters custom pour standard-version
├── .github/                       # Templates, workflows CI/CD, community files
├── tests/                         # Tests Pester
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

- `Core.PS7.ps1` — Implémentation optimisée PowerShell 7+ (Get‑SecureRandom)
- `Legacy.PS5.ps1` — Implémentation fallback pour Windows PowerShell 5.1
- `SecureGen.psm1` — Loader intelligent (détection PS5/PS7, export des cmdlets, alias)
- `SecureGen.psd1` — Manifest du module (version mise à jour automatiquement)

Ce dossier est publié tel quel sur la PowerShell Gallery.

---

# 🎨 2. `assets/` — Identité visuelle

- `logo.png` — Logo officiel SecureGen  
- `banner.png` — Bannière du projet  
- `palette.md` — Palette de couleurs officielle  
- `screenshots/` — GIFs et captures d’écran pour la documentation

---

# 📚 3. `docs/` — Documentation complète

Documentation utilisateur, avancée et technique :

- `index.md` — Page d’accueil de la documentation
- `installation.md` — Installation détaillée
- `examples.md` — Exemples d’utilisation
- `advanced.md` — Guide avancé
- `architecture.md` — Architecture interne du module
- `security.md` — Considérations de sécurité
- `troubleshooting.md` — Dépannage
- `versioning.md` — Versioning (Conventional Commits + standard-version)
- `release-process.md` — Processus de release
- `benchmarks.md` — Benchmarks
- `faq.md` — FAQ
- `screenshots.md` — Aperçus visuels
- `generate-help.md` — Documentation PlatyPS

### 📘 Documentation des commandes (`cmdlets/`)
Documentation générée automatiquement via PlatyPS :

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

# 🛠️ 4. `scripts/` — Scripts développeurs

Scripts internes pour automatiser le développement :

- `build.ps1` — Build local
- `Install-SecureGen.ps1` — Installation locale
- `Publish-SecureGen.ps1` — Publication manuelle
- `Generate-Help.ps1` — Génération de la documentation PlatyPS
- `Versioning-SecureGen.ps1` — Ancien système de versioning (legacy)
- `Release-All.ps1` — Ancien système de release (legacy)

---

# 🔧 5. `.version-updaters/`

Contient les updaters custom utilisés par `standard-version` :

- `psd1-updater.js` — Mise à jour automatique du ModuleVersion dans le manifest

---

# 🧩 6. `.github/` — GitHub Community Standards

- `FUNDING.yml` — Plateformes de soutien (Ko‑fi)
- `pull_request_template.md`
- `SECURITY_ADVISORY_TEMPLATE.md`
- `ISSUE_TEMPLATE/` — Bug report, feature request
- `DISCUSSION_TEMPLATE/` — Announcements, Ideas, Q&A
- `workflows/`
  - `ci.yml` — CI multi‑plateformes (lint + tests)
  - `publish.yml` — Publication automatique PSGallery via tag

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
