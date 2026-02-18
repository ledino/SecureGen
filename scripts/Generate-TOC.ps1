<#
.SYNOPSIS
    Génère ou met à jour automatiquement une table des matières dans un fichier Markdown.

.DESCRIPTION
    Ce script :
    - détecte tous les titres (#, ##, ###)
    - génère une table des matières GitHub‑compatible
    - remplace automatiquement la section existante entre :
        <!-- TOC-START -->
        <!-- TOC-END -->
    - ou l’insère après le premier titre si elle n’existe pas
    - fonctionne sur n’importe quel fichier .md

.NOTES
    Auteur  : SecureGen Project
    Version : 1.0
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Path
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $Path)) {
    throw "❌ Fichier introuvable : $Path"
}

Write-Host "📑 Génération de la table des matières pour : $Path" -ForegroundColor Cyan

# ---------------------------------------------------------------------------
# 1. Lire le fichier
# ---------------------------------------------------------------------------

$content = Get-Content $Path -Raw
$lines   = $content -split "`n"

# ---------------------------------------------------------------------------
# 2. Extraire les titres Markdown
# ---------------------------------------------------------------------------

$headings = foreach ($line in $lines) {
    if ($line -match '^(#+)\s+(.*)$') {
        $level = $Matches[1].Length
        $text  = $Matches[2].Trim()

        # Génération de l’ancre GitHub
        $anchor = $text.ToLower()
        $anchor = $anchor -replace '[^\w\s-]', ''
        $anchor = $anchor -replace '\s+', '-'

        [PSCustomObject]@{
            Level  = $level
            Text   = $text
            Anchor = $anchor
        }
    }
}

if ($headings.Count -eq 0) {
    throw "❌ Aucun titre détecté dans le fichier."
}

# ---------------------------------------------------------------------------
# 3. Générer la TOC
# ---------------------------------------------------------------------------

$toc = @("<!-- TOC-START -->", "## 📑 Table des matières", "")

foreach ($h in $headings) {
    # On ignore le titre principal (#)
    if ($h.Level -eq 1) { continue }

    $indent = " " * (($h.Level - 2) * 2)
    $toc += "$indent- [$($h.Text)](#$($h.Anchor))"
}

$toc += "<!-- TOC-END -->"
$tocText = $toc -join "`n"

# ---------------------------------------------------------------------------
# 4. Remplacer ou insérer la TOC
# ---------------------------------------------------------------------------

if ($content -match '<!-- TOC-START -->') {
    Write-Host "🔄 Mise à jour de la TOC existante..." -ForegroundColor Yellow
    $updated = $content -replace '(?s)<!-- TOC-START -->.*?<!-- TOC-END -->', $tocText
}
else {
    Write-Host "🆕 Insertion d’une nouvelle TOC..." -ForegroundColor Yellow

    # Insérer après le premier titre (# ...)
    $updated = $content -replace '^(# .+)$', "`$1`n`n$tocText`n"
}

# ---------------------------------------------------------------------------
# 5. Écriture du fichier
# ---------------------------------------------------------------------------

Set-Content -Path $Path -Value $updated -Encoding UTF8

Write-Host "✔ TOC générée avec succès !" -ForegroundColor Green
