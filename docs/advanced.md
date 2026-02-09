# 📘 Guide avancé — SecureGen

Ce document couvre les usages avancés, l’architecture interne, les bonnes pratiques de sécurité et les intégrations possibles du module **SecureGen** dans des environnements professionnels.

---

# 🧱 Architecture interne du module

SecureGen utilise une architecture modulaire permettant une compatibilité maximale entre :

- **PowerShell 7+** (Windows, Linux, macOS)
- **Windows PowerShell 5.1**

Le module charge automatiquement la bonne implémentation :

```
src/
│
├── Core.PS7.ps1      # Version moderne (RandomNumberGenerator)
└── Legacy.PS5.ps1    # Version fallback (RNGCryptoServiceProvider)
```

Le fichier principal `SecureGen.psm1` détecte la version PowerShell :

```powershell
if ($PSVersionTable.PSVersion.Major -ge 7) {
    . "$PSScriptRoot/src/Core.PS7.ps1"
}
else {
    . "$PSScriptRoot/src/Legacy.PS5.ps1"
}
```

---

# 🔐 Détails cryptographiques

## PowerShell 7+
SecureGen utilise :

- `RandomNumberGenerator.GetBytes()`  
- `Get-SecureRandom` (si disponible)

Ces API sont basées sur **.NET 6+**, offrant un niveau de sécurité moderne et robuste.

## PowerShell 5.1
Fallback basé sur :

- `RNGCryptoServiceProvider`

Toujours sécurisé, mais API plus ancienne.

---

# 🧩 Utilisation avancée dans des scripts

## Générer un mot de passe et l’injecter dans un fichier de configuration

```powershell
$pwd = Get-PassWord -Symbols
Set-Content -Path "./config.json" -Value "{ `"password`": `"$pwd`" }"
```

## Générer une passphrase pour un secret d’API

```powershell
$secret = Get-PassPhrase -Words 6
Write-Host "Secret généré : $secret"
```

## Générer plusieurs mots de passe en batch

```powershell
1..10 | ForEach-Object {
    Get-PassWord -Length 20
}
```

---

# 🧪 Intégration dans un pipeline CI/CD

## Exemple GitHub Actions

```yaml
steps:
  - name: Installer SecureGen
    run: Install-Module SecureGen -Scope CurrentUser -Force

  - name: Générer un secret
    shell: pwsh
    run: |
      $pwd = Get-PassWord -Symbols
      echo "SECRET=$pwd" >> $GITHUB_ENV
```

## Exemple Azure DevOps

```yaml
- powershell: |
    Install-Module SecureGen -Force
    $key = Get-PassPhrase -Words 8
    Write-Host "##vso[task.setvariable variable=API_KEY]$key"
```

---

# 📋 Gestion avancée du presse‑papier

## Copier un mot de passe et vérifier la disponibilité du clipboard

```powershell
try {
    Get-PassWord -Copy
    Write-Host "Mot de passe copié !"
}
catch {
    Write-Warning "Clipboard indisponible sur ce système."
}
```

## Copier une valeur arbitraire dans un script automatisé

```powershell
Set-ClipboardSafe (Get-PassPhrase -Words 5)
```

---

# 🔔 Personnalisation du beep

## Désactiver globalement le beep dans vos scripts

```powershell
$pwd = Get-PassWord -Copy -Silent
```

## Beep personnalisé pour un workflow

```powershell
Invoke-Beep -Freq 1800 -Duration 150
```

---

# 🧰 Intégration dans un module externe

Vous pouvez réutiliser SecureGen dans vos propres modules :

```powershell
Import-Module SecureGen

function New-UserAccount {
    param([string]$UserName)

    $pwd = Get-PassWord -Symbols
    New-LocalUser -Name $UserName -Password (ConvertTo-SecureString $pwd -AsPlainText -Force)

    Write-Host "Utilisateur créé : $UserName"
    Write-Host "Mot de passe : $pwd"
}
```

---

# 🛡️ Bonnes pratiques de sécurité

- Ne stockez jamais un mot de passe généré en clair dans un fichier non chiffré.
- Utilisez `ConvertTo-SecureString` pour manipuler les secrets.
- Préférez les passphrases pour les clés API ou tokens.
- Activez le mode `-Silent` dans les scripts automatisés.
- Sur Linux/macOS, installez `xclip` ou `xsel` pour une meilleure compatibilité clipboard.

---

# 🧪 Tests Pester (avancé)

Exemple de test :

```powershell
Describe "SecureGen" {
    It "Génère un mot de passe de la bonne longueur" {
        (Get-PassWord -Length 24).Length | Should -Be 24
    }

    It "Génère une passphrase avec le bon nombre de mots" {
        (Get-PassPhrase -Words 5).Split('-').Count | Should -Be 5
    }
}
```

---

# 🧱 Développement & Build

Le script `build.ps1` permet :

- nettoyage  
- validation de la structure  
- packaging  
- tests Pester  
- publication PSGallery (optionnelle)

Exécution simple :

```powershell
.\build.ps1
```

Publication :

```powershell
.\build.ps1 -Publish
```

---

# 🎉 Merci d'utiliser SecureGen !

Pour toute suggestion ou contribution :  
👉 GitHub — Issues & Pull Requests


---
