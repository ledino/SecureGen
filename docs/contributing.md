# 🧱 Architecture interne — SecureGen  
*(Version synchronisée avec la structure actuelle du module et le pipeline moderne)*

Ce document décrit en détail l’architecture interne du module **SecureGen**, son fonctionnement, ses choix techniques et sa structure modulaire.  
Il est destiné aux développeurs, contributeurs et utilisateurs avancés souhaitant comprendre comment le module fonctionne en profondeur.

---

# 🔐 Vision & philosophie

SecureGen repose sur trois principes fondamentaux :

1. **Sécurité moderne**  
   Utiliser les meilleures API cryptographiques disponibles selon la version de PowerShell.

2. **Compatibilité maximale**  
   Fonctionner aussi bien sous **PowerShell 7+** que sous **Windows PowerShell 5.1**.

3. **Expérience utilisateur fluide**  
   Clipboard cross‑platform, beep encapsulé, alias ergonomiques, code propre et maintenable.

---

# 🧩 Architecture modulaire PS7 / PS5

SecureGen utilise une architecture moderne basée sur **deux implémentations distinctes**, chacune optimisée pour sa version de PowerShell :

```
SecureGen/
│
├── Core.PS7.ps1      # Implémentation moderne (PowerShell 7+)
└── Legacy.PS5.ps1    # Implémentation fallback (Windows PowerShell 5.1)
```

## ▶️ Core.PS7.ps1 (PowerShell 7+)

Chargée automatiquement lorsque PowerShell 7 ou supérieur est détecté.

Caractéristiques :

- `Get-SecureRandom` (si disponible)
- `RandomNumberGenerator.GetBytes()` (.NET 6+)
- clipboard totalement cross‑platform
- code plus performant et plus lisible
- génération cryptographique conforme aux recommandations modernes

## ▶️ Legacy.PS5.ps1 (Windows PowerShell 5.1)

Fallback sécurisé pour les environnements plus anciens :

- `RNGCryptoServiceProvider` (API .NET Framework 4.8)
- clipboard limité à Windows
- compatibilité maximale avec PS5.1
- même logique fonctionnelle, adaptée aux contraintes du Framework

---

# 🔍 Détection automatique dans SecureGen.psm1

Le fichier principal `SecureGen.psm1` agit comme un **loader intelligent**.  
Il détecte la version de PowerShell et charge automatiquement la bonne implémentation :

```powershell
if ($PSVersionTable.PSVersion.Major -ge 7) {
    . "$PSScriptRoot/Core.PS7.ps1"
}
else {
    . "$PSScriptRoot/Legacy.PS5.ps1"
}
```

Aucune action n’est requise de la part de l’utilisateur :  
👉 **tout est automatique, transparent et optimisé.**

---

# 🧠 Rôle du loader (SecureGen.psm1)

Le loader :

- charge la bonne implémentation PS7/PS5  
- expose les fonctions publiques du module  
- applique les alias ergonomiques :  
  - `sgw` → `Get-PassWord`  
  - `sgp` → `Get-PassPhrase`  
- garantit une API identique sur toutes les plateformes  
- encapsule les différences techniques entre PS5 et PS7  
- centralise la logique commune (clipboard, beep, helpers)

---

# 📦 Structure complète du module

```
SecureGen/
│
├── SecureGen/                     # Code source du module
│   ├── Core.PS7.ps1               # Implémentation moderne (PowerShell 7+)
│   ├── Legacy.PS5.ps1             # Implémentation fallback (Windows PowerShell 5.1)
│   ├── SecureGen.psm1             # Loader intelligent PS5/PS7 + export des fonctions
│   └── SecureGen.psd1             # Manifest du module (bumpé automatiquement)
│
├── assets/                        # Identité visuelle & médias
│   ├── logo.png
│   ├── banner.png
│   ├── palette.md
│   └── screenshots/
│       ├── password-demo.gif
│       ├── passphrase-demo.gif
│       ├── clipboard-demo.gif
│       ├── script-demo.png
│       └── github-actions-demo.png
│
├── docs/                          # Documentation complète
│   ├── index.md
│   ├── installation.md
│   ├── examples.md
│   ├── advanced.md
│   ├── architecture.md
│   ├── security.md
│   ├── contributing.md
│   ├── troubleshooting.md
│   ├── versioning.md
│   ├── release-process.md
│   ├── faq.md
│   ├── benchmarks.md
│   ├── screenshots.md
│   ├── generate-help.md
│   └── cmdlets/
│       ├── Get-PassWord.md
│       ├── Get-PassPhrase.md
│       ├── Get-CryptoIndex.md
│       ├── Invoke-Beep.md
│       └── SecureGen.md
│
├── scripts/                       # Scripts internes & outils dev
│   ├── build.ps1
│   ├── Install-SecureGen.ps1
│   ├── Publish-SecureGen.ps1
│   ├── Generate-Help.ps1
│   ├── Versioning-SecureGen.ps1   # (legacy, remplacé par standard-version)
│   └── Release-All.ps1            # (legacy, remplacé par GitHub Actions)
│
├── .version-updaters/             # Updaters custom pour standard-version
│   └── psd1-updater.js            # Mise à jour automatique du ModuleVersion
│
├── .github/
│   └── workflows/
│       ├── ci.yml                 # CI multi-plateformes (tests + lint)
│       └── release.yml            # Release automatisée (standard-version + PSGallery)
│
├── package.json                   # Dépendances Node + version source de vérité
├── package-lock.json              # Verrouillage des dépendances
├── .versioningrc.json             # Configuration standard-version
│
├── CHANGELOG.md                   # Changelog généré automatiquement
├── README.md                      # Documentation principale
├── LICENSE                        # Licence MIT
└── .gitignore
```

---

# 🔐 Détails cryptographiques

## PowerShell 7+
- `RandomNumberGenerator.GetBytes()`  
- `Get-SecureRandom` (si disponible)  
- entropie élevée  
- API moderne, performante et cross‑platform  

## PowerShell 5.1
- `RNGCryptoServiceProvider`  
- API .NET Framework  
- fallback sécurisé mais moins moderne  

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
- Paramètres modernes :  
  - `-SpecialChars`  
  - `-UseSpecial`  
  - `-Silent`  

## Get-PassPhrase
- Liste de mots sélectionnés pour lisibilité + entropie  
- Séparateur `-`  
- Paramètres modernes :  
  - `-MotsParBloc`  
  - `-LettresParMot`  
  - `-Silent`  

## Aliases
- `sgp` → `Get-PassPhrase`  
- `sgw` → `Get-PassWord`  

---

# 🧱 Philosophie de maintenance

- Code clair et modulaire  
- Pas de dépendances externes  
- Pas de stockage de secrets  
- Compatibilité maximale  
- Documentation complète  
- Architecture prête pour CI/CD  

---

# 📚 Documentations associées

- `docs/versioning.md`
- `docs/release-process.md`
- `docs/contributing.md`
- `docs/security.md`
- `README.md`

---

# 🎉 Merci d'utiliser SecureGen !

Pour contribuer :  
👉 Issues & Pull Requests sur GitHub
```

---
