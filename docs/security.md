# 🔐 Guide de sécurité — SecureGen  
*(Aligné avec SecureGen 1.5.0 et les recommandations NIST / OWASP / ANSSI)*

Ce document présente les principes de sécurité utilisés par **SecureGen**, ainsi que les bonnes pratiques recommandées pour intégrer le module dans des environnements professionnels.

---

# 🧱 Architecture de sécurité

SecureGen repose sur une architecture modulaire permettant d’utiliser la meilleure API cryptographique disponible selon la version de PowerShell :

| Version PowerShell | Implémentation | API utilisée |
|-------------------|----------------|--------------|
| PowerShell 7+     | Core.PS7.ps1   | `RandomNumberGenerator.GetBytes()` + `Get‑SecureRandom` |
| PowerShell 5.1    | Legacy.PS5.ps1 | `RNGCryptoServiceProvider` |

Le module sélectionne automatiquement la version la plus sécurisée disponible via `SecureGen.psm1`.

Aucune implémentation maison de RNG n’est utilisée.

---

# 📘 Conformité NIST (SP 800‑63B)

SecureGen suit les recommandations modernes du **NIST SP 800‑63B – Digital Identity Guidelines**.

## ✔ Préférer la longueur à la complexité artificielle  
Le NIST recommande d’abandonner les règles obsolètes du type :

- “au moins une majuscule”
- “au moins un chiffre”
- “au moins un symbole”

Au profit de **mots de passe plus longs** ou de **passphrases**.

SecureGen applique cette approche via :

- `Get-PassPhrase`  
- paramètres configurables : `-Words`, `-Len`  
- `Get-PKIPass` (mode Passphrase)

## ✔ Génération aléatoire cryptographiquement sûre  
SecureGen utilise :

- PS7+ : `RandomNumberGenerator.GetBytes()` + `Get‑SecureRandom`  
- PS5.1 : `RNGCryptoServiceProvider`

## ✔ Pas de restrictions inutiles  
SecureGen laisse l’utilisateur choisir :

- la longueur (`-Len`, `-Length`)  
- les symboles (`-SpecialChars`)  
- l’usage ou non des caractères spéciaux (`-UseSpecial`)

## ✔ Pas de stockage ou journalisation des secrets  
SecureGen :

- ne stocke rien  
- ne journalise rien  
- ne transmet rien  

---

# 🛡️ Conformité OWASP ASVS

SecureGen suit plusieurs recommandations du standard **OWASP ASVS**.

## ✔ ASVS 2.1 — Cryptographie approuvée  
- API cryptographiques modernes  
- aucune implémentation maison  
- aucune dépendance externe non vérifiée  

## ✔ ASVS 2.2 — Génération sécurisée de secrets  
- entropie élevée  
- absence de biais  
- RNG cryptographiquement sûr  

## ✔ ASVS 3.4 — Pas de stockage de secrets en clair  
SecureGen ne stocke ni ne log aucun secret.

## ✔ ASVS 3.5 — Clipboard non sécurisé  
SecureGen :

- avertit l’utilisateur  
- propose `Clear-ClipboardSafe`  
- ne copie jamais automatiquement sans consentement  

## ✔ ASVS 1.14 — Compatibilité multi‑plateforme  
Sécurité identique sur Windows, Linux, macOS.

---

# 🛡️ Conformité ANSSI

SecureGen suit les bonnes pratiques de l’**ANSSI**, notamment :

- RGS v2.0  
- Guide d’hygiène informatique  
- Recommandations sur les mots de passe  

## ✔ Préférer la longueur  
SecureGen encourage l’usage de passphrases longues.

## ✔ Utiliser des générateurs cryptographiques fiables  
SecureGen utilise exclusivement :

- RNG .NET moderne (PS7+)  
- RNGCryptoServiceProvider (PS5.1)

## ✔ Ne jamais stocker les secrets  
SecureGen ne stocke rien.

