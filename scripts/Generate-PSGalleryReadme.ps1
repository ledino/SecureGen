<#
.SYNOPSIS
    Génère automatiquement README.md pour PowerShell Gallery (FR+EN, collapsible),
    avec extraction dynamique des cmdlets et synopsis depuis PlatyPS.
#>

# --- FUNCTIONS ---------------------------------------------------------------

function Get-SecureGenCmdlets {
    param(
        [string]$ModulePath = (Join-Path $PSScriptRoot "SecureGen.psm1")
    )

    # Parse AST
    $ast = [System.Management.Automation.Language.Parser]::ParseFile(
        $ModulePath, [ref]$null, [ref]$null
    )

    # Gestion d’erreurs AST
    if ($ast.Errors) {
        Write-Warning "PSM1 parse errors: $($ast.Errors.Count)"
        return @()
    }

    # Extraction des fonctions
    $functions = $ast.FindAll({
        param($node)
        $node -is [System.Management.Automation.Language.FunctionDefinitionAst]
    }, $true)

    return $functions.Name
}

function Get-CmdletSynopsis {
    param(
        [string]$DocsPath = (Join-Path $PSScriptRoot "docs/cmdlets")
    )

    $synopsis = @{}

    if (-not (Test-Path $DocsPath)) {
        return $synopsis
    }

    Get-ChildItem $DocsPath -Filter *.md | ForEach-Object {
        $name = $_.BaseName
        $content = Get-Content $_.FullName -Raw

        # Regex synopsis robuste
        if ($content -match '## SYNOPSIS\s*\r?\n\s*(.+?)(?=\r?\n##|\Z)') {
            $synopsis[$name] = $matches[1].Trim()
        }
    }

    return $synopsis
}

# --- MAIN --------------------------------------------------------------------

# Manifest
$manifest = Import-PowerShellDataFile (Join-Path $PSScriptRoot "SecureGen.psd1")
$version  = $manifest.ModuleVersion
$author   = $manifest.Author
$year     = (Get-Date).Year

# Cmdlets + synopsis
$cmdlets  = Get-SecureGenCmdlets
$synopsis = Get-CmdletSynopsis

# Tri alphabétique
$cmdlets = $cmdlets | Sort-Object

# Formatage automatique FR
$cmdletsFr = ($cmdlets | ForEach-Object {
    "- \`$_\` — $($synopsis[$_] ?? 'Cmdlet SecureGen')"
}) -join "`n"

# Formatage automatique EN
$cmdletsEn = ($cmdlets | ForEach-Object {
    "- \`$_\` — $($synopsis[$_] ?? 'SecureGen cmdlet')"
}) -join "`n"

# Chemin README
$readmePath = Join-Path $PSScriptRoot "SecureGen\README.md"

# Contenu README
$readmeContent = @"
# 📦 SecureGen v$version — PowerShell Module  
*(FR + EN — auto-generated)*

<details>
<summary><strong>🇫🇷 Français</strong></summary>

## 🔐 SecureGen — Module PowerShell v$version

Module moderne et sécurisé pour générer mots de passe, passphrases, secrets PKI et index cryptographiques.

### 🚀 Cmdlets
$cmdletsFr

### 📦 Installation
```powershell
Install-Module SecureGen -Scope CurrentUser
```

### 🧪 Exemples
```powershell
Get-PassWord -Length 20
Get-PassPhrase -Words 5
Get-PKIPass
```

**Docs** : https://github.com/Ledino/SecureGen  
**Licence** : MIT © $author $year

</details>

---

<details open>
<summary><strong>🇬🇧 English</strong></summary>

## 🔐 SecureGen v$version — PowerShell Module

Modern cross-platform module for secure passwords, passphrases, PKI secrets and crypto indexes.

### 🚀 Cmdlets
$cmdletsEn

### 📦 Install
```powershell
Install-Module SecureGen -Scope CurrentUser
```

### 🧪 Examples
```powershell
Get-PassWord -Length 20
Get-PassPhrase -Words 5
Get-PKIPass
```

**Docs** : https://github.com/Ledino/SecureGen  
**License** : MIT © $author $year

</details>
"@

# Écriture du fichier
Set-Content -Path $readmePath -Value $readmeContent -Encoding UTF8NoBOM -NoNewline

Write-Host "✅ README.md généré automatiquement : $readmePath (v$version)"
