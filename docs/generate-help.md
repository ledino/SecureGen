# 📘 Génération automatique de la documentation — PlatyPS  
*(Aligné avec l’architecture moderne et le pipeline CI/CD)*

SecureGen utilise **PlatyPS** pour générer automatiquement la documentation des commandes PowerShell du module.  
Ce système garantit une documentation toujours synchronisée avec le code, propre, standardisée et facile à maintenir.

Ce guide explique comment générer, mettre à jour et maintenir la documentation des cmdlets.

---

# 🧩 Prérequis

Assurez-vous d’avoir installé **PlatyPS v3+** :

```powershell
Install-Module PlatyPS -Scope CurrentUser -Force
```

Vérifiez la version :

```powershell
Get-Module PlatyPS -ListAvailable
```

---

# 🚀 Générer la documentation initiale

Depuis la racine du projet :

```powershell
Import-Module ./SecureGen/SecureGen/SecureGen.psd1 -Force

New-MarkdownHelp `
    -Module SecureGen `
    -OutputFolder ./docs/cmdlets `
    -WithModulePage `
    -Force
```

Cela génère automatiquement :

```
docs/cmdlets/
│
├── Get-CryptoIndex.md
├── Get-PassPhrase.md
├── Get-PassWord.md
├── Invoke-Beep.md
└── SecureGen.md
```

Chaque fichier contient :

- synopsis  
- description  
- paramètres  
- exemples  
- notes  

---

# 🔄 Mettre à jour la documentation après modification du module

Après avoir modifié une fonction (paramètres, description, exemples…), regénérez la documentation :

```powershell
Import-Module ./SecureGen/SecureGen/SecureGen.psd1 -Force

Update-MarkdownHelp `
    -Module SecureGen `
    -OutputFolder ./docs/cmdlets `
    -Force
```

PlatyPS mettra à jour uniquement les sections pertinentes.

---

# 🧪 Vérifier la documentation

Pour vérifier que la documentation est complète et conforme :

```powershell
Test-MarkdownHelp -Path ./docs/cmdlets
```

---

# 🛠️ Script automatisé (recommandé)

Le script dédié se trouve dans :

```
scripts/Generate-Help.ps1
```

Contenu recommandé :

```powershell
Write-Host "🔧 Génération de la documentation PlatyPS..."

Import-Module ./SecureGen/SecureGen/SecureGen.psd1 -Force

New-MarkdownHelp `
    -Module SecureGen `
    -OutputFolder ./docs/cmdlets `
    -WithModulePage `
    -Force

Write-Host "📘 Documentation générée dans docs/cmdlets/"
```

---

# 🤖 Intégration CI/CD (optionnel)

Vous pouvez ajouter un job dans `ci.yml` pour vérifier que la documentation est à jour :

```yaml
- name: Vérifier la documentation PlatyPS
  shell: pwsh
  run: |
    Install-Module PlatyPS -Force -Scope CurrentUser
    Import-Module ./SecureGen/SecureGen/SecureGen.psd1 -Force
    Test-MarkdownHelp -Path ./docs/cmdlets
```

Cela garantit que :

- les cmdlets sont documentées  
- les paramètres sont synchronisés  
- aucune documentation n’est manquante  

---

# 📁 Structure recommandée

```
docs/
│
├── cmdlets/
│   ├── Get-PassWord.md
│   ├── Get-PassPhrase.md
│   ├── Get-CryptoIndex.md
│   ├── Invoke-Beep.md
│   └── SecureGen.md
│
├── generate-help.md
└── ...
```

---

# 🎉 Documentation toujours à jour

Grâce à PlatyPS, SecureGen bénéficie d’une documentation :

- propre  
- standardisée  
- facile à maintenir  
- synchronisée avec le code  
- compatible CI/CD  

Pour toute suggestion d’amélioration :  
👉 Issues GitHub  
👉 Pull Requests
```

---
