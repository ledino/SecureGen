# 📘 Exemples d'utilisation — SecureGen  
*(Version alignée avec le README et l’architecture moderne)*

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
Get-PassWord -Length 32
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
Get-PassPhrase -MotsParBloc 6
```

## Passphrase structurée (exemple recommandé)

Cet exemple est particulièrement utile pour obtenir une passphrase :

- très lisible  
- très régulière  
- très robuste  
- idéale pour un usage quotidien ou professionnel  

```powershell
Get-PassPhrase -LettresParMot 5 -MotsParBloc 7
```

Alias équivalent :

```powershell
sgp 5 7
```

## Générer une passphrase silencieusement

```powershell
Get-PassPhrase -Silent
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
Set-ClipboardSafe "Bonjour SecureGen"
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
Invoke-Beep -Freq 1500 -Duration 300
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

---

# 🧪 Exemples combinés

## Générer un mot de passe, l’afficher, et continuer le script

```powershell
$pwd = Get-PassWord -SpecialChars '!@#?%' -Silent
Write-Host "Mot de passe généré : $pwd"
```

## Générer une passphrase longue et l’utiliser dans un script

```powershell
$phrase = Get-PassPhrase -LettresParMot 4 -MotsParBloc 5
Write-Host "Votre passphrase : $phrase"
```

---

# 🖥️ Notes de compatibilité

- Tous les exemples fonctionnent sous **Windows**, **Linux**, et **macOS**.
- Le clipboard utilise automatiquement la meilleure méthode disponible :
  - Windows : `Set-Clipboard`
  - macOS : `pbcopy`
  - Linux : `xclip` ou `xsel`
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
```

---
