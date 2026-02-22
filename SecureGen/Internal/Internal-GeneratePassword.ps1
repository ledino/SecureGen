function Internal-GeneratePassword {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Length,

        [Parameter(Mandatory)]
        [string]$SpecialChars,

        [bool]$UseSpecial = $true,
        [switch]$RequireAllTypes,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent,

        [string[]]$Warnings  # <-- ajouté, mais non utilisé
    )

    # --- 1) Validation de la longueur ---
    $valid = Private-ValidateLength -Length $Length -Min 16 -Max 256

    if (-not $valid) {
        if ($Length -lt 16) { $Length = 16 }
        if ($Length -gt 256) { $Length = 256 }
    }

    # --- 2) Validation des caractères spéciaux ---
    if ($UseSpecial) {
        Private-ValidateCharset -Charset $SpecialChars -Separator '§'
    }

    # --- 3) Construction du charset final ---
    $Lower  = 'abcdefghijklmnopqrstuvwxyz'
    $Upper  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $Digits = '0123456789'

    $Charset = $Lower + $Upper + $Digits

    if ($UseSpecial) {
        $Charset += $SpecialChars
    }

    # --- 4) Génération du mot de passe ---
    if (-not $RequireAllTypes) {

        $password = Internal-RandomString -Length $Length -Charset $Charset

        # PATCH minimal
        if ($UseSpecial) {

            $containsSpecial = $false
            foreach ($c in $SpecialChars.ToCharArray()) {
                if ($password.Contains($c)) {
                    $containsSpecial = $true
                    break
                }
            }

            if (-not $containsSpecial) {
                $randomSpecial = $SpecialChars[(Get-Random -Min 0 -Max $SpecialChars.Length)]
                $insertPos = Get-Random -Min 0 -Max $password.Length
                $password = $password.Insert($insertPos, $randomSpecial)

                $removePos = Get-Random -Min 0 -Max $password.Length
                $password = $password.Remove($removePos, 1)
            }
        }
    }
    else {
        $maxTries = 1000
        $tries = 0

        do {
            $tries++
            if ($tries -gt $maxTries) {
                throw "Unable to generate a password matching all requirements after $maxTries attempts."
            }

            $password = Internal-RandomString -Length $Length -Charset $Charset

            $hasLower   = $password -match '[a-z]'
            $hasUpper   = $password -match '[A-Z]'
            $hasDigit   = $password -match '\d'

            $hasSpecial = $UseSpecial ? (
                $SpecialChars -split '' |
                    Where-Object { $_ -and $password -match [regex]::Escape($_) }
            ) : $true

        } while (-not ($hasLower -and $hasUpper -and $hasDigit -and $hasSpecial))
    }

    # --- 5) Entropie ---
    $entropy = Internal-ComputeEntropy `
        -SymbolCount $Length `
        -CharsetSize $Charset.Length

    # --- 6) Source d'aléa ---
    $alea = Internal-GetAleaSource

    # --- 7) UX ---
    if (-not $Silent) {
        Internal-DisplaySecret `
            -Secret $password `
            -Entropy $entropy `
            -AleaSource $alea `
            -Type 'Password' `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear `
            -Warnings $Warnings
    }

    # --- 8) Clipboard ---
    if (-not $Silent) {
        Internal-HandleClipboardLifecycle `
            -Secret $password `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear
    }

    if ($Silent) {
        return $password
    }

    return
}