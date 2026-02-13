---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-CryptoIndex

## SYNOPSIS
Génère un entier aléatoire cryptographiquement sûr dans l’intervalle `[0 .. Max-1]`.

## SYNTAX

```
Get-CryptoIndex [[-Max] <Int32>]
```

## DESCRIPTION
`Get-CryptoIndex` retourne un entier pseudo‑aléatoire sécurisé compris entre `0` et `Max - 1`.

Le générateur utilisé dépend de la version de PowerShell :

- **PS7+** : `Get-SecureRandom` (conforme NIST SP 800‑90)
- **PS5.1** : RNG .NET Framework (`System.Security.Cryptography.RandomNumberGenerator`)

Ce cmdlet est utilisé en interne par SecureGen pour garantir une distribution uniforme et une entropie maximale lors de la génération de mots de passe, passphrases ou sélections aléatoires.

## EXAMPLES

### EXAMPLE 1
Générer un index entre 0 et 9 :

```powershell
Get-CryptoIndex -Max 10
```

### EXAMPLE 2
Générer un index pour sélectionner un élément dans un tableau :

```powershell
$items = "alpha","beta","gamma","delta"
$index = Get-CryptoIndex -Max $items.Count
$items[$index]
```

### EXAMPLE 3
Générer un index pour un tirage sécurisé :

```powershell
1..6 | ForEach-Object { Get-CryptoIndex -Max 6 }
```

## PARAMETERS

### -Max
Valeur maximale (exclusive).  
Le résultat sera compris entre `0` et `Max - 1`.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

> **Note :** Si `-Max` vaut `0` ou une valeur négative, une exception est levée.

## INPUTS
Aucune entrée.

## OUTPUTS
`System.Int32`  
Un entier aléatoire cryptographiquement sûr.

## NOTES
- Utilise automatiquement la meilleure source d’aléa selon la version de PowerShell.  
- Peut être utilisé pour des tirages, sélections aléatoires, index de tableaux, etc.  
- Fonction interne utilisée par d’autres cmdlets SecureGen.

## RELATED LINKS
https://github.com/ledino/SecureGen

---
