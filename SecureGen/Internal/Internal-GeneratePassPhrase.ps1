function Internal-GeneratePassPhrase {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Words,

        [Parameter(Mandatory)]
        [int]$Letters,

        [Parameter(Mandatory)]
        [string]$Separator,

        # Options d’enrichissement du charset
        [switch]$Uppercase,
        [switch]$Digits,

        # Options d’affichage / clipboard
        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # --- 1) Validation ANSSI/CNIL ---
    $valid = Private-ValidatePassphrase -Words $Words -Letters $Letters

    # --- 2) Fallback robuste si validation échoue ---
    if (-not $valid) {
        $Words     = 7
        $Letters   = 6
        $Separator = '-'
        $Uppercase = $false
        $Digits    = $false
    }

    # --- 3) Construction du charset final ---
    $charset = 'abcdefghijklmnopqrstuvwxyz'

    if ($Uppercase) {
        $charset += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    }

    if ($Digits) {
        $charset += '0123456789'
    }

    # --- 4) Génération de la passphrase ---
    $bloc = @()
    for ($i = 0; $i -lt $Words; $i++) {
        $word = Internal-RandomString -Length $Letters -Charset $charset
        $bloc += $word
    }

    $phrase = ($bloc -join $Separator)

    # --- 5) Calcul entropie ---
    $symbolCount = $Words * $Letters
    $entropy = Internal-ComputeEntropy `
        -SymbolCount $symbolCount `
        -CharsetSize $charset.Length

    # --- 6) Source d'aléa ---
    $alea = Internal-GetAleaSource

    # --- 7) Affichage factorisé ---
    Internal-DisplaySecret `
        -Secret $phrase `
        -Entropy $entropy `
        -AleaSource $alea `
        -Type 'Passphrase' `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    # --- 8) Gestion du cycle du presse-papier ---
    Internal-HandleClipboardLifecycle `
        -Secret $phrase `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    if ($Silent) { return $phrase }
    return
}