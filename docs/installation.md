# 📘 Guide d’installation — SecureGen

Ce document explique comment installer le module **SecureGen** dans différents environnements :  
Windows PowerShell 5.1, PowerShell 7+, Linux, macOS, et via le script d’installation intelligent fourni dans le dépôt.

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

Importer explicitement (facultatif) :

```powershell
Import-Module SecureGen
```

---

# 🧠 Compatibilité PowerShell

SecureGen fonctionne automatiquement dans :

| Environnement | Support |
|---------------|---------|
| Windows PowerShell 5.1 | ✔ (fallback Legacy) |
| PowerShell 7+ Windows | ✔ (version moderne) |
| PowerShell 7+ Linux | ✔ |
| PowerShell 7+ macOS | ✔ |

Le module charge automatiquement la bonne version :

- `Core.PS7.ps1` pour PowerShell 7+  
- `Legacy.PS5.ps1` pour Windows PowerShell 5.1  

Aucune action n’est requise de la part de l’utilisateur.

---

# 🛠️ Installation via le script intelligent (recommandé pour les développeurs)

Le dépôt inclut un script d’installation avancé :

```
Install-SecureGen.ps1
```

Il détecte automatiquement :

- si PowerShell 5.1 est installé  
- si PowerShell 7+ est installé  
- et installe SecureGen dans **tous les environnements disponibles**

## ▶️ Exécution

```powershell
.\Install-SecureGen.ps1
```

## 📦 Résultat

- Si PS5 est présent → installation dans  
  `%USERPROFILE%\Documents\WindowsPowerShell\Modules\SecureGen`

- Si PS7 est présent → installation dans  
  `%USERPROFILE%\Documents\PowerShell\Modules\SecureGen`

- Si les deux sont présents → installation dans les deux environnements

---

# 🧱 Installation manuelle (développeurs)

Clonez le dépôt :

```powershell
git clone https://github.com/<ton-user>/SecureGen
cd SecureGen
```

Copiez le module dans votre dossier Modules :

### ▶️ PowerShell 7+

```powershell
Copy-Item -Path "./src" -Destination "$HOME/Documents/PowerShell/Modules/SecureGen" -Recurse
```

### ▶️ Windows PowerShell 5.1

```powershell
Copy-Item -Path "./src" -Destination "$HOME/Documents/WindowsPowerShell/Modules/SecureGen" -Recurse
```

---

# 🧪 Vérification de l’installation

```powershell
Get-Module SecureGen -ListAvailable
```

Vous devriez voir :

```
ModuleType Version Name       ExportedCommands
---------- ------- ----       ----------------
Script     1.3.1   SecureGen  Get-PassWord, Get-PassPhrase, ...
```

---

# 🧰 Dépannage

### ❗ Le clipboard ne fonctionne pas

- Windows : `Set-Clipboard` doit être disponible  
- macOS : installez `pbcopy` (inclus par défaut)  
- Linux : installez `xclip` ou `xsel`  

Exemple :

```bash
sudo apt install xclip
```

### ❗ Le module n’apparaît pas dans PS5 ou PS7

Vérifiez les chemins :

```powershell
$env:PSModulePath -split ';'
```

Assurez-vous que :

- `%USERPROFILE%\Documents\WindowsPowerShell\Modules`
- `%USERPROFILE%\Documents\PowerShell\Modules`

sont bien présents.

---

# 🎉 Installation terminée !

SecureGen est maintenant prêt à être utilisé :

```powershell
Get-PassWord
Get-PassPhrase
```

Pour plus d’exemples :  
👉 `docs/examples.md`

Pour les usages avancés :  
👉 `docs/advanced.md`

---
