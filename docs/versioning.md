# 📘 **docs/versioning.md — Versioning & gestion des versions**

# 🧩 Versioning — SecureGen

Ce document décrit la stratégie de versioning utilisée par **SecureGen**, basée sur le standard **SemVer** (Semantic Versioning).  
Il explique comment incrémenter les versions, comment maintenir la cohérence entre le code, le manifest et le changelog, et comment préparer une release propre.

---

# 🔢 Semantic Versioning (SemVer)

SecureGen utilise le format :

```
MAJOR.MINOR.PATCH
```

Exemples :

- `1.3.1`
- `2.0.0`
- `1.4.0`

---

# 🧱 Règles de versioning

## ✔ MAJOR (X.0.0)
Incrémenter lorsque :

- un changement **incompatible** est introduit  
- une fonctionnalité existante est modifiée de manière **non rétro‑compatible**  
- l’architecture interne change profondément  
- un comportement par défaut est modifié  

Exemples :

- refonte complète du module  
- changement du format de sortie  
- suppression d’une fonction publique  

---

## ✔ MINOR (1.X.0)
Incrémenter lorsque :

- une **nouvelle fonctionnalité** est ajoutée  
- une amélioration significative est introduite  
- une option ou un paramètre est ajouté  
- une optimisation importante est réalisée  

Exemples :

- ajout d’une nouvelle fonction (`Get-RandomKey`)  
- ajout d’un paramètre `-Symbols`  
- amélioration du clipboard Linux  

---

## ✔ PATCH (1.3.X)
Incrémenter lorsque :

- une **correction de bug** est effectuée  
- une amélioration mineure est apportée  
- une optimisation interne sans impact utilisateur est réalisée  
- une correction de documentation est faite  

Exemples :

- correction d’un bug dans `Get-CryptoIndex`  
- amélioration du beep sur macOS  
- correction d’un warning  

---

# 🧾 Où définir la version ?

La version officielle du module se trouve dans :

```
src/SecureGen.psd1
```

Champ à modifier :

```powershell
ModuleVersion = 'X.Y.Z'
```

---

# 📝 Mise à jour du CHANGELOG

Chaque version doit être documentée dans :

```
CHANGELOG.md
```

Format recommandé :

```markdown
## 🚀 1.4.0 — 2026-03-01
### Nouveautés
- Ajout de la fonction Get-RandomKey

### Améliorations
- Optimisation du clipboard Linux

### Corrections
- Correction d’un bug dans Get-CryptoIndex
```

---

# 🧪 Vérification avant release

Avant de publier une nouvelle version :

1. Mettre à jour `SecureGen.psd1`
2. Mettre à jour `CHANGELOG.md`
3. Exécuter le build :

```powershell
.\build.ps1
```

4. Vérifier que le module fonctionne sous :
   - PowerShell 5.1
   - PowerShell 7+

5. Vérifier que les tests passent (si présents)

---

# 🚀 Publication

La publication se fait via :

```powershell
.\build.ps1 -Publish
```

ou :

```powershell
.\Publish-SecureGen.ps1
```

Nécessite :

```powershell
$env:PSGALLERY_KEY = "votre_clé_api"
```

---

# 🔄 Automatisation du versioning (optionnel)

Vous pouvez automatiser :

- l’incrémentation de version  
- la mise à jour du changelog  
- la création de tags Git  
- la publication PSGallery  

via un workflow GitHub Actions.

Un fichier type :

```
.github/workflows/release.yml
```

peut être ajouté pour automatiser tout le pipeline.

---

# 🧱 Bonnes pratiques

- Toujours incrémenter la version **avant** la publication  
- Toujours mettre à jour le changelog  
- Toujours tester PS5 + PS7  
- Toujours tagger la version Git (`vX.Y.Z`)  
- Ne jamais réutiliser un numéro de version déjà publié  
- Ne jamais modifier une version déjà publiée sur PSGallery  

---

# 🎉 Versioning maîtrisé !

Grâce à ce processus, SecureGen reste :

- propre  
- cohérent  
- facile à maintenir  
- professionnel  
- prêt pour CI/CD  

Pour plus d’informations :  
👉 `docs/release-process.md`  
👉 `CHANGELOG.md`

---
