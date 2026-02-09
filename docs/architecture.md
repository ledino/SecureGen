# 🧱 Architecture interne — SecureGen

Ce document décrit en détail l’architecture interne du module **SecureGen**, son fonctionnement, ses choix techniques et sa structure modulaire.  
Il est destiné aux développeurs, contributeurs et utilisateurs avancés souhaitant comprendre comment le module fonctionne en profondeur.

---

# 🔐 Vision & philosophie

SecureGen est conçu selon trois principes :

1. **Sécurité moderne**  
   Utiliser les meilleures API cryptographiques disponibles selon la version de PowerShell.

2. **Compatibilité maximale**  
   Fonctionner aussi bien sous **PowerShell 7+** que sous **Windows PowerShell 5.1**.

3. **Expérience utilisateur fluide**  
   Clipboard cross‑platform, beep encapsulé, alias ergonomiques, code propre.

---

# 🧩 Architecture modulaire PS7 / PS5

SecureGen utilise une architecture à deux implémentations :

```
src/
│
├── Core.PS7.ps1      # Version moderne (PowerShell 7+)
└── Legacy.PS5.ps1    # Version fallback (PowerShell 5.1)
```

## ▶️ Core.PS7.ps1 (PowerShell 7+)

Cette version utilise :

- `RandomNumberGenerator.GetBytes()`  
- `Get-SecureRandom` (si disponible)  
- API .NET 6+  
- Clipboard cross‑platform complet  
- Code optimisé et plus performant  

## ▶️ Legacy.PS5.ps1 (Windows PowerShell 5.1)

Fallback basé sur :

- `RNGCryptoServiceProvider`  
- Clipboard limité à Windows  
- Compatibilité .NET Framework 4.8  
- API plus ancienne mais toujours sécurisée  

---

# 🔍 Détection automatique de la version PowerShell

Le fichier principal `SecureGen.psm1` charge automatiquement la bonne implémentation :

```powershell
if ($PSVersionTable.PSVersion.Major -ge 7) {
    . "$PSScriptRoot/src/Core.PS7.ps1"
}
else {
    . "$PSScriptRoot/src/Legacy.PS5.ps1"
}
```

Aucune action n’est requise de la part de l’utilisateur.

---

# 📦 Structure complète du module

```
SecureGen/
│
├── src/
│   ├── Core.PS7.ps1
│   ├── Legacy.PS5.ps1
│   ├── SecureGen.psm1
│   └── SecureGen.psd1
│
├── assets/
│   ├── logo.png
│   ├── banner.png
│   └── palette.md
│
├── docs/
│	├── advanced.md
│	├── architecture.md 
│	├── examples.md
│	├── faq.md
│	├── installation.md
│	├── security.md
│	├── contrubuting.md
│	├── index.md
│   ├── release-process.md
│   ├── versioning.md
│	└── troubleshooting.md
│	
├── Install-SecureGen.ps1
├── Publish-SecureGen.ps1
├── build.ps1
├── CHANGELOG.md
├── README.md
├── LICENSE
└── .gitignore
```

---

# 🔐 Détails cryptographiques

## PowerShell 7+
- `RandomNumberGenerator.GetBytes()`  
- `Get-SecureRandom` (si disponible)  
- Entropie élevée  
- API moderne, performante et cross‑platform  

## PowerShell 5.1
- `RNGCryptoServiceProvider`  
- API .NET Framework  
- Fallback sécurisé mais moins moderne  

---

# 📋 Clipboard cross‑platform

SecureGen gère automatiquement le presse‑papier selon la plateforme :

| OS | Méthode |
|----|---------|
| Windows | `Set-Clipboard` |
| macOS | `pbcopy` |
| Linux | `xclip` ou `xsel` |

Fallback propre avec warnings si non disponible.

---

# 🔔 Beep encapsulé

Le beep est encapsulé pour éviter les erreurs :

- Windows : OK  
- Linux/macOS : silencieux si non supporté  

```powershell
Invoke-Beep
```

---

# 🧠 Générateur cryptographique interne

La fonction `Get-CryptoIndex` est le cœur du module :

- PS7 : `Get-SecureRandom` ou `RandomNumberGenerator.GetBytes()`  
- PS5 : `RNGCryptoServiceProvider`  
- Retourne un index sécurisé entre `0` et `Max - 1`  

Utilisé par :

- `Get-PassWord`  
- `Get-PassPhrase`  

---

# 🧰 Design des fonctions

## Get-PassWord
- Génération caractère par caractère  
- Pool configurable (minuscules, majuscules, chiffres, symboles)  
- Option `-Copy` et `-Silent`  

## Get-PassPhrase
- Liste de mots sélectionnés pour lisibilité + entropie  
- Séparateur `-`  
- Option `-Copy` et `-Silent`  

## Aliases
- `sgp` → `Get-PassPhrase`  
- `sgw` → `Get-PassWord`  

---

# 🛠️ Scripts intégrés

## Install-SecureGen.ps1
- Détection PS5 / PS7  
- Installation dans tous les environnements disponibles  

## Publish-SecureGen.ps1
- Publication PSGallery  
- Vérification de la clé API  

## build.ps1
- Nettoyage  
- Packaging  
- Tests Pester  
- Publication optionnelle  

---

# 🧱 Philosophie de maintenance

- Code clair et modulaire  
- Pas de dépendances externes  
- Pas de stockage de secrets  
- Compatibilité maximale  
- Documentation complète  
- Architecture prête pour CI/CD  

---

# 🎉 Merci d'utiliser SecureGen !

Pour contribuer :  
👉 Issues & Pull Requests sur GitHub

---
