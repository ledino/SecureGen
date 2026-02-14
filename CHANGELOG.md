# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

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

# 🧪 Tests & Qualité

### ✔ Ajout des tests Pester pour Get‑PKIPass
- Tests complets : valeurs par défaut, modes Password/Passphrase, SecureString, clipboard, forwarding interne.
- Mock du clipboard pour compatibilité Linux/macOS/CI.
- Cohérence totale avec les tests existants.

### ✔ Harmonisation de tous les tests existants
- Mise à jour des tests Get‑PassWord, Get‑PassPhrase, Get‑CryptoIndex.
- Nettoyage des mocks obsolètes.
- Compatibilité PS7 / PS5.1 garantie.

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

- Suppression des paramètres obsolètes dans la documentation.
- Nettoyage global des exemples, guides et sections CI/CD.
- Mise à jour des chemins, scripts et conventions.
- Cohérence totale entre README, docs, PlatyPS et tests.

---

# 🚀 Résultat

SecureGen 1.5.0 apporte :

- une **nouvelle commande PKI professionnelle**  
- une **API cohérente et modernisée**  
- une **documentation entièrement revue**  
- des **tests robustes et complets**  
- une **expérience utilisateur plus claire et plus fiable**  

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

