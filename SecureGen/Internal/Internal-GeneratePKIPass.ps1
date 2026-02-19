function Internal-GeneratePKIPass {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Password','Passphrase')]
        [string]$Type,

        # Password mode
        [int]$Length = 20,
        [string]$SpecialChars = '!@#$%^&*()_+-=[]{}<>/\|;~',
        [bool]$UseSpecial = $true,
        [switch]$RequireAllTypes,

        # Passphrase mode
        [int]$Words = 7,
        [int]$Letters = 6,
        [string]$Separator = '-',
        [switch]$Uppercase,
        [switch]$Digits,

        # Options
        [switch]$AsPlainText,
        [switch]$Silent,
        [switch]$NoClipboard,
        [switch]$NoClear
    )

    # --- 1) Génération du secret ---
    if ($Type -eq 'Password') {

        $secret = Internal-GeneratePassword `
            -Length $Length `
            -SpecialChars $SpecialChars `
            -UseSpecial:$UseSpecial `
            -RequireAllTypes:$RequireAllTypes `
            -Silent:$Silent `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear
    }
    else {

        $secret = Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$Uppercase `
            -Digits:$Digits `
            -Silent:$Silent `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear
    }

    # --- 2) Conversion en SecureString si demandé ---
    if (-not $AsPlainText) {
    $secret = Internal-GeneratePKIPass @params -Silent -NoClipboard -NoClear
    return ($secret | ConvertTo-SecureString -AsPlainText -Force)
    }

    return $secret
}