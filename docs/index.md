# 📘 **docs/index.md — Documentation officielle SecureGen**  
*(Version synchronisée avec la structure actuelle du module)*

# 🔐 SecureGen — Documentation officielle

Bienvenue dans la documentation officielle de **SecureGen**, un module PowerShell moderne, sécurisé et cross‑platform conçu pour générer :

- des **mots de passe sécurisés**  
- des **passphrases robustes**  
- des **clés aléatoires cryptographiquement sûres**

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
- Générateur cryptographique interne (`Get-CryptoIndex`)  
- Clipboard cross‑platform (`Set-ClipboardSafe`)  
- Effacement sécurisé du clipboard (`Clear-ClipboardSafe`)  
- Beep encapsulé (`Invoke-Beep`)  
- Aliases ergonomiques : **`sgw`**, **`sgp`**

---

# 🧱 Architecture du module

SecureGen utilise une architecture modulaire :

```
SecureGen/
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

### ▶️ Processus de release  
Pipeline complet pour publier une version stable sur PSGallery.  
👉 `release-process.md`

---

# 🛠️ Scripts intégrés

Les scripts d’automatisation se trouvent dans le dossier `scripts/` :

- `build.ps1` → build complet + tests + packaging  
- `Versioning-SecureGen.ps1` → versioning SemVer automatique  
- `Publish-SecureGen.ps1` → publication PSGallery  
- `Install-SecureGen.ps1` → installation intelligente PS5/PS7  
- `Release-All.ps1` → pipeline complet (versioning + build + publication)

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

# 📚 Documentations associées

- 📦 Installation : [https://github.com/ledino/SecureGen/blob/main/docs/installation.md](https://github.com/ledino/SecureGen/blob/main/docs/installation.md)  
- 📘 Exemples : `https://github.com/ledino/SecureGen/blob/main/docs/examples.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fexamples.md")  
- 🧠 Guide avancé : `https://github.com/ledino/SecureGen/blob/main/docs/advanced.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fadvanced.md")  
- 🧱 Architecture : `https://github.com/ledino/SecureGen/blob/main/docs/architecture.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Farchitecture.md")  
- 🔐 Sécurité : `https://github.com/ledino/SecureGen/blob/main/docs/security.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fsecurity.md")  
- 🧪 Versioning : `https://github.com/ledino/SecureGen/blob/main/docs/versioning.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fversioning.md")  
- 🚀 Processus de release : `https://github.com/ledino/SecureGen/blob/main/docs/release-process.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Frelease-process.md")  
- 🤝 Contribution : `https://github.com/ledino/SecureGen/blob/main/docs/contributing.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fcontributing.md")  
- 📜 README principal : `https://github.com/ledino/SecureGen/blob/main/README.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2FREADME.md")  

---

# 🎉 Merci d'utiliser SecureGen !

Votre retour est précieux pour améliorer le module.  
N’hésitez pas à ouvrir une issue ou proposer une PR sur GitHub.

---
