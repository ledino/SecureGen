---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Clear-ClipboardSafe

## SYNOPSIS
Efface le presse‑papier de manière sécurisée et cross‑platform.

## SYNTAX

```
Clear-ClipboardSafe [<CommonParameters>]
```

## DESCRIPTION
Clear-ClipboardSafe efface le contenu du presse‑papier en utilisant la meilleure méthode
disponible selon la plateforme :

- **Windows** : Set-Clipboard $null  
- **macOS** : pbcopy < /dev/null  
- **Linux (Wayland)** : wl-copy  
- **Linux (X11)** : xclip ou xsel  

La fonction est conçue pour être **silencieuse en cas d’échec**, afin d’éviter toute interruption
dans les environnements où le presse‑papier n’est pas disponible (sessions SSH, conteneurs,
terminaux minimalistes, environnements headless).

Elle est utilisée par les cmdlets SecureGen pour effacer automatiquement le presse‑papier
après un délai sécurisé.

## EXAMPLES

### EXAMPLE 1
```
Clear-ClipboardSafe
```
Efface le presse‑papier si la plateforme le permet.

### EXAMPLE 2
```
Get-PassWord
# ... après 35 secondes
Clear-ClipboardSafe
```
Efface manuellement le presse‑papier après une génération de mot de passe.

## PARAMETERS

*(Aucun paramètre spécifique)*

Clear-ClipboardSafe accepte uniquement les paramètres communs PowerShell.

## OUTPUTS
### None
La fonction ne retourne aucune valeur.

## NOTES
- Compatible Windows, Linux, macOS.  
- Utilise automatiquement la meilleure méthode selon la plateforme.  
- Reste silencieuse en cas d’échec (session SSH, conteneur, terminal sans clipboard).  
- Fonction interne utilisée par Get-PassWord, Get-PassPhrase et Get-PKIPass.  
- Recommandée pour les environnements sensibles où le clipboard doit être nettoyé automatiquement.

## RELATED LINKS
Set-ClipboardSafe  
Get-PassWord  
Get-PassPhrase  
Get-PKIPass  

---

