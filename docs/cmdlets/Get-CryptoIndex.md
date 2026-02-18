---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-CryptoIndex

## SYNOPSIS
Génère un entier aléatoire cryptographiquement sûr dans l'intervalle \[0 ..
Max-1\].

## SYNTAX

```
Get-CryptoIndex [[-Max] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get-CryptoIndex retourne un entier pseudo-aléatoire sécurisé compris entre 0 et Max - 1.

Le générateur utilisé dépend de la version de PowerShell :
- Sous PowerShell 7+, l'aléa provient de Get-SecureRandom (conforme NIST SP 800-90).
- Sous PowerShell 5.1, l'aléa provient de RNG .NET Framework (RandomNumberGenerator).

Ce cmdlet est utilisé en interne par SecureGen pour garantir une distribution uniforme
et une entropie maximale lors de la génération de mots de passe, passphrases ou sélections aléatoires.

## EXAMPLES

### EXAMPLE 1
```
Get-CryptoIndex -Max 10
Génère un index compris entre 0 et 9.
```

### EXAMPLE 2
```
$items = "alpha","beta","gamma","delta"
$index = Get-CryptoIndex -Max $items.Count
$items[$index]
Sélectionne un élément aléatoire dans un tableau.
```

### EXAMPLE 3
```
1..6 | ForEach-Object { Get-CryptoIndex -Max 6 }
Génère plusieurs tirages sécurisés.
```

## PARAMETERS

### -Max
Valeur maximale (exclusive).
 
Le résultat sera compris entre 0 et Max - 1.
 
Une exception est levée si Max est inférieur ou égal à 0.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 100
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

### System.Int32  
### Retourne un entier aléatoire cryptographiquement sûr.
## NOTES
Compatible Windows, Linux, macOS.
 
Utilisé en interne par les autres cmdlets SecureGen.
 
Garantit une distribution uniforme même pour des valeurs de Max non puissances de 2.

## RELATED LINKS
