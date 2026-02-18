<#
.SYNOPSIS
    Prépare automatiquement un environnement de développement complet pour SecureGen.

.DESCRIPTION
    Ce script :
    - Vérifie PowerShell 7+
    - Installe les dépendances Node.js (standard-version)
    - Installe le module SecureGen localement
    - Vérifie PlatyPS
    - Regénère la documentation PlatyPS
    - Exécute PSScriptAnalyzer
    - Exécute les tests Pester
    - Importe le module local
    - Affiche un résumé final

.NOTES
    Auteur  : SecureGen Project
    Version : 1.0
#>

[CmdletBinding()]
param(
    [switch]$SkipTests,
    [switch]$SkipDocs,
    [switch]$SkipAnalyzer
)

Write-Host "🔧 Initialisation de l'environnement de développement SecureGen" -ForegroundColor Cyan
Write-Host "──────────────────────────────────────────────────────────────`n"

# --- 1. Vérification PowerShell ---
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "⚠️ PowerShell 7+ recommandé pour le développement." -ForegroundColor Yellow
} else {
    Write-Host "✔ PowerShell 7 détecté : $($PSVersionTable.PSVersion)" -ForegroundColor Green
}

# --- 2. Installation des dépendances Node.js ---
if (Test-Path "./package.json") {
    Write-Host "`n📦 Installation des dépendances Node.js..." -ForegroundColor Cyan
    npm install | Out-Null
    Write-Host "✔ Dépendances Node installées" -ForegroundColor Green
} else {
    Write-Host "⚠️ Aucun package.json trouvé — standard-version peut ne pas fonctionner." -ForegroundColor Yellow
}

# --- 3. Installation locale du module ---
Write-Host "`n📦 Installation locale du module SecureGen..." -ForegroundColor Cyan
pwsh ./scripts/Install-SecureGen.ps1
Write-Host "✔ Module installé localement" -ForegroundColor Green

# --- 4. Vérification PlatyPS ---
Write-Host "`n📘 Vérification de PlatyPS..." -ForegroundColor Cyan
$platy = Get-Module -ListAvailable -Name PlatyPS | Sort-Object Version -Descending | Select-Object -First 1

if (-not $platy) {
    Write-Host "⚠️ PlatyPS non installé. Installation..." -ForegroundColor Yellow
    Install-Module PlatyPS -Scope CurrentUser -Force -AllowClobber
    $platy = Get-Module -ListAvailable -Name PlatyPS | Sort-Object Version -Descending | Select-Object -First 1
}

Write-Host "✔ PlatyPS détecté : version $($platy.Version)" -ForegroundColor Green

# --- 5. Génération documentation ---
if (-not $SkipDocs) {
    Write-Host "`n📚 Génération de la documentation PlatyPS..." -ForegroundColor Cyan
    pwsh ./scripts/Generate-Help.ps1
    Write-Host "✔ Documentation mise à jour" -ForegroundColor Green
} else {
    Write-Host "⏭ Documentation ignorée (--SkipDocs)" -ForegroundColor Yellow
}

# --- 6. Analyse statique ---
if (-not $SkipAnalyzer) {
    Write-Host "`n🔍 Analyse statique (PSScriptAnalyzer)..." -ForegroundColor Cyan
    Invoke-ScriptAnalyzer -Path ./SecureGen -Recurse
    Write-Host "✔ Analyse statique terminée" -ForegroundColor Green
} else {
    Write-Host "⏭ Analyse statique ignorée (--SkipAnalyzer)" -ForegroundColor Yellow
}

# --- 7. Tests Pester ---
if (-not $SkipTests) {
    Write-Host "`n🧪 Exécution des tests Pester..." -ForegroundColor Cyan
    Invoke-Pester
    Write-Host "✔ Tests terminés" -ForegroundColor Green
} else {
    Write-Host "⏭ Tests ignorés (--SkipTests)" -ForegroundColor Yellow
}

# --- 8. Import du module ---
Write-Host "`n📦 Import du module local..." -ForegroundColor Cyan
Import-Module ./SecureGen/SecureGen.psd1 -Force
Write-Host "✔ Module importé" -ForegroundColor Green

# --- 9. Résumé final ---
Write-Host "`n🎉 Environnement de développement prêt !" -ForegroundColor Green
Write-Host "──────────────────────────────────────────────────────────────"
Write-Host "📘 Module : SecureGen"
Write-Host "📁 Dossier : $PSScriptRoot"
Write-Host "🧩 Cmdlets : $((Get-Command -Module SecureGen).Count)"
Write-Host "📚 Docs : $(Get-ChildItem ./docs/cmdlets/*.md | Measure-Object).Count fichiers"
Write-Host "🧪 Tests : $(Get-ChildItem ./tests/*.ps1 | Measure-Object).Count fichiers"
Write-Host "──────────────────────────────────────────────────────────────`n"