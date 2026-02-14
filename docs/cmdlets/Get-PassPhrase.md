---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PassPhrase

## SYNOPSIS
Génère une passphrase robuste, lisible et hautement entropique, composée de plusieurs mots aléatoires.

## SYNTAX

```
Get-PassPhrase [-Words <Int32>] [-Len <Int32>] [-Separator <String>]
               [-Charset <String>] [-NoClipboard] [-Silent]
               [<CommonParameters>]
```

## DESCRIPTION
`Get-PassPhrase` génère une passphrase sécurisée composée de plusieurs mots aléatoires de longueur fixe.

Elle est idéale pour :

- les comptes utilisateurs  
- les clés API  
- les secrets d’automatisation  
- les usages professionnels nécessitant lisibilité + sécurité  

La génération utilise un générateur cryptographique sécurisé via `Get-CryptoIndex`.

La passphrase peut être automatiquement copiée dans le presse‑papier, puis effacée après un délai sécurisé.  
Le mode `-Silent` supprime l’affichage et le beep.

### Valeurs par défaut
- `Words` : **5**  
- `Len` : **5**  
- `Separator` : `-`

### Alias disponibles
- `Words` : `WordsCount`, `NbWords`
- `Len` : `Length`

### Entropie
L’entropie est calculée selon :

```
entropy = Words × Len × log2(|Charset|)
```

Elle est affichée automatiquement (sauf en mode `-Silent`).

## EXAMPLES

### EXAMPLE 1
```
Get-PassPhrase
```
Génère une passphrase standard composée de 5 mots de 5 lettres.

### EXAMPLE 2
```
Get-PassPhrase -Words 8 -Len 7
```
Génère une passphrase longue (8 mots × 7 lettres).

### EXAMPLE 3
```
Get-PassPhrase -Separator ' ' -Words 4 -Len 5
```
Génère une passphrase avec des espaces comme séparateur.

### EXAMPLE 4
```
Get-PassPhrase -Silent -NoClipboard
```
Génère une passphrase sans affichage et sans copie dans le presse‑papier.

## PARAMETERS

### -Words
Nombre de mots à générer.  
Valeur par défaut : 5.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: WordsCount, NbWords
Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -Len
Longueur de chaque mot.  
Valeur par défaut : 5.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Length
Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -Separator
Caractère utilisé pour séparer les mots.  
Valeur par défaut : `-`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: -
Accept pipeline input: False
Accept wildcard characters: False
```

### -Charset
Jeu de caractères utilisé pour générer les mots.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
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

### -Silent
Désactive l’affichage et le beep.

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

## OUTPUTS

### System.String
Retourne la passphrase générée.

## NOTES
- Compatible Windows, Linux, macOS.  
- Utilise `Get-CryptoIndex` pour garantir une distribution uniforme.  
- Le presse‑papier utilise automatiquement la meilleure méthode selon la plateforme.  
- Fonction centrale du module SecureGen.  
- Cohérente avec `Get-PKIPass` (mode Passphrase).

## RELATED LINKS
Get-PassWord  
Get-PKIPass  
Set-ClipboardSafe  
Clear-ClipboardSafe  

---
