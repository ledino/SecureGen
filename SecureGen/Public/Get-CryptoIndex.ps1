function Get-CryptoIndex {
<#
.SYNOPSIS
Génère un entier aléatoire cryptographiquement sûr dans l’intervalle [0 .. Max-1].

.DESCRIPTION
Get-CryptoIndex retourne un entier pseudo‑aléatoire sécurisé compris entre 0 et Max - 1.

Le générateur utilisé dépend de la version de PowerShell :
- Sous PowerShell 7+, l’aléa provient de Get-SecureRandom (conforme NIST SP 800‑90).
- Sous PowerShell 5.1, l’aléa provient de RNG .NET Framework (RandomNumberGenerator).

Ce cmdlet est utilisé en interne par SecureGen pour garantir une distribution uniforme
et une entropie maximale lors de la génération de mots de passe, passphrases ou sélections aléatoires.

.EXAMPLE
Get-CryptoIndex -Max 10
Génère un index compris entre 0 et 9.

.EXAMPLE
$items = "alpha","beta","gamma","delta"
$index = Get-CryptoIndex -Max $items.Count
$items[$index]
Sélectionne un élément aléatoire dans un tableau.

.EXAMPLE
1..6 | ForEach-Object { Get-CryptoIndex -Max 6 }
Génère plusieurs tirages sécurisés.

.PARAMETER Max
Valeur maximale (exclusive).  
Le résultat sera compris entre 0 et Max - 1.  
Une exception est levée si Max est inférieur ou égal à 0.

.OUTPUTS
System.Int32  
Retourne un entier aléatoire cryptographiquement sûr.

.NOTES
Compatible Windows, Linux, macOS.  
Utilisé en interne par les autres cmdlets SecureGen.  
Garantit une distribution uniforme même pour des valeurs de Max non puissances de 2.
#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$SymbolCount,

        [Parameter(Mandatory)]
        [int]$CharsetSize
    )

    # Validation minimale
    if ($SymbolCount -lt 1) {
        throw "SymbolCount doit être ≥ 1."
    }

    if ($CharsetSize -lt 2) {
        throw "CharsetSize doit être ≥ 2."
    }

    return Internal-ComputeEntropy -SymbolCount $SymbolCount -CharsetSize $CharsetSize
}
