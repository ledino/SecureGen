# Retourne un entier aléatoire [0..Max-1] en choisissant le bon backend.
function Internal-GetCryptoIndex {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Max
    )

    if ($PSVersionTable.PSVersion.Major -ge 7) {
        return Internal-GetSecureRandomInt -Max $Max
    }
    else {
        return Internal-GetLegacyRandomInt -Max $Max
    }
}

function Internal-RandomString {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Length,

        [Parameter(Mandatory)]
        [string]$Charset
    )

    # Génération simple d'une chaîne aléatoire
    $chars = New-Object System.Text.StringBuilder
    for ($i = 0; $i -lt $Length; $i++) {
        $idx = Internal-GetCryptoIndex -Max $Charset.Length
        [void]$chars.Append($Charset[$idx])
    }

    return $chars.ToString()
}
