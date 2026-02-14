function Get-CryptoIndex {
<#
.SYNOPSIS
Génère un entier aléatoire cryptographiquement sûr dans l’intervalle [0 .. Max-1].

.DESCRIPTION
Get-CryptoIndex retourne un entier pseudo‑aléatoire sécurisé compris entre 0 et Max - 1.

Le générateur utilisé dépend de la version de PowerShell :
- Sous PowerShell 7+, l’aléa provient de Get-SecureRandom (conforme NIST SP 800‑90).
- Sous PowerShell 5.1, l’aléa provient de RNG .NET Framework (RandomNumberGenerator).

Ce cmdlet est utilisé en interne par SecureGen pour garantir une distribution uniforme
et une entropie maximale lors de la génération de mots de passe, passphrases ou sélections aléatoires.

.EXAMPLE
Get-CryptoIndex -Max 10
Génère un index compris entre 0 et 9.

.EXAMPLE
$items = "alpha","beta","gamma","delta"
$index = Get-CryptoIndex -Max $items.Count
$items[$index]
Sélectionne un élément aléatoire dans un tableau.

.EXAMPLE
1..6 | ForEach-Object { Get-CryptoIndex -Max 6 }
Génère plusieurs tirages sécurisés.

.PARAMETER Max
Valeur maximale (exclusive).  
Le résultat sera compris entre 0 et Max - 1.  
Une exception est levée si Max est inférieur ou égal à 0.

.OUTPUTS
System.Int32  
Retourne un entier aléatoire cryptographiquement sûr.

.NOTES
Compatible Windows, Linux, macOS.  
Utilisé en interne par les autres cmdlets SecureGen.  
Garantit une distribution uniforme même pour des valeurs de Max non puissances de 2.
#>

    param([int]$Max)

    return Get-SecureRandom -Maximum $Max
}


