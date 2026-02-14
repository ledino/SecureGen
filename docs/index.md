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
