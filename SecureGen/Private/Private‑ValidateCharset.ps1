function Private-ValidateCharset {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Charset,

        [Parameter(Mandatory)]
        [string]$Separator
    )

    # --- 1) Charset vide ---
    if ([string]::IsNullOrWhiteSpace($Charset)) {
        throw "Le paramètre -SpecialChars ne peut pas être vide."
    }

    # --- 2) Interdiction des classes obligatoires ---
    if ($Charset -match "[a-z]") {
        throw "Le paramètre -SpecialChars ne doit pas contenir de lettres minuscules (elles sont déjà obligatoires)."
    }

    if ($Charset -match "[A-Z]") {
        throw "Le paramètre -SpecialChars ne doit pas contenir de lettres majuscules (elles sont déjà obligatoires)."
    }

    if ($Charset -match "\d") {
        throw "Le paramètre -SpecialChars ne doit pas contenir de chiffres (ils sont déjà obligatoires)."
    }

    # --- 3) Le séparateur ne doit pas apparaître dans les symboles ---
    <#
    if ($Charset.Contains($Separator)) {
        throw "Le séparateur '$Separator' ne doit pas apparaître dans les caractères spéciaux."
    }
    #>
    
    # --- 4) Pas de doublons ---
    $unique = ($Charset.ToCharArray() | Select-Object -Unique) -join ''
    if ($unique.Length -ne $Charset.Length) {
        throw "Le paramètre -SpecialChars contient des doublons. Chaque caractère doit être unique."
    }

    # --- 5) Pas d'espaces ou caractères invisibles ---
    if ($Charset -match "\s") {
        throw "Le paramètre -SpecialChars ne doit pas contenir d'espaces ou de caractères invisibles."
    }

    return
}