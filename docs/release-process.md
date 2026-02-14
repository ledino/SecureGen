# 🚀 Processus de release — SecureGen  
*(Workflow moderne : standard-version local + publication via tag)*

Ce document décrit le processus officiel pour générer et publier une nouvelle version de **SecureGen**.  
Depuis la version **1.4.0+**, le processus est **simple, local et entièrement maîtrisé**, basé sur :

- **Conventional Commits**
- **standard-version** (exécuté en local)
- **un updater custom pour le manifest**
- **Git tags**
- **GitHub Actions (publication automatique via publish.yml)**

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
- la CI (`ci.yml`) est verte  
- la documentation PlatyPS est à jour  
- les tests Pester passent sur toutes les plateformes  
- les commits respectent **Conventional Commits**

---

# 🧩 2. Génération de la version (local)

La version est générée **localement** via standard-version.

Exemple :

```powershell
npm run release -- --release-as 1.5.0
```

Cette commande :

1. Analyse les commits (Conventional Commits)  
2. Détermine le bump (MAJOR / MINOR / PATCH)  
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

# 🚀 3. Push de la branche + tag

Une fois la version générée :

```powershell
git push
git push origin vX.Y.Z
```

Le push du tag déclenche automatiquement le workflow `publish.yml`.

---

# 📦 4. Publication automatique sur PowerShell Gallery

Le workflow `publish.yml` :

1. Récupère la version depuis le tag  
2. Charge la clé API PSGallery (`PSGALLERY_KEY`)  
3. Exécute :

```powershell
Publish-Module -Path ./SecureGen -NuGetApiKey $env:PSGALLERY_KEY
```

4. Publie SecureGen sur :

https://www.powershellgallery.com/packages/SecureGen

---

# 🔍 5. Vérification post‑publication

Après quelques secondes :

- vérifier la version sur PSGallery  
- vérifier le changelog généré  
- créer la Release GitHub (notes déjà prêtes dans `CHANGELOG.md`)  
- vérifier que la documentation PlatyPS est cohérente avec la release  

---

# 🚫 6. Ce qu’il ne faut plus faire

Depuis la v1.4.0 :

- ❌ ne plus modifier `ModuleVersion` à la main  
- ❌ ne plus modifier `CHANGELOG.md` à la main  
- ❌ ne plus utiliser `scripts/Versioning-SecureGen.ps1`  
- ❌ ne plus utiliser `scripts/Release-All.ps1`  
- ❌ ne plus utiliser de workflow `release.yml`  
- ❌ ne plus exécuter standard-version dans GitHub Actions  

Le bump est **local**, la publication est **automatique via tag**.

---

# 🧪 7. Dépannage

### Le manifest n’est pas mis à jour  
→ Vérifier `.version-updaters/psd1-updater.js`

### Le changelog ne se met pas à jour  
→ Vérifier `.versioningrc.json`

### Le workflow publish échoue  
→ Vérifier le secret GitHub `PSGALLERY_KEY`

### Le tag ne déclenche rien  
→ Vérifier que le tag commence bien par `v` (ex : `v1.5.0`)

---

# 📚 Documents associés

- `docs/versioning.md`  
- `docs/contributing.md`  
- `.version-updaters/psd1-updater.js`  
- `.versioningrc.json`  
- `.github/workflows/publish.yml`  
- `CHANGELOG.md`  

---

# 🎉 Un processus de release simple, fiable et maîtrisé

Grâce à standard-version exécuté localement + publication via tag, SecureGen bénéficie d’un pipeline :

- fiable  
- reproductible  
- sans erreur humaine  
- professionnel  
- parfaitement aligné avec SemVer  

---
