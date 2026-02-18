---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Invoke-Beep

## SYNOPSIS
Émet un bip sonore compatible Windows, Linux et macOS.

## SYNTAX

```
Invoke-Beep [[-Frequency] <Int32>] [[-Duration] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Invoke-Beep est une fonction utilitaire simple permettant d'émettre un bip sonore.

Elle est utilisée par d'autres cmdlets SecureGen (comme Get-PassWord et Get-PassPhrase)
pour signaler la fin d'une opération, sauf si l'utilisateur active l'option -Silent.

Le comportement dépend de la plateforme :
- Windows : utilise \[Console\]::Beep()
- Linux / macOS : utilise le caractère BEL (\`\a\`) ou une alternative compatible terminal

## EXAMPLES

### EXAMPLE 1
```
Invoke-Beep
Émet un bip standard (800 Hz, 200 ms).
```

### EXAMPLE 2
```
Invoke-Beep -Frequency 1200
Émet un bip plus aigu (1200 Hz).
```

### EXAMPLE 3
```
Invoke-Beep -Duration 500
Émet un bip plus long (500 ms).
```

### EXAMPLE 4
```
Invoke-Beep -Frequency 1000 -Duration 300
Émet un bip personnalisé.
```

## PARAMETERS

### -Frequency
Fréquence du bip en Hertz (Hz).
 
Plus la valeur est élevée, plus le son est aigu.
 
Valeur par défaut : 800.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 1000
Accept pipeline input: False
Accept wildcard characters: False
```

### -Duration
Durée du bip en millisecondes (ms).
 
Valeur par défaut : 200.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 300
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

### None  
### La fonction ne retourne aucune valeur.  
### Elle produit uniquement un signal sonore.
## NOTES
Compatible Windows, Linux, macOS.
 
Utilisé en interne par les autres cmdlets SecureGen.
 
Peut être désactivé via l'option -Silent des autres cmdlets.

## RELATED LINKS
