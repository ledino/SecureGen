<#
    Install-SecureGen.ps1
    Installation intelligente pour SecureGen
    Auteur : Ledino
    Version : 1.0
#>

$ErrorActionPreference = "Stop"

Set-Location (Split-Path $PSScriptRoot -Parent)

Write-Host "🔐 Installation du module SecureGen..." -ForegroundColor Cyan

# ---------------------------------------------------------------------------
# Détection des environnements PowerShell
# ---------------------------------------------------------------------------

$HasPS5 = Test-Path "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe"
$HasPS7 = Get-Command pwsh -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "📦 Détection des environnements :" -ForegroundColor Cyan
Write-Host " - PowerShell 5.1 : $HasPS5"
Write-Host " - PowerShell 7.x : $([bool]$HasPS7)"
Write-Host ""

# ---------------------------------------------------------------------------
# Définition des chemins d’installation
# ---------------------------------------------------------------------------

$ModuleName = "SecureGen"

$PS5Path = Join-Path $env:USERPROFILE "Documents\WindowsPowerShell\Modules\$ModuleName"
$PS7Path = Join-Path $env:USERPROFILE "Documents\PowerShell\Modules\$ModuleName"

# ---------------------------------------------------------------------------
# Fonction d’installation
# ---------------------------------------------------------------------------

function Install-ToPath {
    param(
        [string]$TargetPath
    )

    if (-not (Test-Path $TargetPath)) {
        New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
    }

    Copy-Item -Path "./src/*" -Destination $TargetPath -Recurse -Force
}

# ---------------------------------------------------------------------------
# Installation selon les versions détectées
# ---------------------------------------------------------------------------

if ($HasPS5) {
    Write-Host "➡️ Installation dans PowerShell 5.1..." -ForegroundColor Yellow
    Install-ToPath -TargetPath $PS5Path
}

if ($HasPS7) {
    Write-Host "➡️ Installation dans PowerShell 7..." -ForegroundColor Yellow
    Install-ToPath -TargetPath $PS7Path
}

if (-not $HasPS5 -and -not $HasPS7) {
    Write-Error "❌ Aucune version de PowerShell compatible n'a été trouvée."
    exit 1
}

# ---------------------------------------------------------------------------
# Résumé
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "✅ Installation terminée !" -ForegroundColor Green

if ($HasPS5) {
    Write-Host " - Installé pour PowerShell 5.1 : $PS5Path"
}
if ($HasPS7) {
    Write-Host " - Installé pour PowerShell 7 : $PS7Path"
}

Write-Host ""
Write-Host "Vous pouvez maintenant utiliser : Get-PassWord, Get-PassPhrase, spw, spp"