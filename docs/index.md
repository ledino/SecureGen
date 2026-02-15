# 🔐 SecureGen — Documentation officielle  
*(Version alignée avec SecureGen 1.5.0, l’architecture moderne et le pipeline CI/CD)*

Bienvenue dans la documentation officielle de **SecureGen**, un module PowerShell moderne, sécurisé et cross‑platform conçu pour générer :

- des **mots de passe sécurisés**
- des **passphrases robustes**
- des **secrets PKI** (Password / Passphrase, SecureString)
- des **valeurs aléatoires cryptographiquement sûres**

SecureGen fonctionne automatiquement sous :

- **PowerShell 7+** (Windows, Linux, macOS)
- **Windows PowerShell 5.1**

Grâce à une architecture intelligente, le module charge automatiquement la version la plus adaptée à votre environnement :

- **Core.PS7.ps1** → version moderne utilisant `Get‑SecureRandom` ou `RandomNumberGenerator.GetBytes()`
- **Legacy.PS5.ps1** → version fallback utilisant `RNGCryptoServiceProvider` (.NET Framework)

---

# 🚀 Installation rapide

Depuis la PowerShell Gallery :

```powershell
Install-Module SecureGen -Scope CurrentUser
```

Mettre à jour :

```powershell
Update-Module SecureGen
```

Importer explicitement :

```powershell
Import-Module SecureGen
```

---

# 🧩 Fonctionnalités principales

- Génération de mots de passe sécurisés (`Get-PassWord`)
- Génération de passphrases lisibles (`Get-PassPhrase`)
- Génération de secrets PKI (`Get-PKIPass`, SecureString optionnel)
- Générateur cryptographique interne (`Get-CryptoIndex`)
- Clipboard cross‑platform (`Set-ClipboardSafe`)
- Effacement sécurisé du clipboard (`Clear-ClipboardSafe`)
- Beep encapsulé (`Invoke-Beep`)
- Aliases ergonomiques : **`sgw`**, **`sgp`**, **`sgpki`**

---

# 🧱 Architecture du module

SecureGen utilise une architecture modulaire :

```
SecureGen/
│
├── Core.PS7.ps1      # Version moderne (PowerShell 7+)
└── Legacy.PS5.ps1    # Version fallback (PowerShell 5.1)
```

Le fichier principal `SecureGen.psm1` :

- détecte automatiquement la version PowerShell  
- charge la bonne implémentation  
- expose les cmdlets  
- gère les alias  
- centralise clipboard, beep et helpers  

---

# 🧭 How to Navigate the Repository

SecureGen est organisé de manière claire et modulaire pour faciliter la compréhension du code, la contribution et la maintenance.  
Voici un guide rapide pour vous orienter dans le dépôt.

## 🔐 1. Code source du module  
📁 `SecureGen/`

Contient l’intégralité du code PowerShell :

- `Core.PS7.ps1` — Implémentation optimisée PowerShell 7+  
- `Legacy.PS5.ps1` — Version fallback pour Windows PowerShell 5.1  
- `SecureGen.psm1` — Loader intelligent (détection PS5/PS7, export des cmdlets, alias)  
- `SecureGen.psd1` — Manifest du module (version mise à jour automatiquement)

👉 **Point d’entrée pour comprendre le fonctionnement interne du module.**

---

## 🎨 2. Identité visuelle  
📁 `assets/`

Contient :

- logo officiel  
- bannière  
- palette de couleurs  
- GIFs et captures d’écran  

👉 Utilisé dans le README, la documentation et les présentations.

---

## 📚 3. Documentation complète  
📁 `docs/`

Toute la documentation utilisateur et technique :

- installation  
- exemples  
- guide avancé  
- architecture  
- sécurité  
- benchmarks  
- troubleshooting  
- versioning & release process  

### 📘 Documentation des commandes  
📁 `docs/cmdlets/`  
Documentation générée automatiquement via PlatyPS.

### 🧩 Diagrammes UML  
📁 `docs/diagrams/`  
Diagrammes d’architecture, séquences, CI/CD.

👉 **Si vous cherchez une information, elle est probablement ici.**

---

## 🛠️ 4. Scripts développeurs  
📁 `scripts/`

Scripts internes pour :

- build local  
- installation locale  
- publication  
- génération de documentation  
- versioning (legacy)  
- release (legacy)

👉 **Indispensable pour les contributeurs et mainteneurs.**

---

## 🔧 5. Versioning automatisé  
📁 `.version-updaters/`

Contient les updaters custom utilisés par `standard-version` pour mettre à jour automatiquement :

- la version du module (`ModuleVersion`)  
- les métadonnées du manifest  

👉 **Ne pas modifier sans comprendre le workflow de release.**

---

