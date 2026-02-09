<#
    Publish-SecureGen.ps1
    Script officiel de publication pour SecureGen
    Auteur : Ledino
    Version : 2.0
#>

$ErrorActionPreference = "Stop"

Write-Host "🚀 Publication du module SecureGen..." -ForegroundColor Cyan

# ---------------------------------------------------------------------------
# 1. Vérification de la clé API PSGallery
# ---------------------------------------------------------------------------

if (-not $env:PSGALLERY_KEY) {
    Write-Error "❌ La variable d'environnement PSGALLERY_KEY n'est pas définie."
    Write-Host ""
    Write-Host "Définissez-la avec :" -ForegroundColor Yellow
    Write-Host '$env:PSGALLERY_KEY = "votre_clef_api"' -ForegroundColor Yellow
    exit 1
}

# ---------------------------------------------------------------------------
# 2. Vérification de la structure du module
# ---------------------------------------------------------------------------

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
# 3. Lecture de la version du module
# ---------------------------------------------------------------------------

$Manifest = Import-PowerShellDataFile "./src/SecureGen.psd1"
$Version = $Manifest.ModuleVersion

Write-Host "📦 Version détectée : $Version" -ForegroundColor Cyan

# ---------------------------------------------------------------------------
# 4. Préparation du dossier temporaire
# ---------------------------------------------------------------------------

$Temp = "./out/publish"

if (Test-Path $Temp) {
    Remove-Item $Temp -Recurse -Force
}

New-Item -ItemType Directory -Path $Temp | Out-Null

Copy-Item -Path "./src/*" -Destination $Temp -Recurse -Force

Write-Host "📁 Dossier de publication prêt" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 5. Publication PSGallery
# ---------------------------------------------------------------------------

Write-Host "🚀 Publication sur PowerShell Gallery..." -ForegroundColor Yellow

Publish-Module `
    -Path $Temp `
    -Repository "PSGallery" `
    -NuGetApiKey $env:PSGALLERY_KEY `
    -Verbose

Write-Host ""
Write-Host "🎉 Publication réussie !" -ForegroundColor Green
Write-Host "Module disponible sur :" -ForegroundColor Cyan
Write-Host "➡ https://www.powershellgallery.com/packages/SecureGen"