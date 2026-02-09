# 📘 **docs/index.md — Page d’accueil de la documentation**

# 🔐 SecureGen — Documentation officielle

Bienvenue dans la documentation officielle de **SecureGen**, un module PowerShell moderne, sécurisé et cross‑platform conçu pour générer :

- des **mots de passe sécurisés**
- des **passphrases robustes**
- des **clés aléatoires cryptographiquement sûres**

SecureGen fonctionne automatiquement sous :

- **PowerShell 7+** (Windows, Linux, macOS)
- **Windows PowerShell 5.1**

Grâce à une architecture intelligente, le module charge la version la plus adaptée à votre environnement.

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
- Générateur cryptographique interne (`Get-CryptoIndex`)
- Clipboard cross‑platform (`Set-ClipboardSafe`)
- Effacement du clipboard (`Clear-ClipboardSafe`)
- Beep encapsulé (`Invoke-Beep`)
- Aliases ergonomiques : `sgp`, `sgw`

---

# 🧱 Architecture du module

SecureGen utilise une architecture modulaire :

```
src/
│
├── Core.PS7.ps1      # Version moderne (PowerShell 7+)
└── Legacy.PS5.ps1    # Version fallback (PowerShell 5.1)
```

Le fichier principal `SecureGen.psm1` détecte automatiquement la version PowerShell et charge la bonne implémentation.

---

# 📚 Documentation

La documentation complète est organisée en plusieurs sections :

### ▶️ Installation  
Guide complet pour installer SecureGen sur PS5, PS7, Windows, Linux et macOS.  
👉 `installation.md`

### ▶️ Exemples d’utilisation  
Exemples simples et avancés pour générer mots de passe, passphrases, copier dans le clipboard, etc.  
👉 `examples.md`

### ▶️ Guide avancé  
Intégration dans des scripts, pipelines CI/CD, automatisation, bonnes pratiques.  
👉 `advanced.md`

### ▶️ Architecture interne  
Détails techniques sur la structure du module, PS7/PS5, crypto, clipboard, beep.  
👉 `architecture.md`

### ▶️ Sécurité  
Bonnes pratiques, cryptographie, gestion des secrets, recommandations.  
👉 `security.md`

### ▶️ FAQ  
Réponses aux questions les plus fréquentes.  
👉 `faq.md`

### ▶️ Contribution  
Guide pour contribuer au projet : PR, style, tests, build.  
👉 `contributing.md`

---

# 🛠️ Scripts intégrés

SecureGen inclut plusieurs scripts utiles :

- `Install-SecureGen.ps1` → installation intelligente PS5/PS7  
- `Publish-SecureGen.ps1` → publication PSGallery  
- `build.ps1` → build complet + tests + packaging  

---

# 🧪 Tests & qualité

SecureGen est conçu pour être :

- robuste  
- maintenable  
- compatible PS5/PS7  
- prêt pour CI/CD  

Un dossier `tests/` peut être ajouté pour Pester.  
Le script `build.ps1` les exécutera automatiquement.

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

👉 Voir `contributing.md`

---

# 🎉 Merci d'utiliser SecureGen !

Votre retour est précieux pour améliorer le module.  
N’hésitez pas à ouvrir une issue ou proposer une PR sur GitHub.

---
