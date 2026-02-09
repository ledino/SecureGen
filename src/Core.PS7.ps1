# Core.PS7.ps1
# Version moderne optimisée PowerShell 7+
# Utilise RandomNumberGenerator.GetBytes() et Get-SecureRandom si disponible

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

    if ($IsMacOS) {
        try { $Value | pbcopy } catch {
            Write-Warning "Clipboard macOS indisponible (pbcopy manquant)."
        }
        return
    }

    if ($IsLinux) {
        if (Get-Command xclip -ErrorAction SilentlyContinue) {
            $Value | xclip -selection clipboard
        }
        elseif (Get-Command xsel -ErrorAction SilentlyContinue) {
            $Value | xsel --clipboard --input
        }
        else {
            Write-Warning "Clipboard Linux indisponible : installez xclip ou xsel."
        }
    }
}

function Clear-ClipboardSafe {

    if ($IsWindows) {
        try { Set-Clipboard $null } catch {}
        return
    }

    if ($IsMacOS) {
        try { printf "" | pbcopy } catch {}
        return
    }

    if ($IsLinux) {
        if (Get-Command xclip -ErrorAction SilentlyContinue) {
            printf "" | xclip -selection clipboard
        }
        elseif (Get-Command xsel -ErrorAction SilentlyContinue) {
            printf "" | xsel --clipboard --input
        }
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
# Crypto index (PS7 optimisé)
# ---------------------------------------------------------------------------

function Get-CryptoIndex {
    param([int]$Max)

    # PS7 : Get-SecureRandom si dispo
    if (Get-Command Get-SecureRandom -ErrorAction SilentlyContinue) {
        return Get-SecureRandom -Maximum $Max
    }

    # PS7 : RandomNumberGenerator moderne
    $bytes = [System.Security.Cryptography.RandomNumberGenerator]::GetBytes(1)
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

    if ($Copy) {
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
    $Sym   = "!@#$%^&*()-_=+[]{}:;,.?<>~"

    $Pool = $Lower + $Upper + $Digits
    if ($Symbols) { $Pool += $Sym }

    $Chars = $Pool.ToCharArray()
    $Result = ""

    for ($i = 0; $i -lt $Length; $i++) {
        $Result += $Chars[(Get-CryptoIndex -Max $Chars.Count)]
    }

    if ($Copy) {
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