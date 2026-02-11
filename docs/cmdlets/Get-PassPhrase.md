---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PassPhrase

## SYNOPSIS
Génère une passephrase sécurisée et optionnellement la copie dans le presse-papier.

## SYNTAX

```
Get-PassPhrase [[-LettresParMot] <Int32>] [[-MotsParBloc] <Int32>] [[-Separateur] <String>]
 [[-Charset] <String>] [-NoClipboard] [-NoClear] [-Silent]
```

## DESCRIPTION
Produit une passephrase composée de mots générés caractère par caractère
via un RNG cryptographique conforme aux modules modernes (PS7+).
Affiche l'entropie, copie dans le presse-papier,
et efface automatiquement après 40 secondes (sauf options NoClipboard/NoClear).

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -LettresParMot
{{ Fill LettresParMot Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 6
Accept pipeline input: False
Accept wildcard characters: False
```

### -MotsParBloc
{{ Fill MotsParBloc Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 6
Accept pipeline input: False
Accept wildcard characters: False
```

### -Separateur
{{ Fill Separateur Description }}

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
{{ Fill Charset Description }}

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
{{ Fill NoClipboard Description }}

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
