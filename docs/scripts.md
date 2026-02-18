# 📘 Scripts développeurs — SecureGen  
*(Documentation complète du dossier `scripts/`)*

Ce document décrit tous les scripts internes utilisés pour développer, tester, générer et préparer SecureGen.  
Il sert de référence pour les mainteneurs et contributeurs souhaitant comprendre le rôle de chaque script.

---

# 🧭 Vue d’ensemble

Le dossier `scripts/` contient les outils internes suivants :

```
scripts/
│
├── Generate-Help.ps1
├── Generate-PSGalleryReadme.ps1
├── Install-SecureGen.ps1
├── Publish-SecureGen.ps1
├── Versioning-SecureGen.ps1
├── Release-All.ps1
├── build.ps1
└── Generate-All.ps1
```

Chaque script est documenté ci‑dessous.

---

# 📚 1. `Generate-Help.ps1`  
**Génération automatique de la documentation PlatyPS**

Ce script :

- importe le module SecureGen  
- génère la documentation PlatyPS si elle n’existe pas  
- met à jour la documentation existante  
- valide les fichiers générés  
- garantit une documentation toujours synchronisée avec le code  

**Usage :**

```powershell
pwsh ./scripts/Generate-Help.ps1
```

---

# 📄 2. `Generate-PSGalleryReadme.ps1`  
**Génération automatique du README pour PowerShell Gallery**

Ce script :

- détecte les cmdlets exportées  
- récupère les synopsis PlatyPS  
- génère un README bilingue (FR/EN)  
- compatible avec le rendu PSGallery  
- sans HTML complexe  

**Usage :**

```powershell
pwsh ./scripts/Generate-PSGalleryReadme.ps1
```

---

# 🔐 3. `Install-SecureGen.ps1`  
**Installation locale intelligente**

Ce script :

- détecte PS5.1 et PS7  
- installe SecureGen dans les bons chemins utilisateurs  
- supporte `-Clean` pour repartir d’une installation propre  

**Usage :**

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

---

# 🚀 4. `Publish-SecureGen.ps1`  
**Publication manuelle (optionnelle) sur PowerShell Gallery**

⚠️ Depuis SecureGen 1.5+, la publication officielle est automatisée via GitHub Actions.  
Ce script ne doit être utilisé qu’en cas d’urgence.

Il :

- vérifie la structure  
- prépare un dossier temporaire  
- publie via `Publish-Module`  

**Usage :**

```powershell
pwsh ./scripts/Publish-SecureGen.ps1
```

---

# 🔢 5. `Versioning-SecureGen.ps1`  
**Wrapper local autour de standard-version**

Ce script :

- déclenche un bump local (major/minor/patch)  
- n’édite plus le manifest  
- ne modifie plus le changelog  
- ne crée plus de tag local  

**Usage :**

```powershell
pwsh ./scripts/Versioning-SecureGen.ps1 -Minor
```

---

# 🛠️ 6. `build.ps1`  
**Build local complet**

Ce script :

- nettoie `out/`  
- génère la documentation (optionnel)  
- génère le README PSGallery (optionnel)  
- copie le module dans `out/`  
- exécute les tests (optionnel)  
- valide le manifest  
- simule le packaging  

**Usage :**

```powershell
pwsh ./scripts/build.ps1
```

---

# 🎛️ 7. `Release-All.ps1`  
**Pipeline local de préparation de release**

⚠️ La release officielle est automatisée via GitHub Actions.  
Ce script sert uniquement à :

- faire un bump local (optionnel)  
- lancer un build complet  
- tester une publication manuelle  

**Usage :**

```powershell
pwsh ./scripts/Release-All.ps1 -Minor
```

---

# 🌟 8. `Generate-All.ps1`  
**Script maître — point d’entrée unique**

Ce script orchestre :

- Generate‑Help  
- Generate‑PSGalleryReadme  
- build  
- tests  
- installation locale  

C’est le script recommandé pour les développeurs.

**Usage :**

```powershell
pwsh ./scripts/Generate-All.ps1
```

---
