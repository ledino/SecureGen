# Pipeline CI/CD — Diagramme Officiel

Ce document décrit le pipeline complet de SecureGen, depuis le développement local jusqu’à la publication sur PowerShell Gallery.

---

## 📘 Diagramme du pipeline CI/CD

```
+--------------------------------------------------------------------------------------+
|                                 SecureGen CI/CD Pipeline                             |
+--------------------------------------------------------------------------------------+

1. Développement local
   - Modification du code
   - Tests manuels
   - Commits au format Conventional Commits

        |
        v

2. Versioning automatisé (standard-version)
   - Analyse des commits
   - Détermination du bump (major/minor/patch)
   - Mise à jour du CHANGELOG.md
   - Mise à jour du module manifest (.psd1)
   - Commit automatique
   - Création du tag vX.Y.Z

        |
        v

3. Push vers GitHub
   - `git push origin main`
   - `git push origin vX.Y.Z`

        |
        v

4. Intégration Continue (ci.yml)
   Déclencheur : push sur main
   - Installation PowerShell
   - Analyse statique (PSScriptAnalyzer)
   - Tests unitaires (Pester)
   - Validation du manifest
   - Exécution sur matrice :
       • Windows PowerShell 5.1
       • Windows PowerShell 7
       • Linux PowerShell 7

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

                                        |
                                        v

6. Module publié
   - SecureGen vX.Y.Z disponible sur PowerShell Gallery

        |
        v

7. Release GitHub (manuelle)
   - Création de la page Release
   - Notes de version
   - Association du tag existant

+--------------------------------------------------------------------------------------+
```

---

## 📘 Résumé

Ce pipeline garantit :

- qualité du code  
- versioning propre  
- publication automatique  
- reproductibilité totale  

---