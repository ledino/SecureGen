<#
.SYNOPSIS
    Génère un index cryptographiquement sûr dans l’intervalle [0..Max-1].

.DESCRIPTION
    Sous PowerShell 7+, utilise toujours Get-SecureRandom.
    Cette source d’aléa est conforme aux modules cryptographiques modernes
    (alignée avec les recommandations NIST SP 800‑90).
#>
function Get-CryptoIndex {
    param([int]$Max)

    return Get-SecureRandom -Maximum $Max
}

<#
.SYNOPSIS
    Émet un bip sonore.

.DESCRIPTION
    Fonction utilitaire simple permettant d’émettre un bip.
    Compatible PowerShell 5.x et PowerShell 7+.
#>
function Invoke-Beep {
    param(
        [int]$Frequency = 800,
        [int]$Duration  = 200
    )

    try {
        [console]::Beep($Frequency, $Duration)
    }
    catch {
        Write-Host "[!] Impossible d'émettre un bip sur ce terminal." -ForegroundColor Yellow
    }
}

<#
.SYNOPSIS
    Génère une passephrase sécurisée et optionnellement la copie dans le presse‑papier.

.DESCRIPTION
    Produit une passephrase composée de mots générés caractère par caractère
    via un RNG cryptographique conforme aux modules modernes (PS7+).
    Affiche l’entropie, copie dans le presse‑papier,
    et efface automatiquement après 40 secondes (sauf options NoClipboard/NoClear).
#>
function Get-PassPhrase {
    param(
        [int]$LettresParMot = 6,
        [int]$MotsParBloc = 6,
        [string]$Separateur = '-',
        [string]$Charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # --- Détection de la source d'aléa ---
    $alea = "Crypto (Get-SecureRandom, conforme modules cryptographiques modernes)"

    # --- Génération des mots ---
    $bloc = @()
    for ($i = 0; $i -lt $MotsParBloc; $i++) {
        $indices = 1..$LettresParMot | ForEach-Object { Get-CryptoIndex -Max $Charset.Length }
        $mot = -join ($indices | ForEach-Object { $Charset[$_] })
        $bloc += $mot
    }

    $joined  = $bloc -join $Separateur
    $entropy = [math]::Round(($LettresParMot * $MotsParBloc) * [math]::Log($Charset.Length, 2))

    # --- Mode silencieux ---
    if ($Silent) {
        return $joined
    }

    # --- Copie ---
    if (-not $NoClipboard) { $joined | Set-Clipboard }

    # --- Affichage ---
    Write-Host "🔐 $joined" -ForegroundColor Green
    Write-Host "----------------------------"
    Write-Host "🧠 Passephrase ($entropy bits) : " -NoNewline -ForegroundColor Cyan
    if (-not $NoClipboard) { Write-Host "📋 Copié !" } else { Write-Host "(clipboard désactivé)" }
    Write-Host "🎲 Aléa utilisé : $alea" -ForegroundColor Blue
    Write-Host "   Séparateurs possibles : - . _ ! ?" -ForegroundColor Magenta
    Write-Host "----------------------------"
    Write-Host "⏳ Clipboard 35s auto-clear or Ctrl+C continue" -ForegroundColor Yellow
    # Write-Host "----------------------------"

    # --- Effacement automatique ---
    if (-not $NoClipboard -and -not $NoClear) {
        try { Start-Sleep 35 }
        finally {
            Set-Clipboard $null;
            Write-Host "[!] Clipboard cleared !" -ForegroundColor Red
            Invoke-Beep -Frequency 1200 -Duration 500
        }
    }
}


<#
.SYNOPSIS
    Génère un mot de passe sécurisé et configurable.

.DESCRIPTION
    Par défaut, utilise :
        - minuscules
        - majuscules
        - chiffres
        - caractères spéciaux (personnalisables)

    L’utilisateur peut :
        - personnaliser les caractères spéciaux via -SpecialChars
        - désactiver totalement les caractères spéciaux via -UseSpecial:$false

    L’aléa est généré via Get-SecureRandom (PS7+),
    conforme aux modules cryptographiques modernes.
#>
function Get-PassWord {
    param(
        [int]$Len = 20,

        # Caractères spéciaux personnalisables
        [string]$SpecialChars = '!@#$%^&*()_+-=[]{}<>/\;~',

        # Activation/désactivation des caractères spéciaux
        [bool]$UseSpecial = $true,

        # Options d'affichage
        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # --- Détection de la source d'aléa ---
    $alea = "Get-SecureRandom, conforme aux modules cryptos modernes (FIPS-compliant)"

    # --- Définition des catégories ---
    $Lower = 'abcdefghijklmnopqrstuvwxyz'
    $Upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $Digit = '0123456789'

    # --- Construction du charset ---
    $Charset = $Lower + $Upper + $Digit
    if ($UseSpecial) {
        $Charset += $SpecialChars
    }

    # --- Génération ---
    $indices = 1..$Len | ForEach-Object { Get-CryptoIndex -Max $Charset.Length }
    $mdp     = -join ($indices | ForEach-Object { $Charset[$_] })
    $entropy = [math]::Round($Len * [math]::Log($Charset.Length, 2))

    # --- Mode silencieux ---
    if ($Silent) {
        return $mdp
    }

    # --- Copie ---
    if (-not $NoClipboard) { $mdp | Set-Clipboard }

    # --- Affichage ---
    Write-Host "🔐 $mdp" -ForegroundColor Green
    Write-Host "----------------------------"
    Write-Host "🧠 Mot de passe ($entropy bits) : " -NoNewline -ForegroundColor Cyan
    if (-not $NoClipboard) { Write-Host "📋 Copié !" } else { Write-Host "(clipboard désactivé)" }
    Write-Host "🎲 Aléa utilisé : $alea" -ForegroundColor Blue
    #Write-Host "   Catégories utilisées :" -ForegroundColor Magenta
    #Write-Host "     - Minuscules : Oui"
    #Write-Host "     - Majuscules : Oui"
    #Write-Host "     - Chiffres   : Oui"
    #Write-Host "     - Spéciaux   : $UseSpecial ($SpecialChars)"
    Write-Host "----------------------------"
    Write-Host "⏳ Clipboard 35s auto-clear or Ctrl+C continue" -ForegroundColor Yellow
    # Write-Host "----------------------------"

    # --- Effacement automatique ---
    if (-not $NoClipboard -and -not $NoClear) {
        try { Start-Sleep 35 }
        finally { 
            Set-Clipboard $null; 
            Write-Host "[!] Clipboard cleared !" -ForegroundColor Red
            Invoke-Beep -Frequency 1200 -Duration 500
        }
    }
}

# Alias pratiques
Set-Alias sgp Get-PassPhrase
Set-Alias sgw Get-PassWord

# Export
Export-ModuleMember -Function Get-PassPhrase, Get-PassWord -Alias sgp, sgw