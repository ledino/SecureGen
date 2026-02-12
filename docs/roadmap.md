# 🗺️ Roadmap — SecureGen  
*(Feuille de route officielle du projet)*

Cette roadmap présente les objectifs à court, moyen et long terme de **SecureGen**.  
Elle évolue en fonction :

- des retours utilisateurs  
- des besoins de la communauté  
- des avancées techniques PowerShell  
- de la vision globale du projet  

---

# 🎯 Vision générale

SecureGen vise à rester :

- **simple** — intuitif, minimaliste, facile à utiliser  
- **sécurisé** — basé sur des primitives cryptographiques modernes  
- **cross‑platform** — Windows, Linux, macOS, PS5.1 et PS7+  
- **performant** — génération rapide, overhead minimal  
- **professionnel** — documentation complète, CI/CD robuste, versioning automatisé  
- **ouvert** — contributions bienvenues, code clair et auditable  

---

# 🚀 Court terme (1–3 mois)

## ✔ Fonctionnalités prévues

- [ ] **Mode “phrase naturelle”**  
  Exemple : `lune‑argent‑cascade‑verre` (style Diceware amélioré)

- [ ] **Génération de clés API formatées**  
  - UUID  
  - Base32  
  - Base58  
  - Hex sécurisé  
  - Tokens pour API / CI/CD

- [ ] **Dictionnaire multilingue**  
  - Français  
  - Anglais  
  - Espagnol  
  - Paramètre : `-Lang fr|en|es`

- [ ] **Module additionnel : `SecureGen.Tools`**  
  - Helpers pour scripts automatisés  
  - Génération de secrets pour pipelines  
  - Fonctions utilitaires avancées

- [ ] **Tests Pester supplémentaires**  
  - cas limites  
  - compatibilité PS5.1 / PS7  
  - tests clipboard  

---

# 🧭 Moyen terme (3–6 mois)

## 🔧 Fonctionnalités avancées

- [ ] **Mode interactif (TUI minimal)**  
  Exemple :  
  ```
  [1] Générer un mot de passe
  [2] Générer une passphrase
  [3] Copier dans le presse‑papier
  ```

- [ ] **Support natif SecureString PS7**  
  - conversion automatique  
  - intégration dans les scripts sensibles

- [ ] **Système de presets**  
  Exemple :  
  ```powershell
  Get-PassWord -Preset "DevOps"
  Get-PassPhrase -Preset "Long"
  ```

- [ ] **Mode “entropy report”**  
  Exemple :  
  ```powershell
  Get-PassWord -ReportEntropy
  ```

- [ ] **Mode batch**  
  Exemple :  
  ```powershell
  Get-PassWord -Count 1000
  ```

---

# 🛰️ Long terme (6–12 mois)

## 🌐 Écosystème SecureGen

- [ ] **Site web GitHub Pages**  
  - documentation complète  
  - exemples interactifs  
  - identité visuelle cohérente

- [ ] **Génération de secrets pour DevOps / conteneurs**  
  - Docker  
  - Kubernetes  
  - Terraform

- [ ] **Intégration avec des gestionnaires de secrets**  
  - Azure Key Vault  
  - HashiCorp Vault  
  - KeePass (via module externe)

- [ ] **Mode “audit”**  
  - vérification de robustesse  
  - estimation d’entropie  
  - recommandations NIST / ANSSI  

---

# 💡 Idées en discussion (non planifiées)

- [ ] Génération de phrases mnémotechniques  
- [ ] Mode “secure wipe” (effacement mémoire)  
- [ ] Secrets pour IoT / embarqué  
- [ ] Intégration PowerShell Crescendo  
- [ ] Génération de QR codes (TOTP, API keys)

---

# 🤝 Comment proposer une idée

Vous pouvez :

- ouvrir une **Issue**  
- participer aux **Discussions GitHub**  
- proposer une **Pull Request**  
- suggérer une amélioration dans `docs/roadmap.md`

👉 `https://github.com/ledino/SecureGen/issues` (github.com in Bing) [(bing.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fwww.bing.com%2Fsearch%3Fq%3D%2522https%253A%252F%252Fgithub.com%252Fledino%252FSecureGen%252Fissues%2522")

---

# 🎉 Merci !

SecureGen évolue grâce à vos retours.  
Chaque suggestion, contribution ou test aide à rendre le module plus robuste, plus simple et plus agréable à utiliser.

---
```

---
