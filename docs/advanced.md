# 📘 Guide avancé — SecureGen  
*(Aligné avec SecureGen 1.5.0 et l’architecture moderne)*

Ce document couvre les usages avancés, l’architecture interne, les bonnes pratiques de sécurité et les intégrations possibles du module **SecureGen** dans des environnements professionnels.

---

# 🧱 Architecture interne du module

SecureGen utilise une architecture modulaire permettant une compatibilité maximale entre :

- **PowerShell 7+** (Windows, Linux, macOS)  
- **Windows PowerShell 5.1**

Le module charge automatiquement la bonne implémentation :

```
SecureGen/
│
├── Core.PS7.ps1      # Version moderne (Get‑SecureRandom, RNG .NET 6+)
└── Legacy.PS5.ps1    # Version fallback (RNGCryptoServiceProvider)
```

Le fichier principal `SecureGen.psm1` détecte la version PowerShell :

```powershell
if ($PSVersionTable.PSVersion.Major -ge 7) {
    . "$PSScriptRoot/Core.PS7.ps1"
}
else {
    . "$PSScriptRoot/Legacy.PS5.ps1"
}
```

Aucune action n’est requise : tout est automatique.

---

# 🔐 Détails cryptographiques

## PowerShell 7+
SecureGen utilise :

- `RandomNumberGenerator.GetBytes()`  
- `Get-SecureRandom` (si disponible)

Ces API sont basées sur **.NET 6+**, offrant un niveau de sécurité moderne, robuste et cross‑platform.

## PowerShell 5.1
Fallback basé sur :

- `RNGCryptoServiceProvider` (.NET Framework 4.8)

Toujours sécurisé, mais API plus ancienne.

---

# 🧩 Utilisation avancée dans des scripts

## Générer un mot de passe et l’injecter dans un fichier de configuration

```powershell
$pwd = Get-PassWord -SpecialChars '!@#?%' -Silent
Set-Content -Path "./config.json" -Value "{ `"password`": `"$pwd`" }"
```

## Générer une passphrase pour un secret d’API

```powershell
$secret = Get-PassPhrase -Words 6 -Len 5
Write-Host "Secret généré : $secret"
```

## Générer plusieurs mots de passe en batch

```powershell
1..10 | ForEach-Object {
    Get-PassWord -Len 20 -Silent
}
```

---

# 🔐 Intégration PKI / KMS / Comptes de service

`Get-PKIPass` est la commande dédiée aux usages sensibles.

## Mot de passe PKI (SecureString)

```powershell
$secure = Get-PKIPass -AsSecureString
```

## Passphrase PKI personnalisée

```powershell
Get-PKIPass -Type Passphrase -Words 8 -Len 10
```

## Utilisation dans un PSCredential

```powershell
$cred = New-Object pscredential "svc-backup", (Get-PKIPass -AsSecureString)
```

## Intégration dans un script d’automatisation

```powershell
$pwd = Get-PKIPass -AsSecureString
New-LocalUser -Name "svc-kms" -Password $pwd
```

---

# 🧪 Intégration dans un pipeline CI/CD

## Exemple GitHub Actions

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

## Exemple Azure DevOps

```yaml
- powershell: |
    Install-Module SecureGen -Force
    $key = Get-PKIPass -Type Passphrase -Words 8 -Len 5
    Write-Host "##vso[task.setvariable variable=API_KEY]$key"
```

---

# 📋 Gestion avancée du presse‑papier

SecureGen utilise automatiquement la meilleure méthode disponible selon l’OS :

| OS | Méthode |
|----|---------|
| Windows | `Set-Clipboard` |
| macOS | `pbcopy` |
| Linux | `wl-copy`, `xclip`, `xsel` |

## Copier une valeur arbitraire

```powershell
Set-ClipboardSafe -Text "SecureGen"
```

## Effacer le presse‑papier

```powershell
Clear-ClipboardSafe
```

---

# 🔔 Personnalisation du beep

## Désactiver le beep dans vos scripts

```powershell
$pwd = Get-PassWord -Silent
```

## Beep personnalisé pour un workflow

```powershell
Invoke-Beep -Frequency 1800 -Duration 150
```

---

# 🧰 Intégration dans un module externe

```powershell
Import-Module SecureGen

function New-UserAccount {
    param([string]$UserName)

    $pwd = Get-PKIPass -AsSecureString
    New-LocalUser -Name $UserName -Password $pwd

    Write-Host "Utilisateur créé : $UserName"
}
```

---

# 🛡️ Bonnes pratiques de sécurité

- Utilisez `Get-PKIPass -AsSecureString` pour les usages sensibles.  
- Ne stockez jamais un secret en clair dans un fichier non chiffré.  
- Préférez les passphrases pour les clés API ou tokens.  
- Activez `-Silent` dans les scripts automatisés.  
- Sur Linux/macOS, installez `wl-copy`, `xclip` ou `xsel` pour un clipboard optimal.

---

# 🧪 Tests Pester (avancé)

```powershell
Describe "SecureGen" {
    It "Génère un mot de passe de la bonne longueur" {
        (Get-PassWord -Len 24).Length | Should -Be 24
    }

    It "Génère une passphrase avec le bon nombre de mots" {
        (Get-PassPhrase -Words 5).Split('-').Count | Should -Be 5
    }

    It "Retourne un SecureString en mode PKI" {
        Get-PKIPass -AsSecureString | Should -BeOfType "System.Security.SecureString"
    }
}
```

---

# 🛠️ Développement & Build

Le script `scripts/build.ps1` permet :

- nettoyage  
- validation  
- tests Pester  
- génération de la documentation PlatyPS  
- packaging  
- publication PSGallery (optionnelle)

Exécution simple :

```powershell
pwsh ./scripts/build.ps1
```

Publication :

```powershell
pwsh ./scripts/build.ps1 -Publish
```

---

# 📚 Documentations associées

- `installation.md`  
- `examples.md`  
- `architecture.md`  
- `versioning.md`  
- `release-process.md`  
- `README.md`  

---

# 🎉 Merci d'utiliser SecureGen !

Pour toute suggestion ou contribution :  
👉 GitHub — Issues & Pull Requests

---
