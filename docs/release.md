# 📘 Guide d’utilisation du système de release — SecureGen  
*(Document complémentaire à `release-process.md`)*

Ce guide explique **comment utiliser** le pipeline de release automatisé de SecureGen au quotidien :

- comment déclencher une release  
- comment relancer une release existante  
- comment publier manuellement un tag déjà créé  
- comment interpréter les erreurs courantes  

Pour comprendre **le fonctionnement interne** du pipeline (standard-version, bump automatique, changelog, etc.), se référer à :  
👉 `release-process.md`

---

# 🚀 1. Déclencher une nouvelle release

Le pipeline de release se déclenche **automatiquement** lorsqu’un **message de commit** Conventional Commit est poussé sur `main`.

> **Important : les exemples ci‑dessous sont des messages de commit.**

### Patch (X.Y.Z → X.Y.(Z+1))

```
fix: correction du paramètre -Path
```

### Minor (X.Y.Z → X.(Y+1).0)

```
feat: ajout du support JSON
```

### Major (X.Y.Z → (X+1).0.0)

Dans le body du commit :

```
BREAKING CHANGE: suppression du paramètre -LegacyMode
```

Une fois le commit poussé :

- la version est bumpée automatiquement  
- le changelog est généré  
- le tag `vX.Y.Z` est créé  
- la release GitHub est créée  
- le module est publié sur PSGallery  

Aucune action manuelle n’est nécessaire.

---

# 🔁 2. Relancer une release existante (ex : v1.5.0)

Il peut être utile de relancer une release existante si :

- la publication PSGallery a échoué  
- la release GitHub n’a pas été générée  
- un run précédent était en file d’attente  
- tu veux republier un tag existant sans créer une nouvelle version  

### Étapes :

1. Aller dans **Actions**  
2. Sélectionner **Release PSGallery**  
3. Cliquer sur **Run workflow**  
4. Renseigner le tag existant, par exemple :

```
v1.5.0
```

Le workflow :

- resynchronise le `.psd1`  
- recrée la release GitHub si nécessaire  
- tente de republier sur PSGallery  
- échoue proprement si la version existe déjà (comportement normal)

---

# 🏷 3. Publier manuellement un tag déjà créé

Si un tag existe déjà (ex : `v1.6.0`) mais que la publication n’a pas eu lieu :

1. Actions → Release PSGallery  
2. Run workflow  
3. Tag : `v1.6.0`  

Le workflow se comporte comme si le tag venait d’être poussé.

---

# 🧪 4. Interpréter les erreurs courantes

### ❌ « GitHub Releases requires a tag »
Le workflow a été lancé manuellement **sans fournir de tag**.  
→ Renseigner `vX.Y.Z` dans le champ `tag`.

### ❌ « The module with version X.Y.Z is already available »
La version est **déjà publiée** sur PSGallery.  
→ Le workflow fonctionne, mais refuse de republier une version existante.

### ❌ Le bump ne s’est pas fait
→ Vérifier que le **message de commit** respecte Conventional Commits.

---

# 🧭 5. Quand utiliser quel document ?

| Document | Rôle |
|---------|------|
| **release-process.md** | Comment fonctionne le pipeline (architecture, automatisation, SemVer) |
| **release.md** | Comment utiliser le pipeline (actions, relances, erreurs, pratiques quotidiennes) |

Les deux documents sont complémentaires et couvrent l’ensemble du cycle de release.

---