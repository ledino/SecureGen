<#
.SYNOPSIS
    Installation locale intelligente du module SecureGen pour PS5.1 et PS7.

.DESCRIPTION
    Ce script :
    - détecte automatiquement PowerShell 5.1 et PowerShell 7
    - installe SecureGen dans les bons chemins utilisateurs
    - crée les dossiers si nécessaire
    - copie le module proprement
    - permet un nettoyage optionnel
    - affiche un résumé clair

.NOTES
    Auteur  : SecureGen Project
    Version : 2.0
#>

[CmdletBinding()]
param(
    [switch]$Force,
    [switch]$Clean
)

$ErrorActionPreference = "Stop"

Write-Host "🔐 Installation du module SecureGen..." -ForegroundColor Cyan
Write-Host "──────────────────────────────────────────────`n"

# ---------------------------------------------------------------------------
# 1. Détection des environnements PowerShell
# ---------------------------------------------------------------------------

$HasPS5 = Test-Path "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe"
$HasPS7 = Get-Command pwsh -ErrorAction SilentlyContinue

Write-Host "📦 Détection des environnements :" -ForegroundColor Cyan
Write-Host " - PowerShell 5.1 : $HasPS5"
Write-Host " - PowerShell 7.x : $([bool]$HasPS7)"
Write-Host ""

if (-not $HasPS5 -and -not $HasPS7) {
    throw "❌ Aucun environnement PowerShell compatible détecté."
}

# ---------------------------------------------------------------------------
# 2. Définition des chemins d’installation
# ---------------------------------------------------------------------------

$ModuleName = "SecureGen"

$PS5Path = Join-Path $env:USERPROFILE "Documents\WindowsPowerShell\Modules\$ModuleName"
$PS7Path = Join-Path $env:USERPROFILE "Documents\PowerShell\Modules\$ModuleName"

# ---------------------------------------------------------------------------
# 3. Fonction d’installation
# ---------------------------------------------------------------------------

function Install-ToPath {
    param(
        [string]$TargetPath
    )

    if ($Clean -and (Test-Path $TargetPath)) {
        Write-Host "🧹 Nettoyage du dossier existant : $TargetPath" -ForegroundColor Yellow
        Remove-Item $TargetPath -Recurse -Force
    }

    if (-not (Test-Path $TargetPath)) {
        New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
    }

    Write-Host "📦 Copie du module vers : $TargetPath" -ForegroundColor Yellow
    Copy-Item -Path "./SecureGen/*" -Destination $TargetPath -Recurse -Force
}

# ---------------------------------------------------------------------------
# 4. Installation selon les versions détectées
# ---------------------------------------------------------------------------

if ($HasPS5) {
    Write-Host "➡️ Installation pour PowerShell 5.1..." -ForegroundColor Yellow
    Install-ToPath -TargetPath $PS5Path
}

if ($HasPS7) {
    Write-Host "➡️ Installation pour PowerShell 7..." -ForegroundColor Yellow
    Install-ToPath -TargetPath $PS7Path
}

# ---------------------------------------------------------------------------
# 5. Résumé final
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "✅ Installation terminée !" -ForegroundColor Green
Write-Host "──────────────────────────────────────────────"

if ($HasPS5) {
    Write-Host " - Installé pour PowerShell 5.1 : $PS5Path"
}
if ($HasPS7) {
    Write-Host " - Installé pour PowerShell 7 : $PS7Path"
}

Write-Host ""
Write-Host "Vous pouvez maintenant utiliser : Get-PassWord, Get-PassPhrase, Get-PKIPass, sgw, sgp"
Write-Host "──────────────────────────────────────────────`n"
