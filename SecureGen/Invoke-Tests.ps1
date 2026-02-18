<#
.SYNOPSIS
Lance l’ensemble des tests Pester du module SecureGen.

.DESCRIPTION
Ce script exécute tous les tests présents dans le dossier Tests/,
affiche un résumé clair, et renvoie un code de sortie adapté pour
les pipelines CI/CD (0 = succès, 1 = échec).

.EXAMPLE
.\Invoke-Tests.ps1
#>

param(
    [switch]$CI
)

Write-Host "=== SecureGen - Exécution des tests Pester ===" -ForegroundColor Cyan

$testsPath = Join-Path $PSScriptRoot "Tests"

if (-not (Test-Path $testsPath)) {
    Write-Host "Dossier 'Tests' introuvable." -ForegroundColor Red
    exit 1
}

# Chargement du module avant les tests
$modulePath = Join-Path $PSScriptRoot "SecureGen.psd1"
Import-Module $modulePath -Force

# Exécution Pester
$configuration = [PesterConfiguration]::Default
$configuration.Run.Path = $testsPath
$configuration.Run.PassThru = $true
$configuration.Output.Verbosity = "Detailed"

$result = Invoke-Pester -Configuration $configuration

# Résultat global
if ($result.FailedCount -gt 0) {
    Write-Host "`n❌ Tests échoués : $($result.FailedCount)" -ForegroundColor Red
    if ($CI) { exit 1 }
}
else {
    Write-Host "`n✅ Tous les tests ont réussi !" -ForegroundColor Green
    if ($CI) { exit 0 }
}