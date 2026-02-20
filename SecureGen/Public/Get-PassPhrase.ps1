function Get-PassPhrase {
    [CmdletBinding()]
    param(
        [int]$Words = 7,
        [int]$Letters = 6,
        [string]$Separator = '-',

        [switch]$Uppercase,
        [switch]$Digits,

        [switch]$NoClipboard,
        [switch]$NoClear,

        [switch]$Quiet,
        [switch]$Raw,
        [switch]$Silent
    )

    # --- Modes prioritaires ---
    if ($Raw -or $Quiet -or $Silent) {
        return Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$Uppercase `
            -Digits:$Digits `
            -Silent `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear
    }

    # --- Mode normal ---
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