## 🧩 6. GitHub Community Standards  
📁 `.github/`

Inclut :

- templates Issues  
- templates PR  
- templates Discussions  
- workflows CI/CD  
- fichier FUNDING  
- advisory template  

👉 **Tout ce qui concerne la communauté et l’automatisation GitHub.**

---

## 🧪 7. Tests Pester  
📁 `tests/`

Tests unitaires pour chaque commande :

- `Get-PassWord`  
- `Get-PassPhrase`  
- `Get-PKIPass`  
- `Get-CryptoIndex`  
- `Invoke-Beep`  
- clipboard  

👉 **Point d’entrée pour valider vos modifications.**

---

## 📄 8. Fichiers racine

- `README.md` / `README.en.md` — Documentation principale  
- `CHANGELOG.md` — Historique généré automatiquement  
- `ROADMAP.md` — Vision du projet  
- `SECURITY.md` — Politique de sécurité  
- `SUPPORT.md` — Support utilisateur  
- `CODE_OF_CONDUCT.md` — Code de conduite  
- `GOVERNANCE.md` — Gouvernance  
- `CONTRIBUTING.md` — Guide de contribution  
- `MAINTAINERS.md` — Mainteneurs  
- `LICENSE` — Licence MIT  

👉 **Ces fichiers définissent les règles, la vision et la gouvernance du projet.**

---

## 🎯 Résumé rapide

| Besoin | Où aller |
|-------|----------|
| Comprendre le code | `SecureGen/` |
| Lire la doc | `docs/` |
| Voir les commandes | `docs/cmdlets/` |
| Voir les diagrammes | `docs/diagrams/` |
| Contribuer | `CONTRIBUTING.md` |
| Tester | `tests/` |
| Publier | `scripts/` + workflows GitHub |
| Comprendre la structure | `docs/structure.md` |

---

# ⚙️ Automatisation du versioning & des releases

SecureGen utilise un pipeline moderne basé sur :

- **Conventional Commits**
- **standard-version**
- **un updater custom pour le manifest**
- **GitHub Actions**

Chaque release :

- met à jour automatiquement `SecureGen.psd1`
- génère le `CHANGELOG.md`
- crée un commit `chore(release): X.Y.Z`
- crée un tag `vX.Y.Z`
- publie automatiquement sur PowerShell Gallery

👉 Voir `release-process.md`

---

# 📚 Documentation

La documentation complète est organisée en plusieurs sections :

### ▶️ Installation  
👉 `installation.md`

### ▶️ Exemples d’utilisation  
👉 `examples.md`

### ▶️ Guide avancé  
👉 `advanced.md`

### ▶️ Architecture interne  
👉 `architecture.md`

### ▶️ Sécurité  
👉 `security.md`

### ▶️ FAQ  
👉 `faq.md`

### ▶️ Contribution  
- Version française : `contributing.md`  
- English version : `contributing.en.md`

### ▶️ Processus de release  
👉 `release-process.md`

---

# 🛠️ Scripts intégrés

Les scripts internes se trouvent dans le dossier `scripts/` :

- `build.ps1` → build complet + tests + packaging  
- `Install-SecureGen.ps1` → installation intelligente PS5/PS7  
- `Publish-SecureGen.ps1` → publication manuelle (mainteneurs uniquement)  
- `Generate-Help.ps1` → génération automatique de la documentation PlatyPS  

Scripts legacy (remplacés par standard-version + GitHub Actions) :

- `Versioning-SecureGen.ps1`  
- `Release-All.ps1`

---

# 🧪 Tests & qualité

SecureGen est conçu pour être :

- robuste  
- maintenable  
- compatible PS5/PS7  
- prêt pour CI/CD  

La CI (`ci.yml`) exécute automatiquement :

- PSScriptAnalyzer  
- Import du module  
- Tests Pester (incluant Get‑PKIPass, clipboard, PS5/PS7)

---

# 🎨 Identité visuelle

Les éléments graphiques officiels se trouvent dans :

```
assets/
│
├── logo.png
├── banner.png
└── palette.md
```

---

# 📜 Licence

SecureGen est distribué sous licence **MIT**.

---

# 🤝 Contribuer

Les contributions sont les bienvenues :  
Pull Requests, Issues, suggestions.

👉 Voir `contributing.md` ou `contributing.en.md`

---

# 📚 Documentations associées

- `installation.md`
- `examples.md`
- `advanced.md`
- `architecture.md`
- `security.md`
- `versioning.md`
- `release-process.md`
- `contributing.md`
- `contributing.en.md`
- `README.md`

---

# 🎉 Merci d'utiliser SecureGen !

Votre retour est précieux pour améliorer le module.  
N’hésitez pas à ouvrir une issue ou proposer une PR sur GitHub.
```

---
