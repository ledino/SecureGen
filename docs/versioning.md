# 🧩 Versioning — SecureGen  
*(Aligné avec le pipeline moderne : standard-version exécuté automatiquement dans GitHub Actions)*

SecureGen utilise un système de versioning entièrement automatisé basé sur :

- **Semantic Versioning (SemVer)**  
- **Conventional Commits**  
- **standard-version (exécuté automatiquement dans GitHub Actions)**  
- **tags Git générés automatiquement**  
- **publication automatique sur PowerShell Gallery**

Aucune exécution locale de standard-version n’est nécessaire.  
Aucune modification manuelle du manifest ou du changelog n’est autorisée.

---

# 🔢 Semantic Versioning (SemVer)

SecureGen suit le format :

```
MAJOR.MINOR.PATCH
```

Exemples :

- `1.5.0`
- `1.6.0`
- `2.0.0`

---

# 🧱 Règles SemVer appliquées automatiquement

Le type de commit détermine le bump :

| Type de commit | Effet sur la version |
|----------------|----------------------|
| `fix:` | PATCH (1.5.0 → 1.5.1) |
| `feat:` | MINOR (1.5.0 → 1.6.0) |
| `BREAKING CHANGE:` | MAJOR (1.5.0 → 2.0.0) |
| `docs:` / `chore:` / `refactor:` | Aucun bump |

> **Important : les exemples ci‑dessous sont des messages de commit.**

Exemples :

```
feat: ajout de Get-PKIPass
fix: correction du clipboard sous Linux
refactor: simplification du loader PS7
```

---

# ⚙️ Automatisation du versioning

Le versioning est entièrement géré par **standard-version**, exécuté automatiquement dans GitHub Actions.

Lorsqu’un commit Conventional Commit est poussé sur `main` :

1. standard-version détermine le bump (major/minor/patch)  
2. met à jour automatiquement :
   - `CHANGELOG.md`
   - `SecureGen.psd1` (via un updater custom)
3. crée un commit `chore(release): X.Y.Z`  
4. crée le tag `vX.Y.Z`  
5. pousse commit + tag  
6. déclenche la publication PSGallery  
7. génère la release GitHub

Aucune commande locale n’est nécessaire.

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

# 🔄 Processus de versioning (automatique)

1. Un commit Conventional Commit est poussé sur `main`  
2. standard-version s’exécute dans GitHub Actions  
3. La version est bumpée automatiquement  
4. Le changelog est mis à jour  
5. Le commit de release est généré  
6. Le tag `vX.Y.Z` est créé  
7. Le workflow de publication publie automatiquement sur PSGallery  
8. La release GitHub est créée

---

# 📦 Où se trouve la version ?

### ✔ Source de vérité standard-version
```
CHANGELOG.md
```

### ✔ Version PowerShell (mise à jour automatiquement)
```
SecureGen/SecureGen.psd1
```

### ✔ Version Git (tag)
```
vX.Y.Z
```

---

# 🧪 Vérifications avant release

- commits conformes à Conventional Commits  
- CI verte  
- documentation PlatyPS à jour  
- tests Pester OK  
- pas de modifications manuelles du manifest ou du changelog  

---

# 🚫 Ce qu’il ne faut plus faire

- ❌ ne plus exécuter standard-version en local  
- ❌ ne plus modifier `ModuleVersion` à la main  
- ❌ ne plus modifier `CHANGELOG.md` à la main  
- ❌ ne plus créer de tag manuellement  
- ❌ ne plus utiliser les anciens scripts de release  
- ❌ ne plus utiliser d’ancien workflow de publication  

---

# 📚 Documents associés

- `docs/release-process.md` — fonctionnement interne du pipeline  
- `docs/release.md` — guide d’utilisation du pipeline  
- `.version-updaters/psd1-updater.js`  
- `.versioningrc.json`  
- `CHANGELOG.md`

---

# 🎉 Versioning moderne, simple et maîtrisé

Grâce à standard-version exécuté automatiquement dans GitHub Actions, SecureGen bénéficie d’un versioning :

- fiable  
- reproductible  
- sans intervention humaine  
- parfaitement aligné avec SemVer  
- cohérent entre Git, le manifest et PSGallery  

---

