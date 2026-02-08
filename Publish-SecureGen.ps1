<#
    Publish-SecureGen.ps1
    Script de publication officiel pour le module SecureGen
    Auteur : Saddek
    Version : 1.0
#>

$ErrorActionPreference = "Stop"

Write-Host "🔐 Publication du module SecureGen..." -ForegroundColor Cyan

# Vérification de la clé API PSGallery
if (-not $env:PSGALLERY_KEY) {
    Write-Error "❌ La variable d'environnement PSGALLERY_KEY n'est pas définie."
    Write-Host ""
    Write-Host "Définissez-la avec :" -ForegroundColor Yellow
    Write-Host '$env:PSGALLERY_KEY = "votre_clef_api"' -ForegroundColor Yellow
    exit 1
}

# Vérification du dossier src
if (-not (Test-Path "./src/SecureGen.psm1")) {
    Write-Error "❌ Le dossier ./src ne contient pas SecureGen.psm1"
    exit 1
}

# Publication
Publish-Module `
    -Path "./src" `
    -Repository "PSGallery" `
    -NuGetApiKey $env:PSGALLERY_KEY `
    -Verbose

Write-Host ""
Write-Host "✅ Publication terminée avec succès !" -ForegroundColor Green
Write-Host "Module disponible sur : https://www.powershellgallery.com/packages/SecureGen"