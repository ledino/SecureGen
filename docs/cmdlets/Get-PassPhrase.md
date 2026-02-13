---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PassPhrase

## SYNOPSIS
Génère une passphrase robuste, lisible et configurable, compatible Windows / Linux / macOS.

## SYNTAX

```
Get-PassPhrase [[-LettresParMot] <Int32>] [[-MotsParBloc] <Int32>] [[-Separateur] <String>] [[-Charset] <String>] [-NoClipboard] [-NoClear] [-Silent]
```

## DESCRIPTION
`Get-PassPhrase` génère une passphrase composée de blocs de mots pseudo‑aléatoires, construits caractère par caractère via un générateur cryptographique sécurisé :

- **PS7+** : `Get-SecureRandom` (conforme NIST SP 800‑90)
- **PS5.1** : RNG .NET Framework (cryptographiquement sûr)

La passphrase est :

- lisible  
- régulière  
- hautement entropique  
- idéale pour un usage quotidien ou professionnel  

Par défaut, SecureGen :

- copie la passphrase dans le presse‑papier  
- efface automatiquement le presse‑papier après un délai sécurisé  
- émet un beep discret (désactivable)

Vous pouvez personnaliser :

- le nombre de lettres par mot (`-LettresParMot`)
- le nombre de mots par bloc (`-MotsParBloc`)
- le séparateur (`-Separateur`)
- le charset utilisé (`-Charset`)
- le comportement du presse‑papier (`-NoClipboard`, `-NoClear`)
- le beep (`-Silent`)

## EXAMPLES

### EXAMPLE 1
Générer une passphrase standard (6 mots de 6 lettres) :

```powershell
Get-PassPhrase
```

### EXAMPLE 2
Passphrase longue (7 mots de 5 lettres) :

```powershell
Get-PassPhrase -LettresParMot 5 -MotsParBloc 7
```

### EXAMPLE 3
Passphrase sans caractères spéciaux, uniquement lettres :

```powershell
Get-PassPhrase -Charset 'abcdefghijklmnopqrstuvwxyz'
```

### EXAMPLE 4
Passphrase silencieuse (pas de beep) :

```powershell
Get-PassPhrase -Silent
```

### EXAMPLE 5
Passphrase sans clipboard :

```powershell
Get-PassPhrase -NoClipboard
```

## PARAMETERS

### -LettresParMot
Nombre de lettres par mot généré.

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
Nombre de mots composant la passphrase.

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
Caractère ou chaîne utilisée pour séparer les mots.

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
Ensemble de caractères utilisés pour générer les mots.

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
Empêche la copie automatique de la passphrase dans le presse‑papier.

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
La passphrase générée.

## NOTES
- Compatible Windows, Linux, macOS  
- PS7 utilise `Get-SecureRandom`  
- PS5.1 utilise RNG .NET Framework  
- Le clipboard utilise automatiquement la meilleure méthode disponible selon la plateforme  
- Le séparateur peut être un caractère ou une chaîne complète  

## RELATED LINKS
https://github.com/ledino/SecureGen

---
