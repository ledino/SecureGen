function Get-PassWord {
<#
.SYNOPSIS
Génère un mot de passe sécurisé, configurable et cross‑platform.

.DESCRIPTION
Get-PassWord est une façade publique qui délègue toute la logique interne
à Internal-GeneratePassword.

La génération utilise automatiquement la meilleure source d’aléa selon la version
de PowerShell (PS7 : NIST SP 800‑90, PS5.1 : RNGCryptoServiceProvider).

.EXAMPLE
Get-PassWord
Génère un mot de passe robuste de 16 caractères.

.EXAMPLE
Get-PassWord -Length 32 -RequireAllTypes
Génère un mot de passe long contenant toutes les catégories.

.PARAMETER Length
Longueur du mot de passe. Par défaut : 16 (Recommandation ANSSI).

.PARAMETER SpecialChars
Liste des caractères spéciaux autorisés.

.PARAMETER UseSpecial
Active ou désactive l’utilisation des caractères spéciaux.

.PARAMETER RequireAllTypes
Exige la présence d’au moins une minuscule, une majuscule, un chiffre
et un caractère spécial (si UseSpecial = $true).

.PARAMETER NoClipboard
Désactive la copie automatique dans le presse‑papier.

.PARAMETER NoClear
Empêche l’effacement automatique du presse‑papier.

.PARAMETER Silent
Désactive tout affichage et tout bip.

.OUTPUTS
System.String
Retourne le mot de passe généré.
#>

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

    # 🔥 Mode RAW
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

    # 🔥 Mode QUIET
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

    # 🔥 Mode NORMAL (UX complète)
    return Internal-GeneratePassword `
        -Length $Length `
        -SpecialChars $SpecialChars `
        -UseSpecial:$UseSpecial `
        -RequireAllTypes:$RequireAllTypes `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent
}