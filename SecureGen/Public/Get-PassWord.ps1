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
        [switch]$Silent
    )

    # Tous les caractères par défaut, sauf si -NoSpecial est présent
    $UseSpecial = -not $NoSpecial

    if ($Raw) {
    return (Internal-GeneratePassword `
        -Length $Length `
        -SpecialChars $SpecialChars `
        -UseSpecial:$UseSpecial `
        -RequireAllTypes:$RequireAllTypes `
        -Silent `
        -NoClipboard `
        -NoClear)
    }

    if ($Quiet) {
    $secret = Internal-GeneratePassword `
        -Length $Length `
        -SpecialChars $SpecialChars `
        -UseSpecial:$UseSpecial `
        -RequireAllTypes:$RequireAllTypes `
        -Silent `
        -NoClipboard `
        -NoClear

    return $secret
    }

    return Internal-GeneratePassword `
        -Length $Length `
        -SpecialChars $SpecialChars `
        -UseSpecial:$UseSpecial `
        -RequireAllTypes:$RequireAllTypes `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent
}