# 🖼️ Screenshots & GIFs — SecureGen  
*(Aperçus visuels du module en action)*

Ce document présente des aperçus visuels de SecureGen : génération de mots de passe, passphrases, clipboard sécurisé, intégration dans des scripts et pipelines CI/CD.

Les GIFs et captures d’écran sont stockés dans :

```
assets/screenshots/
```

---

# 🔑 Génération d’un mot de passe

<p align="center">
  <img src="../assets/screenshots/password-demo.gif" width="650" alt="Démonstration de génération de mot de passe"/>
</p>

Ce GIF montre :

- l’exécution de `Get-PassWord`
- la génération instantanée d’un mot de passe sécurisé
- l’utilisation du mode silencieux (`-Silent`)
- un affichage clair et lisible

---

# 🧠 Génération d’une passphrase

<p align="center">
  <img src="../assets/screenshots/passphrase-demo.gif" width="650" alt="Démonstration de génération de passphrase"/>
</p>

Ce GIF illustre :

- l’exécution de `Get-PassPhrase`
- la génération d’une passphrase lisible et robuste
- l’option `-MotsParBloc` pour ajuster la longueur
- l’option `-Silent` pour les scripts automatisés

---

# 📋 Clipboard sécurisé

<p align="center">
  <img src="../assets/screenshots/clipboard-demo.gif" width="650" alt="Clipboard sécurisé"/>
</p>

Ce GIF montre :

- la copie dans le presse‑papier via `Set-ClipboardSafe`
- l’effacement sécurisé via `Clear-ClipboardSafe`
- le beep discret (désactivable avec `-Silent`)
- le fallback cross‑platform (Windows / macOS / Linux)

---

# 🧪 Utilisation dans un script PowerShell

<p align="center">
  <img src="../assets/screenshots/script-demo.png" width="650" alt="SecureGen dans un script PowerShell"/>
</p>

Cette capture montre SecureGen intégré dans un script :

- génération d’un secret
- conversion en SecureString
- utilisation dans une commande système

---

# ⚙️ Utilisation en CI/CD (GitHub Actions)

<p align="center">
  <img src="../assets/screenshots/github-actions-demo.png" width="650" alt="SecureGen dans GitHub Actions"/>
</p>

Cette capture illustre :

- installation du module dans un pipeline
- génération d’un secret dans un job
- export vers une variable d’environnement

---

# 🎥 Comment capturer vos GIFs

Pour créer des GIFs propres et légers :

### 🪟 Windows
- **ScreenToGif** (gratuit, open‑source)
- Paramètres recommandés :
  - 30 FPS
  - zone de capture réduite
  - compression automatique

### 🐧 Linux
- **Peek**
- **Kazam** (mode GIF)

### 🍎 macOS
- **Kap**
- **Gifski** (optimisation)

### 🎨 Conseils
- fond sombre (PowerShell par défaut)
- police Consolas / Cascadia Code
- zoom 125–150% pour la lisibilité
- éviter les mouvements brusques
- durée idéale : 3–6 secondes

---

# 📁 Structure recommandée

```
assets/
└── screenshots/
    ├── password-demo.gif
    ├── passphrase-demo.gif
    ├── clipboard-demo.gif
    ├── script-demo.png
    └── github-actions-demo.png
```

---

# 📌 Notes

- Les GIFs sont optionnels : SecureGen fonctionne parfaitement sans.
- Vous pouvez ajouter autant de captures que nécessaire.
- Les GIFs améliorent la compréhension et l’adoption du module.

---

# 🎉 Merci d’utiliser SecureGen !

Pour toute suggestion d’amélioration visuelle :  
👉 Issues GitHub  
👉 Discussions
```

---
