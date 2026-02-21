function Get-PKIPass {
    [CmdletBinding(DefaultParameterSetName = 'Password')]
    param(

        # --- Mode Password ---
        [Parameter(ParameterSetName='Password')]
        [switch]$Password,

        [Parameter(ParameterSetName='Password')]
        [int]$Length = 32,

        [Parameter(ParameterSetName='Password')]
        [string]$SpecialChars,

        [Parameter(ParameterSetName='Password')]
        [switch]$NoSpecial,

        [Parameter(ParameterSetName='Password')]
        [switch]$RequireAllTypes,

        # --- Mode Passphrase ---
        [Parameter(ParameterSetName='Passphrase')]
        [switch]$Passphrase,

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

        # --- Options communes ---
        [switch]$SecureString,
        [switch]$Silent,
        [switch]$Quiet,
        [switch]$Raw,
        [switch]$NoClipboard,
        [switch]$NoClear
    )

    # --- Modes UX : Raw / Quiet / Silent => forcent le texte clair ---
    $forcePlainText = $Raw -or $Quiet -or $Silent -or $SecureString

    # --- Paramètres communs transmis aux fonctions internes ---
    $params = @{
        Silent      = $Silent
        Quiet       = $Quiet
        Raw         = $Raw
        NoClipboard = $NoClipboard
        NoClear     = $NoClear
    }

    # --- Mode Passphrase ---
    if ($Passphrase) {

        $params.Words   = $Words
        $params.Letters = $Letters

        if ($Separator)       { $params.Separator = $Separator }
        if ($UppercasePhrase) { $params.Uppercase = $UppercasePhrase }
        if ($DigitsPhrase)    { $params.Digits    = $DigitsPhrase }

        # Si SecureString est demandé → forcer Silent pour récupérer la valeur brute
        if ($SecureString) { $params.Silent = $true }

        $secret = Get-PassPhrase @params
    }

    # --- Mode Password ---
    else {

        $params.Length = $Length

        if ($SpecialChars)    { $params.SpecialChars    = $SpecialChars }
        if ($NoSpecial)       { $params.NoSpecial       = $true }
        if ($RequireAllTypes) { $params.RequireAllTypes = $true }

        # Si SecureString est demandé → forcer Silent pour récupérer la valeur brute
        if ($SecureString) { $params.Silent = $true }

        $secret = Get-PassWord @params
    }

    # --- Conversion SecureString si demandé ---
    if ($SecureString) {
        return ($secret | ConvertTo-SecureString -AsPlainText -Force)
    }

    # --- Si pas SecureString et pas Raw/Quiet/Silent → UX déjà affichée, pipeline vide ---
    if (-not $forcePlainText) {
        return
    }

    # --- Sinon → renvoyer la valeur brute ---
    return $secret
}