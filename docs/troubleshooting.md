# 🛠️ Dépannage — SecureGen  
*(Aligné avec l’architecture moderne et le pipeline CI/CD)*

Cette page regroupe les problèmes les plus fréquents rencontrés avec **SecureGen**, ainsi que leurs solutions.  
Elle couvre PowerShell 5.1, PowerShell 7+, Windows, Linux et macOS.

---

# ❗ Le module n’apparaît pas dans PowerShell

## Symptôme

```powershell
Get-Module SecureGen -ListAvailable
```

ne retourne rien.

## Causes possibles

- Module installé dans un mauvais dossier  
- `$env:PSModulePath` incorrect  
- Installation incomplète  
- Conflit entre PS5.1 et PS7  

## Solutions

### 1. Vérifier les chemins

```powershell
$env:PSModulePath -split ';'
```

### 2. Réinstaller proprement

```powershell
Install-Module SecureGen -Scope CurrentUser -Force
```

### 3. Installation via script (développeurs)

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

---

# ❗ Impossible d’exécuter un script : “Running scripts is disabled on this system”

## Cause  
La **Execution Policy** est en mode `Restricted` (valeur par défaut sur Windows).

## Solution recommandée

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

## Exécution ponctuelle sans changer la policy

PowerShell 7+ :

```powershell
pwsh -ExecutionPolicy Bypass -File ./script.ps1
```

PowerShell 5.1 :

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\script.ps1
```

---

# ❗ Le clipboard ne fonctionne pas

## Symptôme

- Rien n’est copié  
- Warning : *"Clipboard non disponible sur ce système"*  

## Causes possibles

- Linux : `xclip` ou `xsel` manquants  
- macOS : `pbcopy` absent (rare)  
- Windows : `Set-Clipboard` indisponible (session distante, sandbox)  

## Solutions

### Linux

```bash
sudo apt install xclip
```

ou :

```bash
sudo apt install xsel
```

### macOS

`pbcopy` est normalement présent.

### Windows

Tester :

```powershell
"test" | Set-Clipboard
```

---

# ❗ Le beep ne fonctionne pas

## Symptôme

Aucun son.

## Causes possibles

- Terminal sans support audio  
- Session distante  
- Docker / WSL / VSCode Remote  

## Solution

Aucune action requise : SecureGen ignore automatiquement l’erreur.

Pour désactiver le beep :

```powershell
Get-PassWord -Silent
```

---

# ❗ Le module ne fonctionne pas sous PowerShell 5.1

## Symptôme

- Erreurs liées à des API modernes  
- Fonctions non reconnues  

## Causes possibles

- Mauvaise installation  
- Structure du module altérée  
- Version PS7 chargée par erreur  

## Solutions

### 1. Vérifier la version PowerShell

```powershell
$PSVersionTable.PSVersion
```

### 2. Réinstaller

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

### 3. Vérifier la structure

```
SecureGen/Core.PS7.ps1
SecureGen/Legacy.PS5.ps1
SecureGen/SecureGen.psm1
SecureGen/SecureGen.psd1
```

---

# ❗ Le module charge la mauvaise version (PS5/PS7)

## Symptôme

- PS7 charge Legacy  
- PS5 charge Core  

## Causes possibles

- Fichiers déplacés  
- Structure incorrecte  
- Mauvais chemin d’installation  

## Solution

Vérifier que `SecureGen.psm1` contient :

```powershell
if ($PSVersionTable.PSVersion.Major -ge 7) {
    . "$PSScriptRoot/Core.PS7.ps1"
}
else {
    . "$PSScriptRoot/Legacy.PS5.ps1"
}
```

---

# ❗ Erreurs liées à standard-version

## Symptôme

- Le bump échoue  
- Le manifest n’est pas mis à jour  
- Le changelog reste vide  

## Causes possibles

- `.version-updaters/psd1-updater.js` incorrect  
- `.versioningrc.json` mal configuré  
- Commit non conforme à Conventional Commits  

## Solutions

### Vérifier l’updater

```
.version-updaters/psd1-updater.js
```

### Vérifier la configuration

```
.versioningrc.json
```

### Vérifier les commits

Exemples valides :

```
feat: ajout du paramètre -Silent
fix: correction du clipboard Linux
```

---

# ❗ Erreurs GitHub Actions (CI)

## Symptôme

- CI rouge  
- Import du module échoue  
- PSScriptAnalyzer remonte des erreurs  

## Solutions

### 1. Vérifier l’import

```powershell
Import-Module ./SecureGen/SecureGen.psd1
```

### 2. Lancer PSScriptAnalyzer localement

```powershell
Invoke-ScriptAnalyzer -Path ./SecureGen
```

### 3. Vérifier la structure du module

---

# ❗ Erreurs GitHub Actions (release)

## Symptôme

- Le workflow release échoue  
- Le tag n’est pas créé  
- Le commit de release n’apparaît pas  

## Causes possibles

- Identité Git manquante  
- Permissions GitHub Actions insuffisantes  
- Clé API PSGallery absente  

## Solutions

### 1. Vérifier l’identité Git

```yaml
git config user.name "github-actions"
git config user.email "github-actions@github.com"
```

### 2. Vérifier le secret PSGallery

Dans GitHub → Settings → Secrets → Actions :

```
PSGALLERY_KEY
```

---

# ❗ Erreur lors de la publication PSGallery

## Symptôme

- `Unauthorized`  
- `NuGetApiKey`  
- `Repository not found`  

## Solutions

### Définir la clé API

```powershell
$env:PSGALLERY_KEY = "votre_clé"
```

### Publier

```powershell
pwsh ./scripts/build.ps1 -Publish
```

---

# ❗ Le module ne se charge pas dans un pipeline CI/CD

## Symptôme

`Install-Module` échoue.

## Solutions

### GitHub Actions

```yaml
- name: Créer dossier Modules
  run: mkdir -p $HOME/Documents/PowerShell/Modules
```

### Azure DevOps

```yaml
Install-Module SecureGen -Force -Scope CurrentUser
```

---

# ❗ Les mots de passe semblent “trop simples”

## Solutions

### Ajouter des symboles

```powershell
Get-PassWord -SpecialChars '!@#?%'
```

### Désactiver les symboles

```powershell
Get-PassWord -UseSpecial:$false
```

### Augmenter la longueur

```powershell
Get-PassWord -Length 32
```

### Passphrase robuste

```powershell
Get-PassPhrase -MotsParBloc 7 -LettresParMot 5
```

---

# ❗ Le clipboard contient encore un ancien mot de passe

## Solution

```powershell
Set-Clipboard ""
# ou
Set-Clipboard $null
```

> Note :
SecureGen ne fournit pas de fonction `Clear-ClipboardSafe`.  
Utilisez simplement `Set-Clipboard ""` pour vider le presse‑papier.


---

# 📚 Documentations associées

- `installation.md`
- `examples.md`
- `advanced.md`
- `architecture.md`
- `versioning.md`
- `release-process.md`
- `README.md`

---

# 🎉 Besoin d’aide supplémentaire ?

Consultez :

- `docs/faq.md`
- `docs/installation.md`
- `docs/advanced.md`
- `docs/architecture.md`

Ou ouvrez une **Issue GitHub**.

```

---
