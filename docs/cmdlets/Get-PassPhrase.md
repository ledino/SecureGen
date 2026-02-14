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
Get-PassPhrase [-Words <Int32>] [-Len <Int32>] [-NoClipboard] [-NoClear] [-Silent] [<CommonParameters>]
```

## DESCRIPTION
Get-PassPhrase génère une passphrase robuste et lisible, composée de plusieurs mots
aléatoires de longueur fixe.  
Contrairement à un mot de passe classique, une passphrase est :

- plus longue  
- plus facile à lire  
- plus simple à taper  
- extrêmement robuste grâce à son entropie élevée  

La génération utilise un générateur cryptographique sécurisé via `Get-CryptoIndex`.

La passphrase peut être automatiquement copiée dans le presse‑papier, puis effacée
après un délai sécurisé.

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
Get-PassPhrase -Silent -NoClipboard
```
Génère une passphrase sans bip et sans copie dans le presse‑papier.

## PARAMETERS

### -Words
Nombre de mots à générer.  
Valeur par défaut : 6.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: 6
Accept pipeline input: False
Accept wildcard characters: False
```

### -Len
Longueur de chaque mot.  
Valeur par défaut : 6.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: 6
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
Retourne la passphrase générée.

## NOTES
- Compatible Windows, Linux, macOS.  
- Utilise `Get-CryptoIndex` pour garantir une distribution uniforme.  
- Le presse‑papier utilise automatiquement la meilleure méthode selon la plateforme.  
- L’entropie dépend du nombre de mots, de leur longueur et du charset utilisé.  
- Conçue pour être lisible, mémorisable et extrêmement robuste.

## RELATED LINKS
Get-PassWord  
Get-PKIPass  
Set-ClipboardSafe  
Clear-ClipboardSafe  

---