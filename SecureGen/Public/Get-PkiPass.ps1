function Get-PKIPass {
<#
.SYNOPSIS
Génère un secret robuste destiné aux usages PKI, certificats, clés privées ou comptes de service.

.DESCRIPTION
Get-PKIPass génère un secret hautement entropique adapté aux usages sensibles :

- Mode Password : 32 caractères aléatoires cryptographiquement sûrs.
- Mode Passphrase : 7 mots de 6 lettres, lisibles mais robustes.

L’utilisateur peut également demander un retour en SecureString pour intégration
dans des scripts, DSC, ou des modules nécessitant ce format.

.EXAMPLE
Get-PKIPass
Génère un mot de passe PKI de 32 caractères.

.EXAMPLE
Get-PKIPass -Type Passphrase
Génère une passphrase de 7×6 lettres.

.EXAMPLE
Get-PKIPass -AsSecureString
Retourne le secret sous forme de SecureString.

.EXAMPLE
Get-PKIPass -NoClipboard
Génère un secret sans copie dans le presse‑papier.

.PARAMETER Type
Type de secret à générer : Password (32 chars) ou Passphrase (7×6 lettres).

.PARAMETER AsSecureString
Retourne le secret sous forme de SecureString.

.PARAMETER NoClipboard
Empêche la copie automatique dans le presse‑papier.

.OUTPUTS
System.String  
System.Security.SecureString

.NOTES
Utilise Get-PassWord et Get-PassPhrase du module SecureGen.
#>
    
    [CmdletBinding(DefaultParameterSetName = 'Password')]
    param(
        # Mode Password
        [Parameter(ParameterSetName='Password')]
        [switch]$Password,

        [Parameter(ParameterSetName='Password')]
        [int]$Length = 32,

        # Mode Passphrase
        [Parameter(ParameterSetName='Passphrase')]
        [switch]$Passphrase,

        [Parameter(ParameterSetName='Passphrase')]
        [int]$Words = 7,

        [Parameter(ParameterSetName='Passphrase')]
        [int]$Letters = 6,

        [Parameter(ParameterSetName='Passphrase')]
        [string]$Separator,

        [Parameter(ParameterSetName='Passphrase')]
        [string]$Charset,

        # Options
        [switch]$AsPlainText,
        [switch]$Silent,
        [switch]$Quiet,
        [switch]$Raw,
        [switch]$NoClipboard,
        [switch]$NoClear
    )

    # --- Si : Raw / Quiet / Silent => forcent le retour en texte clair ---
    $forcePlainText = $Raw -or $Quiet -or $Silent

    # --- Construction dynamique des paramètres ---
    $params = @{
        Silent      = $Silent
        Quiet       = $Quiet
        Raw         = $Raw
        NoClipboard = $NoClipboard
        NoClear     = $NoClear
    }

    if ($Passphrase) {
        if ($Words)     { $params.Words     = $Words }
        if ($Letters)   { $params.Letters   = $Letters }
        if ($Separator) { $params.Separator = $Separator }
        if ($Charset)   { $params.Charset   = $Charset }

        $secret = Get-PassPhrase @params
    }
    else {
        if ($Length) { $params.Length = $Length }

        $secret = Get-PassWord @params
    }

    # --- Gestion du retour SecureString / PlainText ---
    if (-not $AsPlainText -and -not $forcePlainText) {
        return ($secret | ConvertTo-SecureString -AsPlainText -Force)
    }

    return $secret
}