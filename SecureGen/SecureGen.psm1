Set-StrictMode -Version Latest

<# 
.SYNOPSIS
Module PowerShell pour générer des mots de passe, passphrases et valeurs aléatoires cryptographiquement sûres.

.DESCRIPTION
SecureGen est un module PowerShell léger, multiplateforme et sécurisé, conçu pour produire :

- des mots de passe robustes et configurables
- des passphrases lisibles et hautement entropiques
- des secrets PKI (SecureString par défaut)
- des index aléatoires cryptographiquement sûrs
- un utilitaire sonore compatible Windows / Linux / macOS

Le module utilise automatiquement la meilleure source d’aléa disponible :

- Sous PowerShell 7+, Get-SecureRandom (conforme NIST SP 800‑90)
- Sous PowerShell 5.1, RandomNumberGenerator (.NET Framework)

SecureGen inclut également une gestion intelligente du presse‑papier, avec effacement automatique sécurisé, et des options de personnalisation avancées.

.NOTES
Auteur : Ledino
Version : 1.5.0
Site du projet : https://github.com/ledino/SecureGen
#>

# ---------------------------------------------------------------------------
# Chargement automatique des fonctions privées (non exportées)
# ---------------------------------------------------------------------------

$privatePath = Join-Path $PSScriptRoot "Private"
if (Test-Path $privatePath) {
    Get-ChildItem -Path $privatePath -Filter *.ps1 -File | ForEach-Object {
        . $_.FullName
    }
}

# ---------------------------------------------------------------------------
# Chargement automatique des fonctions publiques (exportées ensuite)
# ---------------------------------------------------------------------------

$publicPath = Join-Path $PSScriptRoot "Public"
if (Test-Path $publicPath) {
    Get-ChildItem -Path $publicPath -Filter *.ps1 -File | ForEach-Object {
        . $_.FullName
    }
}

# ---------------------------------------------------------------------------
# Alias pratiques
# ---------------------------------------------------------------------------

Set-Alias -Name sgw   -Value Get-PassWord
Set-Alias -Name sgp   -Value Get-PassPhrase
Set-Alias -Name sgpki -Value Get-PkiPass

# ---------------------------------------------------------------------------
# Export automatique des fonctions publiques
# ---------------------------------------------------------------------------

$publicFunctions = Get-ChildItem -Path $publicPath -Filter *.ps1 -File |
    ForEach-Object { $_.BaseName }

Export-ModuleMember -Function $publicFunctions -Alias @('sgw','sgp','sgpki')