<#
    Publish-SecureGen.ps1
    Script officiel de publication pour SecureGen
    Auteur : Ledino
    Version : 2.0
#>

$ErrorActionPreference = "Stop"

Set-Location (Split-Path $PSScriptRoot -Parent)

<#
Pour éviter l'erreur :
```
La demande a été abandonnée : Impossible de créer un canal sécurisé SSL/TLS.
```
Qui survient parce que :

- PowerShellGet v1 utilise **TLS 1.0/1.1 par défaut**  
- PSGallery **refuse tout sauf TLS 1.2+**  
- PowerShell 7 n’active pas toujours TLS 1.2 pour les commandes PowerShellGet v1
La commande suivante est recommandée
#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "🚀 Publication du module SecureGen..." -ForegroundColor Cyan

# ---------------------------------------------------------------------------
# 1. Vérification de la clé API PSGallery
# ---------------------------------------------------------------------------

if (-not $env:PSGALLERY_KEY) {
    Write-Error "❌ La variable d'environnement PSGALLERY_KEY n'est pas définie."
    Write-Host ""
    Write-Host "Définissez-la avec :" -ForegroundColor Yellow
    Write-Host '$env:PSGALLERY_KEY = "votre_clef_api"' -ForegroundColor Yellow
    exit 1
}

# ---------------------------------------------------------------------------
# 2. Vérification de la structure du module
# ---------------------------------------------------------------------------

$RequiredFiles = @(
    "./SecureGen/SecureGen.psm1",
    "./SecureGen/SecureGen.psd1",
    "./SecureGen/Core.PS7.ps1",
    "./SecureGen/Legacy.PS5.ps1"
)

foreach ($file in $RequiredFiles) {
    if (-not (Test-Path $file)) {
        Write-Error "❌ Fichier manquant : $file"
        exit 1
    }
}

Write-Host "✔ Structure valide" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 3. Lecture de la version du module
# ---------------------------------------------------------------------------

$Manifest = Import-PowerShellDataFile "./SecureGen/SecureGen.psd1"
$Version = $Manifest.ModuleVersion

Write-Host "📦 Version détectée : $Version" -ForegroundColor Cyan

# ---------------------------------------------------------------------------
# 4. Préparation du dossier temporaire
# ---------------------------------------------------------------------------

$Temp = "./out/publish"

if (Test-Path $Temp) {
    Remove-Item $Temp -Recurse -Force
}

New-Item -ItemType Directory -Path $Temp | Out-Null

Copy-Item -Path "./SecureGen/*" -Destination $Temp -Recurse -Force

Write-Host "📁 Dossier de publication prêt" -ForegroundColor Green

# ---------------------------------------------------------------------------
# 5. Publication PSGallery
# ---------------------------------------------------------------------------

Write-Host "🚀 Publication sur PowerShell Gallery..." -ForegroundColor Yellow

Publish-Module `
    -Path $Temp `
    -Repository "PSGallery" `
    -NuGetApiKey $env:PSGALLERY_KEY `
    -Verbose

Write-Host ""
Write-Host "🎉 Publication réussie !" -ForegroundColor Green
Write-Host "Module disponible sur :" -ForegroundColor Cyan
Write-Host "➡ https://www.powershellgallery.com/packages/SecureGen"