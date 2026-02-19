# 📘 Tests SecureGen  
Suite de tests automatisés pour garantir la sécurité, la stabilité et la qualité du module **SecureGen**.

## 🎯 Objectifs de la suite de tests

La suite de tests Pester de SecureGen a été conçue pour assurer :

- **La sécurité** :  
  - longueurs minimales/maximales  
  - corrections automatiques  
  - entropie minimale  
  - conformité `RequireAllTypes`

- **La robustesse** :  
  - aucun crash  
  - comportement stable Windows / Linux / macOS  
  - clipboard sécurisé et mocké

- **La cohérence UX** :  
  - modes Quiet / Raw / Silent  
  - pipeline propre  
  - absence de pollution de sortie

- **La maintenabilité** :  
  - tests unitaires pour chaque fonction publique  
  - tests unitaires pour les fonctions internes critiques  
  - tests d’intégration (pipeline, sécurité globale)

---

# 📁 Structure des tests

```
tests/
│
├── Clipboard.Tests.ps1
├── Get-CryptoIndex.Tests.ps1
├── Get-PKIPass.Tests.ps1
├── Get-PassPhrase.Tests.ps1
├── Get-PassWord.Tests.ps1
├── Invoke-Beep.Tests.ps1
│
├── Internal-RandomString.Tests.ps1
├── Internal-GeneratePassword.Tests.ps1
├── Internal-GeneratePassPhrase.Tests.ps1
├── Private-ValidateLength.Tests.ps1
├── Private-ValidatePassphrase.Tests.ps1
│
├── Pipeline.Tests.ps1
└── Security.Tests.ps1
```

### 🔍 Organisation

| Catégorie | Description |
|----------|-------------|
| **Tests publics** | Vérifient les cmdlets exposées (`Get-PassWord`, `Get-PassPhrase`, etc.) |
| **Tests internes** | Vérifient les moteurs cryptographiques et les validateurs |
| **Tests pipeline** | Garantissent l’absence de pollution du flux |
| **Tests sécurité** | Vérifient les règles de sécurité globales |

---

# ▶️ Exécuter les tests

Depuis la racine du projet :

```powershell
Invoke-Pester -Path ./tests
```

Pour exécuter un fichier spécifique :

```powershell
Invoke-Pester -Path ./tests/Get-PassWord.Tests.ps1
```

Pour un test précis :

```powershell
Invoke-Pester -Path ./tests -TestName "RequireAllTypes"
```

---

# 🧪 Exemple de sortie

```
Executing all tests in 'tests'
Tests completed in 1.42s
Passed: 87 Failed: 0 Skipped: 2 Pending: 0
```

---

# 🧱 Philosophie de test

SecureGen applique une approche **sécurité d’abord**, ce qui implique :

### ✔ Corrections automatiques  
- Password : 8 → 16, 300 → 256  
- Passphrase : Words < 2 → 2, Letters < 2 → 2  

### ✔ Pipeline propre  
Aucun message ne doit polluer la sortie en modes Quiet / Raw / Silent.

### ✔ Clipboard sécurisé  
Le clipboard est **toujours mocké** dans les tests.

### ✔ Entropie minimale  
Les tests détectent un RNG cassé via des distributions simples.

### ✔ Compatibilité PowerShell 5 / 7  
Les backends RNG sont testés via mocks intelligents.

---

# 🧩 Ajouter de nouveaux tests

1. Créer un fichier dans `tests/`  
2. Nommer selon le pattern :  
   ```
   NomDeFonction.Tests.ps1
   ```
3. Utiliser la structure standard :

```powershell
Describe "NomDeFonction" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    Context "Basic behavior" {
        It "Fait quelque chose" {
            # test
        }
    }
}
```

4. Mockez toujours :
- `Set-ClipboardSafe`
- `Clear-ClipboardSafe`
- `Internal-RandomString` (si nécessaire)
- `Get-CryptoIndex` (si nécessaire)

---

# 🛠 Intégration CI/CD (GitHub Actions)

Ajouter dans `.github/workflows/tests.yml` :

```yaml
name: Tests

on:
  push:
  pull_request:

jobs:
  pester:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install PowerShell
        uses: PowerShell/PowerShell-For-GitHub-Actions@v2
      - name: Run Pester
        run: pwsh -c "Invoke-Pester -Path ./tests -CI"
```

---
