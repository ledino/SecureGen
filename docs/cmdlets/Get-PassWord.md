---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PassWord

## SYNOPSIS
Génère un mot de passe sécurisé, configurable et cross-platform.

## SYNTAX

```
Get-PassWord [[-Length] <Int32>] [[-SpecialChars] <String>] [-UseSpecial] [-RequireAllTypes] [-NoClipboard]
 [-NoClear] [-Silent] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get-PassWord est une façade publique qui délègue toute la logique interne
à Internal-GeneratePassword.

La génération utilise automatiquement la meilleure source d'aléa selon la version
de PowerShell (PS7 : NIST SP 800-90, PS5.1 : RNGCryptoServiceProvider).

## EXAMPLES

### EXAMPLE 1
```
Get-PassWord
Génère un mot de passe robuste de 20 caractères.
```

### EXAMPLE 2
```
Get-PassWord -Length 32 -RequireAllTypes
Génère un mot de passe long contenant toutes les catégories.
```

## PARAMETERS

### -Length
Longueur du mot de passe.
Par défaut : 16 (Recommandation ANSSI).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Len

Required: False
Position: 1
Default value: 16
Accept pipeline input: False
Accept wildcard characters: False
```

### -SpecialChars
Liste des caractères spéciaux autorisés.

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
Active ou désactive l'utilisation des caractères spéciaux.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequireAllTypes
Exige la présence d'au moins une minuscule, une majuscule, un chiffre
et un caractère spécial (si UseSpecial = $true).

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

### -NoClipboard
Désactive la copie automatique dans le presse-papier.

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
Empêche l'effacement automatique du presse-papier.

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
Désactive tout affichage et tout bip.

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

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
### Retourne le mot de passe généré.
## NOTES

## RELATED LINKS
