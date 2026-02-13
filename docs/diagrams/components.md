# Diagramme UML — Composants du module SecureGen

Ce document présente l’architecture interne du module SecureGen sous forme de diagramme UML de composants.  
Il illustre la séparation entre l’orchestrateur, les implémentations PS5/PS7 et les ressources.

---

## 🧩 Diagramme des composants

```
+--------------------------------------------------------------------------------------+
|                                   SecureGen Module                                   |
+--------------------------------------------------------------------------------------+

                                     +----------------+
                                     |  SecureGen.psd1|
                                     |  (Manifest)    |
                                     +--------+-------+
                                              |
                                              v
+--------------------------------------------------------------------------------------+
|                                   SecureGen.psm1                                     |
|                         (Module principal — orchestrateur)                           |
+--------------------------------------------------------------------------------------+
| - Détection de l'environnement (PS5 / PS7)                                           |
| - Import conditionnel des implémentations                                            |
| - Export des fonctions publiques                                                     |
| - Chargement des alias                                                               |
+---------------------------+-------------------------------+--------------------------+
                            |                               |
                            |                               |
                            v                               v

        +----------------------------------+     +----------------------------------+
        |      Core.PS7.ps1                |     |      Legacy.PS5.ps1              |
        |  (Implémentations PowerShell 7)  |     |  (Implémentations PS 5.1)        |
        +----------------------------------+     +----------------------------------+
        | - Get-PassWord (PS7)             |     | - Get-PassWord (PS5)             |
        | - Get-PassPhrase (PS7)           |     | - Get-PassPhrase (PS5)           |
        | - Get-CryptoIndex (PS7)          |     | - Get-CryptoIndex (PS5)          |
        | - Invoke-Beep (PS7)              |     | - Invoke-Beep (PS5)              |
        +----------------------------------+     +----------------------------------+

                            ^                               ^
                            |                               |
                            +-------------------------------+
                                              |
                                              v

+--------------------------------------------------------------------------------------+
|                               Ressources & Utilitaires                               |
+--------------------------------------------------------------------------------------+
| - wordlist.txt (liste de mots pour passphrases)                                      |
| - Tests Pester (tests unitaires)                                                     |
| - Helpers internes (futurs)                                                          |
+--------------------------------------------------------------------------------------+
```

---

## 📘 Résumé

Ce diagramme montre clairement :

- la séparation PS5 / PS7  
- le rôle central de `SecureGen.psm1`  
- la structure modulaire du projet  
- les ressources utilisées par les implémentations  

Pour une vue plus large, consultez :  
➡️ `architecture.md`  
```

---