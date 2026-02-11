# 📘 **docs/contributing.md — Guide de contribution**

# 🤝 Guide de contribution — SecureGen

Merci de votre intérêt pour **SecureGen** !  
Les contributions sont les bienvenues : corrections, améliorations, documentation, idées, tests, ou nouvelles fonctionnalités.

Ce guide explique comment contribuer efficacement au projet.

---

# 🧱 Principes du projet

SecureGen repose sur trois piliers :

1. **Sécurité**  
   Utilisation d’API cryptographiques modernes et fiables.

2. **Compatibilité**  
   Fonctionnement garanti sous PowerShell 5.1 et PowerShell 7+.

3. **Simplicité**  
   Code clair, modulaire, facile à maintenir.

Toutes les contributions doivent respecter ces principes.

---

# 🚀 Comment contribuer

## 1. Fork du dépôt

Sur GitHub :

- Cliquez sur **Fork**
- Clonez votre fork :

```powershell
git clone https://github.com/ledino/SecureGen
cd SecureGen
```

---

## 2. Créer une branche

```powershell
git checkout -b feature/ma-nouvelle-fonction
```

Ou pour une correction :

```powershell
git checkout -b fix/clipboard-linux
```

---

# 🧱 Structure du module

Le module est organisé ainsi :

```
SecureGen/
│
├── SecureGen/
│   ├── Core.PS7.ps1
│   ├── Legacy.PS5.ps1
│   ├── SecureGen.psm1
│   └── SecureGen.psd1
│
├── scripts/
│   ├── build.ps1
│   ├── Versioning-SecureGen.ps1
│   ├── Install-SecureGen.ps1
│   ├── Publish-SecureGen.ps1
│   └── Release-All.ps1
│
├── assets/
├── docs/
└── .github/
```

### Règles importantes :

- **Ne jamais mélanger** code PS7 et PS5 dans un même fichier.  
- Toute nouvelle fonctionnalité doit être ajoutée dans **Core.PS7.ps1** et **Legacy.PS5.ps1** si elle doit fonctionner partout.  
- Le fichier `SecureGen.psm1` ne doit contenir **aucune logique métier** :  
  - uniquement le loader PS7/PS5  
  - l’export des fonctions  
  - les alias (`sgp`, `sgw`)  

---

# 🧪 Tests

Un dossier `tests/` peut être ajouté pour les tests Pester.

Exemple de test :

```powershell
Describe "Get-PassWord" {
    It "Génère un mot de passe de la bonne longueur" {
        (Get-PassWord -Length 24).Length | Should -Be 24
    }
}
```

Le script de build exécute automatiquement les tests :

```powershell
pwsh ./scripts/build.ps1
```

---

# 🛠️ Build & validation

Avant de soumettre une PR, exécutez :

```powershell
pwsh ./scripts/build.ps1
```

Ce script :

- nettoie l’environnement  
- vérifie la structure  
- copie le module dans `out/`  
- exécute les tests (si présents)  
- prépare le packaging  

---

# 📦 Publication

La publication sur la PowerShell Gallery est réservée aux mainteneurs.  
Toutefois, vous pouvez tester la publication en local :

```powershell
pwsh ./scripts/build.ps1 -Publish
```

⚠️ Nécessite une clé API PSGallery dans :

```powershell
$env:PSGALLERY_KEY
```

---

# 🧹 Style & bonnes pratiques

Merci de respecter :

- `Set-StrictMode -Version Latest`
- indentation PowerShell standard (4 espaces)
- noms de fonctions en **PascalCase**
- noms de paramètres en **camelCase**
- pas de variables globales
- pas de dépendances externes
- pas de secrets en clair dans le code
- API identiques entre PS5 et PS7

---

# 🧠 Discussions & idées

Pour proposer une idée :

- Ouvrez une **Issue** sur GitHub
- Décrivez clairement :
  - le besoin  
  - le contexte  
  - l’usage prévu  
  - l’impact sur PS5/PS7  

---

# 🔐 Sécurité

Toute contribution touchant :

- la cryptographie  
- la génération aléatoire  
- la gestion du clipboard  
- la copie automatique  
- les paramètres sensibles  

doit être examinée avec attention.

Les PR modifiant ces zones doivent inclure :

- une justification technique  
- des tests  
- une validation PS5 + PS7  

---

# 📝 Processus de Pull Request

1. Fork du dépôt  
2. Création d’une branche  
3. Développement + tests  
4. Build local (`pwsh ./scripts/build.ps1`)  
5. Commit clair et structuré  
6. Push vers votre fork  
7. Ouverture d’une Pull Request  

Merci d’inclure :

- une description claire  
- les motivations  
- les impacts  
- les tests éventuels  

---

# 📚 Documentations associées

- 📦 Installation : [https://github.com/ledino/SecureGen/blob/main/docs/installation.md](https://github.com/ledino/SecureGen/blob/main/docs/installation.md)  
- 📘 Exemples : `https://github.com/ledino/SecureGen/blob/main/docs/examples.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fexamples.md")  
- 🧠 Guide avancé : `https://github.com/ledino/SecureGen/blob/main/docs/advanced.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fadvanced.md")  
- 🧱 Architecture : `https://github.com/ledino/SecureGen/blob/main/docs/architecture.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Farchitecture.md")  
- 🧪 Versioning : `https://github.com/ledino/SecureGen/blob/main/docs/versioning.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fversioning.md")  
- 🚀 Processus de release : `https://github.com/ledino/SecureGen/blob/main/docs/release-process.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Frelease-process.md")  
- 🔐 Sécurité : `https://github.com/ledino/SecureGen/blob/main/docs/security.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fsecurity.md")  
- 📜 README principal : `https://github.com/ledino/SecureGen/blob/main/README.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2FREADME.md")  

---

# 🎉 Merci pour votre contribution !

SecureGen est un projet communautaire.  
Chaque contribution — petite ou grande — aide à rendre le module plus robuste, plus simple et plus agréable à utiliser.

Pour toute question :  
👉 Issues GitHub  
👉 Discussions  
👉 Pull Requests

---
