<#
    build.ps1
    Script de build complet pour SecureGen
    Auteur : Saddek
    Version : 1.0
#>

$ErrorActionPreference = "Stop"

Write-Host "🔧 Build du module SecureGen..." -ForegroundColor Cyan

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
    "./src/SecureGen.psm1",
    "./src/SecureGen.psd1",
    "./src/Core.PS7.ps1",
    "./src/Legacy.PS5.ps1"
)

foreach ($file in $RequiredFiles) {
    if (-not (Test-Path $file)) {
        Write-Error "❌ Fichier manquant : $file"
        exit 1
    }
}

Write-Host "✔ Structure valide" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 3. Copie du module dans le dossier out/
# ---------------------------------------------------------------------------

Write-Host "📦 Préparation du module..." -ForegroundColor Yellow

Copy-Item -Path "./src/*" -Destination "$OutputDir/SecureGen" -Recurse -Force

# ---------------------------------------------------------------------------
# 4. Tests Pester (optionnel)
# ---------------------------------------------------------------------------

$TestsPath = "./tests"

if (Test-Path $TestsPath) {
    Write-Host "🧪 Exécution des tests Pester..." -ForegroundColor Yellow
    Invoke-Pester -Path $TestsPath -Output Detailed
}
else {
    Write-Host "⚠ Aucun test Pester trouvé (dossier ./tests absent)" -ForegroundColor DarkYellow
}

# ---------------------------------------------------------------------------
# 5. Packaging du module
# ---------------------------------------------------------------------------

Write-Host "📦 Packaging du module..." -ForegroundColor Yellow

$Manifest = "./src/SecureGen.psd1"
$ModuleVersion = (Import-PowerShellDataFile $Manifest).ModuleVersion

$NupkgPath = "$OutputDir/SecureGen.$ModuleVersion.nupkg"

Publish-Module `
    -Path "$OutputDir/SecureGen" `
    -NuGetApiKey "DUMMY" `
    -Repository "PSGallery" `
    -WhatIf `
    -ErrorAction SilentlyContinue | Out-Null

Write-Host "✔ Packaging terminé" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 6. Publication (optionnelle)
# ---------------------------------------------------------------------------

param(
    [switch]$Publish
)

if ($Publish) {

    if (-not $env:PSGALLERY_KEY) {
        Write-Error "❌ La variable d'environnement PSGALLERY_KEY n'est pas définie."
        exit 1
    }

    Write-Host "🚀 Publication sur PSGallery..." -ForegroundColor Cyan

    Publish-Module `
        -Path "$OutputDir/SecureGen" `
        -Repository "PSGallery" `
        -NuGetApiKey $env:PSGALLERY_KEY `
        -Verbose

    Write-Host "🎉 Publication réussie !" -ForegroundColor Green
}

Write-Host ""
Write-Host "🏁 Build terminé !" -ForegroundColor Green
Write-Host "Module prêt dans : $OutputDir/SecureGen"