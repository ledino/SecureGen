# 🔐 Guide de sécurité — SecureGen  

Ce document présente les principes de sécurité utilisés par **SecureGen**, ainsi que les bonnes pratiques recommandées pour intégrer le module dans des environnements professionnels.

---

# 🧱 Architecture de sécurité

SecureGen repose sur une architecture modulaire permettant d’utiliser la meilleure API cryptographique disponible selon la version de PowerShell :

| Version PowerShell | Implémentation | API utilisée |
|-------------------|----------------|--------------|
| PowerShell 7+     | Core.PS7.ps1   | `RandomNumberGenerator.GetBytes()` + `Get‑SecureRandom` |
| PowerShell 5.1    | Legacy.PS5.ps1 | `RNGCryptoServiceProvider` |

Le module sélectionne automatiquement la version la plus sécurisée disponible via `SecureGen.psm1`.

---

# 📘 Conformité aux recommandations NIST (SP 800‑63B)

SecureGen suit les recommandations modernes du **NIST SP 800‑63B – Digital Identity Guidelines**, notamment :

## ✔ Préférer la longueur à la complexité artificielle  
Le NIST recommande d’abandonner les règles obsolètes du type :  
- “au moins une majuscule”  
- “au moins un chiffre”  
- “au moins un symbole”

Au profit de **mots de passe plus longs et plus faciles à retenir**, ou de **passphrases**.

SecureGen applique cette approche via :

- `Get-PassPhrase` (passphrases longues, lisibles, entropie élevée)  
- paramètres configurables : `-MotsParBloc`, `-LettresParMot`  

## ✔ Génération aléatoire cryptographiquement sûre  
Le NIST exige l’utilisation de générateurs aléatoires cryptographiquement sûrs.  
SecureGen utilise :

- PS7+ : `RandomNumberGenerator.GetBytes()` + `Get‑SecureRandom`  
- PS5.1 : `RNGCryptoServiceProvider`

## ✔ Pas de restrictions inutiles  
Le NIST déconseille d’imposer des règles de composition trop strictes.  
SecureGen laisse l’utilisateur choisir :

- la longueur (`-Length`)  
- les symboles (`-SpecialChars`)  
- l’usage ou non des caractères spéciaux (`-UseSpecial`)  

## ✔ Pas de rotation forcée  
Le NIST recommande de **ne pas imposer de rotation périodique** sauf en cas de compromission.  
SecureGen ne force aucune rotation.

## ✔ Pas de stockage ou journalisation des secrets  
Le NIST impose qu’aucun secret ne soit stocké ou loggé.  
SecureGen :

- ne stocke rien  
- ne journalise rien  
- ne transmet rien  

---

# 🛡️ Conformité OWASP ASVS (Application Security Verification Standard)

SecureGen suit plusieurs recommandations du standard **OWASP ASVS**, notamment dans les catégories liées à la gestion des secrets, à la cryptographie et à la protection des données sensibles.

## ✔ ASVS 2.1 — Cryptographie approuvée  
OWASP recommande d’utiliser des API cryptographiques modernes, reconnues et non obsolètes.  
SecureGen applique cela via :

- PS7+ : `RandomNumberGenerator.GetBytes()` + `Get‑SecureRandom`  
- PS5.1 : `RNGCryptoServiceProvider` (fallback sécurisé)  
- aucune implémentation maison de RNG  
- aucune dépendance externe non vérifiée  

## ✔ ASVS 2.2 — Génération sécurisée de secrets  
OWASP impose que les secrets soient générés via des sources d’entropie cryptographiquement sûres.  
SecureGen respecte ce point via :

- un générateur interne basé sur RNG .NET  
- une entropie élevée  
- aucune prédictibilité  
- pas de biais statistique  

## ✔ ASVS 3.4 — Pas de stockage de secrets en clair  
OWASP interdit le stockage ou la journalisation de secrets.  
SecureGen :

- ne stocke rien  
- ne log rien  
- ne transmet rien  
- ne conserve aucune valeur générée  

## ✔ ASVS 3.5 — Clipboard non sécurisé  
OWASP rappelle que le presse‑papier n’est **pas un espace sécurisé**.  
SecureGen :

- avertit l’utilisateur  
- propose `Clear-ClipboardSafe`  
- ne copie jamais automatiquement sans consentement  

## ✔ ASVS 1.14 — Compatibilité multi‑plateforme sans dégradation de sécurité  
SecureGen garantit :

- une sécurité identique sur Windows, Linux, macOS  
- un fallback PS5.1 sécurisé  
- une API unifiée  

---

# 🛡️ Conformité ANSSI (Recommandations françaises)

SecureGen suit également les bonnes pratiques de l’**ANSSI**, notamment celles décrites dans :

- **RGS v2.0** (Référentiel Général de Sécurité)  
- **Guide d’hygiène informatique**  
- **Recommandations sur les mots de passe**  

## ✔ ANSSI — Préférer la longueur à la complexité  
L’ANSSI recommande des secrets **longs**, plutôt que des règles de complexité artificielle.  
SecureGen applique cela via :

- `Get-PassPhrase` (passphrases longues, lisibles, robustes)  
- paramètres configurables pour augmenter l’entropie  

## ✔ ANSSI — Utiliser des générateurs cryptographiques fiables  
SecureGen utilise exclusivement :

- RNG .NET moderne (PS7+)  
- RNGCryptoServiceProvider (PS5.1)  

Aucune implémentation maison, aucun algorithme non approuvé.

## ✔ ANSSI — Ne jamais stocker les secrets  
SecureGen :

- ne stocke rien  
- ne journalise rien  
- ne transmet rien  

## ✔ ANSSI — Sécuriser les scripts automatisés  
L’ANSSI recommande :

