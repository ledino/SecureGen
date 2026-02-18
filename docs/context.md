# 📘 **SecureGen — Project Context & Philosophy**

## 🎯 Objectif du document

Ce fichier capture **la mémoire humaine du projet** :

- les intentions derrière les choix techniques  
- les décisions structurantes  
- les compromis acceptés  
- les valeurs du projet  
- les règles non écrites  
- les idées futures  
- les points de vigilance  
- comment reprendre SecureGen après une longue pause  

Il complète :

- `developer-guide.md` (technique)  
- `workflow.md` (opérationnel)  
- `architecture.md` (structure)  

Ici, on documente **le pourquoi**, pas seulement **le comment**.

---

# 🧠 1. Philosophie du projet

SecureGen repose sur quelques principes fondamentaux :

### ✔ Simplicité d’usage  
Une seule commande doit suffire pour générer un mot de passe ou une passphrase.

### ✔ Sécurité avant tout  
- pas de logs sensibles  
- pas de stockage de secrets  
- SecureString quand pertinent  
- clipboard sécurisé et nettoyable  

### ✔ Compatibilité maximale  
- PS7 = implémentation moderne  
- PS5.1 = fallback minimal mais fonctionnel  
- aucun module externe obligatoire  

### ✔ Transparence  
- code lisible  
- documentation complète  
- tests couvrants  
- CI/CD explicite  

### ✔ Maintenabilité  
- architecture modulaire  
- conventions strictes  
- documentation générée automatiquement  
- versioning automatisé  

---

# 🧱 2. Décisions structurantes (et pourquoi elles existent)

## ✔ Dual‑runtime PS5/PS7  
**Pourquoi ?**  
Parce que beaucoup d’entreprises utilisent encore PS5.1, mais les fonctionnalités modernes (clipboard, RNG, UTF‑8) sont meilleures en PS7.

## ✔ Architecture en 3 fichiers  
- `Core.PS7.ps1`  
- `Legacy.PS5.ps1`  
- `SecureGen.psm1` (loader)

**Pourquoi ?**  
Pour éviter les `if ($PSVersionTable...)` partout dans le code.

## ✔ Documentation dans `docs/cmdlets/`  
**Pourquoi ?**  
Pour séparer la doc API de la doc utilisateur, et préparer un futur site statique.

## ✔ Pas de dépendances externes  
**Pourquoi ?**  
Pour garantir portabilité, stabilité et sécurité.

## ✔ standard‑version + updater custom  
**Pourquoi ?**  
Pour éviter les erreurs humaines dans le manifest et le changelog.

## ✔ Tests Pester obligatoires  
**Pourquoi ?**  
Pour garantir la stabilité du module et éviter les régressions.

---

# 🧩 3. Règles non écrites (mais essentielles)

### ✔ Pas de magie cachée  
Tout comportement doit être explicite.

### ✔ Pas de paramètres ambigus  
Chaque cmdlet doit avoir une API claire, cohérente et prévisible.

### ✔ Pas de duplication de code  
Les helpers doivent être centralisés dans le loader.

### ✔ Pas de dépendances inutiles  
Le module doit rester léger et portable.

### ✔ Pas de logs verbeux  
SecureGen ne doit jamais exposer d’informations sensibles.

---

# 🚧 4. Points de vigilance

### ⚠ Compatibilité PS5.1  
Certaines fonctionnalités modernes ne sont pas disponibles.  
Toujours tester les deux environnements.

### ⚠ Clipboard cross‑platform  
Linux/macOS peuvent nécessiter des utilitaires externes (`xclip`, `pbcopy`).  
Le fallback .NET doit rester robuste.

### ⚠ SecureString  
À utiliser uniquement pour les usages pertinents, pas comme mécanisme de sécurité absolu.

### ⚠ Documentation PlatyPS  
PlatyPS 0.14.2 a des limitations.  
Toujours passer par `Generate-Help.ps1`.

---

# 🚀 5. Vision long terme (Roadmap interne)

### ✔ Ajouter un mode interactif  
Exemple : choisir la longueur, les types, etc.

### ✔ Ajouter un générateur de clés API  
UUID, tokens, secrets aléatoires.

### ✔ Ajouter un mode “policy”  
Ex : règles d’entreprise (longueur, types, entropie minimale).

### ✔ Ajouter un site statique (MkDocs ou Docusaurus)  
Pour transformer `docs/` en documentation en ligne.

### ✔ Ajouter un mode “batch”  
Générer plusieurs mots de passe en une commande.

---

# 🧭 6. Reprendre le projet après une longue pause

### ✔ Lire en priorité  
- `developer-guide.md`  
- `workflow.md`  
- `architecture.md`  
- `release-process.md`  
- `CHANGELOG.md`  

### ✔ Vérifier l’environnement

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

### ✔ Lancer les tests

```powershell
Invoke-Pester
```

### ✔ Regénérer la documentation

```powershell
pwsh ./scripts/Generate-Help.ps1
```

### ✔ Vérifier la CI/CD  
`.github/workflows/`

### ✔ Lire la roadmap  
`ROADMAP.md`

---

# 🧩 7. Idées futures (non prioritaires)

- Génération de passphrases multilingues  
- Intégration avec KeePassXC (optionnel)  
- Mode “entropy calculator”  
- Génération de QR codes pour mots de passe  
- Export vers formats sécurisés  

---

# ❤️ 8. Valeurs du projet

- Transparence  
- Sécurité  
- Simplicité  
- Accessibilité  
- Maintenabilité  
- Documentation  
- Qualité  

---

# 🎉 Merci de faire vivre SecureGen

Ce projet existe grâce à la passion, la rigueur et la vision de ses mainteneurs.  
Ce fichier est là pour garantir que cette vision perdure.

---

