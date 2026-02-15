# 📘 **Developer Guide — SecureGen**

## 🔐 Introduction

Ce guide s’adresse aux développeurs souhaitant :

- comprendre l’architecture interne de SecureGen  
- contribuer au code source  
- exécuter les tests  
- générer la documentation  
- participer au processus de release  
- maintenir le module dans le temps  

SecureGen est un module PowerShell moderne, modulaire et cross‑platform, conçu pour être maintenable, testable et extensible.

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
- expose les cmdlets  
- gère les alias (`sgw`, `sgp`, `sgpki`)  
- centralise clipboard, beep, SecureString et helpers  

Le manifest `SecureGen.psd1` est mis à jour automatiquement via `standard-version`.

---

# 🧭 2. Naviguer dans le dépôt

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

---

# 🛠️ 3. Environnement de développement

### ✔ Prérequis

- PowerShell 7+ (recommandé)  
- Windows PowerShell 5.1 (pour tests de compatibilité)  
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

# 🧪 4. Tests & Qualité

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

# 🧩 5. Génération de la documentation (PlatyPS)

La documentation des cmdlets est générée via :

```powershell
pwsh ./scripts/Generate-Help.ps1
```

Elle met à jour :

```
docs/cmdlets/
```

---

# ⚙️ 6. Versioning & Release Workflow

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

# 🔄 7. Pipeline CI/CD — Diagramme UML (Activity Diagram)

```uml
@startuml
title SecureGen CI/CD - Activity Diagram

start

:Développement local;
:Modification du code;
:Tests manuels;
:Commits (Conventional Commits);

--> "standard-version";

partition "Versioning automatisé" {
    :Analyse des commits;
    :Détermination du bump (major/minor/patch);
    :Mise à jour package.json;
    :Mise à jour SecureGen.psd1 (updater custom);
    :Génération CHANGELOG.md;
    :Commit automatique "chore(release): X.Y.Z";
    :Création du tag vX.Y.Z;
}

--> "Push GitHub";

:git push origin main;
:git push origin vX.Y.Z;

--> "CI GitHub Actions";

partition "CI (ci.yml)" {
    :Installation PowerShell;
    :Analyse statique (PSScriptAnalyzer);
    :Import du module;
    :Tests Pester;
    :Validation du manifest;

    fork
        :PS 5.1 (Windows);
    fork again
        :PS 7 (Windows);
    fork again
        :PS 7 (Linux);
    end fork

    if ("CI réussie ?") then (Oui)
        --> "Publish pipeline";
    else (Non)
        :Retour développeur;
        :Corrections locales;
        --> "Développement local";
    endif
}

partition "Publication (publish.yml)" {
    :Déclencheur : push tag v*;
    :Reconstruction du module;
    :Validation du manifest;
    :Publication PSGallery (PSGALLERY_KEY);
    :Création Release GitHub automatique;
}

:Module publié (PSGallery + GitHub Release);

stop
@enduml
```

---

# 🔄 8. Pipeline CI/CD — Vue d’ensemble (ASCII)

Voici une représentation simplifiée du pipeline CI/CD de SecureGen :

```
                 ┌───────────────────────────┐
                 │        Commit / PR        │
                 └─────────────┬─────────────┘
                               │
                               ▼
                 ┌───────────────────────────┐
                 │   GitHub Actions (CI)     │
                 ├───────────────────────────┤
                 │  • Lint (PSScriptAnalyzer)│
                 │  • Import du module       │
                 │  • Tests Pester           │
                 │  • PS5 + PS7 matrix       │
                 └─────────────┬─────────────┘
                               │
                               ▼
                 ┌───────────────────────────┐
                 │   Merge dans `main`       │
                 └─────────────┬─────────────┘
                               │
                               ▼
                 ┌──────────────────────────┐
                 │   standard-version       │
                 ├──────────────────────────┤
                 │  • Bump version          │
                 │  • Update manifest       │
                 │  • Generate CHANGELOG    │
                 │  • Commit + Tag          │
                 └─────────────┬────────────┘
                               │
                               ▼
                 ┌──────────────────────────┐
                 │   Push + Push Tags       │
                 └─────────────┬────────────┘
                               │
                               ▼
                 ┌──────────────────────────┐
                 │ GitHub Actions (Publish) │
                 ├──────────────────────────┤
                 │  • Build module          │
                 │  • Publish PSGallery     │
                 │  • Create GitHub Release │
                 └─────────────┬────────────┘
                               │
                               ▼
                 ┌──────────────────────────┐
                 │   Release disponible     │
                 │  (PSGallery + GitHub)    │
                 └──────────────────────────┘
```

---


# 🧱 9. Ajouter une nouvelle fonctionnalité

### ✔ Étapes recommandées

1. Créer une branche feature :  
   ```powershell
   git checkout -b feature/ma-fonction
   ```

2. Ajouter la fonctionnalité dans :  
   - `Core.PS7.ps1`  
   - `Legacy.PS5.ps1` (si nécessaire)  
   - `SecureGen.psm1` (export + alias éventuels)

3. Ajouter les tests dans `tests/`.

4. Ajouter la documentation dans :  
   - `docs/cmdlets/`  
   - `docs/examples.md` (si pertinent)

5. Lancer les tests + lint.

6. Commit avec Conventional Commits :  
   ```
   feat: ajout de la commande Get-XYZ
   ```

7. Ouvrir une Pull Request.

---

# 🤝 10. Contribution & Standards

Les contributions suivent :

- Conventional Commits  
- Pas de bump manuel du manifest  
- Pas de modification manuelle du changelog  
- Documentation obligatoire pour toute nouvelle commande  
- Tests obligatoires pour toute nouvelle fonctionnalité  
- Respect du style PowerShell (PSScriptAnalyzer)  

Voir :  
👉 `CONTRIBUTING.md`  
👉 `GOVERNANCE.md`  
👉 `MAINTAINERS.md`

---

# 🔐 11. Sécurité & bonnes pratiques

- Ne jamais logguer de secrets  
- Ne jamais stocker de mots de passe  
- Utiliser `SecureString` pour les usages sensibles  
- Utiliser `Get-SecureRandom` ou RNG .NET  
- Respecter la compatibilité PS5/PS7  
- Ne jamais introduire de dépendances externes non nécessaires  

Voir :  
👉 `docs/security.md`

---

# 🧭 12. Checklist avant PR

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
N’hésitez pas à ouvrir une PR, une Issue ou une Discussion.

---
