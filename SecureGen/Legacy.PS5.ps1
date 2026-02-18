function Internal-GetLegacyRandomInt {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Max
    )

    if ($Max -le 0) {
        throw "Max doit être strictement supérieur à 0."
    }

    $bytes = New-Object byte[] 4
    [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
    $value = [BitConverter]::ToUInt32($bytes, 0)

    return ($value % $Max)
}