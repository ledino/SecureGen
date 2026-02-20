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

    # Détermine si on utilise les caractères spéciaux
    $UseSpecial = -not $NoSpecial

    # MODE RAW → retourne uniquement la chaîne
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

    # MODE QUIET → retourne uniquement la chaîne
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

    # MODE SILENT → retourne uniquement la chaîne
    if ($Silent) {
        return (Internal-GeneratePassword `
            -Length $Length `
            -SpecialChars $SpecialChars `
            -UseSpecial:$UseSpecial `
            -RequireAllTypes:$RequireAllTypes `
            -Silent `
            -NoClipboard `
            -NoClear)
    }

    # MODE NORMAL → UX complète
    return Internal-GeneratePassword `
        -Length $Length `
        -SpecialChars $SpecialChars `
        -UseSpecial:$UseSpecial `
        -RequireAllTypes:$RequireAllTypes `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent
}