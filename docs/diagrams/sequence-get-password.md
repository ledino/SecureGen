# UML Sequence Diagram — Exécution de Get-PassWord

Ce diagramme illustre le flux complet d’exécution lorsque l’utilisateur appelle `Get-PassWord`.

---

## 🧬 Diagramme UML de séquence

```
Utilisateur          PowerShell          SecureGen.psm1         Implémentation PS7/PS5        Clipboard
    |                     |                     |                         |                         |
    |  Get-PassWord       |                     |                         |                         |
    |-------------------->|                     |                         |                         |
    |                     |  Résolution module  |                         |                         |
    |                     |-------------------->|                         |                         |
    |                     |                     |  Détecte version PS     |                         |
    |                     |                     |------------------------>|                         |
    |                     |                     |                         |                         |
    |                     |                     |  Charge Core.PS7.ps1    |                         |
    |                     |                     |<------------------------|                         |
    |                     |                     |                         |                         |
    |                     |  Appel fonction     |                         |                         |
    |                     |-------------------->|  Get-PassWord()         |                         |
    |                     |                     |------------------------>|                         |
    |                     |                     |                         |  Génère mot de passe    |
    |                     |                     |                         |------------------------>|
    |                     |                     |                         |                         |
    |                     |                     |                         |  Retourne résultat      |
    |                     |                     |<------------------------|                         |
    |                     |                     |                         |                         |
    |                     |                     |  Si -Silent : Set-Clipboard                       |
    |                     |                     |-------------------------------------------------->|
    |                     |                     |                        |                          |
    |                     |                     |  Retourne mot de passe (ou rien si -Silent)       |
    |                     |<--------------------|                        |                          |
    |  Affiche / utilise  |                     |                        |                          |
    |<--------------------|                     |                        |                          |
```

---

## 📘 Résumé

Ce diagramme montre :

- la résolution dynamique PS5/PS7  
- l’appel interne à l’implémentation  
- la génération du mot de passe  
- la gestion du mode `-Silent`  
- l’interaction avec le presse‑papier  

---