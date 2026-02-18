function Private-ValidatePassphrase {
    [CmdletBinding()]
    param(
        [int]$Words,
        [int]$Letters,
        [int]$MinTotalLength = 30
    )

    # 🔐 Règle logique : minimum 2 mots
    if ($Words -lt 2) {
        Write-Host ""
        Write-Host "ℹ Info — Une passphrase doit contenir au moins 2 mots." -ForegroundColor Yellow
        Write-Host "   SecureGen génère automatiquement une passphrase robuste pour garantir votre sécurité." -ForegroundColor Yellow
        Write-Host ""
        return $false
    }

    # 🔐 Règle logique : au moins 1 lettre par mot
    if ($Letters -lt 1) {
        Write-Host ""
        Write-Host "ℹ Info — Chaque mot doit contenir au moins 1 lettre." -ForegroundColor Yellow
        Write-Host "   SecureGen génère automatiquement une passphrase robuste pour garantir votre sécurité." -ForegroundColor Yellow
        Write-Host ""
        return $false
    }

    $totalLength = $Words * $Letters

    # 🔐 Règle ANSSI/CNIL : longueur minimale
    if ($totalLength -lt $MinTotalLength) {
        Write-Host ""
        Write-Host "ℹ Info — La passphrase demandée est trop courte (minimum $MinTotalLength caractères recommandés)." -ForegroundColor Yellow
        Write-Host "   SecureGen génère automatiquement une passphrase robuste pour garantir votre sécurité." -ForegroundColor Yellow
        Write-Host ""
        return $false
    }

    return $true
}
