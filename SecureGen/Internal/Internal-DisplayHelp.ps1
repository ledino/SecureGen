function Internal-DisplayHelp {
    param(
        [string]$Mode,              # 'Password', 'Passphrase', 'General'
        [string[]]$UnknownOptions
    )

    # --- Paramètres système à exclure ---
    $CommonParams = @(
        'Verbose','Debug','ErrorAction','WarningAction','InformationAction',
        'ErrorVariable','WarningVariable','InformationVariable',
        'OutVariable','OutBuffer','PipelineVariable','ProgressAction'
    )

    # --- Paramètres internes SecureGen à exclure ---
    $InternalParams = @('UnknownOptions')

    # --- Descriptions des paramètres ---
    $Descriptions = @{
        # Password
        'Length'          = 'Longueur du mot de passe généré'
        'SpecialChars'    = 'Liste des caractères spéciaux autorisés'
        'NoSpecial'       = 'Désactive les caractères spéciaux'
        'RequireAllTypes' = 'Exige minuscule/majuscule/chiffre/spécial'

        # Passphrase
        'Words'           = 'Nombre de mots dans la passphrase'
        'Letters'         = 'Nombre de lettres par mot'
        'Separator'       = 'Séparateur entre les mots'
        'Uppercase'       = 'Met la première lettre de chaque mot en majuscule'
        'Digits'          = 'Ajoute un chiffre à chaque mot'

        # Commun
        'NoClipboard'     = 'Désactive la copie automatique dans le presse-papier'
        'NoClear'         = "Empêche l'effacement automatique du presse-papier"
        'Quiet'           = 'Affiche uniquement le secret'
        'Raw'             = 'Retourne uniquement la valeur brute'
        'Silent'          = 'Aucune sortie, renvoie seulement la valeur'
    }

    if ($UnknownOptions) {
        Write-Host "ℹ️ Option inconnue : $($UnknownOptions -join ', ')" -ForegroundColor Yellow
        Write-Host ""
    }

    # --- Paramètres Password ---
    $pwParams = (Get-Command Get-PassWord).Parameters.Keys |
                Where-Object { $CommonParams -notcontains $_ } |
                Where-Object { $InternalParams -notcontains $_ } |
                Sort-Object

    # --- Paramètres Passphrase ---
    $ppParams = (Get-Command Get-PassPhrase).Parameters.Keys |
                Where-Object { $CommonParams -notcontains $_ } |
                Where-Object { $InternalParams -notcontains $_ } |
                Sort-Object

    # --- Paramètres de la fonction appelante ---
    $callerParams = $PSCmdlet.MyInvocation.MyCommand.Parameters.Keys |
                    Where-Object { $CommonParams -notcontains $_ } |
                    Where-Object { $InternalParams -notcontains $_ } |
                    Sort-Object

    # --- Options communes (vraies options SecureGen) ---
    $commonParams = $pwParams |
                    Where-Object { $ppParams -contains $_ } |
                    Where-Object { $callerParams -contains $_ }

    # --- Paramètres spécifiques ---
    $pwOnly = $pwParams | Where-Object { $commonParams -notcontains $_ }
    $ppOnly = $ppParams | Where-Object { $commonParams -notcontains $_ }

    # --- Filtrage selon le mode demandé ---
    $showModes      = ($Mode -eq 'General' -or $Mode -eq 'PKIPass')
    $showPassword   = ($Mode -eq 'Password'   -or $Mode -eq 'General' -or $Mode -eq 'PKIPass')
    $showPassphrase = ($Mode -eq 'Passphrase' -or $Mode -eq 'General' -or $Mode -eq 'PKIPass')

    # --- Calcul de l’alignement ---
    $allParams = @($pwOnly + $ppOnly + $commonParams)
    $maxLen = ($allParams | Measure-Object -Property Length -Maximum).Maximum

    # --- HELP STRUCTURÉ EN ARBORESCENCE ---

    if ($showModes) {
        Write-Host "│=== Modes disponibles ===" -ForegroundColor Cyan
        Write-Host "│"
        Write-Host "├── -Password"
        Write-Host "│   └── Génère un mot de passe robuste"
        Write-Host "├── -Passphrase"
        Write-Host "│   └── Génère une phrase secrète sécurisée"
        Write-Host "│"
    }

    if ($showPassword) {
        Write-Host "│=== Paramètres Password ===" -ForegroundColor Cyan
        foreach ($p in $pwOnly) {
            $desc = $Descriptions[$p]
            $padding = ' ' * ($maxLen - $p.Length)
            Write-Host "│   ├── -$p$padding  # $desc"
        }
        Write-Host "│   │"
    }

    if ($showPassphrase) {
        Write-Host "│=== Paramètres Passphrase ===" -ForegroundColor Cyan
        foreach ($p in $ppOnly) {
            $desc = $Descriptions[$p]
            $padding = ' ' * ($maxLen - $p.Length)
            Write-Host "│   ├── -$p$padding  # $desc"
        }
        Write-Host "│   │"
    }

    Write-Host "│=== Options communes ===" -ForegroundColor Cyan
    $last = $commonParams[-1]
    foreach ($p in $commonParams) {
        $desc = $Descriptions[$p]
        $padding = ' ' * ($maxLen - $p.Length)

        if ($p -eq $last) {
            Write-Host "│   └── -$p$padding  # $desc"
        } else {
            Write-Host "│   ├── -$p$padding  # $desc"
        }
    }

    Write-Host ""
}