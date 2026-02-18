<#
.SYNOPSIS
    Script maître pour générer, tester et préparer SecureGen.

.DESCRIPTION
    Ce script exécute :
    - génération documentation PlatyPS
    - génération README PSGallery
    - build complet
    - tests Pester
    - validation du module
    - installation locale (optionnelle)

    Il sert de point d’entrée unique pour les développeurs.

.NOTES
    Auteur  : SecureGen Project
    Version : 1.0
#>

[CmdletBinding()]
param(
    [switch]$SkipDocs,
    [switch]$SkipReadme,
    [switch]$SkipTests,
    [switch]$SkipInstall,
    [switch]$SkipTOC
)

$ErrorActionPreference = "Stop"

Write-Host "🚀 SecureGen — Generate-All" -ForegroundColor Cyan
Write-Host "──────────────────────────────────────────────`n"

# ---------------------------------------------------------------------------
# 1. Génération documentation PlatyPS
# ---------------------------------------------------------------------------

if (-not $SkipDocs) {
    Write-Host "📚 Génération documentation PlatyPS..." -ForegroundColor Yellow
    pwsh ./scripts/Generate-Help.ps1
    Write-Host "✔ Documentation générée" -ForegroundColor Green
} else {
    Write-Host "⏭ Documentation ignorée (--SkipDocs)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 2. Génération README PSGallery
# ---------------------------------------------------------------------------

if (-not $SkipReadme) {
    Write-Host "`n📄 Génération README PSGallery..." -ForegroundColor Yellow
    pwsh ./scripts/Generate-PSGalleryReadme.ps1
    Write-Host "✔ README généré" -ForegroundColor Green
} else {
    Write-Host "⏭ README ignoré (--SkipReadme)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 3. Génération automatique des tables des matières (TOC)
# ---------------------------------------------------------------------------

if (-not $SkipTOC) {
    Write-Host "`n📑 Génération automatique des TOC..." -ForegroundColor Yellow

    # Générer la TOC pour tous les fichiers Markdown du dossier docs/
    Get-ChildItem ./docs -Filter *.md -Recurse | ForEach-Object {
        Write-Host "   → TOC : $($_.FullName)" -ForegroundColor DarkCyan
        pwsh ./scripts/Generate-TOC.ps1 -Path $_.FullName
    }

    Write-Host "✔ TOC générées" -ForegroundColor Green
}
else {
    Write-Host "⏭ TOC ignorées (--SkipTOC)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 4. Build complet
# ---------------------------------------------------------------------------

Write-Host "`n🛠️ Build complet..." -ForegroundColor Yellow
pwsh ./scripts/build.ps1 --SkipDocs:$SkipDocs --SkipReadme:$SkipReadme --SkipTests:$SkipTests
Write-Host "✔ Build terminé" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 5. Installation locale (optionnelle)
# ---------------------------------------------------------------------------

if (-not $SkipInstall) {
    Write-Host "`n🔐 Installation locale..." -ForegroundColor Yellow
    pwsh ./scripts/Install-SecureGen.ps1 -Clean
    Write-Host "✔ Installation locale terminée" -ForegroundColor Green
} else {
    Write-Host "⏭ Installation locale ignorée (--SkipInstall)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 6. Résumé final
# ---------------------------------------------------------------------------

Write-Host "`n🏁 Generate-All terminé !" -ForegroundColor Green
Write-Host "──────────────────────────────────────────────"
Write-Host "📚 Docs : ./docs/cmdlets/"
Write-Host "📄 README : ./SecureGen/README.md"
Write-Host "📦 Build : ./out/SecureGen"
Write-Host "🧪 Tests : $(Get-ChildItem ./tests/*.ps1 | Measure-Object).Count fichiers"
Write-Host "──────────────────────────────────────────────`n"
