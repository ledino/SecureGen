# 📘 Guide avancé — SecureGen  
*(Aligné avec l’architecture moderne et le pipeline CI/CD)*

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
$secret = Get-PassPhrase -MotsParBloc 6 -LettresParMot 5
Write-Host "Secret généré : $secret"
```

## Générer plusieurs mots de passe en batch

```powershell
1..10 | ForEach-Object {
    Get-PassWord -Length 20 -Silent
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
      $pwd = Get-PassWord -SpecialChars '!@#?%' -Silent
      echo "SECRET=$pwd" >> $GITHUB_ENV
```

## Exemple Azure DevOps

```yaml
- powershell: |
    Install-Module SecureGen -Force
    $key = Get-PassPhrase -MotsParBloc 8 -LettresParMot 5
    Write-Host "##vso[task.setvariable variable=API_KEY]$key"
```

---

# 📋 Gestion avancée du presse‑papier

## Copier une valeur arbitraire

```powershell
Set-ClipboardSafe (Get-PassPhrase -MotsParBloc 5)
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
Invoke-Beep -Freq 1800 -Duration 150
```

---

# 🧰 Intégration dans un module externe

Vous pouvez réutiliser SecureGen dans vos propres modules :

```powershell
Import-Module SecureGen

function New-UserAccount {
    param([string]$UserName)

    $pwd = Get-PassWord -SpecialChars '!@#?%' -Silent
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
- Sur Linux/macOS, installez `xclip` ou `xsel` pour une compatibilité clipboard optimale.

---

# 🧪 Tests Pester (avancé)

Exemple de test :

```powershell
Describe "SecureGen" {
    It "Génère un mot de passe de la bonne longueur" {
        (Get-PassWord -Length 24).Length | Should -Be 24
    }

    It "Génère une passphrase avec le bon nombre de mots" {
        (Get-PassPhrase -MotsParBloc 5).Split('-').Count | Should -Be 5
    }
}
```

---

# 🛠️ Développement & Build

Le script `scripts/build.ps1` permet :

- nettoyage
- validation de la structure
- packaging
- tests Pester
- génération de la documentation PlatyPS
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


