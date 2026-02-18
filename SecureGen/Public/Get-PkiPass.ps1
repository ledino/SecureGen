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
        [switch]$NoClipboard,
        [switch]$NoClear
    )

    if ($Passphrase) {

        # On construit dynamiquement les paramètres
        $params = @{
            Silent      = $Silent
            NoClipboard = $NoClipboard
            NoClear     = $NoClear
        }

        if ($Words)     { $params.Words     = $Words }
        if ($Letters)   { $params.Letters   = $Letters }
        if ($Separator) { $params.Separator = $Separator }
        if ($Charset)   { $params.Charset   = $Charset }

        $secret = Get-PassPhrase @params
    }
    else {

        $params = @{
            Silent      = $Silent
            NoClipboard = $NoClipboard
            NoClear     = $NoClear
        }

        if ($Length) { $params.Length = $Length }

        $secret = Get-PassWord @params
    }

    if (-not $AsPlainText) {
        return ($secret | ConvertTo-SecureString -AsPlainText -Force)
    }

    return $secret
}