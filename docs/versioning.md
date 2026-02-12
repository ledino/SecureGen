# 🧩 Versioning — SecureGen  
*(Version alignée avec le workflow moderne : standard-version + GitHub Actions)*

SecureGen utilise un système de versioning entièrement automatisé basé sur :

- **Semantic Versioning (SemVer)**
- **Conventional Commits**
- **standard-version**
- **GitHub Actions (release automatisée)**

Ce document explique comment les versions sont générées, comment le manifest est mis à jour automatiquement, et comment une release est produite.

---

# 🔢 Semantic Versioning (SemVer)

SecureGen suit le format :

```
MAJOR.MINOR.PATCH
```

Exemples :

- `1.3.3`
- `1.4.0`
- `2.0.0`

---

# 🧱 Règles SemVer

## ✔ MAJOR (X.0.0)
Changements non rétro‑compatibles :

- suppression d’un paramètre
- modification d’un comportement par défaut
- refonte interne cassant des scripts existants

## ✔ MINOR (1.X.0)
Nouvelles fonctionnalités sans rupture :

- ajout d’un paramètre
- ajout d’un alias
- amélioration significative

## ✔ PATCH (1.3.X)
Corrections et améliorations mineures :

- bugfix
- optimisation interne
- correction de documentation

---

# ⚙️ Automatisation du versioning

SecureGen utilise **standard-version** pour :

- lire les commits (Conventional Commits)
- déterminer automatiquement le type de bump (major/minor/patch)
- mettre à jour :
  - `package.json`
  - `SecureGen.psd1` (via un updater custom)
  - `CHANGELOG.md`
- créer un commit
- créer un tag Git

Aucune modification manuelle n’est nécessaire.

---

# 🧩 Updater custom pour le manifest

Le fichier :

```
.version-updaters/psd1-updater.js
```

met automatiquement à jour :

```powershell
ModuleVersion = 'X.Y.Z'
```

dans :

```
SecureGen/SecureGen.psd1
```

C’est la source de vérité pour PowerShell Gallery.

---

# 🧪 Conventional Commits

Le type de commit détermine le bump :

| Type de commit | Effet |
|----------------|-------|
| `feat:`        | MINOR |
| `fix:`         | PATCH |
| `perf:`        | PATCH |
| `docs:`        | Aucun bump |
| `refactor:`    | PATCH (si sans rupture) |
| `BREAKING CHANGE:` | MAJOR |

Exemples :

```
feat: ajout du paramètre -Silent
fix: correction du clipboard sous Linux
refactor: simplification du loader PS7
```

---

# 🔄 Processus de release automatisée

La release est gérée par :

```
.github/workflows/release.yml
```

Étapes :

1. Lancement manuel du workflow **Release SecureGen**
2. standard-version :
   - calcule la nouvelle version
   - met à jour le manifest
   - met à jour le changelog
   - crée un commit
   - crée un tag `vX.Y.Z`
3. GitHub Actions pousse le commit + tag
4. Le job `publish` publie automatiquement sur PowerShell Gallery

Aucune intervention manuelle.

---

# 📦 Où se trouve la version ?

### ✔ Version Node (source de vérité pour standard-version)
```
package.json
```

### ✔ Version PowerShell (mise à jour automatiquement)
```
SecureGen/SecureGen.psd1
```

### ✔ Historique des versions
```
CHANGELOG.md
```

---

# 🧪 Vérifications avant release

Avant de lancer le workflow :

- CI doit être verte
- README et docs doivent être à jour
- commits doivent suivre Conventional Commits

Aucune mise à jour manuelle du manifest ou du changelog.

---

# 🚫 Ce qu’il ne faut plus faire

- ❌ ne plus modifier `ModuleVersion` à la main  
- ❌ ne plus modifier `CHANGELOG.md` à la main  
- ❌ ne plus utiliser `scripts/Versioning-SecureGen.ps1`  
- ❌ ne plus utiliser `scripts/Release-All.ps1`  
- ❌ ne plus créer de tag manuellement (sauf cas exceptionnel)

---

# 📚 Documents associés

- `docs/release-process.md`
- `docs/contributing.md`
- `CHANGELOG.md`
- `.versioningrc.json`
- `.version-updaters/psd1-updater.js`

---

# 🎉 Versioning moderne et maîtrisé

Grâce à standard-version + GitHub Actions, SecureGen bénéficie d’un pipeline :

- propre  
- reproductible  
- sans erreur humaine  
- professionnel  
- parfaitement aligné avec SemVer  

```

---
