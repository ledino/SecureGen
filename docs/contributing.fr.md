# 🤝 Contribuer à SecureGen  
*(Guide officiel pour contributeurs — v1.5.0+)*

Merci de votre intérêt pour **SecureGen** !  
Ce document explique comment contribuer efficacement au projet, respecter les conventions, exécuter les tests, et participer au processus de release.

---

# 🧱 Principes fondamentaux

SecureGen repose sur trois piliers :

1. **Sécurité moderne**  
   Utilisation exclusive d’API cryptographiques approuvées (PS7 : Get‑SecureRandom, PS5 : RNGCryptoServiceProvider).

2. **Compatibilité maximale (PS5.1 + PS7+)**  
   Deux implémentations internes, unifiées via un loader intelligent.

3. **Qualité professionnelle**  
   CI multi‑plateformes, tests Pester, documentation PlatyPS, versioning automatisé.

Toute contribution doit respecter ces principes.

---

# 📦 1. Installation du projet (développement)

Clonez le dépôt :

```powershell
git clone https://github.com/ledino/SecureGen.git
cd SecureGen
```

Installez les dépendances Node (pour standard-version) :

```powershell
npm ci
```

---

# 🧪 2. Lancer les tests & l’analyse statique

## Analyse statique (PSScriptAnalyzer)

```powershell
Invoke-ScriptAnalyzer -Path ./SecureGen -Recurse
```

## Tests Pester

```powershell
Invoke-Pester -Path ./tests
```

Le CI GitHub exécute automatiquement :

- PSScriptAnalyzer  
- Pester  
- tests sur Windows PS5.1  
- tests sur Windows PS7  
- tests sur Linux PS7  

Les tests couvrent désormais **Get‑PKIPass**, y compris :

- modes Password / Passphrase  
- retour SecureString  
- forwarding interne  
- mocks du clipboard  

---

# 🧩 3. Conventions de code

## Style PowerShell

- indentation 4 espaces  
- pas de variables globales  
- pas de `Write-Host` dans les fonctions  
- pas de dépendances externes  
- code compatible PS5.1 **et** PS7+  
- éviter les constructions non supportées par PS5.1  

## Architecture

Le module utilise deux implémentations :

```
Core.PS7.ps1   → version optimisée PS7+
Legacy.PS5.ps1 → fallback PS5.1
```

Toute nouvelle fonctionnalité doit :

- être compatible PS5.1  
- tirer parti de PS7+ quand possible  
- être encapsulée dans le loader `SecureGen.psm1`  
- respecter la cohérence API (Words / Len / Length)  
- intégrer un test Pester  

---

# 🧪 4. Conventional Commits (obligatoire)

SecureGen utilise **Conventional Commits** pour :

- déterminer automatiquement le bump de version  
- générer le changelog  
- garder un historique propre  

Types principaux :

| Type | Effet |
|------|-------|
| `feat:` | nouvelle fonctionnalité (MINOR) |
| `fix:` | correction (PATCH) |
| `docs:` | documentation |
| `refactor:` | amélioration interne |
| `perf:` | optimisation |
| `BREAKING CHANGE:` | MAJOR |

Exemples :

```
feat: ajout de Get-PKIPass
fix: correction du clipboard sous Linux
refactor: simplification du loader PS7
```

---

# 🔄 5. Processus de release (v1.4.0+)

Les releases sont générées **localement**, puis publiées automatiquement via GitHub Actions.

## Étapes :

1. Vérifier que la CI est verte  
2. Générer la version :

```powershell
npm run release -- --release-as X.Y.Z
```

3. Pousser la branche :

```powershell
git push
```

4. Pousser le tag :

```powershell
git push origin vX.Y.Z
```

5. GitHub Actions publie automatiquement sur PowerShell Gallery  
6. Créer la Release GitHub (notes déjà prêtes dans `CHANGELOG.md`)

---

# 🚀 6. Soumettre une Pull Request

## Checklist obligatoire :

- [ ] Code compatible PS5.1 et PS7+  
- [ ] Tests Pester ajoutés ou mis à jour (incluant mocks si clipboard)  
- [ ] Analyse PSScriptAnalyzer OK  
- [ ] Documentation mise à jour (cmdlet + README si nécessaire)  
- [ ] Commit messages conformes à Conventional Commits  
- [ ] Pas de bump manuel du manifest  
- [ ] Pas de modification manuelle du changelog  
- [ ] Cohérence API (Words / Len / Length / Type / AsSecureString)  
- [ ] Si ajout d’une fonctionnalité sensible → tests PKI + SecureString  

## Processus :

1. Fork du dépôt  
2. Créer une branche :

```powershell
git checkout -b feat/ma-nouvelle-fonction
```

3. Développer  
4. Lancer les tests  
5. Commit + push  
6. Ouvrir une Pull Request  

---

# 🧰 7. Scripts utiles

| Script | Rôle |
|--------|------|
| `scripts/Generate-Help.ps1` | Génère la documentation PlatyPS |
| `scripts/Install-SecureGen.ps1` | Installation locale |
| `scripts/Publish-SecureGen.ps1` | Publication manuelle (rarement utilisée) |
| `scripts/Versioning-SecureGen.ps1` | **Legacy — ne plus utiliser** |

---

# 🛑 8. Ce qu’il ne faut plus faire

- ❌ ne pas modifier `ModuleVersion` à la main  
- ❌ ne pas modifier `CHANGELOG.md` à la main  
- ❌ ne pas utiliser `Release-All.ps1`  
- ❌ ne pas créer de tag manuellement (hors release locale)  
- ❌ ne pas exécuter standard-version dans GitHub Actions  
- ❌ ne pas modifier `SecureGen-help.xml` directement  
- ❌ ne pas introduire de paramètres non compatibles PS5.1  

---

# 📚 9. Ressources associées

- `docs/versioning.md`  
- `docs/release-process.md`  
- `docs/architecture.md`  
- `docs/diagrams/overview.md`  
- `README.md`  

---

# 🎉 Merci de contribuer à SecureGen !

Votre aide rend le module plus robuste, plus moderne et plus agréable à utiliser.  
Issues, discussions et PRs sont les bienvenues.

---
