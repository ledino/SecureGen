function Internal-GeneratePassPhrase {
    [CmdletBinding()]
    param(
        [int]$Words,
        [int]$Letters,
        [string]$Separator,

        [switch]$Uppercase,
        [switch]$Digits,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # --- 1) Validation ---
    $valid = Private-ValidatePassphrase `
        -Words $Words `
        -Letters $Letters `
        -Separator $Separator

    if (-not $valid) {
        $Words     = 7
        $Letters   = 6
        $Separator = '-'
    }

    # --- 2) Charset ---
    $charset = 'abcdefghijklmnopqrstuvwxyz'
    if ($Uppercase) { $charset += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' }
    if ($Digits)    { $charset += '0123456789' }

    # --- 3) Génération ---
    $bloc = @()
    for ($i = 0; $i -lt $Words; $i++) {
        $bloc += (Internal-RandomString -Length $Letters -Charset $charset)
    }

    $phrase = ($bloc -join $Separator)

    # --- 4) Entropie ---
    $entropy = Internal-ComputeEntropy `
        -SymbolCount ($Words * $Letters) `
        -CharsetSize $charset.Length

    # --- 5) Source d’aléa ---
    $alea = Internal-GetAleaSource

    # --- 6) UX (désactivée si Silent) ---
    if (-not $Silent) {
        Internal-DisplaySecret `
            -Secret $phrase `
            -Entropy $entropy `
            -AleaSource $alea `
            -Type 'Passphrase' `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear `
            -Silent:$Silent
    }
    # --- 7) Clipboard (désactivé si Silent) ---
    if (-not $Silent) {
        Internal-HandleClipboardLifecycle `
            -Secret $phrase `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear `
            -Silent:$Silent
    }

    # --- 8) Retour pipeline ---
    if ($Silent) {
        return $phrase
    }

    return
}