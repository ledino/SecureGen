---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PkiPass

## SYNOPSIS
Génère un secret PKI robuste (mot de passe ou passphrase).

## SYNTAX

```
Get-PkiPass [[-Type] <String>] [[-Length] <Int32>] [[-Words] <Int32>] [[-Letters] <Int32>] [-AsPlainText]
 [-NoClipboard] [-NoClear] [-Silent] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get-PkiPass est une façade publique qui délègue toute la logique interne
à Internal-GeneratePkiPass.

Ce générateur produit un mot de passe adapté aux usages PKI :
- compatible certificats, CSR, clés privées
- sans caractères ambigus
- conforme aux bonnes pratiques de robustesse
- cross-platform (PS5.1 / PS7)
- basé sur la meilleure source d'aléa disponible (NIST SP 800-90 sous PS7)

La génération est déléguée à :
- Get-PassWord
- Get-PassPhrase

## EXAMPLES

### EXAMPLE 1
```
Get-PkiPass
Génère un mot de passe PKI de 32 caractères.
```

### EXAMPLE 2
```
Get-PkiPass -Type Passphrase -Words 8 -Letters 7
Génère une passphrase PKI robuste.
```

### EXAMPLE 3
```
Get-PkiPass -AsSecureString
Retourne le secret sous forme de SecureString.
```

## PARAMETERS

### -Type
Type de secret : Password ou Passphrase.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Password
Accept pipeline input: False
Accept wildcard characters: False
```

### -Length
Longueur du mot de passe PKI (mode Password).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Len

Required: False
Position: 2
Default value: 32
Accept pipeline input: False
Accept wildcard characters: False
```

### -Words
Nombre de mots (mode Passphrase).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: word, wrd, wd

Required: False
Position: 3
Default value: 7
Accept pipeline input: False
Accept wildcard characters: False
```

### -Letters
Nombre de lettres par mot (mode Passphrase).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Letter, ltrs, Let

Required: False
Position: 4
Default value: 6
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsPlainText
{{ Fill AsPlainText Description }}

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
Désactive tout affichage.

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

### System.String ou System.Security.SecureString
## NOTES

## RELATED LINKS