## ✔ Sécuriser les scripts automatisés  
SecureGen fournit :

- `-Silent`  
- `-AsSecureString`  
- `Get-PKIPass` pour les usages sensibles  

---

# 🔐 Génération cryptographique

## PowerShell 7+ (recommandé)

SecureGen utilise :

- `System.Security.Cryptography.RandomNumberGenerator.GetBytes()`  
- `Get‑SecureRandom` (si disponible)

Avantages :

- entropie élevée  
- absence de biais  
- compatibilité totale Windows/Linux/macOS  

## PowerShell 5.1 (fallback)

SecureGen utilise :

- `RNGCryptoServiceProvider` (.NET Framework 4.8)

Toujours sécurisé, mais API plus ancienne.

---

# 🧠 Entropie & robustesse

### Mots de passe

- aléatoires  
- non prédictibles  
- pool configurable (minuscules, majuscules, chiffres, symboles)

### Passphrases

- lisibles  
- mémorisables  
- entropie élevée  
- structure configurable (`-Words`, `-Len`)

### Secrets PKI

- mode Password ou Passphrase  
- retour `SecureString`  
- idéal pour :  
  - certificats  
  - comptes de service  
  - KMS  
  - automatisation sécurisée  

---

# 🛡️ Bonnes pratiques d’utilisation

## 1. Utiliser `Get-PKIPass -AsSecureString` pour les usages sensibles

```powershell
$secure = Get-PKIPass -AsSecureString
```

## 2. Ne jamais stocker un mot de passe en clair

Évitez :

```powershell
Set-Content "pwd.txt" (Get-PassWord)
```

Préférez :

```powershell
(Get-PassWord) | ConvertTo-SecureString -AsPlainText -Force
```

## 3. Utiliser des passphrases pour les clés API  
## 4. Utiliser `-Silent` dans les scripts automatisés  
## 5. Ne jamais logguer un secret  
## 6. Utiliser des variables d’environnement pour les secrets  

---

# 📋 Sécurité du presse‑papier

SecureGen gère automatiquement le clipboard selon la plateforme :

| OS | Méthode |
|----|---------|
| Windows | `Set-Clipboard` |
| macOS | `pbcopy` |
| Linux | `wl-copy`, `xclip`, `xsel` |

⚠️ Le presse‑papier n’est **pas un espace sécurisé**.

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

  - name: Générer un secret PKI
    shell: pwsh
    run: |
      $pwd = Get-PKIPass -AsSecureString
      echo "SECRET=$pwd" >> $GITHUB_ENV
```

## Azure DevOps

```yaml
- powershell: |
    Install-Module SecureGen -Force
    $key = Get-PKIPass -Type Passphrase -Words 8 -Len 5
    Write-Host "##vso[task.setvariable variable=API_KEY]$key"
```

---

# 🧰 Sécurisation dans vos propres scripts

## Utiliser un mot de passe PKI pour créer un utilisateur

```powershell
$pwd = Get-PKIPass -AsSecureString
New-LocalUser -Name "svc-backup" -Password $pwd
```

## Générer un secret pour un service externe

```powershell
$secret = Get-PKIPass -Type Passphrase -Words 6 -Len 8
```

---

# 🧱 Sécurité du code source

SecureGen suit les bonnes pratiques :

- `Set-StrictMode -Version Latest`  
- pas de variables globales  
- pas de dépendances externes  
- pas de stockage de secrets  
- pas de logs sensibles  
- API identiques entre PS5 et PS7  
- code compatible Windows/Linux/macOS  

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

- `installation.md`  
- `examples.md`  
- `advanced.md`  
- `architecture.md`  
- `versioning.md`  
- `release-process.md`  
- `README.md`  

---

# 🎉 Merci d'utiliser SecureGen !

Pour toute suggestion ou contribution :  
👉 GitHub — Issues & Pull Requests

---
