---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Set-ClipboardSafe

## SYNOPSIS
Copie du texte dans le presse‑papier de manière sécurisée et réellement cross‑platform.

## SYNTAX

```
Set-ClipboardSafe [-Text] <String> [<CommonParameters>]
```

## DESCRIPTION
Set-ClipboardSafe encapsule la commande native `Set-Clipboard` afin d’offrir une gestion
du presse‑papier compatible Windows, Linux et macOS.

La fonction détecte automatiquement la plateforme et utilise la meilleure méthode disponible :

- **Windows** : Set-Clipboard  
- **macOS** : pbcopy  
- **Linux (Wayland)** : wl-copy  
- **Linux (X11)** : xclip ou xsel  

En cas d’indisponibilité du presse‑papier (session SSH, conteneur, terminal minimal),
la fonction reste silencieuse et n’interrompt pas l’exécution.

## EXAMPLES

### EXAMPLE 1
```
Set-ClipboardSafe "Hello world"
```
Copie le texte dans le presse‑papier si la plateforme le permet.

### EXAMPLE 2
```
"secret" | Set-ClipboardSafe
```
Copie la chaîne "secret" via pipeline.

### EXAMPLE 3
```
Set-ClipboardSafe -Text "clé privée"
```
Copie explicitement la valeur fournie.

## PARAMETERS

### -Text
Texte à copier dans le presse‑papier.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## OUTPUTS
### None
La fonction ne retourne aucune valeur.

## NOTES
- Compatible Windows, Linux, macOS.  
- Utilise automatiquement la meilleure méthode selon la plateforme.  
- Reste silencieuse en cas d’échec (session SSH, conteneur, terminal sans clipboard).  
- Fonction interne utilisée par Get-PassWord, Get-PassPhrase et Get-PKIPass.

## RELATED LINKS
Clear-ClipboardSafe  
Get-PassWord  
Get-PassPhrase  
Get-PKIPass  

---
