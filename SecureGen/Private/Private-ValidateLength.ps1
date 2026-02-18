function Private-ValidateLength {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Length,

        [Parameter(Mandatory)]
        [int]$Min,

        [Parameter(Mandatory)]
        [int]$Max
    )

    if ($Length -lt $Min -or $Length -gt $Max) {
        throw "La longueur spécifiée ($Length) est invalide. Elle doit être comprise entre $Min et $Max."
    }
}