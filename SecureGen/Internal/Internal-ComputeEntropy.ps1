function Internal-ComputeEntropy {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$SymbolCount,

        [Parameter(Mandatory)]
        [int]$CharsetSize
    )

    # Entropie = N * log2(|charset|)
    return [math]::Round($SymbolCount * [math]::Log($CharsetSize, 2))
}
