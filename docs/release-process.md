# 🚀 Processus de release — SecureGen  
*(Workflow moderne : standard-version + GitHub Actions)*

Ce document décrit le processus officiel pour générer et publier une nouvelle version de **SecureGen**.  
Depuis la version 1.3.x, le processus est **entièrement automatisé** grâce à :

- **Conventional Commits**
- **standard-version**
- **un updater custom pour le manifest**
- **GitHub Actions (release.yml)**
- **publication automatique sur PowerShell Gallery**

Aucune modification manuelle du manifest ou du changelog n’est nécessaire.

---

# 🧱 1. Préparation de la release

Avant de lancer une release :

```powershell
git pull
git status
```

Vérifier que :

- la branche `main` est propre
- la CI est verte (workflow `ci.yml`)
- la documentation est à jour (README, docs/*)
- les commits respectent **Conventional Commits**

---

# 🧩 2. Lancement de la release automatisée

La release se déclenche via GitHub Actions :

1. Aller dans **Actions**
2. Sélectionner **Release SecureGen**
3. Cliquer sur **Run workflow**

Aucune version à saisir :  
👉 standard-version calcule automatiquement MAJOR / MINOR / PATCH.

---

# ⚙️ 3. Ce que fait standard-version

Lors du lancement, standard-version :

1. Analyse les commits (Conventional Commits)
2. Détermine le type de bump :
   - `feat:` → MINOR
   - `fix:` → PATCH
   - `BREAKING CHANGE:` → MAJOR
3. Met à jour automatiquement :
   - `package.json`
   - `SecureGen.psd1` (via `.version-updaters/psd1-updater.js`)
   - `CHANGELOG.md`
4. Crée un commit :
   ```
   chore(release): X.Y.Z
   ```
5. Crée un tag Git :
   ```
   vX.Y.Z
   ```

Aucune intervention humaine.

---

# 🚀 4. Push automatique du commit + tag

Le workflow `release.yml` pousse automatiquement :

- le commit généré
- le tag `vX.Y.Z`

Cela déclenche automatiquement le job **publish**.

---

# 📦 5. Publication automatique sur PowerShell Gallery

Le job `publish` :

1. Récupère la version depuis le tag
2. Charge la clé API PSGallery (secret GitHub : `PSGALLERY_KEY`)
3. Exécute :

```powershell
Publish-Module -Path ./SecureGen -NuGetApiKey $env:PSGALLERY_KEY
```

4. Publie SecureGen sur :

https://www.powershellgallery.com/packages/SecureGen

---

# 🔍 6. Vérification post‑publication

Après quelques secondes :

- vérifier la version sur PSGallery
- vérifier le changelog généré
- vérifier la release GitHub (automatique)

---

# 🚫 7. Ce qu’il ne faut plus faire

Depuis l’automatisation :

- ❌ ne plus modifier `ModuleVersion` à la main  
- ❌ ne plus modifier `CHANGELOG.md` à la main  
- ❌ ne plus utiliser `scripts/Versioning-SecureGen.ps1`  
- ❌ ne plus utiliser `scripts/Release-All.ps1`  
- ❌ ne plus créer de tag manuellement  
- ❌ ne plus publier via `Publish-SecureGen.ps1`  

Tout est automatisé.

---

# 🧪 8. Dépannage

### Le workflow refuse de committer  
→ Vérifier que `release.yml` contient :

```yaml
git config user.name "github-actions"
git config user.email "github-actions@github.com"
```

### Le manifest n’est pas mis à jour  
→ Vérifier `.version-updaters/psd1-updater.js`

### Le changelog ne se met pas à jour  
→ Vérifier `.versioningrc.json`

---

# 📚 Documents associés

- `docs/versioning.md`
- `docs/contributing.md`
- `.version-updaters/psd1-updater.js`
- `.versioningrc.json`
- `.github/workflows/release.yml`
- `CHANGELOG.md`

---

# 🎉 Release automatisée réussie !

Grâce à ce pipeline moderne, SecureGen bénéficie d’un processus de release :

- fiable  
- reproductible  
- sans erreur humaine  
- professionnel  
- parfaitement aligné avec SemVer  

```

---
