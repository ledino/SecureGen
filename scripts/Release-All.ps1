<#
.SYNOPSIS
    Pipeline local de préparation de release pour SecureGen.

.DESCRIPTION
    ⚠️ IMPORTANT :
    Depuis SecureGen 1.5+, la release officielle (versioning + tag + changelog + publication)
    est entièrement automatisée via GitHub Actions.

    Ce script sert uniquement à :
    - préparer un build complet local
    - regénérer la documentation
    - valider le module
    - effectuer un bump local OPTIONNEL (rarement nécessaire)
    - tester la publication manuelle si besoin

.NOTES
    Auteur  : SecureGen Project
    Version : 3.0
#>

[CmdletBinding()]
param(
    [switch]$Major,
    [switch]$Minor,
    [switch]$Patch,
    [switch]$Publish
)

$ErrorActionPreference = "Stop"

Write-Host "🚀 Pipeline local de préparation de release — SecureGen" -ForegroundColor Cyan
Write-Host "──────────────────────────────────────────────`n"

# ---------------------------------------------------------------------------
# 1. Versioning local (optionnel)
# ---------------------------------------------------------------------------

if ($Major -or $Minor -or $Patch) {

    Write-Host "🔢 Étape 1 : Versioning local (optionnel)" -ForegroundColor Yellow

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

    Write-Host "➡️ Exécution de standard-version local..." -ForegroundColor Cyan

    npm exec standard-version -- $releaseArgs

    Write-Host "✔ Versioning local terminé" -ForegroundColor Green
    Write-Host ""
}
else {
    Write-Host "⏭ Versioning ignoré (aucun paramètre -Major/-Minor/-Patch)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 2. Build complet
# ---------------------------------------------------------------------------

Write-Host "🛠️ Étape 2 : Build complet du module" -ForegroundColor Yellow

pwsh ./scripts/build.ps1

Write-Host "✔ Build terminé" -ForegroundColor Green
Write-Host ""

# ---------------------------------------------------------------------------
# 3. Publication manuelle (optionnelle)
# ---------------------------------------------------------------------------

if ($Publish) {

    Write-Host "📦 Étape 3 : Publication manuelle PSGallery" -ForegroundColor Yellow

    if (-not $env:PSGALLERY_KEY) {
        Write-Error "❌ La variable d'environnement PSGALLERY_KEY n'est pas définie."
        Write-Host "Définissez-la avec :" -ForegroundColor Yellow
        Write-Host '$env:PSGALLERY_KEY = "votre_clef_api"'
        exit 1
    }

    pwsh ./scripts/Publish-SecureGen.ps1

    Write-Host "✔ Publication manuelle terminée" -ForegroundColor Green
    Write-Host ""
}
else {
    Write-Host "⏭ Publication manuelle ignorée (utilisez -Publish pour activer)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 4. Fin
# ---------------------------------------------------------------------------

Write-Host "🎉 Pipeline local terminé !" -ForegroundColor Cyan
Write-Host "Votre module SecureGen est prêt."
Write-Host "──────────────────────────────────────────────`n"
