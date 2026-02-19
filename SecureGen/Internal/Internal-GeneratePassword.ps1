function Internal-GeneratePassword {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Length,

        [Parameter(Mandatory)]
        [string]$SpecialChars,

        [bool]$UseSpecial = $true,
        [switch]$RequireAllTypes,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # --- 1) Validation de la longueur ---
    $valid = Private-ValidateLength -Length $Length -Min 16 -Max 256

    if (-not $valid) {
        if ($Length -lt 16) { $Length = 16 }
        if ($Length -gt 256) { $Length = 256 }
    }

    # --- 2) Validation des caractères spéciaux ---
    if ($UseSpecial) {
        Private-ValidateCharset -Charset $SpecialChars -Separator '-'
    }

    # --- 3) Construction du charset final ---
    $Lower  = 'abcdefghijklmnopqrstuvwxyz'
    $Upper  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $Digits = '0123456789'

    $Charset = $Lower + $Upper + $Digits

    if ($UseSpecial) {
        $Charset += $SpecialChars
    }

    # --- 4) Génération du mot de passe ---
    if (-not $RequireAllTypes) {
        $password = Internal-RandomString -Length $Length -Charset $Charset
    }
    else {
        do {
            $password = Internal-RandomString -Length $Length -Charset $Charset

            $hasLower   = $password -match '[a-z]'
            $hasUpper   = $password -match '[A-Z]'
            $hasDigit   = $password -match '\d'
            $hasSpecial = $UseSpecial ? ($password -match "[$SpecialChars]") : $true

        } while (-not ($hasLower -and $hasUpper -and $hasDigit -and $hasSpecial))
    }

    # --- 5) Calcul entropie ---
    $entropy = Internal-ComputeEntropy `
        -SymbolCount $Length `
        -CharsetSize $Charset.Length

    # --- 6) Source d'aléa ---
    $alea = Internal-GetAleaSource

    # --- 7) Affichage ---
    Internal-DisplaySecret `
        -Secret $password `
        -Entropy $entropy `
        -AleaSource $alea `
        -Type 'Password' `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    # --- 8) Clipboard ---
    Internal-HandleClipboardLifecycle `
        -Secret $password `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    if ($Silent) { return $password }
    return
}