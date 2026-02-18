function Internal-GeneratePassPhrase {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Words,

        [Parameter(Mandatory)]
        [int]$Letters,

        [Parameter(Mandatory)]
        [string]$Separator,

        [Parameter(Mandatory)]
        [string]$Charset,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # --- Validation ANSSI/CNIL ---
    $valid = Private-ValidatePassphrase -Words $Words -Letters $Letters

    # --- Fallback robuste si validation échoue ---
    if (-not $valid) {
        $Words   = 6
        $Letters = 6
    }

    # --- Génération de la passphrase ---
    $phrase = Internal-RandomPassPhrase `
        -Words $Words `
        -Letters $Letters `
        -Charset $Charset `
        -Separator $Separator

    # --- Calcul entropie ---
    $symbolCount = $Words * $Letters
    $entropy = Internal-ComputeEntropy `
        -SymbolCount $symbolCount `
        -CharsetSize $Charset.Length

    # --- Source d'aléa ---
    $alea = Internal-GetAleaSource

    # --- Affichage factorisé ---
    Internal-DisplaySecret `
        -Secret $phrase `
        -Entropy $entropy `
        -AleaSource $alea `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    # --- Gestion du cycle du presse-papier ---
    Internal-HandleClipboardLifecycle `
        -Secret $phrase `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent

    return $phrase
}
