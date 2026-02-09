# 🔐 Guide de sécurité — SecureGen

Ce document présente les principes de sécurité utilisés par **SecureGen**, ainsi que les bonnes pratiques recommandées pour intégrer le module dans des environnements professionnels.

---

# 🧱 Architecture de sécurité

SecureGen repose sur une architecture modulaire permettant d’utiliser la meilleure API cryptographique disponible selon la version de PowerShell :

| Version PowerShell | Implémentation | API utilisée |
|-------------------|----------------|--------------|
| PowerShell 7+     | Core.PS7.ps1   | `RandomNumberGenerator.GetBytes()` + `Get-SecureRandom` |
| PowerShell 5.1    | Legacy.PS5.ps1 | `RNGCryptoServiceProvider` |

Le module sélectionne automatiquement la version la plus sécurisée disponible.

---

# 🔐 Génération cryptographique

## PowerShell 7+ (recommandé)
SecureGen utilise :

- `System.Security.Cryptography.RandomNumberGenerator.GetBytes()`
- `Get-SecureRandom` (si disponible)

Ces API sont basées sur **.NET 6+**, offrant :

- génération cryptographiquement sûre  
- absence de biais statistique  
- performance élevée  
- compatibilité cross‑platform  

## PowerShell 5.1 (fallback)
Fallback basé sur :

- `RNGCryptoServiceProvider`

Toujours sécurisé, mais API plus ancienne.

---

# 🧠 Entropie & robustesse

### Mots de passe
SecureGen génère des mots de passe :

- aléatoires  
- non prédictibles  
- basés sur un pool configurable (minuscules, majuscules, chiffres, symboles)

### Passphrases
Les passphrases sont générées à partir d’une liste de mots soigneusement sélectionnés :

- lisibles  
- mémorisables  
- suffisamment variés pour garantir une bonne entropie  

---

# 🛡️ Bonnes pratiques d’utilisation

## 1. Ne jamais stocker un mot de passe en clair
Évitez :

```powershell
Set-Content "pwd.txt" (Get-PassWord)
```

Préférez :

```powershell
(Get-PassWord) | ConvertTo-SecureString -AsPlainText -Force
```

## 2. Utiliser des passphrases pour les clés API
Les passphrases sont souvent plus adaptées que les mots de passe courts.

## 3. Utiliser `-Silent` dans les scripts automatisés
Pour éviter les beeps dans les pipelines CI/CD :

```powershell
Get-PassWord -Copy -Silent
```

## 4. Ne jamais logguer un secret
Évitez :

```powershell
Write-Host "Mot de passe : $pwd"
```

## 5. Utiliser des variables d’environnement pour les secrets
Exemple :

```powershell
$env:API_KEY = Get-PassPhrase -Words 6
```

---

# 📋 Sécurité du presse‑papier

SecureGen gère automatiquement le clipboard :

- Windows : `Set-Clipboard`
- macOS : `pbcopy`
- Linux : `xclip` ou `xsel`

### ⚠️ Attention
Le presse‑papier n’est **pas un espace sécurisé**.

Évitez de laisser un secret trop longtemps dans le clipboard :

```powershell
Clear-ClipboardSafe
```

---

# 🧪 Sécurité dans les pipelines CI/CD

## GitHub Actions

```yaml
steps:
  - name: Installer SecureGen
    run: Install-Module SecureGen -Scope CurrentUser -Force

  - name: Générer un secret
    shell: pwsh
    run: |
      $pwd = Get-PassWord -Symbols
      echo "SECRET=$pwd" >> $GITHUB_ENV
```

## Azure DevOps

```yaml
- powershell: |
    Install-Module SecureGen -Force
    $key = Get-PassPhrase -Words 8
    Write-Host "##vso[task.setvariable variable=API_KEY]$key"
```

---

# 🧰 Sécurisation dans vos propres scripts

## Convertir un mot de passe en SecureString

```powershell
$pwd = Get-PassWord -Symbols
$secure = ConvertTo-SecureString $pwd -AsPlainText -Force
```

## Utiliser un mot de passe pour créer un utilisateur

```powershell
$pwd = Get-PassWord -Symbols
New-LocalUser -Name "test" -Password (ConvertTo-SecureString $pwd -AsPlainText -Force)
```

---

# 🧱 Sécurité du code source

SecureGen suit les bonnes pratiques :

- `Set-StrictMode -Version Latest`
- pas de variables globales
- pas de dépendances externes
- pas de stockage de secrets
- pas de logs sensibles
- code compatible Windows/Linux/macOS

---

# 🛡️ Recommandations générales

- Utilisez PowerShell 7+ dès que possible  
- Préférez les passphrases pour les tokens  
- Effacez le clipboard après usage  
- Ne stockez jamais un secret en clair  
- Utilisez des SecureString ou des variables d’environnement  
- Activez `-Silent` dans les scripts automatisés  

---

# 🎉 Merci d'utiliser SecureGen !

Pour toute suggestion ou contribution :  
👉 GitHub — Issues & Pull Requests

---
