Set-StrictMode -Version Latest

<#
.SYNOPSIS
Module PowerShell pour générer des mots de passe, passphrases et valeurs aléatoires cryptographiquement sûres.

.DESCRIPTION
SecureGen est un module PowerShell léger, multiplateforme et sécurisé, conçu pour produire :

- des mots de passe robustes et configurables
- des passphrases lisibles et hautement entropiques
- des index aléatoires cryptographiquement sûrs
- un utilitaire sonore compatible Windows / Linux / macOS

Le module utilise automatiquement la meilleure source d’aléa disponible :

- Sous PowerShell 7+, Get-SecureRandom (conforme NIST SP 800‑90)
- Sous PowerShell 5.1, RandomNumberGenerator (.NET Framework)

SecureGen inclut également une gestion intelligente du presse‑papier, avec effacement automatique sécurisé, et des options de personnalisation avancées.

.EXAMPLE
Import-Module SecureGen
Get-PassWord

.EXAMPLE
Get-PassPhrase -MotsParBloc 7 -LettresParMot 5

.EXAMPLE
Get-CryptoIndex -Max 10

.EXAMPLE
Invoke-Beep -Frequency 1200 -Duration 300

.NOTES
Auteur : Saddek
Compatible Windows, Linux, macOS
Version : 1.4.0
Site du projet : https://github.com/ledino/SecureGen

.LINK
Get-PassWord

.LINK
Get-PassPhrase

.LINK
Get-CryptoIndex

.LINK
Invoke-Beep
#>

<#
    SecureGen.psm1
    Version : 1.4.0
    Auteur  : Ledino
    Date    : 2026-02-13

    Notes :
    - Chargement automatique PS7 / PS5
    - Architecture modulaire (Core.PS7.ps1 / Legacy.PS5.ps1)
    - Compatible Windows, Linux, macOS
    - Code propre, professionnel, PSGallery-ready
#>

# ---------------------------------------------------------------------------
# Détection automatique PowerShell 7 / PowerShell 5
# ---------------------------------------------------------------------------

if ($PSVersionTable.PSVersion.Major -ge 7) {
    # Version moderne (RandomNumberGenerator.GetBytes, Get-SecureRandom)
    . "$PSScriptRoot/Core.PS7.ps1"
}
else {
    # Version fallback Windows PowerShell 5.1 (RNGCryptoServiceProvider)
    . "$PSScriptRoot/Legacy.PS5.ps1"
}


# ---------------------------------------------------------------------------
# Fonction pour by passer la règle : convertion de la chaîne en SecureString
# ---------------------------------------------------------------------------

function Convert-ToSecureStringSafe {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSAvoidUsingConvertToSecureStringWithPlainText", ""
    )]
    param(
        [Parameter(Mandatory)]
        [string]$Value
    )

    return ConvertTo-SecureString $Value -AsPlainText -Force
}


# ---------------------------------------------------------------------------
# Fonction utilitaire pour PKI/SecureString
# ---------------------------------------------------------------------------

function Get-PKIPass {
<#
.SYNOPSIS
Génère un secret robuste (mot de passe ou passphrase) destiné aux usages PKI, certificats, clés privées ou comptes de service.

.DESCRIPTION
Get-PKIPass génère un secret hautement entropique adapté aux usages sensibles :

- Mode Password : 24 caractères aléatoires cryptographiquement sûrs.
- Mode Passphrase : 5 mots de 5 lettres, lisibles mais robustes.

L’utilisateur peut également demander un retour en SecureString pour intégration
dans des scripts, DSC, ou des modules nécessitant ce format.

.EXAMPLE
Get-PKIPass
Génère un mot de passe PKI de 24 caractères.

.EXAMPLE
Get-PKIPass -Type Passphrase
Génère une passphrase de 5×5 lettres.

.EXAMPLE
Get-PKIPass -AsSecureString
Retourne le secret sous forme de SecureString.

.EXAMPLE
Get-PKIPass -NoClipboard
Génère un secret sans copie dans le presse‑papier.

.PARAMETER Type
Type de secret à générer : Password (24 chars) ou Passphrase (5×5 lettres).

.PARAMETER AsSecureString
Retourne le secret sous forme de SecureString.

.PARAMETER NoClipboard
Empêche la copie automatique dans le presse‑papier.

.OUTPUTS
System.String  
System.Security.SecureString

.NOTES
Utilise Get-PassWord et Get-PassPhrase du module SecureGen.
#>

    [CmdletBinding()]
    param(
        [ValidateSet('Password','Passphrase')]
        [string]$Type = 'Password',

        [switch]$AsSecureString,
        [switch]$NoClipboard
    )

    # Génération du secret
    if ($Type -eq 'Password') {
        $secret = Get-PassWord -Len 32 -UseSpecial $true -NoClipboard:$NoClipboard
    }
    else {
        $secret = Get-PassPhrase -LettresParMot 5 -MotsParBloc 5 -NoClipboard:$NoClipboard
    }

    # Conversion SecureString si demandé
    if ($AsSecureString) {
        return Convert-ToSecureStringSafe $secret
    }

    return $secret
}


