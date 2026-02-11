# 📘 Guide d’installation — SecureGen
*(Version synchronisée avec CI/CD, PSGallery et structure du module)*

![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/SecureGen.svg?style=for-the-badge)
![Downloads](https://img.shields.io/powershellgallery/dt/SecureGen.svg?style=for-the-badge)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%20%7C%207.x-blue?style=for-the-badge)

---

# 🚀 Installation depuis la PowerShell Gallery

La méthode la plus simple et recommandée :

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

# 📦 Installation depuis GitHub Release

Télécharger la dernière version :

👉 `https://github.com/ledino/SecureGen/releases/latest` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Freleases%2Flatest")

---

# 🧠 Compatibilité PowerShell

SecureGen fonctionne automatiquement dans :

| Environnement | Support |
|---------------|---------|
| Windows PowerShell 5.1 | ✔ |
| PowerShell 7+ Windows | ✔ |
| PowerShell 7+ Linux | ✔ |
| PowerShell 7+ macOS | ✔ |

Le module charge automatiquement :

- `Core.PS7.ps1` pour PowerShell 7+
- `Legacy.PS5.ps1` pour Windows PowerShell 5.1

---

# 🛠️ Installation via le script intelligent (développeurs)

Le dépôt inclut un script d’installation avancé :

```
scripts/Install-SecureGen.ps1
```

Il détecte automatiquement :

- PowerShell 5.1  
- PowerShell 7+  
- et installe SecureGen dans tous les environnements disponibles

## ▶️ Exécution

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

ou :

```powershell
./scripts/Install-SecureGen.ps1
```

---

# 🧱 Installation manuelle (développeurs)

Clonez le dépôt :

```powershell
git clone https://github.com/ledino/SecureGen
cd SecureGen
```

### ▶️ PowerShell 7+

```powershell
Copy-Item "./SecureGen" "$HOME/Documents/PowerShell/Modules/SecureGen" -Recurse -Force
```

### ▶️ Windows PowerShell 5.1

```powershell
Copy-Item "./SecureGen" "$HOME/Documents/WindowsPowerShell/Modules/SecureGen" -Recurse -Force
```

---

# 🧪 Vérification

```powershell
Get-Module SecureGen -ListAvailable
```

---

# 🧰 Dépannage

### ❗ Clipboard non fonctionnel

- Windows : `Set-Clipboard`
- macOS : `pbcopy`
- Linux : installer `xclip` ou `xsel`

```bash
sudo apt install xclip
```

### ❗ Module non détecté

Vérifiez :

```powershell
$env:PSModulePath -split ';'
```

---

# 📜 Changelog

👉 `https://github.com/ledino/SecureGen/blob/main/CHANGELOG.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2FCHANGELOG.md")

---

# 🎉 Installation terminée !

SecureGen est maintenant prêt :

```powershell
Get-PassWord
Get-PassPhrase
```
```

---

