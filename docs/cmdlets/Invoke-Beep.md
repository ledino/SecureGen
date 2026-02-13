---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Invoke-Beep

## SYNOPSIS
Émet un bip sonore, compatible Windows, Linux et macOS.

## SYNTAX

```
Invoke-Beep [[-Frequency] <Int32>] [[-Duration] <Int32>]
```

## DESCRIPTION
`Invoke-Beep` est une petite fonction utilitaire permettant d’émettre un bip sonore.

Elle est utilisée par d’autres cmdlets SecureGen (comme `Get-PassWord` ou `Get-PassPhrase`) pour signaler la fin d’une opération, sauf si l’utilisateur active l’option `-Silent`.

Le comportement dépend de la plateforme :

- **Windows** : utilise `[Console]::Beep()`  
- **Linux / macOS** : utilise un caractère sonore (`BEL`, `\a`) ou une alternative compatible terminal

## EXAMPLES

### EXAMPLE 1
Émettre un bip standard :

```powershell
Invoke-Beep
```

### EXAMPLE 2
Bip plus aigu (1200 Hz) :

```powershell
Invoke-Beep -Frequency 1200
```

### EXAMPLE 3
Bip plus long (500 ms) :

```powershell
Invoke-Beep -Duration 500
```

### EXAMPLE 4
Bip personnalisé :

```powershell
Invoke-Beep -Frequency 1000 -Duration 300
```

## PARAMETERS

### -Frequency
Fréquence du bip en Hertz (Hz).  
Plus la valeur est élevée, plus le son est aigu.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Required: False
Position: 1
Default value: 800
Accept pipeline input: False
Accept wildcard characters: False
```

### -Duration
Durée du bip en millisecondes (ms).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Required: False
Position: 2
Default value: 200
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS
Aucune entrée.

## OUTPUTS
Aucune sortie.  
Le cmdlet produit uniquement un signal sonore.

## NOTES
- Compatible Windows, Linux, macOS  
- Utilisé en interne par `Get-PassWord` et `Get-PassPhrase`  
- Peut être désactivé via l’option `-Silent` des autres cmdlets  

## RELATED LINKS
https://github.com/ledino/SecureGen

---
