# 🔄 Pipeline CI/CD — Diagramme Officiel (Version améliorée)

Ce document décrit le pipeline complet de SecureGen, depuis le développement local jusqu’à la publication automatique sur PowerShell Gallery.

---

# 📘 Diagramme du pipeline CI/CD

```
+--------------------------------------------------------------------------------------+
|                                 SecureGen CI/CD Pipeline                             |
+--------------------------------------------------------------------------------------+

1. Développement local
   - Modification du code
   - Tests manuels
   - Commits au format Conventional Commits
   - Pas de bump manuel du manifest
   - Pas de modification manuelle du CHANGELOG

        |
        v

2. Versioning automatisé (standard-version)
   - Analyse des commits
   - Détermination du bump (major / minor / patch)
   - Mise à jour automatique :
       • package.json
       • SecureGen.psd1 (via updater custom)
       • CHANGELOG.md
   - Commit automatique : "chore(release): X.Y.Z"
   - Création du tag : vX.Y.Z

        |
        v

3. Push vers GitHub
   - git push origin main
   - git push origin vX.Y.Z

        |
        v

4. Intégration Continue (ci.yml)
   Déclencheur : push sur main
   - Installation PowerShell
   - Analyse statique (PSScriptAnalyzer)
   - Import du module
   - Tests unitaires (Pester)
   - Validation du manifest
   - Exécution sur matrice :
       • Windows PowerShell 5.1
       • PowerShell 7 (Windows)
       • PowerShell 7 (Linux)

        |
        v

   [Décision] CI réussie ?
        |----------------------------|
        |                            |
       Non                          Oui
        |                            |
        v                            v

   Retour développeur         5. Publication (publish.yml)
   - Correction locale           Déclencheur : push tag v*
   - Nouveau commit              - Reconstruction du module
   - Nouveau push                - Validation du manifest
                                 - Publication sur PSGallery
                                   via PSGALLERY_KEY
                                 - Création automatique de la Release GitHub

                                        |
                                        v

6. Module publié
   - SecureGen vX.Y.Z disponible sur PowerShell Gallery
   - Release GitHub générée automatiquement

        |
        v

7. (Optionnel) Finalisation manuelle
   - Ajout de notes de version enrichies
   - Ajout de captures d’écran ou GIFs
   - Mise à jour de la documentation si nécessaire

+--------------------------------------------------------------------------------------+
```

---

# 🔄 Pipeline CI/CD — Diagramme UML (Activity Diagram)

```uml
@startuml
title SecureGen CI/CD - Activity Diagram

start

:Développement local;
:Modification du code;
:Tests manuels;
:Commits (Conventional Commits);

--> "standard-version";

partition "Versioning automatisé" {
    :Analyse des commits;
    :Détermination du bump (major/minor/patch);
    :Mise à jour package.json;
    :Mise à jour SecureGen.psd1 (updater custom);
    :Génération CHANGELOG.md;
    :Commit automatique "chore(release): X.Y.Z";
    :Création du tag vX.Y.Z;
}

--> "Push GitHub";

:git push origin main;
:git push origin vX.Y.Z;

--> "CI GitHub Actions";

partition "CI (ci.yml)" {
    :Installation PowerShell;
    :Analyse statique (PSScriptAnalyzer);
    :Import du module;
    :Tests Pester;
    :Validation du manifest;

    fork
        :PS 5.1 (Windows);
    fork again
        :PS 7 (Windows);
    fork again
        :PS 7 (Linux);
    end fork

    if ("CI réussie ?") then (Oui)
        --> "Publish pipeline";
    else (Non)
        :Retour développeur;
        :Corrections locales;
        --> "Développement local";
    endif
}

partition "Publication (publish.yml)" {
    :Déclencheur : push tag v*;
    :Reconstruction du module;
    :Validation du manifest;
    :Publication PSGallery (PSGALLERY_KEY);
    :Création Release GitHub automatique;
}

:Module publié (PSGallery + GitHub Release);

stop
@enduml
```

---

# 🔄 Pipeline CI/CD — Diagramme mermaid

```mermaid
flowchart TD

     %% Styles
     classDef stepClass fill:#0A2A4F,stroke:#0A2A4F,color:#fff
     classDef actionClass fill:#00BCD4,stroke:#008BA3,color:#fff
     classDef decisionClass fill:#4FC3F7,stroke:#0288D1,color:#000
     classDef endClass fill:#4CAF50,stroke:#2E7D32,color:#fff


     A[Développement local<br/>• Modifications du code<br/>• Tests manuels<br/>• Commits Conventional]:::step

     A --> B[standard-version<br/>Versioning automatisé]:::action

     B --> B1[Analyse des commits]:::action
     B1 --> B2[Détermination du bump]:::action
     B2 --> B3[Mise à jour package.json<br/>+ SecureGen.psd1]:::action
     B3 --> B4[Génération CHANGELOG.md]:::action
     B4 --> B5[Commit auto<br/>chore(release): X.Y.Z]:::action
     B5 --> B6[Création du tag vX.Y.Z]:::action

     B6 --> C[Push vers GitHub<br/>main + tag]:::step

     C --> D[CI GitHub Actions<br/>(ci.yml)]:::action

     D --> D1[Installation PowerShell]:::action
     D1 --> D2[Analyse statique<br/>PSScriptAnalyzer]:::action
     D2 --> D3[Import du module]:::action
     D3 --> D4[Tests Pester]:::action
     D4 --> D5[Validation du manifest]:::action

     D5 --> M{Matrice PS5 / PS7}:::decision
     M --> M1[Windows PowerShell 5.1]:::action
     M --> M2[PowerShell 7 (Windows)]:::action
     M --> M3[PowerShell 7 (Linux)]:::action

     M1 --> E
     M2 --> E
     M3 --> E

     E{CI réussie ?}:::decision

     E -->|Non| F[Retour développeur<br/>Corrections locales]:::step
     F --> A

     E -->|Oui| G[Pipeline de publication<br/>(publish.yml)]:::action

     G --> G1[Déclencheur : push tag v*]:::action
     G1 --> G2[Reconstruction du module]:::action
     G2 --> G3[Validation du manifest]:::action
     G3 --> G4[Publication PSGallery]:::action
     G4 --> G5[Création Release GitHub]:::action

     G5 --> H[Module publié<br/>PSGallery + Release GitHub]:::end
```

---

# 📘 Résumé du pipeline

- **Versioning automatisé** → standard-version + updater custom  
- **CI multi‑plateformes** → PS5.1 + PS7 Windows + PS7 Linux  
- **Tests automatisés** → Pester  
- **Analyse statique** → PSScriptAnalyzer  
- **Publication automatique** → GitHub Actions + PSGallery  
- **Release GitHub générée automatiquement**  
- **Aucune intervention manuelle requise** (sauf notes de release optionnelles)

---
