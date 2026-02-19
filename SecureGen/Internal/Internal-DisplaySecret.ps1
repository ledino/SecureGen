function Internal-DisplaySecret {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Secret,

        [Parameter(Mandatory)]
        [int]$Entropy,

        [Parameter(Mandatory)]
        [string]$AleaSource,

        [Parameter(Mandatory)]
        [ValidateSet('Password','Passphrase')]
        [string]$Type,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # Mode silencieux : aucun affichage
    if ($Silent) { return }

    # Titre dynamique
    if ($Type -eq 'Password') {
        Write-Host "🔐 Mot de passe généré :" -ForegroundColor Green
    }
    else {
        Write-Host "🔐 Passphrase générée :" -ForegroundColor Green
    }

    Write-Host $Secret
    Write-Host "----------------------------"

    Write-Host "🧠 Entropie estimée : $Entropy bits" -ForegroundColor Cyan

    if (-not $NoClipboard -and -not $NoClear) {
        Write-Host "📋 Presse-papier : copié, effacement automatique dans 35 secondes." -ForegroundColor Yellow
    }
    elseif (-not $NoClipboard -and $NoClear) {
        Write-Host "📋 Presse-papier : copié, conservé (NoClear activé)." -ForegroundColor Yellow
    }
    else {
        Write-Host "📋 Presse-papier : désactivé." -ForegroundColor Yellow
    }

    Write-Host "🎲 Source d'aléa : $AleaSource" -ForegroundColor Blue
    Write-Host "----------------------------"
}