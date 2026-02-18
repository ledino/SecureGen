function Internal-ComputeEntropy {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$SymbolCount,

        [Parameter(Mandatory)]
        [int]$CharsetSize
    )

    return [math]::Round($SymbolCount * [math]::Log($CharsetSize, 2))
}