---
Module Name: SecureGen
Module Guid: b4f7c2c3-1c9e-4e4d-9f8a-9e2a4c1d7a31
Download Help Link: https://github.com/ledino/SecureGen
Help Version: 1.0.0.0
Locale: fr-FR
---

# SecureGen Module

## Description
SecureGen est un module PowerShell léger et multiplateforme conçu pour générer des mots de passe, des passphrases et des valeurs aléatoires cryptographiquement sûres.

Il fournit :

- des mots de passe robustes et configurables  
- des passphrases lisibles et hautement entropiques  
- un générateur d’index sécurisé pour les sélections aléatoires  
- un utilitaire sonore compatible Windows / Linux / macOS  

SecureGen fonctionne sous **PowerShell 5.1** et **PowerShell 7+**, en utilisant automatiquement la meilleure source d’aléa disponible :

- PS7+ : `Get-SecureRandom` (conforme NIST SP 800‑90)  
- PS5.1 : RNG .NET Framework (`System.Security.Cryptography.RandomNumberGenerator`)  

Il inclut également une gestion intelligente du presse‑papier et un effacement automatique sécurisé.

---

## SecureGen Cmdlets

### [Get-CryptoIndex](Get-CryptoIndex.md)
Génère un entier aléatoire cryptographiquement sûr dans l’intervalle `[0 .. Max-1]`.  
Utilisé en interne pour garantir une distribution uniforme dans les tirages et sélections.

---

### [Get-PassPhrase](Get-PassPhrase.md)
Génère une passphrase lisible et robuste, composée de mots aléatoires construits caractère par caractère.  
Compatible clipboard, effacement sécurisé, et entièrement personnalisable.

---

### [Get-PassWord](Get-PassWord.md)
Génère un mot de passe sécurisé incluant lettres, chiffres et caractères spéciaux (personnalisables).  
Compatible clipboard, effacement sécurisé, et options avancées.

---

### [Invoke-Beep](Invoke-Beep.md)
Émet un bip sonore compatible Windows, Linux et macOS.  
Utilisé par les autres cmdlets pour signaler la fin d’une opération.

---
