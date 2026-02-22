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
        [switch]$Silent,

        [string[]]$Warnings
    )

    # Mode silencieux → aucune UX, mais on renvoie la valeur
    if ($Silent) {
        return $Secret
    }

    # --- Affichage des warnings (options inconnues, incohérences, etc.) ---
    if ($Warnings -and $Warnings.Count -gt 0) {
        foreach ($w in $Warnings) {
            if ([string]::IsNullOrWhiteSpace($w)) { continue }
            Write-Host "ℹ️ $w" -ForegroundColor Yellow
        }
        Write-Host ""
    }

    # --- UX principale ---
    if ($Type -eq 'Password') {
        Write-Host "`n[🔐] Mot de passe généré :" -ForegroundColor Green
    }
    else {
        Write-Host "`n[🔐] Passphrase générée :" -ForegroundColor Green
    }

    Write-Host " 👉   $Secret"
    Write-Host "--------------------------------"

    Write-Host "[🧠] Entropie estimée : $Entropy bits" -ForegroundColor Cyan

    if (-not $NoClipboard -and -not $NoClear) {
        Write-Host "[📋] Presse-papier : copié, effacement automatique dans 30 secondes ou Crtl+C." -ForegroundColor Yellow
    }
    elseif (-not $NoClipboard -and $NoClear) {
        Write-Host "[📋] Presse-papier : copié, conservé (NoClear activé)." -ForegroundColor Yellow
    }
    else {
        Write-Host "[📋] Presse-papier : désactivé." -ForegroundColor Yellow
    }

    Write-Host "[🎲] Source d'aléa : $AleaSource" -ForegroundColor Blue
    Write-Host "--------------------------------"

    return $Secret
}