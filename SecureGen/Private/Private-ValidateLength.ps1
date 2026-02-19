function Private-ValidateLength {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Length,

        [Parameter(Mandatory)]
        [int]$Min,

        [Parameter(Mandatory)]
        [int]$Max
    )

    # Trop petit → message UX + correction automatique
    if ($Length -lt $Min) {
        Write-Host ""
        Write-Host "ℹ  Info — La longueur demandée ($Length) est trop faible (minimum recommandé : $Min)." -ForegroundColor Yellow
        Write-Host "   SecureGen génère automatiquement un mot de passe robuste pour garantir votre sécurité.`n"
        return $false
    }

    # Trop grand → message UX + correction automatique
    if ($Length -gt $Max) {
        Write-Host ""
        Write-Host "ℹ  Info — La longueur demandée ($Length) dépasse la limite maximale ($Max)." -ForegroundColor Yellow
        Write-Host "   SecureGen ajuste automatiquement la longueur pour rester dans une plage sécurisée.`n"
        return $false
    }

    # Longueur valide → renvoi direct
    return $true
}