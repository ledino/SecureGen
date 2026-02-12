# 🧩 Versioning — SecureGen  
*(Version alignée avec le workflow moderne : standard-version local + publication via tag)*

SecureGen utilise un système de versioning moderne basé sur :

- **Semantic Versioning (SemVer)**
- **Conventional Commits**
- **standard-version** (exécuté en local)
- **Git tags** (déclenchent la publication PSGallery)
- **GitHub Actions** (publication automatique uniquement)

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
Changements non rétro‑compatibles.

## ✔ MINOR (1.X.0)
Nouvelles fonctionnalités sans rupture.

## ✔ PATCH (1.3.X)
Corrections et améliorations mineures.

---

# ⚙️ Automatisation du versioning

SecureGen utilise **standard-version**, exécuté **localement**, pour :

- lire les commits (Conventional Commits)
- déterminer automatiquement le type de bump (major/minor/patch)
- mettre à jour :
  - `package.json`
  - `SecureGen.psd1` (via un updater custom)
  - `CHANGELOG.md`
- créer un commit `chore(release): X.Y.Z`
- créer un tag `vX.Y.Z`

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

C’est la version utilisée par PowerShell Gallery.

---

# 🧪 Conventional Commits

Le type de commit détermine le bump :

| Type de commit | Effet |
|----------------|-------|
| `feat:`        | MINOR |
| `fix:`         | PATCH |
| `perf:`        | PATCH |
| `docs:`        | Aucun bump |
| `refactor:`    | PATCH |
| `BREAKING CHANGE:` | MAJOR |

Exemples :

```
feat: ajout du paramètre -Silent
fix: correction du clipboard sous Linux
refactor: simplification du loader PS7
```

---

# 🔄 Processus de release (v1.4.0+)

La release est désormais **simple, locale et maîtrisée** :

1. Vérifier que la CI est verte  
2. Exécuter standard-version en local :  
   ```powershell
   npm run release -- --release-as X.Y.Z
   ```
3. Pousser la branche `main` :  
   ```powershell
   git push
   ```
4. Pousser le tag généré :  
   ```powershell
   git push origin vX.Y.Z
   ```
5. GitHub Actions détecte le tag et publie automatiquement sur PowerShell Gallery  
6. Créer la Release GitHub (notes générées dans CHANGELOG.md)

Aucune exécution de standard-version dans GitHub Actions.

---

# 📦 Où se trouve la version ?

### ✔ Source de vérité standard-version
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

- CI verte  
- README et docs à jour  
- commits conformes à Conventional Commits  
- pas de modifications manuelles du manifest ou du changelog  

---

# 🚫 Ce qu’il ne faut plus faire

- ❌ ne plus modifier `ModuleVersion` à la main  
- ❌ ne plus modifier `CHANGELOG.md` à la main  
- ❌ ne plus utiliser `scripts/Versioning-SecureGen.ps1`  
- ❌ ne plus utiliser `scripts/Release-All.ps1`  
- ❌ ne plus utiliser de workflow `release.yml`  
- ❌ ne plus exécuter standard-version dans GitHub Actions  

---

# 📚 Documents associés

- `docs/release-process.md`
- `docs/contributing.md`
- `CHANGELOG.md`
- `.versioningrc.json`
- `.version-updaters/psd1-updater.js`

---

# 🎉 Versioning moderne, simple et maîtrisé

Grâce à standard-version exécuté localement + publication via tag, SecureGen bénéficie d’un pipeline :

- simple  
- fiable  
- reproductible  
- sans erreur humaine  
- parfaitement aligné avec SemVer  
```

---
