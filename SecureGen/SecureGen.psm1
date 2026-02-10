Set-StrictMode -Version Latest

<#
    SecureGen.psm1
    Version : 1.3.1
    Auteur  : Ledino
    Date    : 2026-02-09

    Notes :
    - Chargement automatique PS7 / PS5
    - Architecture modulaire (Core.PS7.ps1 / Legacy.PS5.ps1)
    - Compatible Windows, Linux, macOS
    - Code propre, professionnel, PSGallery-ready
#>

# ---------------------------------------------------------------------------
# DÃ©tection automatique PowerShell 7 / PowerShell 5
# ---------------------------------------------------------------------------

if ($PSVersionTable.PSVersion.Major -ge 7) {
    # Version moderne (RandomNumberGenerator.GetBytes, Get-SecureRandom)
    . "$PSScriptRoot/Core.PS7.ps1"
}
else {
    # Version fallback Windows PowerShell 5.1 (RNGCryptoServiceProvider)
    . "$PSScriptRoot/Legacy.PS5.ps1"
}

# ---------------------------------------------------------------------------
# Export public
# ---------------------------------------------------------------------------

Export-ModuleMember -Function * -Alias *