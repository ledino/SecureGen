# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [1.4.1](https://github.com/ledino/SecureGen/compare/v1.5.0...v1.4.1) (2026-02-16)


### 🐛 Fixes

*  release pipeline ([8be1b10](https://github.com/ledino/SecureGen/commit/8be1b1061325ca6fc90e89dd21f0805cea7d463c))
* test release pipeline ([43030ea](https://github.com/ledino/SecureGen/commit/43030ea050804bbe14fd0c4249a9f5e3ff713d97))

## [1.5.0](https://github.com/ledino/SecureGen/compare/v1.4.0...v1.5.0) (2026-02-16)


### ✨ Features

* add Pester tests + PlatyPS docs v1.4.0 ([b960e1f](https://github.com/ledino/SecureGen/commit/b960e1f78c90d17965c4e8e52c55acc2654b8fab)), closes [#12](https://github.com/ledino/SecureGen/issues/12)
* release 1.5.0 with PKIPass, SecureStringSafe and clipboard improvements ([5bbe32c](https://github.com/ledino/SecureGen/commit/5bbe32c358b44d4edb709afd485e0e0b66b9dd31))


### 🐛 Fixes

* clean release pipeline ([0067a27](https://github.com/ledino/SecureGen/commit/0067a27f71523d0a947424f16d103047ef4cfd58))
* configure git identity before everything ([fc82cbb](https://github.com/ledino/SecureGen/commit/fc82cbbd4139d9ceb3265db20d8f295663061a9e))
* configure git identity before standard-version ([3f8e3cc](https://github.com/ledino/SecureGen/commit/3f8e3cc0a2604a51340a5997c3b65bc6c35b3d4f))
* enable release workflow by removing paths-ignore ([ee4fbb6](https://github.com/ledino/SecureGen/commit/ee4fbb60b2c1cc2c833dd5c567b84fe7d2e38284))
* test release pipeline ([2c956ff](https://github.com/ledino/SecureGen/commit/2c956ffefc47710d9611072505c0d407f5f700f5))
* test release pipeline ([8fc283b](https://github.com/ledino/SecureGen/commit/8fc283b44382f9d3c6744912210fe498f64434d1))
* test release pipeline ([10391ff](https://github.com/ledino/SecureGen/commit/10391ff8d202d4d0c3cdac7c8587b075e26f57be))

### [1.4.1](https://github.com/ledino/SecureGen/compare/v1.5.0...v1.4.1) (2026-02-16)


### 🐛 Fixes

* configure git identity before everything ([fc82cbb](https://github.com/ledino/SecureGen/commit/fc82cbbd4139d9ceb3265db20d8f295663061a9e))
* test release pipeline ([10391ff](https://github.com/ledino/SecureGen/commit/10391ff8d202d4d0c3cdac7c8587b075e26f57be))

## [1.5.0](https://github.com/ledino/SecureGen/compare/v1.4.0...v1.5.0) (2026-02-16)


### ✨ Features

* add Pester tests + PlatyPS docs v1.4.0 ([b960e1f](https://github.com/ledino/SecureGen/commit/b960e1f78c90d17965c4e8e52c55acc2654b8fab)), closes [#12](https://github.com/ledino/SecureGen/issues/12)
* release 1.5.0 with PKIPass, SecureStringSafe and clipboard improvements ([5bbe32c](https://github.com/ledino/SecureGen/commit/5bbe32c358b44d4edb709afd485e0e0b66b9dd31))


### 🐛 Fixes

* configure git identity before standard-version ([3f8e3cc](https://github.com/ledino/SecureGen/commit/3f8e3cc0a2604a51340a5997c3b65bc6c35b3d4f))
* enable release workflow by removing paths-ignore ([ee4fbb6](https://github.com/ledino/SecureGen/commit/ee4fbb60b2c1cc2c833dd5c567b84fe7d2e38284))

## [1.5.0](https://github.com/ledino/SecureGen/compare/v1.4.0...v1.5.0) (2026‑02‑14)

# ✨ Nouveautés majeures

### 🔐 Nouveau : Get‑PKIPass (mode Password / Passphrase + SecureString)
- Ajout d’une nouvelle commande dédiée aux usages sensibles (PKI, certificats, comptes de service, KMS, CI/CD).
- Support complet des deux modes :
  - **Password** (32 caractères par défaut, personnalisable via `-Length`)
  - **Passphrase** (5×5 par défaut, personnalisable via `-Words` et `-Len`)
- Nouveau paramètre **`-AsSecureString`** pour intégration directe dans :
  - PSCredential
  - scripts d’automatisation
  - services Windows
  - pipelines CI/CD
- Alias ergonomique : **`sgpki`**
- API cohérente avec `Get-PassWord` et `Get-PassPhrase`.

---

### 🔒 Amélioration : `Get-PassWord` avec `-RequireAllTypes`
Ajout du paramètre **`-RequireAllTypes`** garantissant que chaque mot de passe contient au minimum :

- 1 minuscule  
- 1 majuscule  
- 1 chiffre  
- 1 caractère spécial  

✔ Conforme aux politiques de sécurité strictes  
✔ Renforce la robustesse des mots de passe  
✔ Compatible avec toutes les options existantes

---

### 🛡️ Nouveau : Convert-ToSecureStringSafe
Fonction dédiée à la conversion robuste en SecureString, permettant de :

- contourner les limitations de `ConvertTo-SecureString`  
- éviter les erreurs en environnement non interactif  
- garantir une conversion fiable sur Windows, Linux et macOS  

✔ Idéal pour les scripts automatisés  
✔ Compatible PKI / CI/CD  
✔ API simple et cohérente

---

### 📋 Nouveaux outils Clipboard : `Set-ClipboardSafe` & `Clear-ClipboardSafe`
Ajout de deux fonctions sécurisées pour la gestion du presse‑papier :

- **`Set-ClipboardSafe`** : copie fiable, cross‑platform, compatible CI/CD  
- **`Clear-ClipboardSafe`** : effacement sécurisé du presse‑papier, même en environnement restreint  

Ces fonctions remplacent les appels natifs instables (`Set-Clipboard`, `pbcopy`, `xclip`, etc.) et garantissent :

✔ un comportement identique sur Windows / Linux / macOS  
✔ une meilleure sécurité (effacement explicite)  
✔ une intégration parfaite avec `Get-PassWord`, `Get-PassPhrase` et `Get-PKIPass`

---

# 🧪 Tests & Qualité

### ✔ Ajout des tests Pester pour Get‑PKIPass
- Tests complets : valeurs par défaut, modes Password/Passphrase, SecureString, clipboard, forwarding interne.
- Mock du clipboard pour compatibilité Linux/macOS/CI.
- Cohérence totale avec les tests existants.

### ✔ Harmonisation de tous les tests existants
- Mise à jour des tests Get‑PassWord, Get‑PassPhrase, Get‑CryptoIndex.
- Nettoyage des mocks obsolètes.
- Compatibilité PS7 / PS5.1 garantie.

### ✔ Nouveaux tests ClipboardSafe  
- Tests complets pour `Set-ClipboardSafe` et `Clear-ClipboardSafe`  
- Mock du presse‑papier pour compatibilité Linux/macOS/CI  
- Validation du comportement sécurisé (effacement, fallback, erreurs propres)

---

# 📚 Documentation (mise à jour complète)

### ✔ Mise à jour de **toutes** les pages PlatyPS :
- `Get-PKIPass.md` (nouvelle page)
- `Get-PassPhrase.md` (API modernisée : Words / Len)
- `Get-PassWord.md` (valeurs par défaut, cohérence API)
- `Get-CryptoIndex.md`
- `SecureGen.md`

### ✔ Mise à jour des documents avancés :
- `docs/examples.md` (nouvelle section PKI complète)
- `docs/advanced.md`
- `docs/security.md`
- `docs/architecture.md`
- `docs/release-process.md`
- `docs/versioning.md`

### ✔ Mise à jour du README :
- Nouvelle section PKIPass
- Table des fonctions mise à jour
- Exemples modernisés
- Cohérence totale avec SecureGen 1.5.0

---

# 🧩 API & Cohérence

### ✔ Harmonisation complète de l’API
- `Get-PassPhrase` utilise désormais **Words** et **Len** (plus de MotsParBloc / LettresParMot).
- `Get-PKIPass` reprend exactement la même logique.
- `Get-PassWord` reste cohérent avec `-Len`.

### ✔ Alias officiels
- `sgw` → Get-PassWord  
- `sgp` → Get-PassPhrase  
- `sgpki` → Get-PKIPass  

---

# 🧹 Nettoyage & Maintenance

### ✔ Correction des paramètres & messages d’erreur
- Correction des erreurs retournées lors de saisies invalides dans plusieurs fonctions.  
- Validation des paramètres renforcée.  
- Messages d’erreur plus clairs et cohérents.

### ✔ Correction de la documentation
- Suppression des paramètres obsolètes dans la documentation.
- Nettoyage global des exemples, guides et sections CI/CD.
- Mise à jour des chemins, scripts et conventions.
- Cohérence totale entre README, docs, PlatyPS et tests.

---

# 🚀 Résultat

SecureGen 1.5.0 apporte :

- une **commande PKI professionnelle**  
- une **API modernisée et cohérente**  
- une **gestion du clipboard sécurisée et cross‑platform**  
- une **documentation entièrement revue**  
- des **tests robustes et complets**  
- une **expérience utilisateur plus fiable**  

SecureGen devient un module **mature**, **professionnel**, et parfaitement adapté aux environnements modernes (PKI, CI/CD, automatisation, multi‑plateforme).

---

## [1.4.0](https://github.com/ledino/SecureGen/compare/v1.3.2...v1.4.0) (2026-02-12)

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
