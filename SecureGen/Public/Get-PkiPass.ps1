function Get-PkiPass {
<#
.SYNOPSIS
Génère un secret PKI robuste (mot de passe ou passphrase).

.DESCRIPTION
Get-PkiPass est une façade publique qui délègue toute la logique interne
à Internal-GeneratePkiPass.

Ce générateur produit un mot de passe adapté aux usages PKI :
- compatible certificats, CSR, clés privées
- sans caractères ambigus
- conforme aux bonnes pratiques de robustesse
- cross‑platform (PS5.1 / PS7)
- basé sur la meilleure source d’aléa disponible (NIST SP 800‑90 sous PS7)

La génération est déléguée à :
- Get-PassWord
- Get-PassPhrase

.EXAMPLE
Get-PkiPass
Génère un mot de passe PKI de 32 caractères.

.EXAMPLE
Get-PkiPass -Type Passphrase -Words 8 -Letters 7
Génère une passphrase PKI robuste.

.EXAMPLE
Get-PkiPass -AsSecureString
Retourne le secret sous forme de SecureString.

.PARAMETER Type
Type de secret : Password ou Passphrase.

.PARAMETER Length
Longueur du mot de passe PKI (mode Password).

.PARAMETER Words
Nombre de mots (mode Passphrase).

.PARAMETER Letters
Nombre de lettres par mot (mode Passphrase).

.PARAMETER AsSecureString
Retourne le secret sous forme de SecureString.

.PARAMETER NoClipboard
Désactive la copie automatique dans le presse‑papier.

.PARAMETER NoClear
Empêche l’effacement automatique du presse‑papier.

.PARAMETER Silent
Désactive tout affichage.

.OUTPUTS
System.String ou System.Security.SecureString
#>

   [CmdletBinding()]
    param(
        [ValidateSet('Password','Passphrase')]
        [string]$Type = 'Password',

        [Alias('Len')]
        [int]$Length = 32,

        [Alias('word','wrd','wd')]
        [int]$Words = 7,

        [Alias('Letter','ltrs','Let')]
        [int]$Letters = 6,

        [switch]$AsPlainText,
        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # --- Délégation ---
    if ($Type -eq 'Password') {
        $secret = Get-PassWord `
            -Length $Length `
            -UseSpecial `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear `
            -Silent:$Silent
    }
    else {
        $secret = Get-PassPhrase `
            -Words $Words `
            -LettersPerWord $Letters `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear `
            -Silent:$Silent
    }

    # --- SecureString par défaut ---
    if (-not $AsPlainText) {
        return Convert-ToSecureStringSafe $secret
    }

    return $secret
}

