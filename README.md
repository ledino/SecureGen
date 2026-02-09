# 📄 **README.md — Version mise à jour**

# 🔐 SecureGen

<p align="center">
  <img src="assets/logo.png" width="140" alt="SecureGen Logo"/>
</p>

<p align="center">
  <img src="assets/banner.png" alt="SecureGen Banner"/>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/powershellgallery/v/SecureGen.svg" alt="PSGallery Version"/>
  </a>
  <a href="https://www.powershellgallery.com/packages/SecureGen">
    <img src="https://img.shields.io/powershellgallery/dt/SecureGen.svg" alt="Downloads"/>
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="MIT License"/>
  </a>
</p>

---

# 🔐 SecureGen

**SecureGen** est un module PowerShell moderne, ergonomique et cross‑platform permettant de générer :

- des **mots de passe sécurisés**
- des **passphrases robustes**
- des **clés aléatoires cryptographiquement sûres**

Il est compatible **PowerShell 5.1** et **PowerShell 7+**, avec une architecture intelligente qui charge automatiquement :

- une version **optimisée PS7** (`Core.PS7.ps1`)
- une version **fallback PS5** (`Legacy.PS5.ps1`)

Le module inclut également une gestion automatique du **clipboard** (Windows/macOS/Linux) et un **beep discret** pour confirmer la copie.

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

# 🛠️ Installation intelligente (PS5 + PS7)

Le script d’installation fourni dans le dépôt installe automatiquement SecureGen dans :

- **PowerShell 5.1** si présent  
- **PowerShell 7+** si présent  
- **les deux** si les deux environnements existent  

Il détecte les chemins standards Microsoft et copie le module proprement.

```powershell
.\Install-SecureGen.ps1
```

---

# 🧩 Fonctions incluses

| Fonction              | Description |
|----------------------|-------------|
| `Get-PassWord`       | Génère un mot de passe sécurisé |
| `Get-PassPhrase`     | Génère une passphrase lisible et robuste |
| `Get-CryptoIndex`    | Générateur cryptographique interne |
| `Set-ClipboardSafe`  | Copie cross-platform avec fallback |
| `Clear-ClipboardSafe`| Efface le clipboard de manière sûre |
| `Invoke-Beep`        | Feedback sonore cross-platform |

Aliases ergonomiques :

| Alias | Fonction |
|-------|----------|
| `sgp` | `Get-PassPhrase` |
| `sgw` | `Get-PassWord` |

---

# 📝 Exemples d'utilisation

## 🔑 Générer un mot de passe

```powershell
Get-PassWord
```

Avec symboles :

```powershell
Get-PassWord -Symbols
```

Copier automatiquement :

```powershell
Get-PassWord -Copy
```

---

## 🧠 Générer une passphrase

```powershell
Get-PassPhrase
```

6 mots :

```powershell
Get-PassPhrase -Words 6
```

Copier sans beep :

```powershell
Get-PassPhrase -Copy -Silent
```

---

# 🖥️ Compatibilité

| Plateforme | Support |
|------------|---------|
| Windows PowerShell 5.1 | ✔ (fallback Legacy) |
| PowerShell 7+ Windows | ✔ (version moderne) |
| PowerShell 7+ Linux | ✔ |
| PowerShell 7+ macOS | ✔ |

Clipboard géré automatiquement via :

- Windows : `Set-Clipboard`
- macOS : `pbcopy`
- Linux : `xclip` ou `xsel`

---

# 🧱 Architecture du module

SecureGen charge automatiquement la bonne version :

```
src/
│
├── Core.PS7.ps1      # Version moderne (RandomNumberGenerator)
└── Legacy.PS5.ps1    # Version fallback (RNGCryptoServiceProvider)
```

Module principal :

```
SecureGen.psm1
```

Manifest :

```
SecureGen.psd1
```

---

# 🎨 Identité visuelle

La palette officielle SecureGen est disponible dans :

```
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

```
SecureGen/
│
├── src/
│   ├── Core.PS7.ps1
│   ├── Legacy.PS5.ps1
│   ├── SecureGen.psm1
│   └── SecureGen.psd1
│
├── assets/
│   ├── logo.png
│   ├── banner.png
│   └── palette.md
│
├── docs/
│	├── advanced.md
│	├── architecture.md 
│	├── examples.md
│	├── faq.md
│	├── installation.md
│	├── security.md
│	├── contrubuting.md
│	├── index.md
│   ├── release-process.md
│   ├── versioning.md
│	└── troubleshooting.md
│	
├── Install-SecureGen.ps1
├── Publish-SecureGen.ps1
├── Versioning-SecureGen.ps1
├── Release-All.ps1
├── build.ps1
├── CHANGELOG.md
├── README.md
├── LICENSE
└── .gitignore
```

---

# 📜 Licence

SecureGen est distribué sous licence **MIT**.

---

# 🤝 Contributions

Les contributions sont les bienvenues :

- Pull Requests  
- Issues  
- Suggestions d’amélioration  

---

# ⭐ Remerciements

Merci d’utiliser SecureGen — un module conçu pour être **simple**, **sécurisé**, et **agréable à utiliser**.

---