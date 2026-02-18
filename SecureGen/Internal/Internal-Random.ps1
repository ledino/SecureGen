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

function Internal-RandomPassPhrase {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Words,

        [Parameter(Mandatory)]
        [int]$Letters,

        [Parameter(Mandatory)]
        [string]$Charset,

        [Parameter(Mandatory)]
        [string]$Separator
    )

    # Validation unique (pas de double validation)
    $valid = Private-ValidatePassphrase -Words $Words -Letters $Letters

    # Fallback robuste si validation échoue
    if (-not $valid) {
        $Words   = 6
        $Letters = 6
    }

    # Génération
    $bloc = @()
    for ($i = 0; $i -lt $Words; $i++) {
        $word = Internal-RandomString -Length $Letters -Charset $Charset
        $bloc += $word
    }

    return ($bloc -join $Separator)
}
