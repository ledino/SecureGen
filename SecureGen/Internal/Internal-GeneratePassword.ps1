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
    Private-ValidateLength -Length $Length -Min 16 -Max 256

    # --- 2) Validation des caractères spéciaux (si utilisés) ---
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

        # Génération simple
        $password = Internal-RandomString -Length $Length -Charset $Charset
    }
    else {

        # Génération stricte : toutes les classes doivent apparaître
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

    # --- 7) Affichage factorisé ---
    Internal-DisplaySecret `
        -Secret $password `
        -Entropy $entropy `
        -AleaSource $alea `
        -Type 'Password' `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    # --- 8) Gestion du cycle du presse-papier ---
    Internal-HandleClipboardLifecycle `
        -Secret $password `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    if ($Silent) { return $password }
    return
}