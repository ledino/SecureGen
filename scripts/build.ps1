<#
    build.ps1
    Script de build local complet pour SecureGen
    Auteur : Ledino
    Version : 2.0
#>

[CmdletBinding()]
param(
    [switch]$SkipTests,
    [switch]$SkipDocs,
    [switch]$SkipReadme
)

$ErrorActionPreference = "Stop"

Write-Host "🔧 Build du module SecureGen..." -ForegroundColor Cyan
Write-Host "──────────────────────────────────────────────`n"

# ---------------------------------------------------------------------------
# 1. Nettoyage
# ---------------------------------------------------------------------------

Write-Host "🧹 Nettoyage des anciens artefacts..." -ForegroundColor Yellow

$OutputDir = "./out"

if (Test-Path $OutputDir) {
    Remove-Item $OutputDir -Recurse -Force
}

New-Item -ItemType Directory -Path $OutputDir | Out-Null

# ---------------------------------------------------------------------------
# 2. Vérification de la structure
# ---------------------------------------------------------------------------

Write-Host "📁 Vérification de la structure du module..." -ForegroundColor Yellow

$RequiredFiles = @(
    "./SecureGen/SecureGen.psm1",
    "./SecureGen/SecureGen.psd1",
    "./SecureGen/Core.PS7.ps1",
    "./SecureGen/Legacy.PS5.ps1"
)

foreach ($file in $RequiredFiles) {
    if (-not (Test-Path $file)) {
        Write-Error "❌ Fichier manquant : $file"
        exit 1
    }
}

Write-Host "✔ Structure valide" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 3. Génération documentation PlatyPS
# ---------------------------------------------------------------------------

if (-not $SkipDocs) {
    Write-Host "`n📚 Génération de la documentation PlatyPS..." -ForegroundColor Yellow
    pwsh ./scripts/Generate-Help.ps1
    Write-Host "✔ Documentation mise à jour" -ForegroundColor Green
} else {
    Write-Host "⏭ Documentation ignorée (--SkipDocs)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 4. Génération du README PSGallery
# ---------------------------------------------------------------------------

if (-not $SkipReadme) {
    Write-Host "`n📄 Génération du README PSGallery..." -ForegroundColor Yellow
    pwsh ./scripts/Generate-PSGalleryReadme.ps1
    Write-Host "✔ README généré" -ForegroundColor Green
} else {
    Write-Host "⏭ README ignoré (--SkipReadme)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 5. Copie du module dans out/
# ---------------------------------------------------------------------------

Write-Host "`n📦 Préparation du module..." -ForegroundColor Yellow

Copy-Item -Path "./SecureGen/*" -Destination "$OutputDir/SecureGen" -Recurse -Force

# ---------------------------------------------------------------------------
# 6. Tests Pester
# ---------------------------------------------------------------------------

if (-not $SkipTests) {
    Write-Host "`n🧪 Exécution des tests Pester..." -ForegroundColor Yellow
    Invoke-Pester -Path "./tests" -Output Detailed
    Write-Host "✔ Tests terminés" -ForegroundColor Green
} else {
    Write-Host "⏭ Tests ignorés (--SkipTests)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 7. Validation du manifest
# ---------------------------------------------------------------------------

Write-Host "`n🔍 Validation du manifest..." -ForegroundColor Yellow

$Manifest = "./SecureGen/SecureGen.psd1"
$ModuleVersion = (Import-PowerShellDataFile $Manifest).ModuleVersion

Write-Host "✔ Version détectée : $ModuleVersion" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 8. Packaging local (WhatIf)
# ---------------------------------------------------------------------------

Write-Host "`n📦 Packaging du module (simulation)..." -ForegroundColor Yellow

Publish-Module `
    -Path "$OutputDir/SecureGen" `
    -NuGetApiKey "DUMMY" `
    -Repository "PSGallery" `
    -WhatIf `
    -ErrorAction SilentlyContinue | Out-Null

Write-Host "✔ Packaging simulé (réel effectué par GitHub Actions)" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 9. Résumé final
# ---------------------------------------------------------------------------

Write-Host "`n🏁 Build terminé !" -ForegroundColor Green
Write-Host "──────────────────────────────────────────────"
Write-Host "📦 Module prêt dans : $OutputDir/SecureGen"
Write-Host "📄 README généré : $OutputDir/SecureGen/README.md"
Write-Host "📚 Docs PlatyPS : ./docs/cmdlets/"
Write-Host "🧪 Tests : $(Get-ChildItem ./tests/*.ps1 | Measure-Object).Count fichiers"
Write-Host "──────────────────────────────────────────────`n"
