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

    # --- Validation ---
    Private-ValidateLength -Length $Length -Min 16 -Max 256

    # --- Définition des catégories ---
    $Lower  = 'abcdefghijklmnopqrstuvwxyz'
    $Upper  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $Digits = '0123456789'

    # ⚠️ SpecialChars doit être une liste brute, pas une regex
    # Exemple recommandé : '!@#$%^&*()_+-=[]{}<>/\|;~'
    $Charset = $Lower + $Upper + $Digits
    if ($UseSpecial) {
        $Charset += $SpecialChars
    }

    # --- Génération du mot de passe ---
    if (-not $RequireAllTypes) {
        $password = Internal-RandomString -Length $Length -Charset $Charset
    }
    else {
        do {
            $password = Internal-RandomString -Length $Length -Charset $Charset

            $hasLower   = $password -match '[a-z]'
            $hasUpper   = $password -match '[A-Z]'
            $hasDigit   = $password -match '\d'
            $hasSpecial = $password -match "[$SpecialChars]"

            # Si UseSpecial = $false → on n’exige PAS de caractère spécial
            $requireSpecial = $UseSpecial ? $hasSpecial : $true

        } while (-not ($hasLower -and $hasUpper -and $hasDigit -and $requireSpecial))
    }

    # --- Calcul entropie ---
    $entropy = Internal-ComputeEntropy `
        -SymbolCount $Length `
        -CharsetSize $Charset.Length

    # --- Source d'aléa ---
    $alea = Internal-GetAleaSource

    # --- Affichage factorisé ---
    Internal-DisplaySecret `
        -Secret $password `
        -Entropy $entropy `
        -AleaSource $alea `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    # --- Gestion du cycle du presse-papier ---
    Internal-HandleClipboardLifecycle `
        -Secret $password `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    return $password
}
