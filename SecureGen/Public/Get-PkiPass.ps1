function Get-PKIPass {
    [CmdletBinding(DefaultParameterSetName = 'Password')]
    param(
        # Mode Password
        [Parameter(ParameterSetName='Password')]
        [switch]$Password,

        [Parameter(ParameterSetName='Password')]
        [int]$Length,

        # Mode Passphrase
        [Parameter(ParameterSetName='Passphrase')]
        [switch]$Passphrase,

        [Parameter(ParameterSetName='Passphrase')]
        [int]$Words,

        [Parameter(ParameterSetName='Passphrase')]
        [int]$Letters,

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