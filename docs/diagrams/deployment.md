# UML Deployment Diagram — SecureGen

Ce diagramme montre où vivent les composants du module SecureGen :  
- sur la machine utilisateur  
- dans PowerShell Gallery  
- dans GitHub Actions (CI/CD)

---

## 🏗️ Diagramme UML de déploiement

```
+--------------------------------------------------------------------------------------+
|                                   Poste Utilisateur                                  |
|                           (Windows / Linux / macOS — PS7)                            |
+--------------------------------------------------------------------------------------+
|                                                                                      |
|   +--------------------------------------+       +--------------------------------+  |
|   |   PowerShell Runtime (PS7 / PS5.1)   |       |   File System                  |  |
|   |--------------------------------------|       |--------------------------------|  |
|   |  - Gestion des modules               |       |  - Modules utilisateur         |  |
|   |  - ExecutionPolicy                   |       |    C:\Users\<User>\Documents\  |  |
|   |  - Cmdlets natifs (Get-Clipboard)    |       |      PowerShell\Modules\       |  |
|   +------------------+-------------------+       |                                |  |
|                      |                           |  - Modules système             |  |
|                      |                           |    C:\Program Files\...        |  |
|                      |                           +----------------+---------------+  |
|                      |                                            |                  |
|                      v                                            v                  |
|   +--------------------------------------------------------------------------------+ |
|   |                           Module SecureGen (v1.4.0)                            | |
|   |--------------------------------------------------------------------------------| |
|   |  SecureGen.psd1 (Manifest)                                                     | |
|   |  SecureGen.psm1 (Orchestrateur)                                                | |
|   |                                                                                | |
|   |  +----------------------+     +----------------------+                         | |
|   |  |   Core.PS7.ps1       |     |   Legacy.PS5.ps1     |                         | |
|   |  | (Impl. PS7/Linux)    |     | (Impl. Windows PS5)  |                         | |
|   |  +----------------------+     +----------------------+                         | |
|   |                                                                                | |
|   |  Ressources :                                                                  | |
|   |   - wordlist.txt                                                               | |
|   |   - Tests Pester                                                               | |
|   +--------------------------------------------------------------------------------+ |
|                                                                                      |
+--------------------------------------------------------------------------------------+

                                   ▲
                                   |
                                   |
+--------------------------------------------------------------------------------------+
|                                   PowerShell Gallery                                 |
|                           (Source officielle de distribution)                        |
+--------------------------------------------------------------------------------------+
|  - Héberge SecureGen v1.4.0                                                          |
|  - Fournit Install-Module                                                            |
|  - Source de confiance PowerShellGet                                                 |
+--------------------------------------------------------------------------------------+

                                   ▲
                                   |
                                   |
+--------------------------------------------------------------------------------------+
|                                   GitHub Actions                                     |
|                               (CI/CD — Build & Publish)                              |
+--------------------------------------------------------------------------------------+
|  - CI (ci.yml)                                                                       |
|     • Linting (PSScriptAnalyzer)                                                     |
|     • Tests Pester                                                                   |
|     • Validation manifest                                                            |
|     • Matrice PS5/PS7/Linux                                                          |
|                                                                                      |
|  - Publication (publish.yml)                                                         |
|     • Build module                                                                   |
|     • Publication PSGallery via PSGALLERY_KEY                                        |
+--------------------------------------------------------------------------------------+
```

---

## 📘 Résumé

Ce diagramme montre :

- où le module est installé  
- comment il est chargé  
- comment il est publié  
- comment GitHub Actions et PSGallery interagissent