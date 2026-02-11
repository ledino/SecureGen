# 🧱 Architecture interne — SecureGen  
*(Version synchronisée avec la structure actuelle du module)*

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

Cette version est chargée automatiquement lorsque PowerShell 7 ou supérieur est détecté.  
Elle utilise :

- `Get-SecureRandom` (si disponible)
- `RandomNumberGenerator.GetBytes()` (.NET 6+)
- un clipboard totalement cross‑platform
- un code plus performant et plus lisible
- une génération cryptographique conforme aux recommandations modernes

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
│   └── SecureGen.psd1             # Manifest du module
│
├── assets/                        # Identité visuelle & médias
│   ├── logo.png
│   ├── banner.png
│   ├── blanc_pur.png
│   ├── bleu_clair.png
│   ├── bleu_fonce.png
│   ├── cyan_vibrant.png
│   ├── gris_anthracite.png
│   ├── palette.md
│   └── screenshots/               # Nouveaux GIFs & captures d’écran
│       ├── password-demo.gif
│       ├── passphrase-demo.gif
│       ├── clipboard-demo.gif
│       ├── script-demo.png
│       └── github-actions-demo.png
│
├── docs/                          # Documentation complète
│   ├── index.md                   # Page d’accueil de la documentation
│   ├── installation.md            # Guide d’installation complet
│   ├── examples.md                # Exemples d’utilisation
│   ├── advanced.md                # Guide avancé
│   ├── architecture.md            # Architecture interne (PS5/PS7)
│   ├── security.md                # Guide de sécurité (NIST / OWASP / ANSSI)
│   ├── contributing.md            # Guide de contribution
│   ├── troubleshooting.md         # Dépannage
│   ├── versioning.md              # Versioning & SemVer
│   ├── release-process.md         # Processus de release complet
│   ├── faq.md                     # Questions fréquentes
│   ├── benchmarks.md              # Benchmarks (nouveau)
│   └── screenshots.md             # Screenshots & GIFs (nouveau)
│
├── scripts/                       # Scripts internes & CI/CD
│   ├── build.ps1                  # Build + tests + packaging
│   ├── Versioning-SecureGen.ps1   # Gestion automatique de version
│   ├── Install-SecureGen.ps1      # Installation locale
│   ├── Publish-SecureGen.ps1      # Publication PSGallery
│   └── Release-All.ps1            # Pipeline complet de release
│
├── .github/
│   └── workflows/
│       └── ci.yml                 # Workflow CI/CD unique (tests + publish)
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

# 🛠️ Scripts intégrés

## build.ps1
- Nettoyage  
- Packaging  
- Tests Pester  
- Publication optionnelle  

## Versioning-SecureGen.ps1
- Versioning SemVer automatique  
- Mise à jour du manifest  

## Publish-SecureGen.ps1
- Publication PSGallery  
- Vérification de la clé API  

## Release-All.ps1
- Pipeline complet : versioning + build + publication  

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

- 📦 Installation : [https://github.com/ledino/SecureGen/blob/main/docs/installation.md](https://github.com/ledino/SecureGen/blob/main/docs/installation.md)  
- 📘 Exemples : `https://github.com/ledino/SecureGen/blob/main/docs/examples.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fexamples.md")  
- 🧠 Guide avancé : `https://github.com/ledino/SecureGen/blob/main/docs/advanced.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fadvanced.md")  
- 🧪 Versioning : `https://github.com/ledino/SecureGen/blob/main/docs/versioning.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fversioning.md")  
- 🚀 Processus de release : `https://github.com/ledino/SecureGen/blob/main/docs/release-process.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Frelease-process.md")  
- 📜 README principal : `https://github.com/ledino/SecureGen/blob/main/README.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2FREADME.md")  

---


# 🎉 Merci d'utiliser SecureGen !

Pour contribuer :  
👉 Issues & Pull Requests sur GitHub

---
