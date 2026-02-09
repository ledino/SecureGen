# Legacy.PS5.ps1
# Version fallback pour Windows PowerShell 5.1
# Utilise RNGCryptoServiceProvider (API .NET Framework)

Set-StrictMode -Version Latest

# ---------------------------------------------------------------------------
# Clipboard cross-platform
# ---------------------------------------------------------------------------

function Set-ClipboardSafe {
    param([string]$Value)

    if ($IsWindows) {
        try { Set-Clipboard -Value $Value } catch {
            Write-Warning "Impossible d'accéder au presse-papier Windows."
        }
        return
    }

    Write-Warning "Clipboard non supporté nativement en PowerShell 5 hors Windows."
}

function Clear-ClipboardSafe {
    if ($IsWindows) {
        try { Set-Clipboard $null } catch {}
        return
    }
}

# ---------------------------------------------------------------------------
# Beep cross-platform
# ---------------------------------------------------------------------------

function Invoke-Beep {
    param([int]$Freq = 1000, [int]$Duration = 200)
    try { [console]::Beep($Freq, $Duration) } catch {}
}

# ---------------------------------------------------------------------------
# Crypto index (fallback PS5)
# ---------------------------------------------------------------------------

function Get-CryptoIndex {
    param([int]$Max)

    $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
    $bytes = New-Object byte[] 1
    $rng.GetBytes($bytes)

    return ($bytes[0] % $Max)
}

# ---------------------------------------------------------------------------
# Passphrase generator
# ---------------------------------------------------------------------------

function Get-PassPhrase {
    [CmdletBinding()]
    param(
        [int]$Words = 4,
        [switch]$Copy,
        [switch]$Silent
    )

    $WordList = @(
        "azure","nebula","quantum","cipher","matrix","vector","fusion","orbit",
        "crystal","shadow","vertex","signal","nova","binary","echo","pulse",
        "delta","omega","lunar","stellar","flux","prism","arc","glyph"
    )

    $Result = for ($i = 0; $i -lt $Words; $i++) {
        $WordList[(Get-CryptoIndex -Max $WordList.Count)]
    }

    $PassPhrase = ($Result -join "-")

    if ($Copy -and $IsWindows) {
        Set-ClipboardSafe $PassPhrase
        if (-not $Silent) { Invoke-Beep }
    }

    return $PassPhrase
}

# ---------------------------------------------------------------------------
# Password generator
# ---------------------------------------------------------------------------

function Get-PassWord {
    [CmdletBinding()]
    param(
        [int]$Length = 16,
        [switch]$Symbols,
        [switch]$Copy,
        [switch]$Silent
    )

    $Lower = "abcdefghijklmnopqrstuvwxyz"
    $Upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $Digits = "0123456789"
    $Sym   = "!@#$%^&*()-_=+[]{}:;,.?<>~€"

    $Pool = $Lower + $Upper + $Digits
    if ($Symbols) { $Pool += $Sym }

    $Chars = $Pool.ToCharArray()
    $Result = ""

    for ($i = 0; $i -lt $Length; $i++) {
        $Result += $Chars[(Get-CryptoIndex -Max $Chars.Count)]
    }

    if ($Copy -and $IsWindows) {
        Set-ClipboardSafe $Result
        if (-not $Silent) { Invoke-Beep }
    }

    return $Result
}

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------

Set-Alias sgp Get-PassPhrase
Set-Alias sgw Get-PassWord