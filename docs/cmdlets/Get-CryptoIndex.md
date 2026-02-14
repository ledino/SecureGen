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
`Get-CryptoIndex` retourne un entier pseudo‑aléatoire **cryptographiquement sûr**, compris entre `0` et `Max - 1`.

Ce cmdlet constitue la **brique de base** utilisée par SecureGen pour garantir :

- une distribution uniforme  
- une entropie maximale  
- l’absence de biais dans les tirages  
- une compatibilité totale PS7 / PS5.1  

Il est utilisé en interne par :

- `Get-PassWord`  
- `Get-PassPhrase`  
- `Get-PKIPass`  

### 🔐 Source d’aléa selon la version PowerShell

- **PowerShell 7+**  
  Utilise `Get-SecureRandom` (NIST SP 800‑90), via `.NET 6+`.

- **PowerShell 5.1**  
  Utilise `System.Security.Cryptography.RandomNumberGenerator`  
  (fallback sécurisé du .NET Framework).

Aucune implémentation maison n’est utilisée.

---

## EXAMPLES

### EXAMPLE 1
Générer un index entre 0 et 9 :

```powershell
Get-CryptoIndex -Max 10
```

### EXAMPLE 2
Sélectionner un élément dans un tableau :

```powershell
$items = "alpha","beta","gamma","delta"
$index = Get-CryptoIndex -Max $items.Count
$items[$index]
```

### EXAMPLE 3
Tirage sécurisé (ex. lancer de dé) :

```powershell
1..6 | ForEach-Object { Get-CryptoIndex -Max 6 }
```

---

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

---

## INPUTS
Aucune entrée.

## OUTPUTS

### System.Int32
Un entier aléatoire cryptographiquement sûr.

---

## NOTES
- Utilise automatiquement la meilleure source d’aléa selon la version de PowerShell.  
- Fonction interne utilisée par les autres cmdlets SecureGen.  
- Compatible Windows, Linux, macOS.  
- Entièrement déterministe du point de vue API (mais non prédictible).  

---

## RELATED LINKS
Get-PassWord  
Get-PassPhrase  
Get-PKIPass  

---
