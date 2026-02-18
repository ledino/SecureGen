function Internal-HandleClipboardLifecycle {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Secret,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    # --- Copie dans le presse-papier ---
    if (-not $NoClipboard) {
        Set-ClipboardSafe -Text $Secret
    }

    # --- Effacement automatique après 35 secondes ---
    if (-not $NoClipboard -and -not $NoClear) {
        try {
            Start-Sleep -Seconds 35
        }
        finally {
            Clear-ClipboardSafe

            if (-not $Silent) {
                Write-Host "[!] Clipboard cleared !" -ForegroundColor Red
                Internal-Beep -Frequency 1200 -Duration 500
            }
        }
    }
}