- d’éviter les affichages de secrets  
- d’utiliser des variables d’environnement  
- d’utiliser des SecureString  

SecureGen fournit :

- `-Silent`  
- compatibilité SecureString  
- exemples CI/CD conformes  

---

# 🔐 Génération cryptographique

## PowerShell 7+ (recommandé)

SecureGen utilise :

- `System.Security.Cryptography.RandomNumberGenerator.GetBytes()`  
- `Get‑SecureRandom` (si disponible)

Ces API offrent :

- une génération cryptographiquement sûre  
- une entropie élevée  
- une absence de biais statistique  
- une compatibilité totale Windows/Linux/macOS  

## PowerShell 5.1 (fallback)

SecureGen utilise :

- `RNGCryptoServiceProvider` (.NET Framework 4.8)

Toujours sécurisé, mais API plus ancienne et moins performante.

---

# 🧠 Entropie & robustesse

### Mots de passe

Les mots de passe générés par SecureGen sont :

- aléatoires  
- non prédictibles  
- basés sur un pool configurable :  
  - minuscules  
  - majuscules  
  - chiffres  
  - caractères spéciaux (`-SpecialChars`)  

### Passphrases

Les passphrases sont générées à partir d’une liste de mots sélectionnés pour :

- lisibilité  
- mémorisation  
- entropie élevée  
- structure configurable (`-LettresParMot`, `-MotsParBloc`)  

---

# 🛡️ Bonnes pratiques d’utilisation

## 1. Ne jamais stocker un mot de passe en clair

Évitez :

```powershell
Set-Content "pwd.txt" (Get-PassWord)
```

Préférez :

```powershell
(Get-PassWord) | ConvertTo-SecureString -AsPlainText -Force
```

## 2. Utiliser des passphrases pour les clés API

Les passphrases longues sont souvent plus robustes que les mots de passe courts.

## 3. Utiliser `-Silent` dans les scripts automatisés

```powershell
Get-PassWord -Silent
```

## 4. Ne jamais logguer un secret

Évitez :

```powershell
Write-Host "Mot de passe : $pwd"
```

## 5. Utiliser des variables d’environnement pour les secrets

```powershell
$env:API_KEY = Get-PassPhrase -MotsParBloc 6 -LettresParMot 5
```

---

# 📋 Sécurité du presse‑papier

SecureGen gère automatiquement le clipboard selon la plateforme :

| OS | Méthode |
|----|---------|
| Windows | `Set-Clipboard` |
| macOS | `pbcopy` |
| Linux | `xclip` ou `xsel` |

### ⚠️ Attention  
Le presse‑papier n’est **pas un espace sécurisé**.

Effacez‑le après usage :

```powershell
Clear-ClipboardSafe
```

---

# 🧪 Sécurité dans les pipelines CI/CD

## GitHub Actions

```yaml
steps:
  - name: Installer SecureGen
    run: Install-Module SecureGen -Scope CurrentUser -Force

  - name: Générer un secret
    shell: pwsh
    run: |
      $pwd = Get-PassWord -SpecialChars '!@#?%' -Silent
      echo "SECRET=$pwd" >> $GITHUB_ENV
```

## Azure DevOps

```yaml
- powershell: |
    Install-Module SecureGen -Force
    $key = Get-PassPhrase -MotsParBloc 8 -LettresParMot 5
    Write-Host "##vso[task.setvariable variable=API_KEY]$key"
```

---

# 🧰 Sécurisation dans vos propres scripts

## Convertir un mot de passe en SecureString

```powershell
$pwd = Get-PassWord -SpecialChars '!@#?%' -Silent
$secure = ConvertTo-SecureString $pwd -AsPlainText -Force
```

## Utiliser un mot de passe pour créer un utilisateur

```powershell
$pwd = Get-PassWord -SpecialChars '!@#?%' -Silent
New-LocalUser -Name "test" -Password (ConvertTo-SecureString $pwd -AsPlainText -Force)
```

---

# 🧱 Sécurité du code source

SecureGen suit les bonnes pratiques :

- `Set-StrictMode -Version Latest`  
- pas de variables globales  
- pas de dépendances externes  
- pas de stockage de secrets  
- pas de logs sensibles  
- code compatible Windows/Linux/macOS  
- API identiques entre PS5 et PS7  

---

# 🛡️ Recommandations générales

- Utilisez PowerShell 7+ dès que possible  
- Préférez les passphrases pour les tokens  
- Effacez le clipboard après usage  
- Ne stockez jamais un secret en clair  
- Utilisez des SecureString ou des variables d’environnement  
- Activez `-Silent` dans les scripts automatisés  

---

# 📚 Documentations associées

- 📦 Installation : [https://github.com/ledino/SecureGen/blob/main/docs/installation.md](https://github.com/ledino/SecureGen/blob/main/docs/installation.md)  
- 📘 Exemples : `https://github.com/ledino/SecureGen/blob/main/docs/examples.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fexamples.md")  
- 🧠 Guide avancé : `https://github.com/ledino/SecureGen/blob/main/docs/advanced.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fadvanced.md")  
- 🧱 Architecture : `https://github.com/ledino/SecureGen/blob/main/docs/architecture.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Farchitecture.md")  
- 🧪 Versioning : `https://github.com/ledino/SecureGen/blob/main/docs/versioning.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fversioning.md")  
- 🚀 Processus de release : `https://github.com/ledino/SecureGen/blob/main/docs/release-process.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Frelease-process.md")  
- 📜 README principal : `https://github.com/ledino/SecureGen/blob/main/README.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2FREADME.md")  

---

# 🎉 Merci d'utiliser SecureGen !

Pour toute suggestion ou contribution :  
👉 GitHub — Issues & Pull Requests

---
