---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PKIPass

## SYNOPSIS
Génère un secret PKI robuste (mot de passe ou passphrase), personnalisable et compatible avec les usages sensibles  
(certificats, clés privées, comptes de service, KMS, automatisation sécurisée).

## SYNTAX

### Password (par défaut)
```
Get-PKIPass [-Type <String>] [-Length <Int32>] [-AsSecureString] [-NoClipboard] [<CommonParameters>]
```

### Passphrase
```
Get-PKIPass -Type Passphrase [-Words <Int32>] [-Len <Int32>] [-AsSecureString] [-NoClipboard] [<CommonParameters>]
```

## DESCRIPTION
`Get-PKIPass` génère un secret hautement entropique destiné aux environnements exigeants :  
PKI, certificats, HSM, comptes de service, automatisation CI/CD, KMS, etc.

Il peut produire :

- un **mot de passe PKI** (32 caractères par défaut)
- une **passphrase PKI** (5 mots × 5 lettres par défaut)
- un **SecureString** pour intégration dans des systèmes sensibles

La fonction est entièrement personnalisable et cohérente avec `Get-PassWord` et `Get-PassPhrase`.

## EXAMPLES

### EXAMPLE 1
```
Get-PKIPass
```
Génère un mot de passe PKI standard (32 caractères).

### EXAMPLE 2
```
Get-PKIPass -Type Passphrase
```
Génère une passphrase PKI (5 mots × 5 lettres).

### EXAMPLE 3
```
Get-PKIPass -Type Password -Length 48
```
Génère un mot de passe PKI long (48 caractères).

### EXAMPLE 4
```
Get-PKIPass -Type Passphrase -Words 8 -Len 10
```
Génère une passphrase personnalisée (8 mots de 10 lettres).

### EXAMPLE 5
```
Get-PKIPass -AsSecureString
```
Retourne le secret sous forme de `SecureString` (KMS, AD, DSC, scripts sensibles).

## PARAMETERS

### -Type
Type de secret à générer :  
- `Password` (par défaut)  
- `Passphrase`

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Password, Passphrase
Required: False
Position: 0
Default value: Password
Accept pipeline input: False
Accept wildcard characters: False
```

### -Length
Longueur du mot de passe PKI (mode Password).  
Valeur par défaut : 32.

```yaml
Type: Int32
Parameter Sets: Password
Aliases:
Required: False
Position: Named
Default value: 32
Accept pipeline input: False
Accept wildcard characters: False
```

### -Words
Nombre de mots dans la passphrase (mode Passphrase).  
Valeur par défaut : 5.

```yaml
Type: Int32
Parameter Sets: Passphrase
Aliases: MotsParBloc, WordsCount, NbWords
Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -Len
Longueur de chaque mot dans la passphrase (mode Passphrase).  
Valeur par défaut : 5.

```yaml
Type: Int32
Parameter Sets: Passphrase
Aliases:
Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsSecureString
Retourne le secret sous forme de `SecureString`.  
Idéal pour les usages PKI, KMS, AD, DSC, automatisation sécurisée.

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
Empêche la copie automatique dans le presse‑papier.

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
Secret PKI généré (mot de passe ou passphrase).

### System.Security.SecureString
Si `-AsSecureString` est utilisé.

## NOTES
- Compatible Windows, Linux, macOS  
- Utilise `Get-PassWord` ou `Get-PassPhrase` selon le mode  
- Retour `SecureString` pour intégration dans des systèmes sensibles  
- Clipboard intelligent (désactivable via `-NoClipboard`)  

## RELATED LINKS
Get-PassWord  
Get-PassPhrase  
Get-CryptoIndex  

---
