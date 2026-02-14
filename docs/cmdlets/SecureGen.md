---
Module Name: SecureGen
Module Guid: b4f7c2c3-1c9e-4e4d-9f8a-9e2a4c1d7a31
Download Help Link: https://github.com/ledino/SecureGen
Help Version: 1.5.0
Locale: fr-FR
---

# SecureGen Module

## Description
SecureGen est un module PowerShell moderne, léger et multiplateforme conçu pour générer :

- des **mots de passe sécurisés**
- des **passphrases robustes**
- des **secrets PKI** (Password ou Passphrase, avec support SecureString)
- des **valeurs aléatoires cryptographiquement sûres**
- un **feedback sonore discret**
- une **gestion intelligente du presse‑papier**

Il fonctionne sous **PowerShell 5.1** et **PowerShell 7+**, en utilisant automatiquement la meilleure source d’aléa disponible :

- **PS7+** : `Get-SecureRandom` (NIST SP 800‑90, .NET 6+)  
- **PS5.1** : `System.Security.Cryptography.RandomNumberGenerator` (fallback sécurisé)

SecureGen est conçu pour être :

- **sécurisé** (aucune implémentation maison de RNG)
- **ergonomique** (alias, UX soignée, clipboard intelligent)
- **automatisable** (CI/CD, scripts, comptes de service)
- **cross‑platform** (Windows, Linux, macOS)
- **documenté** (PlatyPS, README, exemples)

---

## SecureGen Cmdlets

### [Get-CryptoIndex](Get-CryptoIndex.md)
Génère un entier aléatoire cryptographiquement sûr dans l’intervalle `[0 .. Max-1]`.  
Utilisé en interne pour garantir une distribution uniforme dans les tirages et sélections.

---

### [Get-PassPhrase](Get-PassPhrase.md)
Génère une passphrase lisible et robuste, composée de mots aléatoires construits caractère par caractère.  
Compatible clipboard, effacement sécurisé, et entièrement personnalisable (`Words`, `Len`, `Separator`, `Charset`).

---

### [Get-PassWord](Get-PassWord.md)
Génère un mot de passe sécurisé incluant lettres, chiffres et caractères spéciaux (personnalisables).  
Compatible clipboard, effacement sécurisé, et options avancées (`RequireAllTypes`, `UseSpecial`, `Silent`).

---

### [Get-PKIPass](Get-PKIPass.md)
Génère un secret PKI destiné aux usages sensibles : certificats, clés privées, comptes de service, KMS, automatisation sécurisée.  
Peut retourner un **SecureString**, et supporte les modes :

- Password (longueur configurable)
- Passphrase (Words × Len configurables)

---

### [Invoke-Beep](Invoke-Beep.md)
Émet un bip sonore compatible Windows, Linux et macOS.  
Utilisé par les autres cmdlets pour signaler la fin d’une opération.

---

## Notes supplémentaires

- SecureGen ne stocke jamais aucun secret.  
- Le presse‑papier est automatiquement géré selon la plateforme.  
- Le module est entièrement compatible CI/CD.  
- La documentation est générée via PlatyPS.  
- Le code source est auditable et open‑source.

---
