# 🗺️ Roadmap — SecureGen

Ce document présente la feuille de route officielle de SecureGen.  
Elle reflète les objectifs à court, moyen et long terme du projet, ainsi que les fonctionnalités envisagées.

La roadmap est vivante : elle évolue en fonction des retours utilisateurs, des besoins de la communauté et des avancées techniques.

---

# 🎯 Objectifs généraux

SecureGen vise à rester :

- **simple** — facile à utiliser, intuitif  
- **sécurisé** — basé sur des primitives cryptographiques modernes  
- **cross‑platform** — Windows, Linux, macOS, PS5.1 et PS7+  
- **performant** — génération rapide, overhead minimal  
- **professionnel** — documentation complète, CI/CD robuste  
- **ouvert** — contributions bienvenues, code clair et auditable  

---

# 🚀 Roadmap à court terme (1–3 mois)

## ✔ Améliorations prévues

- [ ] Ajout d’un mode “phrase naturelle”  
  Exemple : `lune‑argent‑cascade‑verre` (style Diceware amélioré)

- [ ] Génération de clés API formatées  
  - UUID  
  - Base32  
  - Base58  
  - Hex sécurisé  
  - Tokens aléatoires pour API / CI/CD

- [ ] Ajout d’un dictionnaire multilingue  
  - Français  
  - Anglais  
  - Espagnol  
  - Option `-Lang fr|en|es`

- [ ] Ajout d’un module `SecureGen.Tools`  
  - Helpers pour scripts automatisés  
  - Génération de secrets pour pipelines  
  - Fonctions utilitaires avancées

- [ ] Ajout de tests Pester supplémentaires  
  - couverture des cas limites  
  - tests PS5.1 / PS7  
  - tests clipboard

---

# 🧭 Roadmap à moyen terme (3–6 mois)

## 🔧 Fonctionnalités avancées

- [ ] Mode interactif (TUI minimal)  
  Exemple :  
  ```
  [1] Générer un mot de passe
  [2] Générer une passphrase
  [3] Copier dans le presse‑papier
  ```

- [ ] Support natif du SecureString PS7  
  - conversion automatique  
  - intégration dans les scripts sensibles

- [ ] Ajout d’un système de presets  
  Exemple :  
  ```powershell
  Get-PassWord -Preset "DevOps"
  Get-PassPhrase -Preset "Long"
  ```

- [ ] Intégration d’un mode “entropy report”  
  Exemple :  
  ```powershell
  Get-PassWord -ReportEntropy
  ```

- [ ] Ajout d’un mode “batch”  
  Exemple :  
  ```powershell
  Get-PassWord -Count 1000
  ```

---

# 🛰️ Roadmap à long terme (6–12 mois)

## 🌐 Écosystème SecureGen

- [ ] Site web GitHub Pages  
  - documentation complète  
  - exemples interactifs  
  - thèmes cohérents avec l’identité visuelle

- [ ] Génération de secrets pour conteneurs / DevOps  
  - Docker  
  - Kubernetes  
  - Terraform

- [ ] Intégration avec des gestionnaires de secrets  
  - Azure Key Vault  
  - HashiCorp Vault  
  - KeePass (via module externe)

- [ ] Ajout d’un mode “audit”  
  - vérification de la robustesse d’un mot de passe  
  - estimation d’entropie  
  - recommandations NIST/ANSSI

---

# 🧩 Idées en discussion

Ces idées ne sont pas encore planifiées, mais ouvertes à contribution :

- [ ] Génération de phrases mnémotechniques  
- [ ] Mode “secure wipe” pour effacer la mémoire  
- [ ] Génération de secrets pour IoT / embarqué  
- [ ] Intégration avec PowerShell Crescendo  
- [ ] Génération de QR codes pour secrets (TOTP, API keys)

---

# 🤝 Comment proposer une idée

Vous pouvez :

- ouvrir une **Issue**  
- participer aux **Discussions GitHub**  
- proposer une **Pull Request**  
- suggérer une amélioration dans `docs/roadmap.md`

👉 `https://github.com/ledino/SecureGen/issues` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fissues")

---

# 🎉 Merci !

SecureGen évolue grâce à vos retours.  
Chaque suggestion, contribution ou test aide à rendre le module plus robuste, plus simple et plus agréable à utiliser.

---
