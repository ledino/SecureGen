function Internal-DisplaySecret {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Secret,

        [Parameter(Mandatory)]
        [int]$Entropy,

        [Parameter(Mandatory)]
        [string]$AleaSource,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    if ($Silent) { return }

    Write-Host "🔐 $Secret" -ForegroundColor Green
    Write-Host "----------------------------"

    Write-Host "🧠 Entropie ($Entropy bits) : " -NoNewline -ForegroundColor Cyan
    if (-not $NoClipboard) {
        Write-Host "📋 Copié !"
    }
    else {
        Write-Host "(clipboard désactivé)"
    }

    Write-Host "🎲 Aléa utilisé : $AleaSource" -ForegroundColor Blue
    Write-Host "----------------------------"

    if (-not $NoClipboard -and -not $NoClear) {
        Write-Host "⏳ Clipboard 35s auto-clear or Ctrl+C continue" -ForegroundColor Yellow
    }
    elseif (-not $NoClipboard -and $NoClear) {
        Write-Host "📋 Clipboard conservé (NoClear activé)" -ForegroundColor Yellow
    }
    else {
        Write-Host "📋 Clipboard désactivé" -ForegroundColor Yellow
    }
}