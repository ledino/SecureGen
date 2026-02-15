# 🧱 Architecture interne — SecureGen  
*(Version synchronisée avec SecureGen 1.5.0)*

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
   Clipboard cross‑platform, beep encapsulé, alias ergonomiques, documentation complète, SecureString pour les usages PKI.

---

# 📚 Diagrammes UML

Les diagrammes décrivant l’architecture complète du module sont regroupés dans `docs/diagrams/`.

### 🧩 Diagramme des composants  
`docs/diagrams/components.md`  
Vue interne du module : orchestrateur, implémentations PS5/PS7, ressources.

### 🏗️ Diagramme de déploiement  
`docs/diagrams/deployment.md`  
Où vivent les fichiers : poste utilisateur, PowerShell Gallery, GitHub Actions.

### 🔁 Diagramme de séquence — Get-PassWord  
`docs/diagrams/sequence-get-password.md`  
Flux d’exécution complet d’un appel utilisateur.

### 🚀 Pipeline CI/CD  
`docs/diagrams/pipeline-ci-cd.md`  
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
- Gestion des SecureString pour Get‑PKIPass  

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
- applique les alias (`sgw`, `sgp`, `sgpki`)  
- centralise la logique commune (clipboard, beep, helpers)  
- expose les cmdlets de manière cohérente  

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
├── node_modules                   # Dépendances Node.js (standard-version)
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
│   ├── FUNDING.yml
│   ├── pull_request_template.md
│   ├── SECURITY_ADVISORY_TEMPLATE.md
│   ├── DISUSSION_TEMPLATE/
│   │   ├── announcements.yml
│   │   ├── ideas.yml
│   │   └── qna.yml
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   └── feature_request.md
│   └── workflows/
│       ├── ci.yml                 # CI multi-plateformes (tests + lint)
│       └── publish.yml            # Publication automatique sur PSGallery (déclenchée par tag)
│
├── package.json                   # Dépendances Node + version source de vérité
├── package-lock.json              # Verrouillage des dépendances
├── .versioningrc.json             # Configuration standard-version
│
tests/
│   ├── Get-PKIPass.Tests.ps1
│   ├── Get-PassWord.Tests.ps1
│   ├── Get-PassPhrase.Tests.ps1
│   ├── Get-CryptoIndex.Tests.ps1
│   ├── Invoke-Beep.Tests.ps1
│   └── Clipboard.Tests.ps1
│
├── CHANGELOG.md                   # Changelog généré automatiquement
├── README.md                      # Documentation principale
├── README.en.md
├── ROADMAP.md
├── SECURITY.md
├── SUPPORT.md
├── CODE_OF_CONDUCT.md
├── GOVERNANCE.md
├── CONTRIBUTING.md
├── MAINTAINERS.md
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
| Linux | `wl-copy`, `xclip`, `xsel` |

SecureGen encapsule ces appels via :

- `Set-ClipboardSafe`  
- `Clear-ClipboardSafe`  

Avec fallback propre si non disponible.

---

# 🔔 Beep encapsulé

- Windows : bip natif  
- Linux/macOS : bip simulé ou silencieux selon support  

```powershell
Invoke-Beep
```

---

# 🧠 Générateur cryptographique interne

`Get-CryptoIndex` est utilisé par toutes les fonctions :

- PS7 : `Get-SecureRandom` ou `RandomNumberGenerator.GetBytes()`  
- PS5 : `RNGCryptoServiceProvider`  
- Retourne un index sécurisé entre `0` et `Max - 1`  

C’est la brique fondamentale garantissant l’absence de biais.

---

# 🧰 Design des fonctions

## Get-PassWord
- Génération caractère par caractère  
- Pools configurables  
- Paramètres modernes (`-UseSpecial`, `-SpecialChars`, `-Silent`)  
- Entropie affichée automatiquement  

## Get-PassPhrase
- Mots générés caractère par caractère  
- Séparateur configurable  
- Paramètres (`-Words`, `-Len`, `-Separator`)  
- Entropie affichée automatiquement  

## Get-PKIPass
- Fonction dédiée aux usages sensibles (PKI, KMS, comptes de service)  
- Modes Password / Passphrase  
- Retour `SecureString` optionnel  
- Paramètres cohérents avec Get‑PassWord et Get‑PassPhrase  

## Aliases
- `sgw` → `Get-PassWord`  
- `sgp` → `Get-PassPhrase`  
- `sgpki` → `Get-PKIPass`  

---

# 🧱 Philosophie de maintenance

- Code clair et modulaire  
- Pas de dépendances externes  
- Compatibilité maximale  
- Documentation complète (PlatyPS)  
- CI/CD robuste (GitHub Actions)  
- Versioning automatisé (standard-version)  
- Publication automatique via GitHub Actions  
- Tests Pester multi‑plateformes  

---

# 🎉 Merci d’utiliser SecureGen

Pour contribuer :  
👉 Issues & Pull Requests sur GitHub

---