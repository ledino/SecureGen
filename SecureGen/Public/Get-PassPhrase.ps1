function Get-PassPhrase {
    [CmdletBinding()]
    param(
        # Paramètres de structure
        [int]$Words   = 7,
        [int]$Letters = 6,

        # Séparateur configurable
        [string]$Separator = '-',

        # Options d’enrichissement du charset
        [switch]$Uppercase,
        [switch]$Digits,

        # Options d’affichage / clipboard
        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent,

        # Nouveaux modes
        [switch]$Quiet,
        [switch]$Raw
    )

    # --- Mode RAW : retourne la phrase brute, aucun affichage ---
    if ($Raw) {
        return (Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$Uppercase `
            -Digits:$Digits `
            -Silent `
            -NoClipboard `
            -NoClear)
    }

    # --- Mode QUIET : retourne uniquement la phrase, aucun décor ---
    if ($Quiet) {
        $phrase = Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$Uppercase `
            -Digits:$Digits `
            -Silent `
            -NoClipboard `
            -NoClear

        return $phrase
    }

    # --- Mode SILENT : aucun affichage, retourne la phrase ---
    if ($Silent) {
        return (Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$Uppercase `
            -Digits:$Digits `
            -Silent `
            -NoClipboard `
            -NoClear)
    }

    # --- Mode DEFAULT : UX complète ---
    return Internal-GeneratePassPhrase `
        -Words $Words `
        -Letters $Letters `
        -Separator $Separator `
        -Uppercase:$Uppercase `
        -Digits:$Digits `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent
}