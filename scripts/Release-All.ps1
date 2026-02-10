<#
    Release-All.ps1
    Pipeline complet de release pour SecureGen
    Auteur : Ledino
    Version : 1.0

    Usage :
        .\Release-All.ps1 -Patch
        .\Release-All.ps1 -Minor
        .\Release-All.ps1 -Major
        .\Release-All.ps1 -Publish
#>

Set-Location (Split-Path $PSScriptRoot -Parent)

param(
    [switch]$Major,
    [switch]$Minor,
    [switch]$Patch,
    [switch]$Publish
)

$ErrorActionPreference = "Stop"

Write-Host "🚀 Pipeline complet de release — SecureGen" -ForegroundColor Cyan
Write-Host ""

# ---------------------------------------------------------------------------
# 1. Versioning automatique
# ---------------------------------------------------------------------------

Write-Host "🔢 Étape 1 : Versioning automatique" -ForegroundColor Yellow

$VersioningArgs = @()
if ($Major) { $VersioningArgs += "-Major" }
elseif ($Minor) { $VersioningArgs += "-Minor" }
else { $VersioningArgs += "-Patch" }

.\Versioning-SecureGen.ps1 @VersioningArgs

Write-Host "✔ Versioning terminé" -ForegroundColor Green
Write-Host ""

# ---------------------------------------------------------------------------
# 2. Build complet
# ---------------------------------------------------------------------------

Write-Host "🛠️ Étape 2 : Build du module" -ForegroundColor Yellow

.\build.ps1

Write-Host "✔ Build terminé" -ForegroundColor Green
Write-Host ""

# ---------------------------------------------------------------------------
# 3. Publication PSGallery (optionnelle)
# ---------------------------------------------------------------------------

if ($Publish) {
    Write-Host "📦 Étape 3 : Publication PSGallery" -ForegroundColor Yellow

    if (-not $env:PSGALLERY_KEY) {
        Write-Error "❌ La variable d'environnement PSGALLERY_KEY n'est pas définie."
        Write-Host "Définissez-la avec :" -ForegroundColor Yellow
        Write-Host '$env:PSGALLERY_KEY = "votre_clef_api"'
        exit 1
    }

    .\Publish-SecureGen.ps1

    Write-Host "✔ Publication terminée" -ForegroundColor Green
    Write-Host ""
}
else {
    Write-Host "⚠️ Publication PSGallery ignorée (utilisez -Publish pour activer)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 4. Fin
# ---------------------------------------------------------------------------

Write-Host "🎉 Release complète terminée !" -ForegroundColor Cyan
Write-Host "Votre module SecureGen est prêt."