# 📘 Guide d’installation — SecureGen  
*(Version synchronisée avec CI/CD, PSGallery et structure du module)*

![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/SecureGen.svg?style=for-the-badge)
![Downloads](https://img.shields.io/powershellgallery/dt/SecureGen.svg?style=for-the-badge)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%20%7C%207.x-blue?style=for-the-badge)

---

# 🚀 Installation depuis la PowerShell Gallery (recommandé)

La méthode la plus simple, propre et fiable :

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

## 🛡️ Problème courant : “Running scripts is disabled on this system”

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

Aucune action n’est requise.

---

# 🧭 Workflow d’installation & développement recommandé

SecureGen peut être utilisé de trois manières selon votre contexte :  
développement local, test comme un module installé, ou usage professionnel.

---

## 1️⃣ Développement local pur (mode développeur)

Idéal pour travailler sur le code sans installation, avec rechargement immédiat.

```powershell
# Dans PowerShell 7 (recommandé)
cd C:\Users\<vous>\Git\SecureGen
Import-Module .\SecureGen\SecureGen.psd1 -Force
```

Avantages :

- pas d’installation → pas d’uninstall  
- modifications rechargées instantanément  
- parfait pour le développement rapide  
- aucun impact sur les modules installés du système  

⚠️ À éviter en production :  
Importer via un chemin relatif contourne le PSModulePath et peut charger la mauvaise version.

---

## 2️⃣ Test “comme PSGallery” (simulation d’installation réelle)

Permet de tester SecureGen **exactement comme s’il venait de la PowerShell Gallery**.

```powershell
$ModulePath = "$HOME/Documents/PowerShell/Modules/SecureGen"

Remove-Item $ModulePath -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item .\SecureGen $ModulePath -Recurse -Force

Import-Module SecureGen -Force
```

Avantages :

- teste le module dans son environnement réel  
- valide la structure du module  
- valide le loader PS5/PS7  
- valide les exports, le manifest, les chemins  

Recommandé **avant chaque release**.

---

## 3️⃣ Usage professionnel / production

Méthode officielle :

```powershell
Install-Module SecureGen -Scope CurrentUser
```

Mise à jour :

```powershell
Update-Module SecureGen
```

Désinstallation propre :

```powershell
Uninstall-Module SecureGen
```

Avantages :

- installation propre  
- versioning géré  
- mise à jour simple  
- aucune copie manuelle  
- aucune pollution du PSModulePath  

---

# ❌ À éviter absolument

### Copier manuellement le module sans cleanup
Cela crée :

- des modules fantômes  
- des versions “Script” dans `Get-Module`  
- des conflits PS5/PS7  
- des imports instables  

### Importer SecureGen via un chemin relatif en production

```powershell
Import-Module .\SecureGen.psm1   # ❌ À éviter
```

Cela contourne :

- le manifest  
- la détection PS5/PS7  
- le PSModulePath  
- la structure du module  

---

# 🛠️ Installation via le script intelligent (développeurs)

Le dépôt inclut un script d’installation avancé :

```
scripts/Install-SecureGen.ps1
```

Il détecte automatiquement :

- PowerShell 5.1  
- PowerShell 7+  
- et installe SecureGen dans les bons chemins

### ▶️ Exécution

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
