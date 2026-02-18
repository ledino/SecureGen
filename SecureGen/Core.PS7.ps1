function Internal-GetSecureRandomInt {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Max
    )

    if ($Max -le 0) {
        throw "Max doit être strictement supérieur à 0."
    }

    # PS7 : conforme NIST SP 800-90
    return Get-SecureRandom -Maximum $Max
}