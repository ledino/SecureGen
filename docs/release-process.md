# 🚀 **Processus de release — SecureGen**  
*(Pipeline moderne, automatisé, fiable et sans intervention humaine)*

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

# 🧭 1. Vue d’ensemble du pipeline de release

Voici le pipeline complet, du commit jusqu’à la publication :

```
Commit → Push → CI → standard-version → Commit release → Tag → Release GitHub → Publish PSGallery
```

### Diagramme ASCII

```
                 ┌───────────────────────────┐
                 │   Commit Conventional     │
                 │         Commits           │
                 └─────────────┬─────────────┘
                               │
                               ▼
                 ┌───────────────────────────┐
                 │   GitHub Actions (CI)     │
                 │  Lint + Tests + Import    │
                 └─────────────┬─────────────┘
                               │
                               ▼
                 ┌──────────────────────────┐
                 │   standard-version       │
                 │  Bump + Changelog + Tag  │
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

# 🧱 2. Préparation de la release

Avant de pousser un commit déclenchant une release :

- vérifier que la branche `main` est propre  
- vérifier que la CI (`ci.yml`) est verte  
- vérifier que la documentation PlatyPS est à jour  
- vérifier que les tests Pester passent  
- s’assurer que les commits respectent **Conventional Commits**  
- s’assurer que le manifest n’a pas été modifié manuellement  

---

# 🧩 3. Déclenchement de la release

La release est déclenchée automatiquement lorsqu’un **commit Conventional Commits** est poussé sur `main`.

Exemples valides :

```
feat: ajout de Get-PKIPass
fix: correction des paramètres invalides
chore(release): préparation de la version 1.5.0
```

### 📌 Rappel SemVer appliqué automatiquement

| Type de commit | Effet sur la version |
|----------------|----------------------|
| `fix:` | bump **patch** (1.5.0 → 1.5.1) |
| `feat:` | bump **minor** (1.5.0 → 1.6.0) |
| `BREAKING CHANGE:` | bump **major** (1.5.0 → 2.0.0) |

---

# 🚀 4. Pipeline de release (automatique)

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

# 📦 5. Publication automatique sur PowerShell Gallery

Aucune commande locale.

Le workflow exécute :

```powershell
Publish-Module -Path . -NuGetApiKey $env:PSGALLERY_KEY
```

La publication est automatique dès que le tag est créé.

---

# 🧪 6. Vérification post‑publication

Après quelques secondes :

- vérifier la version sur PSGallery  
- vérifier la release GitHub générée  
- vérifier le changelog généré automatiquement  
- vérifier la cohérence de la documentation PlatyPS  
- vérifier que le manifest contient la bonne version  

---

# 🧰 7. Checklist avant release

- [ ] Tests Pester OK  
- [ ] PSScriptAnalyzer OK  
- [ ] Documentation PlatyPS à jour  
- [ ] Documentation utilisateur à jour  
- [ ] Aucun changement manuel dans `SecureGen.psd1`  
- [ ] Aucun changement manuel dans `CHANGELOG.md`  
- [ ] Commit Conventional Commits  
- [ ] CI verte  

---

# 🧰 8. Checklist après release

- [ ] Vérifier la version sur PSGallery  
- [ ] Vérifier la release GitHub  
- [ ] Vérifier le changelog  
- [ ] Vérifier que le tag est correct  
- [ ] Vérifier que la documentation est cohérente  
- [ ] Mettre à jour la roadmap si nécessaire  

---

# 🔥 9. Cas particuliers

## ✔ Hotfix (patch urgent)

Utiliser un commit :

```
fix: correction critique sur Get-PassWord
```

→ déclenche automatiquement un bump patch.

## ✔ Breaking change

Ajouter dans le commit :

```
BREAKING CHANGE: suppression du paramètre -LegacyMode
```

→ déclenche automatiquement un bump major.

## ✔ Rollback d’une release

1. Supprimer le tag  
2. Supprimer la release GitHub  
3. Revert du commit `chore(release)`  
4. Pousser le revert  
5. Laisser GitHub Actions reconstruire  

---

# 🚫 10. Ce qu’il ne faut plus faire (depuis la v1.5.0)

- ❌ ne plus modifier `ModuleVersion` à la main  
- ❌ ne plus modifier `CHANGELOG.md` à la main  
- ❌ ne plus créer de tag manuellement  
- ❌ ne plus exécuter standard-version en local  
- ❌ ne plus utiliser les anciens scripts de release  
- ❌ ne plus utiliser `publish.yml` (remplacé par `release.yml`)  

---

# ❓ 11. FAQ Release

### “Pourquoi standard-version n’est plus exécuté en local ?”  
Pour éviter les divergences entre environnements et garantir un pipeline reproductible.

### “Pourquoi ne pas modifier le manifest à la main ?”  
Parce que l’updater custom gère la version automatiquement.

### “Pourquoi la release est déclenchée par un commit ?”  
Parce que c’est le workflow le plus fiable et le plus utilisé dans les projets modernes.

### “Puis-je publier manuellement ?”  
Oui, mais **fortement déconseillé**.  
Le pipeline garantit la cohérence.

---

# 🎉 12. Un pipeline de release moderne, fiable et sans intervention humaine

Grâce à GitHub Actions + standard-version, SecureGen bénéficie d’un pipeline :

- automatisé  
- reproductible  
- professionnel  
- sans erreur humaine  
- parfaitement aligné avec SemVer  

---
