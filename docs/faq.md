# 📘 **docs/faq.md — Foire Aux Questions (FAQ)**

# ❓ FAQ — SecureGen

Bienvenue dans la FAQ officielle de **SecureGen**.  
Cette page répond aux questions les plus fréquentes concernant l’installation, l’utilisation, la compatibilité et la sécurité du module.

---

# 🔐 Général

## 👉 Qu’est‑ce que SecureGen ?
SecureGen est un module PowerShell moderne permettant de générer :

- des mots de passe sécurisés  
- des passphrases robustes  
- des clés aléatoires cryptographiquement sûres  

Il fonctionne sous **PowerShell 5.1** et **PowerShell 7+**, sur Windows, Linux et macOS.

---

# 🧩 Compatibilité

## 👉 SecureGen fonctionne‑t‑il sous PowerShell 5.1 ?
Oui.  
SecureGen inclut une version **Legacy** spécialement conçue pour Windows PowerShell 5.1.

## 👉 SecureGen fonctionne‑t‑il sous PowerShell 7 ?
Oui, et c’est même la version recommandée.  
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
Le presse‑papier n’est **jamais** un espace sécurisé, quel que soit le système.

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

## 👉 Où se trouve la structure du module ?
Dans `docs/architecture.md`.

## 👉 Comment builder le module ?
Avec :

```powershell
pwsh ./scripts/build.ps1
```

---

# 🧪 Tests

## 👉 SecureGen inclut‑il des tests ?
Un dossier `tests/` peut être ajouté pour Pester.  
Le script `build.ps1` les exécutera automatiquement.

---

# 🧱 Problèmes courants

## ❗ Le module n’apparaît pas dans PS5 ou PS7
Vérifiez les chemins :

```powershell
$env:PSModulePath -split ';'
```

## ❗ Le beep ne fonctionne pas
C’est normal sur certains environnements Linux/macOS.  
SecureGen ignore l’erreur automatiquement.

## ❗ Le clipboard ne copie rien
Installez `xclip` ou `xsel` sous Linux.

---

# 📚 Documentations associées

- 📦 Installation : [https://github.com/ledino/SecureGen/blob/main/docs/installation.md](https://github.com/ledino/SecureGen/blob/main/docs/installation.md)  
- 📘 Exemples : `https://github.com/ledino/SecureGen/blob/main/docs/examples.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fexamples.md")  
- 🧠 Guide avancé : `https://github.com/ledino/SecureGen/blob/main/docs/advanced.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fadvanced.md")  
- 🧱 Architecture : `https://github.com/ledino/SecureGen/blob/main/docs/architecture.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Farchitecture.md")  
- 🧪 Versioning : `https://github.com/ledino/SecureGen/blob/main/docs/versioning.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fversioning.md")  
- 🚀 Processus de release : `https://github.com/ledino/SecureGen/blob/main/docs/release-process.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Frelease-process.md")  
- 🔐 Sécurité : `https://github.com/ledino/SecureGen/blob/main/docs/security.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2Fdocs%2Fsecurity.md")  
- 📜 README principal : `https://github.com/ledino/SecureGen/blob/main/README.md` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fblob%2Fmain%2FREADME.md")  

---

# 🎉 Merci d'utiliser SecureGen !

Pour toute autre question :  
👉 GitHub — Issues & Discussions

---