function Invoke-Beep {
<#
.SYNOPSIS
Émet un bip sonore compatible Windows, Linux et macOS.

.DESCRIPTION
Invoke-Beep est une fonction utilitaire simple permettant d’émettre un bip sonore.

Elle est utilisée par d’autres cmdlets SecureGen (comme Get-PassWord et Get-PassPhrase)
pour signaler la fin d’une opération, sauf si l’utilisateur active l’option -Silent.

Le comportement dépend de la plateforme :
- Windows : utilise [Console]::Beep()
- Linux / macOS : utilise le caractère BEL (`\a`) ou une alternative compatible terminal

.EXAMPLE
Invoke-Beep
Émet un bip standard (800 Hz, 200 ms).

.EXAMPLE
Invoke-Beep -Frequency 1200
Émet un bip plus aigu (1200 Hz).

.EXAMPLE
Invoke-Beep -Duration 500
Émet un bip plus long (500 ms).

.EXAMPLE
Invoke-Beep -Frequency 1000 -Duration 300
Émet un bip personnalisé.

.PARAMETER Frequency
Fréquence du bip en Hertz (Hz).  
Plus la valeur est élevée, plus le son est aigu.  
Valeur par défaut : 800.

.PARAMETER Duration
Durée du bip en millisecondes (ms).  
Valeur par défaut : 200.

.OUTPUTS
None  
La fonction ne retourne aucune valeur.  
Elle produit uniquement un signal sonore.

.NOTES
Compatible Windows, Linux, macOS.  
Utilisé en interne par les autres cmdlets SecureGen.  
Peut être désactivé via l’option -Silent des autres cmdlets.
#>

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



function Get-PassPhrase {
<#
.SYNOPSIS
Génère une passphrase robuste, lisible et configurable, compatible Windows / Linux / macOS.

.DESCRIPTION
Get-PassPhrase génère une passphrase composée de mots pseudo‑aléatoires construits caractère par caractère
via un générateur cryptographique sécurisé.

- Sous PowerShell 7+, l’aléa provient de Get-SecureRandom (conforme NIST SP 800‑90).
- Sous PowerShell 5.1, l’aléa provient de RNG .NET Framework (RandomNumberGenerator).

La passphrase est :
- lisible
- régulière
- hautement entropique
- idéale pour un usage quotidien ou professionnel

Par défaut, SecureGen :
- copie la passphrase dans le presse‑papier
- efface automatiquement le presse‑papier après un délai sécurisé
- émet un bip discret (désactivable via -Silent)

Vous pouvez personnaliser :
- le nombre de lettres par mot (-LettresParMot)
- le nombre de mots par bloc (-MotsParBloc)
- le séparateur (-Separateur)
- le charset utilisé (-Charset)
- le comportement du presse‑papier (-NoClipboard, -NoClear)
- le bip (-Silent)

.EXAMPLE
Get-PassPhrase
Génère une passphrase standard (6 mots de 6 lettres).

.EXAMPLE
Get-PassPhrase -LettresParMot 5 -MotsParBloc 7
Génère une passphrase longue (7 mots de 5 lettres).

.EXAMPLE
Get-PassPhrase -Charset 'abcdefghijklmnopqrstuvwxyz'
Génère une passphrase uniquement composée de lettres minuscules.

.EXAMPLE
Get-PassPhrase -Silent
Génère une passphrase sans bip sonore.

.EXAMPLE
Get-PassPhrase -NoClipboard
Génère une passphrase sans copie dans le presse‑papier.

.PARAMETER LettresParMot
Nombre de lettres par mot généré.  
Valeur par défaut : 6.

.PARAMETER MotsParBloc
Nombre de mots composant la passphrase.  
Valeur par défaut : 6.

.PARAMETER Separateur
Caractère ou chaîne utilisée pour séparer les mots.  
Valeur par défaut : "-".

.PARAMETER Charset
Ensemble de caractères utilisés pour générer les mots.  
Valeur par défaut : lettres majuscules, minuscules et chiffres.

.PARAMETER NoClipboard
Empêche la copie automatique de la passphrase dans le presse‑papier.

.PARAMETER NoClear
Empêche l’effacement automatique du presse‑papier après un délai sécurisé.

.PARAMETER Silent
Désactive le bip de confirmation.

.OUTPUTS
System.String  
Retourne la passphrase générée.

.NOTES
Compatible Windows, Linux, macOS.  
PS7 utilise Get-SecureRandom.  
PS5.1 utilise RNG .NET Framework.  
Le clipboard utilise automatiquement la meilleure méthode selon la plateforme.  
Le séparateur peut être un caractère ou une chaîne complète.
#>

    [CmdletBinding()]
    param(
        [Alias('Length','Lenght')]
        [int]$Len = 6,

        [Alias('WordsCount','NbWords')]
        [int]$Words = 6,

        [string]$Separator = '-',

        [string]$Charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # Vérification des paramètres
    if ($Len -lt 1) { throw "Len doit être supérieur ou égal à 1." }
    if ($Words -lt 1) { throw "Words doit être supérieur ou égal à 1." }

    # Source d'aléa
    $alea = "Conforme NIST SP 800-90 (modules cryptographiques modernes)"

    # Génération cryptographique
    $bloc = @()
    for ($i = 0; $i -lt $Words; $i++) {
        $indices = 1..$Len | ForEach-Object { Get-CryptoIndex -Max $Charset.Length }
        $mot = -join ($indices | ForEach-Object { $Charset[$_] })
        $bloc += $mot
    }

    $joined = $bloc -join $Separator   # <-- Correction ici

    # Calcul entropie
    $entropy = [math]::Round(($Words * $Len) * [math]::Log($Charset.Length, 2))

    # Mode silencieux
    if ($Silent) {
        if (-not $NoClipboard) { Set-ClipboardSafe -Text $joined }
        return $joined
    }

    # Copie
    if (-not $NoClipboard) { Set-ClipboardSafe -Text $joined }

    # Affichage
    Write-Host "🔐 $joined" -ForegroundColor Green
    Write-Host "----------------------------"
    Write-Host "🧠 Passephrase ($entropy bits) : " -NoNewline -ForegroundColor Cyan
    if (-not $NoClipboard) { Write-Host "📋 Copié !" } else { Write-Host "(clipboard désactivé)" }
    Write-Host "🎲 Aléa utilisé : $alea" -ForegroundColor Blue
    Write-Host "   Séparateurs possibles : - . _ ! ?" -ForegroundColor Magenta
    Write-Host "----------------------------"
    Write-Host "⏳ Clipboard 35s auto-clear or Ctrl+C continue" -ForegroundColor Yellow

    # Effacement automatique
    if (-not $NoClipboard -and -not $NoClear) {
        try { Start-Sleep 35 }
        finally {
            Clear-ClipboardSafe
            Write-Host "[!] Clipboard cleared !" -ForegroundColor Red
            Invoke-Beep -Frequency 1200 -Duration 500
        }
    }
}


function Get-PassWord {
<#
.SYNOPSIS
Génère un mot de passe sécurisé, configurable et compatible Windows / Linux / macOS.

.DESCRIPTION
Get-PassWord génère un mot de passe robuste en utilisant un générateur cryptographique sécurisé.

- Sous PowerShell 7+, l’aléa provient de Get-SecureRandom (conforme NIST SP 800‑90).
- Sous PowerShell 5.1, l’aléa provient de RNG .NET Framework (RandomNumberGenerator).

Le mot de passe inclut par défaut :
- minuscules
- majuscules
- chiffres
- caractères spéciaux (personnalisables)

Vous pouvez :
- personnaliser les caractères spéciaux via -SpecialChars
- désactiver totalement les caractères spéciaux via -UseSpecial:$false
- exiger la présence de toutes les catégories via -RequireAllTypes
- désactiver la copie dans le presse‑papier (-NoClipboard)
- empêcher l’effacement automatique du presse‑papier (-NoClear)
- désactiver le bip de confirmation (-Silent)

.PARAMETER Len
Longueur du mot de passe à générer.  
Valeur par défaut : 20.

.PARAMETER SpecialChars
Liste personnalisée de caractères spéciaux à utiliser.

.PARAMETER UseSpecial
Active ou désactive l’utilisation de caractères spéciaux.  
Valeur par défaut : True.

.PARAMETER RequireAllTypes
Exige que le mot de passe contienne au moins :
- une minuscule
- une majuscule
- un chiffre
- un caractère spécial (si UseSpecial = $true)

.PARAMETER NoClipboard
Empêche la copie automatique du mot de passe dans le presse‑papier.

.PARAMETER NoClear
Empêche l’effacement automatique du presse‑papier après un délai sécurisé.

.PARAMETER Silent
Désactive le bip de confirmation.

.OUTPUTS
System.String  
Retourne le mot de passe généré.
#>

    param(
        [int]$Len = 20,

        # Caractères spéciaux personnalisables
        [string]$SpecialChars = '[!@#$%^&*()_+\-=\[\]{}<>\/\\|;~]', # True (= } < { )


        # Activation/désactivation des caractères spéciaux
        [bool]$UseSpecial = $true,

        # Exiger toutes les catégories
        [bool]$RequireAllTypes = $false,

        # Options d'affichage
        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # --- Détection de la source d'aléa ---
    $alea = "Conforme NIST SP 800-90"

    # --- Définition des catégories ---
    $Lower = 'abcdefghijklmnopqrstuvwxyz'
    $Upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $Digit = '0123456789'

    # --- Construction du charset ---
    $Charset = $Lower + $Upper + $Digit
    if ($UseSpecial) {
        $Charset += $SpecialChars
    }

    # --- Génération initiale ---
    $indices = 1..$Len | ForEach-Object { Get-CryptoIndex -Max $Charset.Length }
    $mdp     = -join ($indices | ForEach-Object { $Charset[$_] })
    $entropy = [math]::Round($Len * [math]::Log($Charset.Length, 2))

    # --- RequireAllTypes ---
	# Garantit que le mot de passe contient au moins 1 minuscule, 1 majuscule, 1 chiffre & 1 caractère spécial
    
	if ($RequireAllTypes) {
        do {
            $indices = 1..$Len | ForEach-Object { Get-CryptoIndex -Max $Charset.Length }
            $mdp     = -join ($indices | ForEach-Object { $Charset[$_] })

            $hasLower   = $mdp -match '[a-z]'
            $hasUpper   = $mdp -match '[A-Z]'
            $hasDigit   = $mdp -match '\d'
            $hasSpecial = $mdp -match "[$SpecialChars]"

            # Si UseSpecial = $false → on n’exige PAS de caractère spécial
            $requireSpecial = $UseSpecial ? $hasSpecial : $true

        } while (-not ($hasLower -and $hasUpper -and $hasDigit -and $requireSpecial))
    }

	$entropy = [math]::Round($Len * [math]::Log($Charset.Length, 2))

    # Mode silencieux
    if ($Silent) {
        if (-not $NoClipboard) { Set-ClipboardSafe -Text $mdp }
        return $mdp
    }

    # --- Copie ---
    if (-not $NoClipboard) { Set-ClipboardSafe -Text $mdp }

    # --- Affichage ---
    Write-Host "🔐 $mdp" -ForegroundColor Green
    Write-Host "----------------------------"
    Write-Host "🧠 Mot de passe ($entropy bits) : " -NoNewline -ForegroundColor Cyan
    if (-not $NoClipboard) { Write-Host "📋 Copié !" } else { Write-Host "(clipboard désactivé)" }
    Write-Host "🎲 Aléa utilisé : $alea" -ForegroundColor Blue
    Write-Host "----------------------------"
    Write-Host "⏳ Clipboard 35s auto-clear or Ctrl+C continue" -ForegroundColor Yellow

    # --- Effacement automatique ---
    if (-not $NoClipboard -and -not $NoClear) {
        try { Start-Sleep 35 }
        finally { 
            Clear-ClipboardSafe
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