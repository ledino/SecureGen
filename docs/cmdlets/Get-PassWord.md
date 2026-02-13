---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PassWord

## SYNOPSIS
Génère un mot de passe sécurisé, configurable et compatible Windows / Linux / macOS.

## SYNTAX

```
Get-PassWord [[-Len] <Int32>] [[-SpecialChars] <String>] [[-UseSpecial] <Boolean>] [-NoClipboard] [-NoClear] [-Silent]
```

## DESCRIPTION
`Get-PassWord` génère un mot de passe robuste en utilisant un générateur cryptographique sécurisé :

- **PS7+** : `Get-SecureRandom` (conforme NIST SP 800‑90)
- **PS5.1** : RNG .NET Framework (cryptographiquement sûr)

Par défaut, le mot de passe inclut :

- minuscules  
- majuscules  
- chiffres  
- caractères spéciaux (personnalisables)

Vous pouvez :

- personnaliser les caractères spéciaux via `-SpecialChars`
- désactiver totalement les caractères spéciaux via `-UseSpecial:$false`
- désactiver la copie automatique dans le presse‑papier (`-NoClipboard`)
- empêcher l’effacement automatique du presse‑papier (`-NoClear`)
- désactiver le beep (`-Silent`)

## EXAMPLES

### EXAMPLE 1
Générer un mot de passe standard (20 caractères par défaut) :

```powershell
Get-PassWord
```

### EXAMPLE 2
Mot de passe avec caractères spéciaux personnalisés :

```powershell
Get-PassWord -SpecialChars '!@#?%'
```

### EXAMPLE 3
Mot de passe sans caractères spéciaux :

```powershell
Get-PassWord -UseSpecial:$false
```

### EXAMPLE 4
Mot de passe long (32 caractères) :

```powershell
Get-PassWord -Len 32
```

### EXAMPLE 5
Générer un mot de passe sans beep ni clipboard :

```powershell
Get-PassWord -Silent -NoClipboard
```

## PARAMETERS

### -Len
Longueur du mot de passe à générer.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Required: False
Position: 1
Default value: 20
Accept pipeline input: False
Accept wildcard characters: False
```

### -SpecialChars
Liste personnalisée de caractères spéciaux à utiliser.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Required: False
Position: 2
Default value: [!@#$%^&*()_+\-=\[\]{}<>\/\\|;~]
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSpecial
Active ou désactive l’utilisation de caractères spéciaux.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 
Required: False
Position: 3
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClipboard
Empêche la copie automatique du mot de passe dans le presse‑papier.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 
Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClear
Empêche l’effacement automatique du presse‑papier après un délai sécurisé.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 
Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Silent
Désactive le beep de confirmation.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 
Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS
Aucune entrée.

## OUTPUTS
`System.String`  
Le mot de passe généré.

## NOTES
- Compatible Windows, Linux, macOS  
- PS7 utilise `Get-SecureRandom`  
- PS5.1 utilise RNG .NET Framework  
- Le clipboard utilise automatiquement la meilleure méthode disponible selon la plateforme

## RELATED LINKS
https://github.com/ledino/SecureGen

---
