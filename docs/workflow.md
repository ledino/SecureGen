# 📘 **SecureGen — Developer Workflow**

## 🎯 Objectif

Ce document décrit **le workflow complet** pour travailler sur SecureGen :

- installer l’environnement  
- développer une fonctionnalité  
- lancer les tests  
- générer la documentation  
- respecter les standards  
- préparer une release  
- publier le module  

Il sert de **guide opérationnel** pour les mainteneurs et contributeurs.

---

# 🧭 1. Préparation de l’environnement

## ✔ Cloner le dépôt

```powershell
git clone https://github.com/ledino/SecureGen
cd SecureGen
```

## ✔ Installer les dépendances

### PowerShell

- PowerShell 7+ (recommandé)
- Windows PowerShell 5.1 (compatibilité)

### Node.js

```powershell
npm install
```

### Installer le module localement

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

---

# 🧱 2. Structure du projet (rappel rapide)

```
SecureGen/
│
├── SecureGen/              # Code source (PS7/PS5 loader)
├── docs/                   # Documentation utilisateur
│   ├── cmdlets/            # Documentation PlatyPS
│   └── diagrams/           # Diagrammes UML / SVG
├── scripts/                # Scripts dev (build, help, release…)
├── tests/                  # Tests Pester
└── .github/workflows/      # CI/CD
```

---

# 🛠️ 3. Développement d’une fonctionnalité

## ✔ 1. Créer une branche

```powershell
git checkout -b feature/ma-fonction
```

## ✔ 2. Implémenter la fonctionnalité

Selon la nature :

- **PS7+** → `SecureGen/Core.PS7.ps1`
- **PS5.1** → `SecureGen/Legacy.PS5.ps1`
- **Exports** → `SecureGen/SecureGen.psm1`

## ✔ 3. Ajouter les tests

Dans :

```
tests/
```

Chaque cmdlet doit avoir un fichier dédié.

## ✔ 4. Mettre à jour la documentation

### Documentation utilisateur  
`docs/`

### Documentation API (cmdlets)  
```powershell
pwsh ./scripts/Generate-Help.ps1
```

## ✔ 5. Vérifier la qualité

### Tests

```powershell
Invoke-Pester
```

### Analyse statique

```powershell
Invoke-ScriptAnalyzer -Path ./SecureGen -Recurse
```

## ✔ 6. Commit (Conventional Commits)

Exemples :

```
feat: ajout de Get-XYZ
fix: correction du paramètre -Len
docs: mise à jour de la documentation
test: ajout des tests pour Get-PKIPass
```

---

# 🧪 4. Tests & Validation

## ✔ Lancer tous les tests

```powershell
Invoke-Pester
```

## ✔ Lancer PSScriptAnalyzer

```powershell
Invoke-ScriptAnalyzer -Path ./SecureGen -Recurse
```

## ✔ Importer le module local

```powershell
Import-Module ./SecureGen/SecureGen.psd1 -Force
```

---

# 📚 5. Génération de la documentation (PlatyPS)

La documentation des cmdlets est générée via :

```powershell
pwsh ./scripts/Generate-Help.ps1
```

Ce script :

- détecte PlatyPS  
- génère ou met à jour la doc  
- crée SecureGen.md  
- valide la cohérence  
- écrit dans `docs/cmdlets/`  

---

# ⚙️ 6. Versioning & Release

SecureGen utilise :

- **Conventional Commits**
- **standard-version**
- **un updater custom pour SecureGen.psd1**
- **GitHub Actions** pour publier sur PSGallery

## ✔ Bumper la version

```powershell
npm run release -- --release-as minor
```

Cela :

- met à jour `package.json`
- met à jour `SecureGen.psd1`
- génère `CHANGELOG.md`
- crée un commit `chore(release): X.Y.Z`
- crée un tag `vX.Y.Z`

## ✔ Publier

```powershell
git push
git push --tags
```

GitHub Actions s’occupe du reste.

---

# 🚀 7. CI/CD (GitHub Actions)

Deux workflows :

### ✔ `ci.yml`
- PSScriptAnalyzer  
- Import du module  
- Tests Pester  
- Matrix PS5/PS7 Windows/Linux  

### ✔ `release.yml`
- Déclenché par un tag `v*`
- Build du module
- Validation du manifest
- Publication PSGallery
- Création Release GitHub

---

# 🔄 8. Workflow complet (résumé)

```
Développement → Tests → Doc → Commit → PR → Merge → standard-version → Tag → Push → CI → Release
```

---

# 🧭 9. Reprendre le projet après une longue pause

1. Lire :
   - `developer-guide.md`
   - `workflow.md`
   - `architecture.md`
   - `release-process.md`
   - `CHANGELOG.md`

2. Installer l’environnement :

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

3. Lancer les tests :

```powershell
Invoke-Pester
```

4. Regénérer la documentation :

```powershell
pwsh ./scripts/Generate-Help.ps1
```

5. Vérifier la CI/CD :

`.github/workflows/`

---

# 🧩 10. Checklist avant PR

- [ ] Tests Pester OK  
- [ ] PSScriptAnalyzer OK  
- [ ] Documentation mise à jour  
- [ ] Cmdlets exportées dans `SecureGen.psm1`  
- [ ] Compatibilité PS5/PS7 vérifiée  
- [ ] Commit message conforme  
- [ ] Pas de bump manuel de version  
- [ ] Pas de modification manuelle du changelog  

---

# 🎉 Merci de contribuer à SecureGen !

---
