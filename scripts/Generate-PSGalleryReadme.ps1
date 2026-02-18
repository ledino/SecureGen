[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

Write-Host "🔧 Génération automatique du README PSGallery…" -ForegroundColor Cyan

# ---------------------------------------------------------------------------
# 1. Détection du module et récupération de la version
# ---------------------------------------------------------------------------

$moduleRoot   = Join-Path $PSScriptRoot "..\SecureGen"
$manifestPath = Join-Path $moduleRoot "SecureGen.psd1"
$readmePath   = Join-Path $moduleRoot "README.md"

if (-not (Test-Path $manifestPath)) {
    throw "❌ Manifest introuvable : $manifestPath"
}

$manifest = Test-ModuleManifest -Path $manifestPath
$moduleVersion = $manifest.Version.ToString()

Write-Host "✔ Version détectée : $moduleVersion" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 2. Récupération des cmdlets publiques via le manifest
# ---------------------------------------------------------------------------

$cmdlets = $manifest.FunctionsToExport

if (-not $cmdlets -or $cmdlets.Count -eq 0) {
    throw "❌ Aucune fonction exportée trouvée dans le manifest."
}

Write-Host "✔ Cmdlets détectées : $($cmdlets -join ', ')" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 3. Récupération des synopsis depuis docs/cmdlets/*.md
# ---------------------------------------------------------------------------

$docsPath = Join-Path $PSScriptRoot "..\docs\cmdlets"
$synopsis = @{}

foreach ($cmdlet in $cmdlets) {
    $file = Join-Path $docsPath "$cmdlet.md"

    if (-not (Test-Path $file)) {
        $synopsis[$cmdlet] = "Cmdlet SecureGen"
        continue
    }

    $content = Get-Content $file -Raw

    if ($content -match "(?m)^\.SYNOPSIS\s*(.+)$") {
        $synopsis[$cmdlet] = $Matches[1].Trim()
    }
    else {
        $synopsis[$cmdlet] = "Cmdlet SecureGen"
    }
}

# ---------------------------------------------------------------------------
# 4. Construction des listes FR / EN
# ---------------------------------------------------------------------------

$cmdletsFr = ($cmdlets | ForEach-Object {
    "- `$_` — $($synopsis[$_])"
}) -join "`n"

$cmdletsEn = ($cmdlets | ForEach-Object {
    "- `$_` — $($synopsis[$_] -replace 'é','e' -replace 'è','e' -replace 'à','a')"
}) -join "`n"

# ---------------------------------------------------------------------------
# 5. Construction du README PSGallery-friendly
# ---------------------------------------------------------------------------

$readmeContent = @"
# 📦 SecureGen v$moduleVersion — PowerShell Module  
*(FR + EN — auto-generated)*

---

## 🇫🇷 Français

### 🔐 SecureGen — Module PowerShell v$moduleVersion

Module moderne et sécurisé pour générer mots de passe, passphrases, secrets PKI et index cryptographiques.

### 🚀 Cmdlets
$cmdletsFr

### 📦 Installation
\`\`\`powershell
Install-Module SecureGen -Scope CurrentUser
\`\`\`

### 🧪 Exemples

\`\`\`powershell
Get-PassWord -Length 20
Get-PassPhrase -Words 5
Get-PKIPass
\`\`\`

Documentation complète : https://github.com/Ledino/SecureGen  
Licence : MIT © Ledino 2026

---

## 🇬🇧 English

### 🔐 SecureGen v$moduleVersion — PowerShell Module

Modern cross-platform module for secure passwords, passphrases, PKI secrets and crypto indexes.

### 🚀 Cmdlets
$cmdletsEn

### 📦 Install
\`\`\`powershell
Install-Module SecureGen -Scope CurrentUser
\`\`\`

### 🧪 Examples

\`\`\`powershell
Get-PassWord -Length 20
Get-PassPhrase -Words 5
Get-PKIPass
\`\`\`

Full documentation: https://github.com/Ledino/SecureGen  
License: MIT © Ledino 2026
"@

# ---------------------------------------------------------------------------
# 6. Écriture du README
# ---------------------------------------------------------------------------

Set-Content -Path $readmePath -Value $readmeContent -Encoding UTF8

Write-Host "✅ README.md généré automatiquement : $readmePath" -ForegroundColor Green
