---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PassPhrase

## SYNOPSIS
Génère une passphrase robuste, lisible et conforme ANSSI/CNIL.

## SYNTAX

```
Get-PassPhrase [[-Letters] <Int32>] [[-Words] <Int32>] [[-Separator] <String>] [[-Charset] <String>]
 [-NoClipboard] [-NoClear] [-Silent] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get-PassPhrase est une façade publique qui délègue toute la logique interne
à Internal-GeneratePassPhrase.

La génération utilise automatiquement la meilleure source d'aléa selon la version
de PowerShell (PS7 : NIST SP 800-90, PS5.1 : RNGCryptoServiceProvider).

Les recommandations ANSSI/CNIL (2021-2024) sont appliquées :
- minimum 7 mots
- longueur totale ≥ 30 caractères
- priorité à la longueur

## EXAMPLES

### EXAMPLE 1
```
Get-PassPhrase
Génère une passphrase de 7 mots de 6 lettres.
```

### EXAMPLE 2
```
Get-PassPhrase -Words 10 -Letters 5
Génère une passphrase longue et très entropique.
```

## PARAMETERS

### -Letters
{{ Fill Letters Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Letter, ltrs, Let

Required: False
Position: 1
Default value: 6
Accept pipeline input: False
Accept wildcard characters: False
```

### -Words
Nombre de mots.
Par défaut : 7.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: word, wrd, wd

Required: False
Position: 2
Default value: 7
Accept pipeline input: False
Accept wildcard characters: False
```

### -Separator
Séparateur entre les mots.
Par défaut : "-".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: -
Accept pipeline input: False
Accept wildcard characters: False
```

### -Charset
Ensemble des caractères utilisés pour générer les mots.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: AbcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
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
### Retourne la passphrase générée.
## NOTES

## RELATED LINKS
