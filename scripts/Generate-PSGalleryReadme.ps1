[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

Write-Verbose "🔧 Génération automatique du README PSGallery…"

# Racine du module
$moduleRoot = Join-Path $PSScriptRoot "..\SecureGen"
$readmePath = Join-Path $moduleRoot "README.md"

if (-not (Test-Path $moduleRoot)) {
    throw "Module root not found: $moduleRoot"
}

# ---------------------------------------------------------------------------
# Récupération des cmdlets publiques via AST
# ---------------------------------------------------------------------------

function Get-SecureGenCmdlets {
    param(
        [string]$ModuleRoot
    )

    $cmdlets = @()

    # Tous les fichiers .ps1 / .psm1 du module
    $files = Get-ChildItem $ModuleRoot -Filter *.ps* -File -Recurse

    foreach ($file in $files) {
        $ast = [System.Management.Automation.Language.Parser]::ParseFile(
            $file.FullName, [ref]$null, [ref]$null
        )

        if ($ast.Errors) {
            Write-Warning "Parse errors in $($file.FullName)"
            continue
        }

        $functions = $ast.FindAll({
            param($node)

            $isFunction = $node -is [System.Management.Automation.Language.FunctionDefinitionAst]
            if (-not $isFunction) { return $false }

            $name = $node.Name

            # Conventions pour ignorer les helpers internes
            $isPrivate =
                $name.StartsWith('Internal-') -or
                $name.StartsWith('_') -or
                $name.StartsWith('Private-') -or
                $name.StartsWith('Helper-')

            return -not $isPrivate
        }, $true)

        if ($functions) {
            $cmdlets += $functions.Name
        }
    }

    return $cmdlets | Sort-Object -Unique
}

# ---------------------------------------------------------------------------
# Récupération des synopsis PlatyPS
# ---------------------------------------------------------------------------

function Get-PlatySynopsis {
    param(
        [string]$ModuleRoot,
        [string[]]$Cmdlets
    )

    $synopsis = @{}

    $docsPath = Join-Path $ModuleRoot "docs"

    if (-not (Test-Path $docsPath)) {
        return $synopsis
    }

    $mdFiles = Get-ChildItem $docsPath -Filter *.md -File -Recurse

    foreach ($file in $mdFiles) {
        $content = Get-Content $file.FullName -Raw

        foreach ($cmdlet in $Cmdlets) {
            if ($content -match "(?ms)^#\s*$cmdlet\s*$(.+?)(?=^#|\Z)") {
                $block = $Matches[1]

                if ($block -match "(?m)^\.SYNOPSIS\s*(.+)$") {
                    $synopsis[$cmdlet] = $Matches[1].Trim()
                }
            }
        }
    }

    return $synopsis
}

# ---------------------------------------------------------------------------
# Génération des listes FR / EN
# ---------------------------------------------------------------------------

$cmdlets  = Get-SecureGenCmdlets -ModuleRoot $moduleRoot
$synopsis = Get-PlatySynopsis -ModuleRoot $moduleRoot -Cmdlets $cmdlets

# IMPORTANT : chaînes simples + concaténation pour éviter $(...) dans le README
$cmdletsFr = ($cmdlets | ForEach-Object {
    '- `' + $_ + '` — ' + ($synopsis[$_] ?? 'Cmdlet SecureGen')
}) -join "`n"

$cmdletsEn = ($cmdlets | ForEach-Object {
    '- `' + $_ + '` — ' + ($synopsis[$_] ?? 'SecureGen cmdlet')
}) -join "`n"

# ---------------------------------------------------------------------------
# Construction du README
# ---------------------------------------------------------------------------

$readmeContent = @"
# 📦 SecureGen v1.5.0 — PowerShell Module  
*(FR + EN — auto-generated)*

<details>
<summary><strong>🇫🇷 Français</strong></summary>

## 🔐 SecureGen — Module PowerShell v1.5.0

Module moderne et sécurisé pour générer mots de passe, passphrases, secrets PKI et index cryptographiques.

### 🚀 Cmdlets
$cmdletsFr

### 📦 Installation
\`powershell
Install-Module SecureGen -Scope CurrentUser
\`

### 🧪 Exemples
\`powershell
Get-PassWord -Length 20
Get-PassPhrase -Words 5
Get-PKIPass
\`

**Docs** : https://github.com/Ledino/SecureGen  
**Licence** : MIT © Ledino 2026

</details>

---

<details open>
<summary><strong>🇬🇧 English</strong></summary>

## 🔐 SecureGen v1.5.0 — PowerShell Module

Modern cross-platform module for secure passwords, passphrases, PKI secrets and crypto indexes.

### 🚀 Cmdlets
$cmdletsEn

### 📦 Install
\`powershell
Install-Module SecureGen -Scope CurrentUser
\`

### 🧪 Examples
\`powershell
Get-PassWord -Length 20
Get-PassPhrase -Words 5
Get-PKIPass
\`

**Docs** : https://github.com/Ledino/SecureGen  
**License** : MIT © Ledino 2026

</details>
"@

Set-Content -Path $readmePath -Value $readmeContent -Encoding UTF8

Write-Host "✅ README.md généré automatiquement : $readmePath"