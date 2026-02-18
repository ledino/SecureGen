# 🚀 **Pipeline CI/CD — SecureGen**  
*(Vue d’ensemble complète du pipeline automatisé)*

Ce document décrit le pipeline CI/CD complet de SecureGen, depuis le développement local jusqu’à la publication automatique sur PowerShell Gallery.

Le pipeline repose sur :

- **GitHub Actions**  
- **Pester**  
- **PSScriptAnalyzer**  
- **standard-version**  
- **updater custom pour SecureGen.psd1**  
- **publication automatique PSGallery**  

Il garantit un workflow :

- fiable  
- reproductible  
- sans intervention humaine  
- conforme aux standards modernes  

---

# 🧭 1. Vue d’ensemble du pipeline

Voici le pipeline complet, du commit jusqu’à la publication :

```
Développement → Commit → CI → standard-version → Tag → Release GitHub → Publication PSGallery
```

---

# 🧱 2. Diagramme global (ASCII)

```
                 ┌───────────────────────────┐
                 │   Développement local     │
                 │  (code + tests + docs)    │
                 └─────────────┬─────────────┘
                               │
                               ▼
                 ┌───────────────────────────┐
                 │ Commit Conventional Commits│
                 └─────────────┬─────────────┘
                               │
                               ▼
                 ┌───────────────────────────┐
                 │   GitHub Actions (CI)     │
                 │  • Lint (PSScriptAnalyzer)│
                 │  • Import du module       │
                 │  • Tests Pester           │
                 │  • Matrix PS5/PS7         │
                 └─────────────┬─────────────┘
                               │
                               ▼
                 ┌──────────────────────────┐
                 │   standard-version       │
                 │  • Bump version          │
                 │  • Update manifest       │
                 │  • Generate CHANGELOG    │
                 │  • Commit + Tag          │
                 └─────────────┬────────────┘
                               │
                               ▼
                 ┌──────────────────────────┐
                 │   Release GitHub         │
                 └─────────────┬────────────┘
                               │
                               ▼
                 ┌──────────────────────────┐
                 │  Publish PSGallery       │
                 └──────────────────────────┘
```

---

# 🧩 3. CI — `ci.yml`

Le workflow CI s’exécute à chaque :

- commit  
- pull request  
- push sur `main`  

Il effectue :

### ✔ Analyse statique  
```powershell
Invoke-ScriptAnalyzer -Path ./SecureGen -Recurse
```

### ✔ Import du module  
Pour vérifier que le manifest et le loader sont valides.

### ✔ Tests Pester  
Exécutés sur :

- Windows PowerShell 5.1  
- PowerShell 7 (Windows)  
- PowerShell 7 (Linux)  

### ✔ Validation du manifest  
Pour éviter les erreurs de packaging.

---

# 🚀 4. Release — `release.yml`

Déclenché automatiquement lorsqu’un commit Conventional Commits est poussé sur `main`.

Il exécute :

### ✔ standard-version  
- bump automatique de version  
- mise à jour du manifest  
- génération du changelog  
- commit `chore(release): X.Y.Z`  
- création du tag `vX.Y.Z`  

### ✔ Création de la release GitHub  
Avec changelog intégré.

### ✔ Publication PSGallery  
Via :

```powershell
Publish-Module -Path . -NuGetApiKey $env:PSGALLERY_KEY
```

---

# 🔐 5. Secrets utilisés

### ✔ `GITHUB_TOKEN`  
Généré automatiquement par GitHub.

### ✔ `PSGALLERY_KEY`  
Clé API PowerShell Gallery (à configurer dans Settings → Secrets).

---

# 🧪 6. Tests automatisés

Le pipeline exécute :

- tests unitaires Pester  
- tests de compatibilité PS5/PS7  
- tests d’import du module  
- tests de documentation (optionnel)  

---

# 📘 7. Documentation automatisée

La documentation PlatyPS peut être vérifiée dans la CI :

```powershell
Test-MarkdownHelp -Module SecureGen -HelpFilesPath ./docs/cmdlets
```

---

# 🧰 8. Rôles & responsabilités

### Développeur  
- écrit le code  
- met à jour la documentation  
- écrit les tests  
- respecte Conventional Commits  

### CI  
- valide la qualité  
- empêche les régressions  

### Release pipeline  
- bump la version  
- génère le changelog  
- crée la release GitHub  
- publie sur PSGallery  

---

# 🧭 9. Cas particuliers

### ✔ Hotfix  
Commit `fix:` → bump patch automatique.

### ✔ Breaking change  
Ajouter :

```
BREAKING CHANGE: description
```

→ bump major automatique.

### ✔ Rollback  
1. Supprimer le tag  
2. Supprimer la release GitHub  
3. Revert du commit `chore(release)`  
4. Pousser le revert  

---

# 🎯 10. Résumé

Le pipeline CI/CD de SecureGen est :

- **automatisé**  
- **fiable**  
- **sans intervention humaine**  
- **basé sur des standards modernes**  
- **parfaitement reproductible**  

Il garantit que chaque release est :

- testée  
- validée  
- versionnée correctement  
- documentée  
- publiée automatiquement  

---
