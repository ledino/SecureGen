# 📘 **Developer Guide — SecureGen (Version enrichie)**

## 🔐 Introduction

Ce guide s’adresse aux développeurs souhaitant :

- comprendre l’architecture interne de SecureGen  
- contribuer au code source  
- exécuter les tests  
- générer la documentation  
- participer au processus de release  
- maintenir le module dans le temps  
- reprendre le projet après une longue pause  

SecureGen est un module PowerShell moderne, modulaire et cross‑platform, conçu pour être maintenable, testable et extensible.  
Ce document constitue **la mémoire technique du projet**.

---

# 🧱 1. Architecture interne

Le code source se trouve dans :

```
SecureGen/
│
├── Core.PS7.ps1      # Implémentation moderne (PS7+)
└── Legacy.PS5.ps1    # Implémentation fallback (PS5.1)
```

Le loader `SecureGen.psm1` :

- détecte automatiquement PS5/PS7  
- charge la bonne implémentation  
- expose les cmdlets publiques  
- gère les alias (`sgw`, `sgp`, `sgpki`)  
- centralise clipboard, beep, SecureString et helpers  
- applique les conventions d’export automatique  

Le manifest `SecureGen.psd1` est mis à jour automatiquement via `standard-version`.

## Diagramme

👉 `assets/diagrams/architecture-interne.svg`

---

# 🧭 2. Naviguer dans le dépôt *(version mise à jour)*

Pour une vue complète :  
👉 `docs/structure.md`

Résumé rapide :

| Besoin | Dossier |
|--------|---------|
| Code source | `SecureGen/` |
| Documentation | `docs/` |
| Cmdlets (PlatyPS) | `docs/cmdlets/` |
| Diagrammes UML | `docs/diagrams/` |
| Scripts dev | `scripts/` |
| Tests | `tests/` |
| CI/CD | `.github/workflows/` |
| Versioning | `.version-updaters/` |

### 🔧 Scripts développeurs

Tous les scripts internes (génération de documentation, build, installation locale, publication manuelle, versioning, etc.) sont documentés ici :

👉 `docs/scripts.md`

---

# 🧠 3. Décisions techniques importantes (mémoire du projet)

Cette section documente les choix structurants du projet.

### ✔ Dual‑runtime PS5/PS7  
- PS7 = implémentation moderne  
- PS5 = fallback minimal  
- Loader intelligent pour compatibilité maximale

### ✔ Documentation dans `docs/cmdlets/`  
- PlatyPS génère dans un sous‑dossier dédié  
- Séparation claire entre doc utilisateur et doc API  
- Structure scalable pour un futur site statique

### ✔ Pas de dépendances externes  
- Aucun module tiers  
- 100% PowerShell natif + .NET intégré

### ✔ API harmonisée  
- `Words` / `Len`  
- Paramètres cohérents entre cmdlets  
- Messages d’erreur uniformisés

### ✔ Clipboard cross‑platform  
- Windows : `Set-Clipboard`  
- Linux/macOS : `xclip`, `pbcopy`, fallback .NET  
- Sécurisation via `Clear-ClipboardSafe`

### ✔ Versioning automatisé  
- standard‑version  
- updater custom pour SecureGen.psd1  
- CI/CD GitHub Actions

---

# 🛠️ 4. Environnement de développement

### ✔ Prérequis

- PowerShell 7+ (recommandé)  
- Windows PowerShell 5.1 (pour compatibilité)  
- Node.js (pour `standard-version`)  
- Git  
- Pester 5.x  
- PSScriptAnalyzer  

### ✔ Cloner le dépôt

```powershell
git clone https://github.com/ledino/SecureGen
cd SecureGen
```

### ✔ Installation locale du module

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

---

# 🧪 5. Tests & Qualité

Les tests se trouvent dans :

```
tests/
│
├── Get-PKIPass.Tests.ps1
├── Get-PassWord.Tests.ps1
├── Get-PassPhrase.Tests.ps1
├── Get-CryptoIndex.Tests.ps1
├── Invoke-Beep.Tests.ps1
└── Clipboard.Tests.ps1
```

### ✔ Lancer tous les tests

```powershell
Invoke-Pester
```

### ✔ Lancer PSScriptAnalyzer

```powershell
Invoke-ScriptAnalyzer -Path ./SecureGen -Recurse
```

La CI GitHub exécute automatiquement :

- PSScriptAnalyzer  
- Import du module  
- Tests Pester  
- Compatibilité PS5/PS7  

---

# 📚 6. Génération de la documentation (PlatyPS)

La documentation des cmdlets est générée via :

```powershell
pwsh ./scripts/Generate-Help.ps1
```

Elle met à jour :

```
docs/cmdlets/
```

Le script :

- détecte PlatyPS  
- génère ou met à jour la doc  
- crée SecureGen.md  
- valide la cohérence  
- supporte `--Force` et `--Clean`

---

# ⚙️ 7. Versioning & Release Workflow

SecureGen utilise :

- **Conventional Commits**  
- **standard-version**  
- **un updater custom pour le manifest**  
- **GitHub Actions** pour la publication PSGallery  

### ✔ Bumper la version

```powershell
npm run release -- --release-as minor
```

Cela :

- met à jour `package.json`  
- met à jour `SecureGen.psd1`  
- génère `CHANGELOG.md`  
- crée un commit `chore(release): X.Y.Z`  
- crée un tag `vX.Y.Z`  

### ✔ Publier

Il suffit de pousser :

```powershell
git push
git push --tags
```

GitHub Actions publie automatiquement sur PowerShell Gallery.

---

# 🔄 8. Pipeline CI/CD — Diagrammes

👉 UML : `assets/diagrams/pipeline-ci-cd.svg`  
👉 ASCII : `docs/pipeline.md`

---

# 🧱 9. Ajouter une nouvelle fonctionnalité

### ✔ Étapes recommandées

1. Créer une branche feature  
2. Implémenter dans Core.PS7.ps1 / Legacy.PS5.ps1  
3. Exporter dans SecureGen.psm1  
4. Ajouter les tests  
5. Ajouter la documentation  
6. Lancer les tests + lint  
7. Commit Conventional Commits  
8. Ouvrir une PR  

---

# 🧭 10. Reprendre le projet après une longue pause

Cette section est **cruciale** pour la continuité du projet.

### ✔ 1. Lire ces fichiers en priorité

- `docs/developer-guide.md` (ce fichier)  
- `docs/architecture.md`  
- `docs/workflow.md`  
- `docs/release-process.md`  
- `CHANGELOG.md`  

### ✔ 2. Vérifier l’état du projet

```powershell
pwsh ./scripts/Setup-Dev.ps1
```

(à créer si tu veux)

### ✔ 3. Lancer les tests

```powershell
Invoke-Pester
```

### ✔ 4. Regénérer la documentation

```powershell
pwsh ./scripts/Generate-Help.ps1
```

### ✔ 5. Vérifier la CI/CD

- `.github/workflows/ci.yml`  
- `.github/workflows/release.yml`  

### ✔ 6. Lire la roadmap

👉 `ROADMAP.md`

---

# 🔐 11. Sécurité & bonnes pratiques

- Ne jamais logguer de secrets  
- Ne jamais stocker de mots de passe  
- Utiliser `SecureString` pour les usages sensibles  
- Utiliser RNG .NET  
- Respecter la compatibilité PS5/PS7  
- Pas de dépendances externes  

---

# 🧩 12. Checklist avant PR

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

Chaque contribution améliore la qualité, la sécurité et l’expérience utilisateur du module.

---
