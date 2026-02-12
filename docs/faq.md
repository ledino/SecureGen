# ❓ FAQ — SecureGen  
*(Alignée avec l’architecture moderne et le pipeline CI/CD)*

Bienvenue dans la FAQ officielle de **SecureGen**.  
Cette page répond aux questions les plus fréquentes concernant l’installation, l’utilisation, la compatibilité, la sécurité et le développement du module.

---

# 🔐 Général

## 👉 Qu’est‑ce que SecureGen ?
SecureGen est un module PowerShell moderne permettant de générer :

- des mots de passe sécurisés  
- des passphrases robustes  
- des clés aléatoires cryptographiquement sûres  

Il fonctionne sous **PowerShell 5.1** et **PowerShell 7+**, sur Windows, Linux et macOS.

## 👉 SecureGen est‑il open‑source ?
Oui.  
Le code source est disponible sur GitHub.

---

# 🧩 Compatibilité

## 👉 SecureGen fonctionne‑t‑il sous PowerShell 5.1 ?
Oui.  
SecureGen inclut une version **Legacy** spécialement conçue pour Windows PowerShell 5.1.

## 👉 SecureGen fonctionne‑t‑il sous PowerShell 7 ?
Oui, et c’est la version recommandée.  
La version **Core.PS7.ps1** utilise les API cryptographiques modernes de .NET 6+.

## 👉 Comment SecureGen choisit‑il la bonne version ?
Automatiquement.  
Le fichier `SecureGen.psm1` détecte la version PowerShell et charge :

- `Core.PS7.ps1` si PS7+  
- `Legacy.PS5.ps1` si PS5.1  

Aucune action n’est requise.

---

# 🚀 Installation

## 👉 Comment installer SecureGen depuis la PowerShell Gallery ?

```powershell
Install-Module SecureGen -Scope CurrentUser
```

## 👉 Comment mettre à jour SecureGen ?

```powershell
Update-Module SecureGen
```

## 👉 Comment installer SecureGen manuellement ?
Clonez le dépôt puis exécutez :

```powershell
pwsh ./scripts/Install-SecureGen.ps1
```

Le script détecte automatiquement PS5/PS7 et installe dans les bons chemins.

---

# 🔑 Utilisation

## 👉 Comment générer un mot de passe ?

```powershell
Get-PassWord
```

## 👉 Comment générer une passphrase ?

```powershell
Get-PassPhrase
```

## 👉 Comment personnaliser une passphrase ?

```powershell
Get-PassPhrase -LettresParMot 5 -MotsParBloc 7
```

## 👉 Comment désactiver le beep ?

```powershell
Get-PassWord -Silent
```

## 👉 Quels sont les alias disponibles ?

- `sgw` → `Get-PassWord`  
- `sgp` → `Get-PassPhrase`  

---

# 📋 Presse‑papier (Clipboard)

## 👉 Le clipboard ne fonctionne pas sous Linux/macOS, pourquoi ?
Vous devez installer un utilitaire :

- Linux : `xclip` ou `xsel`  
- macOS : `pbcopy` (déjà installé par défaut)  

Exemple Linux :

```bash
sudo apt install xclip
```

## 👉 Le clipboard est‑il sécurisé ?
Non.  
Le presse‑papier n’est **jamais** un espace sécurisé.

Effacez‑le après usage :

```powershell
Clear-ClipboardSafe
```

---

# 🔐 Sécurité

## 👉 SecureGen stocke‑t‑il mes mots de passe ?
Non.  
Aucun secret n’est stocké, loggé ou envoyé.

## 👉 Les mots de passe sont‑ils vraiment aléatoires ?
Oui.  
SecureGen utilise :

- PS7 : `RandomNumberGenerator.GetBytes()` + `Get-SecureRandom`  
- PS5 : `RNGCryptoServiceProvider`  

Toutes ces API sont cryptographiquement sûres.

## 👉 Puis‑je utiliser SecureGen dans un pipeline CI/CD ?
Oui.  
Exemple GitHub Actions :

```yaml
- name: Générer un secret
  shell: pwsh
  run: |
    $pwd = Get-PassWord -SpecialChars '!@#?%' -Silent
    echo "SECRET=$pwd" >> $GITHUB_ENV
```

---

# 🛠️ Développement

## 👉 Comment contribuer ?
Pull Requests et Issues sont les bienvenues.  
Voir : `docs/contributing.md`

## 👉 Où se trouve la structure du module ?
Dans :  
`docs/architecture.md`

## 👉 Comment builder le module ?
Avec :

```powershell
pwsh ./scripts/build.ps1
```

## 👉 Comment générer la documentation des cmdlets ?
Avec :

```powershell
pwsh ./scripts/Generate-Help.ps1
```

---

# 🔄 Versioning & Release

## 👉 Comment fonctionne le versioning ?
SecureGen utilise :

- **Conventional Commits**
- **standard-version**
- un **updater custom** pour le manifest
- un **CHANGELOG.md** généré automatiquement

Voir : `docs/versioning.md`

## 👉 Comment fonctionne la release automatisée ?
Via GitHub Actions :

- bump automatique  
- changelog automatique  
- commit + tag  
- publication PSGallery  

Voir : `docs/release-process.md`

## 👉 Dois‑je modifier `ModuleVersion` à la main ?
Non.  
C’est géré automatiquement par standard‑version.

---

# 🧱 Problèmes courants

## ❗ Le module n’apparaît pas dans PS5 ou PS7
Vérifiez les chemins :

```powershell
$env:PSModulePath -split ';'
```

## ❗ Le beep ne fonctionne pas
Normal dans certains environnements Linux/macOS.

## ❗ Le clipboard ne copie rien
Installez `xclip` ou `xsel` sous Linux.

## ❗ Le workflow release échoue
Vérifiez :

- le secret `PSGALLERY_KEY`
- l’identité GitHub Actions
- la configuration `.versioningrc.json`

---

# 📚 Documentations associées

- `installation.md`
- `examples.md`
- `advanced.md`
- `architecture.md`
- `security.md`
- `versioning.md`
- `release-process.md`
- `contributing.md`
- `README.md`

---

# 🎉 Merci d'utiliser SecureGen !

Pour toute autre question :  
👉 GitHub — Issues & Discussions
```

---
