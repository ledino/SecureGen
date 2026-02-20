function Private-ValidatePassphrase {
    [CmdletBinding()]
    param(
        [int]$Words,
        [int]$Letters,
        [string]$Separator,
        [int]$MinTotalLength = 30
    )

    # --- 1) Minimum logique : 2 mots ---
    if ($Words -lt 2) {
        Write-Host ""
        Write-Host "ℹ  Info — Une passphrase doit contenir au moins 2 mots." -ForegroundColor Yellow
        Write-Host "   SecureGen génère automatiquement une passphrase robuste pour garantir votre sécurité." -ForegroundColor Cyan
        Write-Host ""
        return $false
    }

    # --- 2) Validation du séparateur ---
    $allowedSeparators = @('-', '.', '_', '~', ':', '=', '+')

    if ($Separator -notin $allowedSeparators) {
        Write-Host ""
        Write-Host "ℹ  Info — Le séparateur '$Separator' n'est pas autorisé." -ForegroundColor Yellow
        Write-Host "   Séparateurs valides : - . _ ~ : = + " -ForegroundColor Yellow
        Write-Host "   SecureGen applique automatiquement un séparateur sûr." -ForegroundColor Cyan
        Write-Host ""
        return $false
    }

    # --- 3) Règle ANSSI/CNIL : longueur totale >= 30 ---
    $totalLength = $Words * $Letters

    if ($totalLength -lt $MinTotalLength) {
        Write-Host ""
        Write-Host "ℹ  Info — La passphrase demandée est trop courte (minimum $MinTotalLength caractères recommandés)." -ForegroundColor Yellow
        Write-Host "   SecureGen génère automatiquement une passphrase robuste pour garantir votre sécurité." -ForegroundColor Cyan
        Write-Host ""
        return $false
    }

    return $true
}