<#
.SYNOPSIS
    Génère ou met à jour la documentation Markdown des cmdlets SecureGen via PlatyPS.

.DESCRIPTION
    Ce script :
    - importe le module SecureGen local
    - génère la documentation PlatyPS si elle n'existe pas
    - met à jour la documentation existante
    - crée automatiquement la page du module (SecureGen.md)
    - garantit une documentation toujours synchronisée avec le code

.NOTES
    Auteur  : SecureGen Project
    Version : 1.0
#>

Write-Host "📘 Génération de la documentation PlatyPS..." -ForegroundColor Cyan

# --- Vérification du module PlatyPS ---
if (-not (Get-Module -ListAvailable -Name PlatyPS)) {
    Write-Host "📦 Installation de PlatyPS..." -ForegroundColor Yellow
    Install-Module PlatyPS -Scope CurrentUser -Force
}

Import-Module PlatyPS -Force

# --- Import du module SecureGen ---
$modulePath = Join-Path $PSScriptRoot "..\SecureGen\SecureGen\SecureGen.psd1"

if (-not (Test-Path $modulePath)) {
    Write-Host "❌ Impossible de trouver le module SecureGen à l'emplacement attendu :" -ForegroundColor Red
    Write-Host "   $modulePath"
    exit 1
}

Write-Host "📦 Import du module SecureGen..." -ForegroundColor Cyan
Import-Module $modulePath -Force

# --- Dossier de sortie ---
$outputFolder = Join-Path $PSScriptRoot "..\docs\cmdlets"

if (-not (Test-Path $outputFolder)) {
    Write-Host "📁 Création du dossier : $outputFolder" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $outputFolder | Out-Null
}

# --- Génération ou mise à jour ---
$existingFiles = Get-ChildItem $outputFolder -Filter "*.md" -ErrorAction SilentlyContinue

if ($existingFiles.Count -eq 0) {
    Write-Host "🆕 Aucune documentation trouvée. Génération complète..." -ForegroundColor Green

    New-MarkdownHelp `
        -Module SecureGen `
        -OutputFolder $outputFolder `
        -WithModulePage `
        -Force
}
else {
    Write-Host "🔄 Documentation existante détectée. Mise à jour..." -ForegroundColor Green

    Update-MarkdownHelp `
        -Module SecureGen `
        -OutputFolder $outputFolder `
        -Force
}

Write-Host "✅ Documentation générée dans : $outputFolder" -ForegroundColor Green
Write-Host "🎉 Terminé !"
