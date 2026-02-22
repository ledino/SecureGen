function Get-PassWord {

    [CmdletBinding()]
    param(
        [int]$Length = 20,
        [string]$SpecialChars = '!@#$%^&*()_+-=[]{}<>/\|;~',

        [switch]$NoSpecial,
        [switch]$RequireAllTypes,

        [switch]$NoClipboard,
        [switch]$NoClear,

        [switch]$Quiet,
        [switch]$Raw,
        [switch]$Silent,

        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$UnknownOptions
    )

    # --- Validation centralisée ---
    if (-not (Internal-ValidateInput -Mode 'Password' @PSBoundParameters)) {
        return
    }

    $UseSpecial = -not $NoSpecial

    # --- Pipeline mode ---
    if ($Raw -or $Quiet -or $Silent) {

        return Internal-GeneratePassword `
            -Length $Length `
            -SpecialChars $SpecialChars `
            -UseSpecial:$UseSpecial `
            -RequireAllTypes:$RequireAllTypes `
            -Silent `
            -NoClipboard `
            -NoClear
    }

    # --- Mode normal ---
    Internal-GeneratePassword `
        -Length $Length `
        -SpecialChars $SpecialChars `
        -UseSpecial:$UseSpecial `
        -RequireAllTypes:$RequireAllTypes `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear | Out-Null

    return
}