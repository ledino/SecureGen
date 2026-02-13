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
get-
.NOTES
    Auteur  : SecureGen Project
    Version : 1.0
#>

<# Ligne ci-dessous est une directive de parsing traitée AVANT toute exécution. Module 1.0.0 n'existe pas encore dans PSGallery - cmd non utilisée
#Requires -Version 7.4 -Modules @{ModuleName='PlatyPS';ModuleVersion='1.0.0'}
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

# --- 1. IMPORT PLATYPS ---
try {
    Import-Module PlatyPS -MinimumVersion 1.0.0 -Force -ErrorAction Stop
    Write-Host "✅ PlatyPS chargé (v$((Get-Module PlatyPS).Version))" -ForegroundColor Green
}
catch {
    Write-Host "⚠️ PlatyPS absent. Installation..." -ForegroundColor Yellow
    Install-Module PlatyPS -Scope CurrentUser -Force -AllowClobber
    Import-Module PlatyPS -Force
}

# --- 2. MODULE CIBLE ---
if (-not $ModulePath) {
    $ModulePath = Join-Path $PSScriptRoot "../SecureGen/SecureGen.psd1"
}

if (-not (Test-Path $ModulePath)) {
    throw "❌ Module non trouvé : $ModulePath"
}

Import-Module $ModulePath -Force -ErrorAction Stop
Write-Host "📦 Module importé : $ModulePath" -ForegroundColor Green

# --- 3. DOSSIER DE SORTIE ---
if (-not $OutputFolder) {
    $OutputFolder = Join-Path $PSScriptRoot "../docs/cmdlets"
}

if (-not (Test-Path $OutputFolder)) {
    Write-Host "📁 Création du dossier : $OutputFolder" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $OutputFolder -Force | Out-Null
}

# --- 4. NETTOYAGE OPTIONNEL ---
if ($Clean) {
    Write-Host "🧹 Nettoyage des anciens fichiers..." -ForegroundColor Yellow
    Get-ChildItem $OutputFolder -Filter "*.md" -ErrorAction SilentlyContinue |
        Remove-Item -Force
}

# --- 5. GÉNÉRATION / MISE À JOUR ---
$existing = Get-ChildItem $OutputFolder -Filter "*.md" -ErrorAction SilentlyContinue

$params = @{
    Module        = $ModuleName
    OutputFolder  = $OutputFolder
    WithModulePage = $true
    Locale        = 'fr-FR'
    Force         = $Force.IsPresent
}

if ($existing.Count -eq 0) {
    Write-Host "🆕 Aucune documentation trouvée. Génération complète..." -ForegroundColor Green
    New-MarkdownHelp @params
}
else {
    Write-Host "🔄 Documentation existante détectée. Mise à jour..." -ForegroundColor Green
    Update-MarkdownHelp @params
}

# --- 6. VALIDATION ---
if (Get-Command Test-MarkdownHelp -ErrorAction SilentlyContinue) {
    Write-Host "🧪 Validation PlatyPS..." -ForegroundColor Cyan
    Test-MarkdownHelp -Path $OutputFolder
}
else {
    Write-Host "⚡ Validation PlatyPS non disponible (version < 1.0)" -ForegroundColor Yellow
}

# --- 7. RÉSUMÉ ---
$files = Get-ChildItem $OutputFolder -Filter "*.md"

Write-Host ""
Write-Host "📊 Résumé" -ForegroundColor Cyan
Write-Host "   📄 Fichiers générés : $($files.Count)"
Write-Host "   📁 Dossier : $OutputFolder"
Write-Host "   🧩 Cmdlets détectés : $((Get-Command -Module $ModuleName).Count)"
Write-Host ""
Write-Host "🎉 Documentation PlatyPS générée avec succès !" -ForegroundColor Green
