# 📜 Changelog — SecureGen

Toutes les modifications notables du projet sont documentées ici.

---

## 🔥 1.3.1 — 2026-02-08
### Améliorations majeures
- Compatibilité **PowerShell 5.1 et 7+** entièrement validée
- Gestion du **clipboard cross‑platform** :
  - Windows : Set-Clipboard
  - macOS : pbcopy
  - Linux : xclip / xsel
- Ajout de **warnings propres** lorsque le clipboard n’est pas disponible
- Encapsulation du **beep** pour éviter les erreurs sur Linux/macOS
- Nettoyage complet du code et harmonisation du style
- Version totalement **PSGallery‑ready**

---

## 🚀 1.3.0 — 2026-02-05
### Nouveautés
- Ajout du **manifest complet (`SecureGen.psd1`)**
- Introduction du **Silent Mode** pour les fonctions de copie
- Ajout d’**aliases ergonomiques** :
  - `sgp` → `Get-PassPhrase`
  - `sgw` → `Get-PassWord`
- Réorganisation du module pour une meilleure lisibilité
- Ajout d’un README enrichi

---

## 🛠️ 1.2.x — 2025
### Fonctionnalités initiales
- Génération de **mots de passe sécurisés**
- Génération de **passphrases robustes**
- Implémentation du générateur cryptographique interne
- Premiers tests cross‑platform

---

## 🧱 1.0.0 — 2025
### Première version publique
- Base du module
- Génération simple de mots de passe
- Structure initiale du projet