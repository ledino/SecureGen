# 📘 **docs/troubleshooting.md — Dépannage & problèmes courants**

# 🛠️ Dépannage — SecureGen

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
- Le module n’a pas été installé dans le bon dossier.
- Le chemin `$env:PSModulePath` n’inclut pas le dossier Modules utilisateur.
- Le script d’installation n’a pas été exécuté.

## Solutions
### 1. Vérifier les chemins
```powershell
$env:PSModulePath -split ';'
```

### 2. Réinstaller avec le script intelligent
```powershell
.\Install-SecureGen.ps1
```

### 3. Installer depuis PSGallery
```powershell
Install-Module SecureGen -Scope CurrentUser
```

---

# ❗ Le clipboard ne fonctionne pas

## Symptôme
- Rien n’est copié.
- Un warning apparaît :  
  *"Clipboard non disponible sur ce système"*

## Causes possibles
- Linux : `xclip` ou `xsel` non installés.
- macOS : `pbcopy` absent (rare).
- Windows : `Set-Clipboard` inaccessible (session distante, sandbox).

## Solutions
### Linux
Installer un utilitaire :

```bash
sudo apt install xclip
```
ou :
```bash
sudo apt install xsel
```

### macOS
`pbcopy` est normalement présent.  
Si absent, réinstaller les outils système.

### Windows
Vérifier que `Set-Clipboard` fonctionne :

```powershell
"test" | Set-Clipboard
```

---

# ❗ Le beep ne fonctionne pas

## Symptôme
Aucun son n’est émis.

## Causes possibles
- Terminal Linux sans support sonore.
- macOS sans accès au système audio.
- Environnement distant (SSH, VSCode Remote, Docker).

## Solution
Aucune action requise.  
SecureGen **ignore automatiquement l’erreur** et continue normalement.

Pour désactiver le beep :

```powershell
- Silent
```

---

# ❗ Le module ne fonctionne pas sous PowerShell 5.1

## Symptôme
- Erreurs liées à des API modernes.
- Fonctions non reconnues.

## Causes possibles
- Mauvaise installation.
- Version PS7 chargée par erreur.
- Fichiers manquants dans `src/`.

## Solutions
### 1. Vérifier la version PowerShell
```powershell
$PSVersionTable.PSVersion
```

### 2. Réinstaller le module
```powershell
.\Install-SecureGen.ps1
```

### 3. Vérifier la présence des fichiers
```
src/Core.PS7.ps1
src/Legacy.PS5.ps1
src/SecureGen.psm1
src/SecureGen.psd1
```

---

# ❗ Le module charge la mauvaise version (PS5/PS7)

## Symptôme
- PS7 charge la version Legacy.
- PS5 charge la version Core.

## Causes possibles
- Fichiers déplacés.
- Structure incorrecte.
- Mauvais chemin d’installation.

## Solution
Vérifier que `SecureGen.psm1` contient bien :

```powershell
if ($PSVersionTable.PSVersion.Major -ge 7) {
    . "$PSScriptRoot/src/Core.PS7.ps1"
}
else {
    . "$PSScriptRoot/src/Legacy.PS5.ps1"
}
```

---

# ❗ Erreur lors de la publication PSGallery

## Symptôme
- Erreur `NuGetApiKey`
- Erreur `Unauthorized`
- Erreur `Repository not found`

## Causes possibles
- Clé API absente.
- Clé API expirée.
- Mauvais repository.

## Solutions
### 1. Définir la clé API
```powershell
$env:PSGALLERY_KEY = "votre_clé"
```

### 2. Publier
```powershell
.\build.ps1 -Publish
```

---

# ❗ Le module ne se charge pas dans un script CI/CD

## Symptôme
`Install-Module` échoue dans GitHub Actions ou Azure DevOps.

## Causes possibles
- Pas de profil utilisateur.
- Pas de dossier Modules.
- Droits insuffisants.

## Solutions
### GitHub Actions
Ajouter :

```yaml
- name: Créer dossier Modules
  run: mkdir -p $HOME/Documents/PowerShell/Modules
```

### Azure DevOps
Utiliser :

```yaml
Install-Module SecureGen -Force -Scope CurrentUser
```

---

# ❗ Les mots de passe générés semblent “trop simples”

## Symptôme
- Pas assez de symboles.
- Pas assez de longueur.

## Solutions
### Ajouter des symboles
```powershell
Get-PassWord -Symbols
```

### Augmenter la longueur
```powershell
Get-PassWord -Length 32
```

### Générer une passphrase plus robuste
```powershell
Get-PassPhrase -Words 8
```

---

# ❗ Le clipboard contient encore un ancien mot de passe

## Solution
Effacer le presse‑papier :

```powershell
Clear-ClipboardSafe
```

---

# 🎉 Besoin d’aide supplémentaire ?

Consultez :

- `docs/faq.md`
- `docs/installation.md`
- `docs/advanced.md`
- `docs/architecture.md`

Ou ouvrez une **Issue GitHub** pour obtenir de l’aide.

---
