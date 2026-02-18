<#
.SYNOPSIS
    Wrapper local pour standard-version (bump de version).

.DESCRIPTION
    ⚠️ IMPORTANT :
    Depuis SecureGen 1.5+, le versioning officiel est automatisé via GitHub Actions.
    Ce script sert uniquement à déclencher un bump local (rarement nécessaire).

    Il NE modifie PAS :
    - SecureGen.psd1
    - CHANGELOG.md
    - les tags Git

    Il se contente d’appeler standard-version avec le bon paramètre.

.NOTES
    Auteur  : SecureGen Project
    Version : 3.0
#>

[CmdletBinding()]
param(
    [switch]$Major,
    [switch]$Minor,
    [switch]$Patch
)

$ErrorActionPreference = "Stop"

Write-Host "🔢 Versioning local — SecureGen" -ForegroundColor Cyan
Write-Host "──────────────────────────────────────────────`n"

# ---------------------------------------------------------------------------
# 1. Détermination du type de bump
# ---------------------------------------------------------------------------

$releaseArgs = @()

if ($Major) {
    $releaseArgs += "--release-as major"
}
elseif ($Minor) {
    $releaseArgs += "--release-as minor"
}
else {
    $releaseArgs += "--release-as patch"
}

Write-Host "➡️ Type de bump : $($releaseArgs -join ' ')" -ForegroundColor Yellow

# ---------------------------------------------------------------------------
# 2. Exécution de standard-version
# ---------------------------------------------------------------------------

Write-Host "`n🚀 Exécution de standard-version..." -ForegroundColor Cyan

npm exec standard-version -- $releaseArgs

Write-Host "`n✔ standard-version exécuté" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 3. Résumé
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "📦 Version locale mise à jour (manifest & changelog seront gérés par la CI)" -ForegroundColor Cyan
Write-Host "🎉 Versioning local terminé !" -ForegroundColor Green
Write-Host "──────────────────────────────────────────────`n"
