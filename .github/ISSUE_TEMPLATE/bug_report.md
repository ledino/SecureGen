
---
name: "🐛 Bug Report"
about: Signaler un problème avec SecureGen
title: "[BUG] "
labels: bug
assignees: ""
---

# 🐛 Bug Report — SecureGen

Merci de prendre le temps de signaler un bug.  
Veuillez fournir les informations ci‑dessous pour faciliter l’analyse.

---

## 🔍 Description du bug

Décrivez clairement le problème rencontré :

- Quel comportement observé ?
- Quel comportement attendu ?
- Depuis quand le problème apparaît‑il ?

---

## 🧪 Étapes pour reproduire

Merci de fournir un exemple minimal :

```powershell
# Exemple
Get-PassWord -Len 20
```

---

## 📄 Sortie / Logs

Ajoutez ici :

- messages d’erreur
- output PowerShell
- captures d’écran (optionnel)

---

## 🖥️ Environnement

Merci de préciser :

- Version SecureGen :  
  ```powershell
  (Get-Module SecureGen).Version
  ```
- Version PowerShell :  
  ```powershell
  $PSVersionTable
  ```
- OS : Windows / Linux / macOS  
- Mode d’installation : PSGallery / Script / GitHub Release

---

## 🧩 Contexte

Ce bug concerne :

- [ ] `Get-PassWord`
- [ ] `Get-PassPhrase`
- [ ] `Get-PKIPass`
- [ ] Clipboard (`Set-ClipboardSafe`, `Clear-ClipboardSafe`)
- [ ] `Get-CryptoIndex`
- [ ] `Invoke-Beep`
- [ ] Loader PS5/PS7
- [ ] Documentation
- [ ] CI/CD
- [ ] Autre (préciser) :

---

## 📝 Notes supplémentaires

Ajoutez toute information utile pour reproduire ou comprendre le problème.
```

---

# ✨ **Issue Template — Feature Request**

```markdown
---
name: "✨ Feature Request"
about: Proposer une amélioration ou une nouvelle fonctionnalité
title: "[FEATURE] "
labels: enhancement
assignees: ""
---

# ✨ Feature Request — SecureGen

Merci de proposer une idée pour améliorer SecureGen !

---

## 💡 Description de la fonctionnalité

Expliquez clairement :

- Quelle fonctionnalité vous souhaitez ?
- Quel problème elle résout ?
- Pourquoi elle serait utile ?

---

## 🧩 Contexte

Cette demande concerne :

- [ ] `Get-PassWord`
- [ ] `Get-PassPhrase`
- [ ] `Get-PKIPass`
- [ ] Clipboard
- [ ] SecureString
- [ ] Architecture PS5/PS7
- [ ] Documentation
- [ ] Scripts internes
- [ ] CI/CD
- [ ] Autre (préciser) :

---

## 📝 Exemple d’utilisation (optionnel)

Si possible, proposez une syntaxe :

```powershell
# Exemple
Get-PKIPass -Type Passphrase -Words 8 -Len 12 -AsSecureString
```

---

## 🚀 Bénéfices attendus

- En quoi cette fonctionnalité améliore‑t‑elle SecureGen ?
- Quels cas d’usage cela débloque‑t‑il ?

---

## 🔧 Alternatives envisagées

Avez‑vous déjà essayé d’autres solutions ?

---

## 📎 Notes supplémentaires

Ajoutez toute information utile, diagramme, lien, capture, etc.

---
