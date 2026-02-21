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

    # Modes pipeline (Raw / Quiet / Silent)
    if ($Raw -or $Quiet -or $Silent) {

        return Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$Uppercase `
            -Digits:$Digits `
            -Silent `
            -NoClipboard `
            -NoClear
    }

    # Mode NORMAL → UX complète
    Internal-GeneratePassPhrase `
        -Words $Words `
        -Letters $Letters `
        -Separator $Separator `
        -Uppercase:$Uppercase `
        -Digits:$Digits `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear | Out-Null

    return
}