function Private-ValidatePassphrase {
    [CmdletBinding()]
    param(
        [int]$Words,
        [int]$Letters,
        [int]$MinWords = 7,
        [int]$MinTotalLength = 30
    )

    if ($Words -lt 1 -or $LettersPerWord -lt 1) {
        throw "Words et LettersPerWord doivent être ≥ 1."
    }

    $totalLength = $Words * $LettersPerWord

    if ($totalLength -lt $MinTotalLength) {
        throw "La passphrase doit contenir au moins $MinTotalLength caractères (ANSSI/CNIL). Longueur actuelle : $totalLength."
    }

    if ($Words -lt $MinWords) {
        throw "La passphrase doit contenir au moins $MinWords mots (ANSSI/CNIL). Mots actuels : $Words."
    }

    return $true
}