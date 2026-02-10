# 📜 Changelog — SecureGen  
Toutes les modifications notables du projet sont documentées ici.

---

## 🛠️ 1.3.2 — 2026‑02‑10

### Corrections & synchronisation documentaire
- Mise à jour complète de **toute la documentation** pour refléter l’architecture réelle du module :
  - séparation PS7 / PS5
  - loader intelligent `SecureGen.psm1`
  - structure `SecureGen/` + `scripts/`
- Harmonisation de **tous les exemples** avec les paramètres modernes :
  - `-SpecialChars`
  - `-UseSpecial`
  - `-MotsParBloc`
  - `-LettresParMot`
  - `-Silent`
- Correction de tous les alias obsolètes → adoption définitive de :
  - `sgw` → `Get-PassWord`
  - `sgp` → `Get-PassPhrase`
- Suppression de toutes les références aux anciens paramètres :
  - `-Symbols`, `-Words`, `-Copy`
- Mise à jour des sections CI/CD (GitHub Actions & Azure DevOps)
- Mise à jour des chemins d’installation et de build :
  - `pwsh ./scripts/build.ps1`
  - `pwsh ./scripts/Install-SecureGen.ps1`
- Nettoyage global du style et cohérence entre tous les fichiers `docs/`

### Améliorations mineures
- Clarification des messages de troubleshooting
- Amélioration de la lisibilité des guides avancés
- Mise à jour du `index.md` pour refléter la structure finale

---

## 🔥 1.3.1 — 2026‑02‑09  
### Améliorations majeures

#### 🧱 Nouvelle architecture modulaire PS7 / PS5  
- Séparation claire :  
  - `Core.PS7.ps1` (version moderne, .NET 6+, Get‑SecureRandom)  
  - `Legacy.PS5.ps1` (fallback Windows PowerShell 5.1)  
- Chargement automatique via `SecureGen.psm1`  
- API unifiée entre PS5 et PS7

#### 🛠️ Nouveau script d’installation intelligent  
- `scripts/Install-SecureGen.ps1`  
- Détection automatique PS5 / PS7  
- Installation dans tous les environnements disponibles

#### 📚 Refonte complète de la documentation  
- Mise à jour de **tous les fichiers** :  
  - `installation.md`  
  - `examples.md`  
  - `advanced.md`  
  - `architecture.md`  
  - `security.md`  
  - `faq.md`  
  - `contributing.md`  
  - `troubleshooting.md`  
  - `versioning.md`  
  - `index.md`  
- Harmonisation totale avec la nouvelle architecture  
- Exemples modernisés (paramètres actuels, alias, CI/CD)

#### 🎨 Identité visuelle  
- Nouveau logo officiel  
- Mise à jour des assets (`assets/`)

#### 🧹 Nettoyage global  
- Code harmonisé  
- Style unifié  
- Module totalement **PSGallery‑ready**

---

## 🚀 1.3.0 — 2026‑02‑05  
### Nouveautés

- Ajout du **manifest complet (`SecureGen.psd1`)**  
- Introduction du **Silent Mode** (`-Silent`)  
- Ajout des **aliases ergonomiques** :  
  - `gpp` → `Get-PassPhrase`  
  - `gpw` → `Get-PassWord`  
- Réorganisation du module pour une meilleure lisibilité  
- Ajout d’un README enrichi

---

## 🛠️ 1.2.x — 2025  
### Fonctionnalités initiales

- Génération de **mots de passe sécurisés**  
- Génération de **passphrases robustes**  
- Implémentation du générateur cryptographique interne (`Get-CryptoIndex`)  
- Premiers tests cross‑platform  

---

## 🧱 1.0.0 — 2025  
### Première version publique

- Base du module  
- Génération simple de mots de passe  
- Structure initiale du projet  

---