# ---------------------------------------------------------------------------
# Fonction Set-ClipboardSafe
# ---------------------------------------------------------------------------

function Set-ClipboardSafe {
<#
.SYNOPSIS
Copie du texte dans le presse‑papier de manière réellement cross‑platform.

.DESCRIPTION
Set-ClipboardSafe détecte automatiquement la plateforme et utilise la meilleure
méthode disponible pour copier du texte dans le presse‑papier :

- Windows : Set-Clipboard
- macOS   : pbcopy
- Linux   : xclip / xsel / wl-copy (selon disponibilité)

En cas d’échec, la fonction reste silencieuse pour ne pas interrompre l’exécution.

.PARAMETER Text
Texte à copier dans le presse‑papier.
#>

    param(
        [Parameter(Mandatory=$true)]
        [string]$Text
    )

    try {
        if ($IsWindows) {
            Set-Clipboard -Value $Text -ErrorAction Stop
            return
        }

        if ($IsMacOS) {
            $Text | pbcopy 2>$null
            return
        }

        if ($IsLinux) {
            if (Get-Command wl-copy -ErrorAction SilentlyContinue) {
                $Text | wl-copy 2>$null
                return
            }
            if (Get-Command xclip -ErrorAction SilentlyContinue) {
                $Text | xclip -selection clipboard 2>$null
                return
            }
            if (Get-Command xsel -ErrorAction SilentlyContinue) {
                $Text | xsel --clipboard --input 2>$null
                return
            }
        }
    }
    catch {
        # Silence volontaire
    }

    Write-Verbose "Clipboard non disponible sur cette plateforme."
}


# ---------------------------------------------------------------------------
# Fonction Clear-ClipboardSafe
# ---------------------------------------------------------------------------

function Clear-ClipboardSafe {
<#
.SYNOPSIS
Efface le presse‑papier de manière cross‑platform.

.DESCRIPTION
Efface le presse‑papier selon la plateforme :

- Windows : Set-Clipboard $null
- macOS   : pbcopy < /dev/null
- Linux   : wl-copy / xclip / xsel selon disponibilité

Reste silencieux en cas d’échec.
#>

    try {
        if ($IsWindows) {
            Set-Clipboard -Value $null -ErrorAction Stop
            return
        }

        if ($IsMacOS) {
            "" | pbcopy 2>$null
            return
        }

        if ($IsLinux) {
            if (Get-Command wl-copy -ErrorAction SilentlyContinue) {
                "" | wl-copy 2>$null
                return
            }
            if (Get-Command xclip -ErrorAction SilentlyContinue) {
                "" | xclip -selection clipboard 2>$null
                return
            }
            if (Get-Command xsel -ErrorAction SilentlyContinue) {
                "" | xsel --clipboard --input 2>$null
                return
            }
        }
    }
    catch {
        # Silence volontaire
    }

    Write-Verbose "Impossible d'effacer le presse‑papier sur cette plateforme."
}


# Alias pratiques
Set-Alias -Name sgpki -Value Get-PKIPass

# ---------------------------------------------------------------------------
# Export public
# ---------------------------------------------------------------------------

Export-ModuleMember -Function * -Alias *