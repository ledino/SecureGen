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
    Version : 2.0
#>

[CmdletBinding()]
param(
    [string]$ModuleName = 'SecureGen',
    [string]$ModulePath,
    [string]$OutputFolder,
    [switch]$Force,
    [switch]$Clean
)

Write-Host "📘 Génération de la documentation PlatyPS : $ModuleName" -ForegroundColor Cyan

# ---------------------------------------------------------------------------
# 1. Détection et import de PlatyPS
# ---------------------------------------------------------------------------

$platy = Get-Module -ListAvailable -Name PlatyPS | Sort-Object Version -Descending | Select-Object -First 1

if (-not $platy) {
    Write-Host "⚠️ PlatyPS non installé. Installation..." -ForegroundColor Yellow
    Install-Module PlatyPS -Scope CurrentUser -Force -AllowClobber
    $platy = Get-Module -ListAvailable -Name PlatyPS | Sort-Object Version -Descending | Select-Object -First 1
}

Write-Host "📦 PlatyPS détecté : version $($platy.Version)" -ForegroundColor Green
Import-Module PlatyPS -Force

# ---------------------------------------------------------------------------
# 2. Module cible
# ---------------------------------------------------------------------------

if (-not $ModulePath) {
    $ModulePath = Join-Path $PSScriptRoot "../SecureGen/SecureGen.psd1"
}

if (-not (Test-Path $ModulePath)) {
    throw "❌ Module non trouvé : $ModulePath"
}

Import-Module $ModulePath -Force -ErrorAction Stop
Write-Host "📦 Module importé : $ModulePath" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 3. Dossier de sortie
# ---------------------------------------------------------------------------

if (-not $OutputFolder) {
    $OutputFolder = Join-Path $PSScriptRoot "../docs/cmdlets"
}

if (-not (Test-Path $OutputFolder)) {
    Write-Host "📁 Création du dossier : $OutputFolder" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $OutputFolder -Force | Out-Null
}

# ---------------------------------------------------------------------------
# 4. Nettoyage optionnel
# ---------------------------------------------------------------------------

if ($Clean) {
    Write-Host "🧹 Nettoyage des anciens fichiers..." -ForegroundColor Yellow
    Get-ChildItem $OutputFolder -Filter "*.md" -ErrorAction SilentlyContinue |
        Remove-Item -Force
}

# ---------------------------------------------------------------------------
# 5. Génération ou mise à jour
# ---------------------------------------------------------------------------

$existing = Get-ChildItem $OutputFolder -Filter "*.md" -ErrorAction SilentlyContinue

$params = @{
    Module       = $ModuleName
    OutputFolder = $OutputFolder
    Force        = $Force.IsPresent
}

if ($existing.Count -eq 0) {
    Write-Host "🆕 Aucune documentation trouvée. Génération complète..." -ForegroundColor Green
    New-MarkdownHelp @params
}
else {
    Write-Host "🔄 Documentation existante détectée. Mise à jour..." -ForegroundColor Green
    Update-MarkdownHelp @params
}

# ---------------------------------------------------------------------------
# 6. Validation
# ---------------------------------------------------------------------------

Write-Host "🧪 Validation PlatyPS..." -ForegroundColor Cyan
Test-MarkdownHelp -Module $ModuleName -HelpFilesPath $OutputFolder

# ---------------------------------------------------------------------------
# 7. Résumé
# ---------------------------------------------------------------------------

$files = Get-ChildItem $OutputFolder -Filter "*.md"

Write-Host ""
Write-Host "📊 Résumé" -ForegroundColor Cyan
Write-Host "   📄 Fichiers générés : $($files.Count)"
Write-Host "   📁 Dossier : $OutputFolder"
Write-Host "   🧩 Cmdlets détectées : $((Get-Command -Module $ModuleName).Count)"
Write-Host ""
Write-Host "🎉 Documentation PlatyPS générée avec succès !" -ForegroundColor Green
