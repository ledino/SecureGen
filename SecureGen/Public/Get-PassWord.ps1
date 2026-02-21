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

    # --- Modes pipeline (Raw / Quiet / Silent) ---
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

    # --- Mode NORMAL (UX complète) ---
    # IMPORTANT : on laisse Internal-GeneratePassword gérer l’UX
    # et on NE renvoie rien dans le pipeline
    Internal-GeneratePassword `
        -Length $Length `
        -SpecialChars $SpecialChars `
        -UseSpecial:$UseSpecial `
        -RequireAllTypes:$RequireAllTypes `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear | Out-Null

    return
}