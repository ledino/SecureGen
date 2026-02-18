function Get-CryptoIndex {
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
