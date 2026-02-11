---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PassWord

## SYNOPSIS
Génère un mot de passe sécurisé et configurable.

## SYNTAX

```
Get-PassWord [[-Len] <Int32>] [[-SpecialChars] <String>] [[-UseSpecial] <Boolean>] [-NoClipboard] [-NoClear]
 [-Silent]
```

## DESCRIPTION
Par défaut, utilise :
    - minuscules
    - majuscules
    - chiffres
    - caractères spéciaux (personnalisables)

L'utilisateur peut :
    - personnaliser les caractères spéciaux via -SpecialChars
    - désactiver totalement les caractères spéciaux via -UseSpecial:$false

L'aléa est généré via Get-SecureRandom (PS7+),
conforme aux modules cryptographiques modernes.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Len
{{ Fill Len Description }}

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
Caractères spéciaux personnalisables

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: !@#$%^&*()_+-=[]{}<>/\;~
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSpecial
Activation/désactivation des caractères spéciaux

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
Options d'affichage

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
{{ Fill NoClear Description }}

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
{{ Fill Silent Description }}

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

## OUTPUTS

## NOTES

## RELATED LINKS
