function Internal-HandleClipboardLifecycle {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Secret,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # En mode Silent : aucune gestion du clipboard, aucune attente
    if ($Silent) {
        return
    }

    # --- 1) Copie dans le presse-papier ---

    if (-not $NoClipboard) {
        Set-ClipboardSafe -Text $Secret
    }

    # --- 2) Effacement automatique après 30 secondes ---
    if (-not $NoClipboard -and -not $NoClear) {

        try {
            Start-Sleep -Seconds 30
        }
        finally {
            Clear-ClipboardSafe

            # --- 3) Notification (sans réafficher le secret) ---
            if (-not $Silent) {
                Write-Host " [!] Clipboard cleared.`n" -ForegroundColor Red
                Internal-Beep -Frequency 1200 -Duration 500
            }
        }
    }
}