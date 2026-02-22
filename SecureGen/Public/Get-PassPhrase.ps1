function Get-PassPhrase {

    [CmdletBinding()]
    param(
        [int]$Words = 7,
        [int]$Letters = 6,
        [string]$Separator = '-',

        [switch]$UpperCase,
        [switch]$Digits,

        [switch]$NoClipboard,
        [switch]$NoClear,

        [switch]$Quiet,
        [switch]$Raw,
        [switch]$Silent,

        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$UnknownOptions
    )

    # --- Validation centralisée ---
    if (-not (Internal-ValidateInput -Mode 'Passphrase' @PSBoundParameters)) {
        return
    }

    # --- Pipeline mode ---
    if ($Raw -or $Quiet -or $Silent) {

        return Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$UpperCase `
            -Digits:$Digits `
            -Silent `
            -NoClipboard `
            -NoClear
    }

    # --- Mode normal ---
    Internal-GeneratePassPhrase `
        -Words $Words `
        -Letters $Letters `
        -Separator $Separator `
        -Uppercase:$UpperCase `
        -Digits:$Digits `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear | Out-Null

    return
}