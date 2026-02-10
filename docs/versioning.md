# 📘 **docs/versioning.md — Versioning & gestion des versions**

# 🧩 Versioning — SecureGen  
*(Version synchronisée avec la structure actuelle du module)*

Ce document décrit la stratégie de versioning utilisée par **SecureGen**, basée sur le standard **SemVer** (Semantic Versioning).  
Il explique comment incrémenter les versions, maintenir la cohérence entre le code, le manifest et le changelog, et préparer une release propre.

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
- un paramètre est ajouté  
- une optimisation importante est réalisée  

Exemples :

- ajout d’un paramètre `-LettresParMot`  
- ajout d’un alias (`sgw`, `sgp`)  
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
SecureGen/SecureGen.psd1
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
- Ajout du paramètre -LettresParMot

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
pwsh ./scripts/build.ps1
```

4. Vérifier que le module fonctionne sous :  
   - PowerShell 5.1  
   - PowerShell 7+  

5. Vérifier que les tests passent (si présents)

---

# 🚀 Publication

La publication se fait via :

```powershell
pwsh ./scripts/build.ps1 -Publish
```

ou :

```powershell
pwsh ./scripts/Publish-SecureGen.ps1
```

Nécessite :

```powershell
$env:PSGALLERY_KEY = "votre_clé_api"
```

---

# 🔄 Automatisation du versioning

Le script suivant gère déjà une partie du versioning :

```
scripts/Versioning-SecureGen.ps1
```

Il permet :

- l’incrémentation automatique SemVer  
- la mise à jour du manifest  
- la mise à jour du changelog  
- la création d’un tag Git (optionnel)  

Pour automatiser entièrement le pipeline, vous pouvez utiliser :

```
scripts/Release-All.ps1
```

ou un workflow GitHub Actions :

```
.github/workflows/release.yml
```

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
