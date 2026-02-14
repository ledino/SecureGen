---
external help file: SecureGen-help.xml
Module Name: SecureGen
online version:
schema: 2.0.0
---

# Get-PassWord

## SYNOPSIS
Génère un mot de passe sécurisé, configurable et compatible Windows, Linux et macOS.

## SYNTAX

```
Get-PassWord [-Len <Int32>] [-SpecialChars <String>] [-UseSpecial <Boolean>]
             [-RequireAllTypes <Boolean>] [-NoClipboard] [-NoClear] [-Silent]
             [<CommonParameters>]
```

## DESCRIPTION
Get-PassWord génère un mot de passe robuste en utilisant un générateur cryptographique sécurisé.

### 🔐 Source d’aléa selon la version de PowerShell

- **PowerShell 7+**  
  Utilise `Get-SecureRandom`, conforme aux recommandations modernes (NIST SP 800‑90).  
  Distribution uniforme, génération cryptographiquement forte.

- **PowerShell 5.1**  
  Utilise `RandomNumberGenerator` (.NET Framework).  
  Cryptographiquement sûr, mais non conforme aux modules cryptographiques modernes.

### 🔤 Composition du mot de passe
Le mot de passe peut inclure :
- minuscules  
- majuscules  
- chiffres  
- caractères spéciaux (personnalisables)

### 🎛️ Options avancées
- `-RequireAllTypes` : impose la présence d’au moins une occurrence de chaque catégorie  
- `-UseSpecial:$false` : désactive les caractères spéciaux  
- `-NoClipboard` : désactive la copie automatique  
- `-NoClear` : empêche l’effacement automatique du presse‑papier  
- `-Silent` : désactive le bip de confirmation  

### 🔢 Entropie
L’entropie est calculée automatiquement :

```
entropy = Len × log2(|charset|)
```

Elle est affichée après génération.

## EXAMPLES

### EXAMPLE 1
```
Get-PassWord
```
Génère un mot de passe sécurisé de 20 caractères.

### EXAMPLE 2
```
Get-PassWord -Len 32 -RequireAllTypes
```
Génère un mot de passe long contenant obligatoirement :
- une minuscule  
- une majuscule  
- un chiffre  
- un caractère spécial  

### EXAMPLE 3
```
Get-PassWord -UseSpecial:$false
```
Génère un mot de passe alphanumérique uniquement.

### EXAMPLE 4
```
Get-PassWord -Silent -NoClipboard
```
Génère un mot de passe sans bip et sans copie dans le presse‑papier.

## PARAMETERS

### -Len
Longueur du mot de passe à générer.  
Valeur par défaut : 20.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: 20
Accept pipeline input: False
Accept wildcard characters: False
```

### -SpecialChars
Liste personnalisée de caractères spéciaux à utiliser.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: [!@#$%^&*()_+\-=\[\]{}<>\/\\|;~]
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSpecial
Active ou désactive l’utilisation de caractères spéciaux.  
Valeur par défaut : True.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequireAllTypes
Exige que le mot de passe contienne au moins :
- une minuscule  
- une majuscule  
- un chiffre  
- un caractère spécial (si `-UseSpecial` est activé)

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: False
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
Retourne le mot de passe généré.

## NOTES
- Compatible Windows, Linux, macOS.  
- Utilise `Get-SecureRandom` sous PS7+ et `RandomNumberGenerator` sous PS5.1.  
- Le presse‑papier utilise automatiquement la meilleure méthode selon la plateforme.  
- L’entropie est calculée en bits.  
- Fonction centrale du module SecureGen.

## RELATED LINKS
Get-PassPhrase  
Get-PKIPass  
Set-ClipboardSafe  
Clear-ClipboardSafe  

---