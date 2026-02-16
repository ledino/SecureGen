# 🚀 Processus de release — SecureGen  
*(Workflow moderne : release entièrement automatisée via GitHub Actions)*

Ce document décrit le processus officiel pour générer et publier une nouvelle version de **SecureGen**.  
Depuis la version **1.5.0+**, le pipeline est **entièrement automatisé**, basé sur :

- **Conventional Commits**  
- **standard-version exécuté dans GitHub Actions**  
- **bump automatique de version**  
- **génération automatique du CHANGELOG**  
- **tag Git automatique**  
- **release GitHub automatique**  
- **publication PSGallery automatique**

Aucune commande locale n’est nécessaire.  
Aucune modification manuelle du manifest ou du changelog n’est autorisée.

---

# 🧱 1. Préparation de la release

Avant de pousser un commit déclenchant une release :

- vérifier que la branche `main` est propre  
- vérifier que la CI (`ci.yml`) est verte  
- vérifier que la documentation PlatyPS est à jour  
- vérifier que les tests Pester passent  
- s’assurer que les commits respectent **Conventional Commits**

---

# 🧩 2. Déclenchement de la release

La release est déclenchée automatiquement lorsqu’un **message de commit** respectant Conventional Commits est poussé sur `main`.

> **Important : les exemples ci‑dessous sont des messages de commit.**

Exemples valides :

```
feat: ajout de Get-PKIPass
fix: correction des paramètres invalides
chore(release): préparation de la version 1.5.0
```

### 📌 Rappel SemVer appliqué automatiquement

| Type de commit | Effet sur la version |
|----------------|----------------------|
| `fix:` | bump **patch** (ex : 1.5.0 → 1.5.1) |
| `feat:` | bump **minor** (ex : 1.5.0 → 1.6.0) |
| `BREAKING CHANGE:` | bump **major** (ex : 1.5.0 → 2.0.0) |

Dès que le commit est poussé :

1. GitHub Actions exécute **standard-version**  
2. La version est bumpée automatiquement  
3. `CHANGELOG.md` est généré  
4. Le tag `vX.Y.Z` est créé  
5. Le commit + tag sont poussés automatiquement  
6. Une release GitHub est créée  
7. Le module est publié sur PSGallery

Aucune action manuelle.

---

# 🚀 3. Pipeline de release (automatique)

Le workflow `release.yml` :

1. Analyse les commits  
2. Bump la version (`ModuleVersion`)  
3. Met à jour `CHANGELOG.md`  
4. Crée un commit `chore(release): X.Y.Z`  
5. Crée le tag `vX.Y.Z`  
6. Crée la release GitHub  
7. Publie SecureGen sur PSGallery via `Publish-Module`  
8. Utilise automatiquement :
   - `GITHUB_TOKEN` (fourni par GitHub)
   - `PSGALLERY_KEY` (secret configuré dans le repo)

---

# 📦 4. Publication automatique sur PowerShell Gallery

Aucune commande locale.

Le workflow :

```powershell
Publish-Module -Path . -NuGetApiKey $env:PSGALLERY_KEY
```

La publication est automatique dès que le tag est créé.

---

# 🔍 5. Vérification post‑publication

Après quelques secondes :

- vérifier la version sur PSGallery  
- vérifier la release GitHub générée  
- vérifier le changelog généré automatiquement  
- vérifier la cohérence de la documentation PlatyPS  

---

# 🚫 6. Ce qu’il ne faut plus faire (depuis la v1.5.0)

- ❌ ne plus modifier `ModuleVersion` à la main  
- ❌ ne plus modifier `CHANGELOG.md` à la main  
- ❌ ne plus créer de tag manuellement  
- ❌ ne plus exécuter standard-version en local  
- ❌ ne plus utiliser les anciens scripts de release  
- ❌ ne plus utiliser `publish.yml` (remplacé par `release.yml`)  

Le bump, le changelog, le tag, la release GitHub et la publication PSGallery sont **entièrement automatisés**.

---

# 🧪 7. Dépannage

### La version n’a pas été bumpée  
→ Vérifier que le **message de commit** respecte Conventional Commits

### Le changelog n’a pas été généré  
→ Vérifier que standard-version s’est exécuté dans le workflow

### La publication PSGallery échoue  
→ Vérifier le secret GitHub `PSGALLERY_KEY`

### La release GitHub n’apparaît pas  
→ Vérifier les permissions du workflow (`contents: write`)

---

# 🎉 Un pipeline de release moderne, fiable et sans intervention humaine

Grâce à GitHub Actions + standard-version, SecureGen bénéficie d’un pipeline :

- automatisé  
- reproductible  
- professionnel  
- sans erreur humaine  
- parfaitement aligné avec SemVer  

---

# ⭐ Résultat  
Ton `release-process.md` est maintenant **parfaitement clair**, **sans ambiguïté**, et **aligné avec ton workflow réel**.

---
