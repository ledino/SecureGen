function Internal-ValidateInput {
    param(
        [string]$Mode,              # 'Password', 'Passphrase', 'PKIPass'
        [switch]$Password,
        [switch]$Passphrase,
        [string[]]$UnknownOptions
    )

    # --- Paramètres système à exclure ---
    $CommonParams = @(
        'Verbose','Debug','ErrorAction','WarningAction','InformationAction',
        'ErrorVariable','WarningVariable','InformationVariable',
        'OutVariable','OutBuffer','PipelineVariable','ProgressAction'
    )

    # --- Filtrer les options inconnues pour ignorer les Common Parameters ---
    $UnknownOptions = $UnknownOptions | Where-Object { $CommonParams -notcontains $_ }

    # --- 1) Options inconnues ---
    if ($UnknownOptions -and $UnknownOptions.Count -gt 0) {

        $helpMode = switch ($Mode) {
            'Password'   { 'Password' }
            'Passphrase' { 'Passphrase' }
            'PKIPass'    {
                if ($Passphrase) { 'Passphrase' }
                elseif ($Password) { 'Password' }
                else { 'General' }
            }
        }

        Internal-DisplayHelp -Mode $helpMode -UnknownOptions $UnknownOptions
        return $false
    }

    # --- 2) Conflit explicite (uniquement pour Get-PKIPass) ---
    if ($Mode -eq 'PKIPass' -and $Password -and $Passphrase) {
        Write-Host "ℹ️ Vous ne pouvez pas utiliser -Password et -Passphrase en même temps." -ForegroundColor Yellow
        Write-Host "ℹ️ Veuillez choisir un seul mode." -ForegroundColor Yellow
        return $false
    }

    # --- 3) Aucun mode (uniquement pour Get-PKIPass) ---
    if ($Mode -eq 'PKIPass' -and -not $Password -and -not $Passphrase) {
        Write-Host "ℹ️ Veuillez choisir le type de secret :" -ForegroundColor Yellow
        Write-Host "       -Password   ou   -Passphrase" -ForegroundColor Yellow
        return $false
    }

    return $true
}