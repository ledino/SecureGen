---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PassPhrase

## SYNOPSIS
Génère une passphrase sécurisée composée de plusieurs mots aléatoires.

## SYNTAX

```
Get-PassPhrase [-Len <Int32>] [-Words <Int32>] [-Separator <String>]
               [-Charset <String>] [-NoClipboard] [-NoClear] [-Silent]
               [<CommonParameters>]
```

## DESCRIPTION
Get-PassPhrase génère une passphrase robuste et lisible, composée de plusieurs mots
aléatoires de longueur fixe.  
La génération utilise un générateur cryptographique sécurisé via `Get-CryptoIndex`.

La passphrase peut être automatiquement copiée dans le presse‑papier, puis effacée
après un délai sécurisé.  
Le mode `-Silent` permet de récupérer uniquement la valeur, sans affichage.

### Alias disponibles
- `-Len` : `Length`, `Lenght`
- `-Words` : `WordsCount`, `NbWords`

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
Génère une passphrase standard composée de 6 mots de 6 caractères.

### EXAMPLE 2
```
Get-PassPhrase -Words 8 -Len 7
```
Génère une passphrase plus longue : 8 mots de 7 caractères chacun.

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

### -Len
Longueur de chaque mot.  
Alias : `Length`, `Lenght`  
Valeur par défaut : 6.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Length, Lenght
Required: False
Position: Named
Default value: 6
Accept pipeline input: False
Accept wildcard characters: False
```

### -Words
Nombre de mots à générer.  
Alias : `WordsCount`, `NbWords`  
Valeur par défaut : 6.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: WordsCount, NbWords
Required: False
Position: Named
Default value: 6
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
Désactive l’affichage et le bip, mais conserve la copie dans le presse‑papier.

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
- L’entropie est affichée sauf en mode `-Silent`.  
- Fonction centrale du module SecureGen.

## RELATED LINKS
Get-PassWord  
Get-PKIPass  
Set-ClipboardSafe  
Clear-ClipboardSafe  

---
