# 📘 Exemples d'utilisation — SecureGen  
*(Version alignée avec SecureGen 1.5.0)*

Ce document présente des exemples pratiques et avancés pour exploiter pleinement les fonctionnalités du module **SecureGen**.

---

# 🔑 Génération de mots de passe

## Mot de passe simple (16 caractères)

```powershell
Get-PassWord
```

## Mot de passe avec caractères spéciaux personnalisés

```powershell
Get-PassWord -SpecialChars '!@#?%'
```

## Désactiver les caractères spéciaux

```powershell
Get-PassWord -UseSpecial:$false
```

## Mot de passe plus long (32 caractères)

```powershell
Get-PassWord -Len 32
```

Alias équivalent :

```powershell
sgw 32
```

## Générer un mot de passe silencieusement (sans beep)

```powershell
Get-PassWord -Silent
```

---

# 🧠 Génération de passphrases

## Passphrase standard (4 mots)

```powershell
Get-PassPhrase
```

## Passphrase longue (6 mots)

```powershell
Get-PassPhrase -Words 6
```

## Passphrase structurée (exemple recommandé)

```powershell
Get-PassPhrase -Words 7 -Len 5
```

Alias équivalent :

```powershell
sgp 7 5
```

## Générer une passphrase silencieusement

```powershell
Get-PassPhrase -Silent
```

---

# 🔐 Génération PKI (Get‑PKIPass)

`Get-PKIPass` est conçu pour les usages sensibles :  
certificats, clés privées, comptes de service, KMS, automatisation sécurisée, etc.

## Mot de passe PKI par défaut (32 caractères)

```powershell
Get-PKIPass
```

## Mot de passe PKI personnalisé (48 caractères)

```powershell
Get-PKIPass -Type Password -Length 48
```

## Passphrase PKI par défaut (5×5)

```powershell
Get-PKIPass -Type Passphrase
```

## Passphrase PKI personnalisée (8 mots × 10 lettres)

```powershell
Get-PKIPass -Type Passphrase -Words 8 -Len 10
```

## Retour en SecureString (KMS, AD, DSC, comptes de service)

```powershell
$secure = Get-PKIPass -AsSecureString
```

## Utilisation dans un PSCredential

```powershell
$cred = New-Object pscredential "svc-kms", (Get-PKIPass -AsSecureString)
```

## Alias rapide

```powershell
sgpki
```

---

# 🔐 Génération cryptographique interne

## Obtenir un index aléatoire sécurisé

```powershell
Get-CryptoIndex -Max 100
```

Renvoie un entier compris entre `0` et `99`, basé sur un générateur cryptographique sécurisé.

---

# 📋 Gestion du presse‑papier

## Copier une valeur arbitraire

```powershell
Set-ClipboardSafe -Text "SecureGen"
```

## Effacer le presse‑papier

```powershell
Clear-ClipboardSafe
```

---

# 🔔 Beep cross‑platform

## Beep standard

```powershell
Invoke-Beep
```

## Beep personnalisé

```powershell
Invoke-Beep -Frequency 1500 -Duration 300
```

---

# 🧩 Aliases ergonomiques

## Générer une passphrase rapidement

```powershell
sgp
```

## Générer un mot de passe rapidement

```powershell
sgw
```

## Générer un secret PKI rapidement

```powershell
sgpki
```

---

# 🧪 Exemples combinés

## Générer un mot de passe, l’afficher, et continuer le script

```powershell
$pwd = Get-PassWord -SpecialChars '!@#?%' -Silent
Write-Host "Mot de passe généré : $pwd"
```

## Générer une passphrase longue et l’utiliser dans un script

```powershell
$phrase = Get-PassPhrase -Words 5 -Len 8
Write-Host "Votre passphrase : $phrase"
```

## Générer un secret PKI et l’utiliser dans un credential

```powershell
$cred = New-Object pscredential "svc-backup", (Get-PKIPass -AsSecureString)
```

---

# 🖥️ Notes de compatibilité

- Tous les exemples fonctionnent sous **Windows**, **Linux**, et **macOS**.
- Le clipboard utilise automatiquement la meilleure méthode disponible :
  - Windows : `Set-Clipboard`
  - macOS : `pbcopy`
  - Linux : `wl-copy`, `xclip`, `xsel`
- SecureGen charge automatiquement la version adaptée :
  - **Core.PS7.ps1** pour PowerShell 7+
  - **Legacy.PS5.ps1** pour Windows PowerShell 5.1

---

# 📚 Documentation associée

- `installation.md`
- `advanced.md`
- `README.md`

---

# 🎉 Merci d'utiliser SecureGen !

N'hésitez pas à contribuer via GitHub : issues, PR, suggestions.

---
