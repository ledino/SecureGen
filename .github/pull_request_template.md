# 🔀 Pull Request — SecureGen

Merci de contribuer à SecureGen !  
Veuillez remplir les sections ci‑dessous pour faciliter la revue et garantir la qualité du module.

---

## 📘 Description

Expliquez clairement ce que fait cette Pull Request :

- Quel problème est résolu ?
- Quelle fonctionnalité est ajoutée ?
- Quel comportement est modifié ?
- Pourquoi ce changement est utile ?

---

## 🧩 Type de changement

Cochez ce qui correspond :

- [ ] `feat:` Nouvelle fonctionnalité (MINOR)
- [ ] `fix:` Correction de bug (PATCH)
- [ ] `docs:` Documentation uniquement
- [ ] `refactor:` Amélioration interne sans changement fonctionnel
- [ ] `perf:` Optimisation
- [ ] `BREAKING CHANGE:` Rupture de compatibilité (MAJOR)

---

## 🧪 Tests

Merci d’indiquer ce qui a été testé :

- [ ] Tests Pester ajoutés
- [ ] Tests Pester mis à jour
- [ ] Clipboard mocké si nécessaire
- [ ] Tests PS5.1 OK
- [ ] Tests PS7 OK

Commandes utilisées :

```powershell
Invoke-Pester -Path ./tests
Invoke-ScriptAnalyzer -Path ./SecureGen -Recurse
```

---

## 📦 Checklist obligatoire

Merci de vérifier les points suivants :

- [ ] Code compatible PS5.1 **et** PS7+
- [ ] Pas de dépendances externes
- [ ] Pas de `Write-Host` dans les fonctions
- [ ] Documentation mise à jour (cmdlet + README si nécessaire)
- [ ] Commit messages conformes à **Conventional Commits**
- [ ] Pas de modification manuelle du `CHANGELOG.md`
- [ ] Pas de modification manuelle du `ModuleVersion` dans `SecureGen.psd1`
- [ ] API cohérente (`Words`, `Len`, `Length`, `Type`, `AsSecureString`)
- [ ] Si ajout d’une fonctionnalité sensible → tests PKI + SecureString inclus

---

## 🧱 Architecture

Ce changement impacte :

- [ ] `Core.PS7.ps1`
- [ ] `Legacy.PS5.ps1`
- [ ] `SecureGen.psm1`
- [ ] Documentation PlatyPS
- [ ] Scripts internes
- [ ] CI/CD
- [ ] Autre (préciser) :

---

## 📸 Screenshots / Logs (optionnel)

Ajoutez ici des captures, extraits de logs ou sorties de tests si utile.

---

## 📝 Notes complémentaires

Ajoutez toute information utile pour les mainteneurs.

---

Merci pour votre contribution à SecureGen ! 🎉

---
