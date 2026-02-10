<#
    Versioning-SecureGen.ps1
    Script d’incrémentation automatique de version pour SecureGen
#>

Set-Location (Split-Path $PSScriptRoot -Parent)

param(
    [switch]$Major,
    [switch]$Minor,
    [switch]$Patch
)

$ErrorActionPreference = "Stop"

Write-Host "🔢 Versioning automatique — SecureGen" -ForegroundColor Cyan

# ---------------------------------------------------------------------------
# 1. Charger le manifest
# ---------------------------------------------------------------------------

$ManifestPath = "./src/SecureGen.psd1"

if (-not (Test-Path $ManifestPath)) {
    Write-Error "❌ Impossible de trouver SecureGen.psd1"
    exit 1
}

$Manifest = Import-PowerShellDataFile $ManifestPath
$OldVersion = [version]$Manifest.ModuleVersion

Write-Host "📦 Version actuelle : $OldVersion" -ForegroundColor Yellow

# ---------------------------------------------------------------------------
# 2. Calcul de la nouvelle version
# ---------------------------------------------------------------------------

if ($Major) {
    $NewVersion = [version]::new($OldVersion.Major + 1, 0, 0)
}
elseif ($Minor) {
    $NewVersion = [version]::new($OldVersion.Major, $OldVersion.Minor + 1, 0)
}
else {
    # Patch par défaut
    $NewVersion = [version]::new($OldVersion.Major, $OldVersion.Minor, $OldVersion.Build + 1)
}

Write-Host "➡️ Nouvelle version : $NewVersion" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 3. Mise à jour du manifest
# ---------------------------------------------------------------------------

$Content = Get-Content $ManifestPath -Raw
$Replacement = "ModuleVersion = '$NewVersion'"
$Updated = $Content -replace "ModuleVersion\s*=\s*'[^']+'", $Replacement

Set-Content -Path $ManifestPath -Value $Updated -Encoding UTF8

Write-Host "✔ Manifest mis à jour" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 4. Mise à jour du CHANGELOG
# ---------------------------------------------------------------------------

$ChangelogPath = "./CHANGELOG.md"

if (-not (Test-Path $ChangelogPath)) {
    Write-Error "❌ CHANGELOG.md introuvable"
    exit 1
}

$Date = (Get-Date).ToString("yyyy-MM-dd")

$NewEntry = @"
## 🚀 $NewVersion — $Date
### Nouveautés
- (À compléter)

### Améliorations
- (À compléter)

### Corrections
- (À compléter)

---
"@

$OldChangelog = Get-Content $ChangelogPath -Raw
Set-Content -Path $ChangelogPath -Value ($NewEntry + "`n" + $OldChangelog) -Encoding UTF8

Write-Host "✔ CHANGELOG mis à jour" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 5. Commit Git + Tag
# ---------------------------------------------------------------------------

Write-Host "📌 Création du commit Git..." -ForegroundColor Cyan

git add .
git commit -m "🔖 Release $NewVersion"
git tag "v$NewVersion"

Write-Host "✔ Commit et tag créés" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 Version $NewVersion prête !" -ForegroundColor Cyan
Write-Host "Vous pouvez maintenant publier avec :" -ForegroundColor Yellow
Write-Host "  .\build.ps1 -Publish"