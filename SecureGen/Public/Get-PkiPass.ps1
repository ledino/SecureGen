function Get-PKIPass {
    [CmdletBinding(DefaultParameterSetName = 'Password')]
    param(

        # Modes (sans ParameterSet pour éviter l’erreur PowerShell)
        [switch]$Password,
        [switch]$Passphrase,

        # Password
        [Parameter(ParameterSetName='Password')]
        [int]$Length = 32,

        [Parameter(ParameterSetName='Password')]
        [string]$SpecialChars,

        [Parameter(ParameterSetName='Password')]
        [switch]$NoSpecial,

        [Parameter(ParameterSetName='Password')]
        [switch]$RequireAllTypes,

        # Passphrase
        [Parameter(ParameterSetName='Passphrase')]
        [int]$Words = 7,

        [Parameter(ParameterSetName='Passphrase')]
        [int]$Letters = 6,

        [Parameter(ParameterSetName='Passphrase')]
        [string]$Separator,

        [Parameter(ParameterSetName='Passphrase')]
        [switch]$UppercasePhrase,

        [Parameter(ParameterSetName='Passphrase')]
        [switch]$DigitsPhrase,

        # Commun
        [switch]$SecureString,
        [switch]$Silent,
        [switch]$Quiet,
        [switch]$Raw,
        [switch]$NoClipboard,
        [switch]$NoClear,

        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$UnknownOptions
    )

    # --- Validation centralisée ---
    if (-not (Internal-ValidateInput -Mode 'PKIPass' @PSBoundParameters)) {
        return
    }

    # --- Modes UX ---
    $forcePlainText = $Raw -or $Quiet -or $Silent -or $SecureString

    # --- Paramètres communs ---
    $params = @{
        Silent      = $Silent
        Quiet       = $Quiet
        Raw         = $Raw
        NoClipboard = $NoClipboard
        NoClear     = $NoClear
    }

    # --- Passphrase ---
    if ($Passphrase) {

        $params.Words   = $Words
        $params.Letters = $Letters

        if ($Separator)       { $params.Separator = $Separator }
        if ($UppercasePhrase) { $params.Uppercase = $UppercasePhrase }
        if ($DigitsPhrase)    { $params.Digits    = $DigitsPhrase }

        if ($SecureString) { $params.Silent = $true }

        $secret = Get-PassPhrase @params
    }

    # --- Password ---
    else {

        $params.Length = $Length

        if ($SpecialChars)    { $params.SpecialChars    = $SpecialChars }
        if ($NoSpecial)       { $params.NoSpecial       = $true }
        if ($RequireAllTypes) { $params.RequireAllTypes = $true }

        if ($SecureString) { $params.Silent = $true }

        $secret = Get-PassWord @params
    }

    # --- SecureString ---
    if ($SecureString) {
        return ($secret | ConvertTo-SecureString -AsPlainText -Force)
    }

    if (-not $forcePlainText) { return }

    return $secret
}