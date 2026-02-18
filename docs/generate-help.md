# 📘 Génération automatique de la documentation — PlatyPS  
*(Aligné avec l’architecture SecureGen et le script Generate-Help.ps1)*

SecureGen utilise **PlatyPS** pour générer automatiquement la documentation des cmdlets du module.  
Ce système garantit une documentation :

- toujours synchronisée avec le code  
- propre et standardisée  
- compatible PowerShell 5.1 et 7  
- intégrée au workflow CI/CD  

Ce guide explique comment générer, mettre à jour et valider la documentation.

---

# 🧩 Prérequis

SecureGen utilise **PlatyPS 0.14.2**, car :

- c’est la version stable compatible PS5.1  
- elle fonctionne avec `-Module` (et non `-ModulePath`)  
- elle génère automatiquement les fichiers dans un dossier dédié  

Installez-la si nécessaire :

```powershell
Install-Module PlatyPS -Scope CurrentUser -Force
```

Vérifiez la version :

```powershell
Get-Module PlatyPS -ListAvailable
```

---

# 📁 Emplacement de la documentation générée

Toute la documentation des cmdlets est stockée dans :

```
docs/cmdlets/
```

Ce dossier est **généré automatiquement** et ne doit jamais être modifié manuellement.

---

# 🚀 Générer la documentation initiale

Depuis la racine du projet :

```powershell
Import-Module ./SecureGen/SecureGen.psd1 -Force

New-MarkdownHelp `
    -Module SecureGen `
    -OutputFolder ./docs/cmdlets `
    -Force
```

Cela génère :

```
docs/cmdlets/
│
├── Get-CryptoIndex.md
├── Get-PassPhrase.md
├── Get-PassWord.md
├── Get-PKIPass.md
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
Import-Module ./SecureGen/SecureGen.psd1 -Force

Update-MarkdownHelp `
    -Module SecureGen `
    -OutputFolder ./docs/cmdlets `
    -Force
```

PlatyPS mettra à jour uniquement les sections pertinentes.

---

# 🧪 Vérifier la documentation

Pour vérifier que la documentation est complète et cohérente :

```powershell
Test-MarkdownHelp -Module SecureGen -HelpFilesPath ./docs/cmdlets
```

---

# 🛠️ Script automatisé (recommandé)

Le script officiel se trouve dans :

```
scripts/Generate-Help.ps1
```

Il :

- détecte automatiquement PlatyPS  
- importe le module SecureGen  
- génère ou met à jour la documentation  
- crée la page du module (`SecureGen.md`)  
- valide la cohérence  
- nettoie si nécessaire  

Exécution :

```powershell
pwsh ./scripts/Generate-Help.ps1
```

---

# 🤖 Intégration CI/CD

La CI peut vérifier que la documentation est valide :

```yaml
- name: Vérifier la documentation PlatyPS
  shell: pwsh
  run: |
    Install-Module PlatyPS -Force -Scope CurrentUser
    Import-Module ./SecureGen/SecureGen.psd1 -Force
    Test-MarkdownHelp -Module SecureGen -HelpFilesPath ./docs/cmdlets
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
│   ├── Get-PKIPass.md
│   └── SecureGen.md
│
├── generate-help.md
└── ...
```

---

# 🎉 Documentation toujours à jour

Grâce à PlatyPS et au script `Generate-Help.ps1`, SecureGen bénéficie d’une documentation :

- propre  
- standardisée  
- facile à maintenir  
- synchronisée avec le code  
- compatible CI/CD  

Pour toute suggestion d’amélioration :  
👉 Issues GitHub  
👉 Pull Requests

---
