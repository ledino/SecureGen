# 📜 Changelog — SecureGen

Toutes les modifications notables du projet sont documentées ici.

---

## 🔥 1.3.1 — 2026-02-09
### Améliorations majeures
- Nouvelle **architecture modulaire PS7/PS5** :
  - `Core.PS7.ps1` (version moderne)
  - `Legacy.PS5.ps1` (fallback Windows PowerShell)
  - Chargement automatique via `SecureGen.psm1`
- Ajout du **script d’installation intelligent** :
  - Installe SecureGen dans PS5, PS7 ou les deux selon l’environnement
- Mise à jour complète du **README** :
  - Compatibilité détaillée
  - Structure du dépôt
  - Documentation enrichie
- Refonte du **logo officiel** et intégration dans les assets
- Nettoyage global du code et harmonisation du style
- Module totalement **PSGallery‑ready**

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
