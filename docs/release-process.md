# 📘 **docs/release-process.md — Processus de release SecureGen**

# 🚀 Processus de release — SecureGen

Ce document décrit le processus officiel pour préparer, valider et publier une nouvelle version du module **SecureGen**.  
Il s’adresse aux mainteneurs et contributeurs souhaitant publier une version stable sur la PowerShell Gallery.

---

# 🧱 1. Préparation de la release

## ✔ Vérifier l’état du dépôt

Avant toute release :

```powershell
git pull
git status
```

Assurez-vous que :

- aucune modification non commitée n’est présente
- la branche `main` est à jour
- les tests passent (si présents)

---

# 📝 2. Mettre à jour la version

La version du module se trouve dans :

```
src/SecureGen.psd1
```

Modifiez :

```powershell
ModuleVersion = 'X.Y.Z'
```

### Règles de versioning (SemVer)

- **MAJOR** : changements incompatibles  
- **MINOR** : nouvelles fonctionnalités  
- **PATCH** : corrections, améliorations mineures  

Exemples :

- `1.3.1` → `1.3.2` (patch)
- `1.3.1` → `1.4.0` (minor)
- `1.3.1` → `2.0.0` (major)

---

# 🧾 3. Mettre à jour le CHANGELOG

Dans :

```
CHANGELOG.md
```

Ajoutez une nouvelle entrée :

- date  
- numéro de version  
- nouveautés  
- corrections  
- améliorations  

Exemple :

```markdown
## 🚀 1.4.0 — 2026-03-01
### Nouveautés
- Ajout de la fonction Get-RandomKey
- Amélioration du clipboard Linux

### Corrections
- Correction d’un bug dans Get-CryptoIndex
```

---

# 🧪 4. Exécuter le build complet

Utilisez le script :

```powershell
.\build.ps1
```

Ce script :

- nettoie l’environnement  
- vérifie la structure  
- copie le module dans `out/`  
- exécute les tests Pester (si présents)  
- prépare le packaging  

Si tout est vert → la release est prête.

---

# 🔐 5. Préparer la clé API PSGallery

Assurez-vous que la clé API est définie :

```powershell
$env:PSGALLERY_KEY = "votre_clé_api"
```

Vous pouvez la récupérer sur :  
https://www.powershellgallery.com/account/apikey

---

# 🚀 6. Publier la nouvelle version

Deux options :

## Option A — Via le script de build

```powershell
.\build.ps1 -Publish
```

## Option B — Via le script de publication dédié

```powershell
.\Publish-SecureGen.ps1
```

Les deux scripts :

- valident la structure  
- publient sur PSGallery  
- affichent l’URL du module  

---

# 🔍 7. Vérifier la publication

Après quelques secondes, vérifiez :

https://www.powershellgallery.com/packages/SecureGen

Assurez-vous que :

- la version est correcte  
- les fichiers sont présents  
- les métadonnées (tags, description, logo) sont correctes  

---

# 🧹 8. Tag Git & release GitHub

Une fois la version publiée :

```powershell
git tag vX.Y.Z
git push origin vX.Y.Z
```

Puis créez une release GitHub :

- titre : `vX.Y.Z`
- changelog associé
- lien vers PSGallery

---

# 🛠️ 9. Mise à jour de la documentation

Mettre à jour si nécessaire :

- `README.md`
- `docs/*.md`
- `CHANGELOG.md`

---

# 🧩 10. Workflow CI/CD (optionnel)

Vous pouvez automatiser :

- tests  
- build  
- packaging  
- publication  

via GitHub Actions.

Un workflow type peut être ajouté dans :

```
.github/workflows/release.yml
```

---

# 🎉 Release terminée !

Votre nouvelle version de SecureGen est maintenant disponible pour tous les utilisateurs PowerShell.

Merci de contribuer à rendre SecureGen plus robuste, plus simple et plus agréable à utiliser.

---
