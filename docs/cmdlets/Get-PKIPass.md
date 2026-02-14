---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PKIPass

## SYNOPSIS
Génère un secret robuste (mot de passe ou passphrase), lisible et conforme aux bonnes pratiques cryptographiques.
(PKI, certificats, clés privées, comptes de service etc.)

## SYNTAX

```
Get-PKIPass [-Len <Int32>] [-NoClipboard] [-NoClear] [-Silent] [<CommonParameters>]
```

## DESCRIPTION
Get-PKIPass génère un mot de passe destiné aux usages PKI (certificats, clés privées, HSM, comptes sensibles).  
Il produit une chaîne aléatoire composée uniquement de caractères **alphanumériques** et **spéciaux sûrs**, garantissant :

- une entropie élevée  
- une compatibilité maximale avec les outils PKI  
- une lisibilité correcte  
- une absence de caractères ambigus  

Le mot de passe peut être automatiquement copié dans le presse‑papier, puis effacé après un délai sécurisé.

## EXAMPLES

### EXAMPLE 1
```
Get-PKIPass
```
Génère un mot de passe PKI standard (32 caractères).

### EXAMPLE 2
```
Get-PKIPass -Len 48
```
Génère un mot de passe PKI long (48 caractères).

### EXAMPLE 3
```
Get-PKIPass -Silent -NoClipboard
```
Génère un mot de passe sans bip et sans copie dans le presse‑papier.

## PARAMETERS

### -Len
Longueur du mot de passe PKI à générer.  
Valeur par défaut : 32.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: 32
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClipboard
Empêche la copie automatique du mot de passe dans le presse‑papier.

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
Désactive le bip de confirmation.

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
Retourne le mot de passe PKI généré.

## NOTES
- Compatible Windows, Linux, macOS.  
- Utilise Get-CryptoIndex pour garantir une distribution uniforme.  
- Le presse‑papier utilise automatiquement la meilleure méthode selon la plateforme.  
- Le mot de passe est conçu pour être compatible avec les outils PKI (OpenSSL, certreq, HSM, etc.).

## RELATED LINKS
Get-PassWord  
Get-PassPhrase  
Get-CryptoIndex  

---

