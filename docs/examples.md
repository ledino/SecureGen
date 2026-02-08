# 📄 **docs/examples.md — COMPLET**

```markdown
# 📘 Exemples d'utilisation — SecureGen

Ce document présente des exemples pratiques et avancés pour exploiter pleinement les fonctionnalités du module **SecureGen**.

---

# 🔑 Génération de mots de passe

## Mot de passe simple (16 caractères)

```powershell
Get-PassWord
```

## Mot de passe avec symboles

```powershell
Get-PassWord -Symbols
```

## Mot de passe plus long (32 caractères)

```powershell
Get-PassWord -Length 32
```

## Copier automatiquement dans le presse‑papier

```powershell
Get-PassWord -Copy
```

## Copier sans beep

```powershell
Get-PassWord -Copy -Silent
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

## Copier automatiquement

```powershell
Get-PassPhrase -Copy
```

## Copier sans beep

```powershell
Get-PassPhrase -Copy -Silent
```

---

# 🔐 Génération cryptographique interne

## Obtenir un index aléatoire sécurisé

```powershell
Get-CryptoIndex -Max 100
```

Cela renvoie un entier compris entre `0` et `99`, basé sur un générateur cryptographique.

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

## Générer un mot de passe, le copier, et afficher un message

```powershell
$pwd = Get-PassWord -Symbols -Copy
Write-Host "Mot de passe généré et copié : $pwd"
```

## Générer une passphrase longue et l’utiliser dans un script

```powershell
$phrase = Get-PassPhrase -Words 8
Write-Host "Votre passphrase : $phrase"
```

---

# 📦 Notes

- Tous les exemples fonctionnent sous **Windows**, **Linux**, et **macOS**.
- Le clipboard utilise automatiquement la meilleure méthode disponible.
- Le beep est encapsulé pour éviter les erreurs sur les systèmes qui ne le supportent pas.

---

# 🎉 Merci d'utiliser SecureGen !

N'hésitez pas à contribuer via GitHub : issues, PR, suggestions.
```

---
