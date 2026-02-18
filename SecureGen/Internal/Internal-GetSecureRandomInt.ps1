function Internal-GetSecureRandomInt {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Max
    )

    if ($Max -le 0) {
        throw "Max doit être supérieur à 0."
    }

    # PowerShell 7+ : Get-SecureRandom (cryptographiquement sûr)
    if ($PSVersionTable.PSVersion.Major -ge 7) {
        return Get-SecureRandom -Minimum 0 -Maximum $Max
    }

    # PowerShell 5.1 : RandomNumberGenerator (.NET Framework)
    $bytes = New-Object byte[] 4
    [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
    $value = [BitConverter]::ToUInt32($bytes, 0)

    return ($value % $Max)
}