# 🧱 Architecture interne — SecureGen  
*(Version synchronisée avec la structure actuelle du module)*

Ce document présente l’architecture interne du module **SecureGen**, son fonctionnement, ses choix techniques et la manière dont il assure une compatibilité totale entre **PowerShell 7+** et **Windows PowerShell 5.1**.

Il s’adresse aux développeurs, contributeurs et utilisateurs avancés souhaitant comprendre comment le module fonctionne en profondeur.

---

# 📘 Vue d’ensemble

SecureGen repose sur trois principes fondamentaux :

1. **Sécurité moderne**  
   Utilisation des meilleures API cryptographiques disponibles selon la version de PowerShell.

2. **Compatibilité maximale**  
   Architecture duale PS7 / PS5.1 avec implémentations séparées.

3. **Expérience utilisateur fluide**  
   Clipboard cross‑platform, beep encapsulé, alias ergonomiques, documentation complète.

---

# 📚 Diagrammes UML

Les diagrammes suivants décrivent l’architecture complète du module **SecureGen**.  
Ils sont regroupés dans le dossier `docs/diagrams/` pour une consultation claire et structurée.

### 🧩 **Diagramme des composants**  
**Fichier :** `docs/diagrams/components.md`  
Vue interne du module : orchestrateur, implémentations PS5/PS7, ressources.

### 🏗️ **Diagramme de déploiement**  
**Fichier :** `docs/diagrams/deployment.md`  
Où vivent les fichiers : poste utilisateur, PowerShell Gallery, GitHub Actions.

### 🔁 **Diagramme de séquence — Get-PassWord**  
**Fichier :** `docs/diagrams/sequence-get-password.md`  
Flux d’exécution complet d’un appel utilisateur jusqu’à la génération du mot de passe.

### 🚀 **Pipeline CI/CD**  
**Fichier :** `docs/diagrams/pipeline-ci-cd.md`  
Processus complet : développement → versioning → CI → publication PSGallery.

---

# 🧩 Architecture modulaire PS7 / PS5

SecureGen utilise deux implémentations distinctes, chacune optimisée pour son environnement :

```
SecureGen/
│
├── Core.PS7.ps1      # Implémentation moderne (PowerShell 7+)
└── Legacy.PS5.ps1    # Implémentation fallback (Windows PowerShell 5.1)
```

## ▶️ Core.PS7.ps1 (PowerShell 7+)

- `RandomNumberGenerator.GetBytes()` (.NET 6+)  
- `Get-SecureRandom` (si disponible)  
- Clipboard cross‑platform  
- API modernes et performantes  

## ▶️ Legacy.PS5.ps1 (Windows PowerShell 5.1)

- `RNGCryptoServiceProvider` (.NET Framework 4.8)  
- Clipboard Windows uniquement  
- Compatibilité maximale  
- Fonctionnalités identiques, adaptées aux contraintes du Framework  

---

# 🧠 SecureGen.psm1 — Le loader intelligent

Le fichier principal `SecureGen.psm1` agit comme un **orchestrateur** :

- détecte la version de PowerShell  
- charge automatiquement l’implémentation PS7 ou PS5  
- exporte les fonctions publiques  
- applique les alias (`sgw`, `sgp`)  
- centralise la logique commune (clipboard, beep, helpers)  

Détection automatique :

```powershell
if ($PSVersionTable.PSVersion.Major -ge 7) {
    . "$PSScriptRoot/Core.PS7.ps1"
}
else {
    . "$PSScriptRoot/Legacy.PS5.ps1"
}
```

---

# 📦 Structure complète du module

```text
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
├── docs/                          # Documentations complètes
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
│   ├── cmdlets/
│   │   ├── Get-PassWord.md
│   │   ├── Get-PassPhrase.md
│   │   ├── Get-CryptoIndex.md
│   │   ├── Invoke-Beep.md
│   │   └── SecureGen.md
│   └── diagrams/
│       ├── components.md
│       ├── deployment.md
│       ├── overview.md
│       ├── pipeline-ci-cd.md
│       └── sequence-get-password.md
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
│       └── publish.yml            # Publication automatique sur PSGallery (déclenchée par tag)
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
- `Get-SecureRandom`  
- Entropie élevée  
- API modernes et cross‑platform  

## PowerShell 5.1
- `RNGCryptoServiceProvider`  
- API .NET Framework  
- Fallback sécurisé  

---

# 📋 Clipboard cross‑platform

| OS | Méthode |
|----|---------|
| Windows | `Set-Clipboard` |
| macOS | `pbcopy` |
| Linux | `xclip` / `xsel` |

Fallback propre si non disponible.

---

# 🔔 Beep encapsulé

- Windows : OK  
- Linux/macOS : silencieux si non supporté  

```powershell
Invoke-Beep
```

---

# 🧠 Générateur cryptographique interne

`Get-CryptoIndex` est utilisé par toutes les fonctions :

- PS7 : `Get-SecureRandom` ou `RandomNumberGenerator.GetBytes()`  
- PS5 : `RNGCryptoServiceProvider`  
- Retourne un index sécurisé entre `0` et `Max - 1`  

---

# 🧰 Design des fonctions

## Get-PassWord
- Génération caractère par caractère  
- Pools configurables  
- Paramètres modernes (`-UseSpecial`, `-SpecialChars`, `-Silent`)  

## Get-PassPhrase
- Liste de mots optimisée  
- Séparateur `-`  
- Paramètres (`-MotsParBloc`, `-LettresParMot`, `-Silent`)  

## Aliases
- `sgw` → `Get-PassWord`  
- `sgp` → `Get-PassPhrase`  

---

# 🧱 Philosophie de maintenance

- Code clair et modulaire  
- Pas de dépendances externes  
- Compatibilité maximale  
- Documentation complète  
- CI/CD robuste  
- Versioning automatisé  
- Publication automatique via GitHub Actions  

---

# 🎉 Merci d’utiliser SecureGen

Pour contribuer :  
👉 Issues & Pull Requests sur GitHub

---