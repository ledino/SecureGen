function Set-ClipboardSafe {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Text
    )

    try {
        if ($IsWindows) {
            Set-Clipboard -Value $Text
        }
        else {
            # Linux / macOS : xclip, pbcopy, etc.
            if (Get-Command pbcopy -ErrorAction SilentlyContinue) {
                $Text | pbcopy
            }
            elseif (Get-Command xclip -ErrorAction SilentlyContinue) {
                $Text | xclip -selection clipboard
            }
            elseif (Get-Command xsel -ErrorAction SilentlyContinue) {
                $Text | xsel --clipboard --input
            }
            else {
                Write-Verbose "Aucun utilitaire de clipboard disponible sur cette plateforme."
            }
        }
    }
    catch {
        Write-Verbose "Impossible de copier dans le presse-papier : $($_.Exception.Message)"
    }
}

function Clear-ClipboardSafe {
    [CmdletBinding()]
    param()

    try {
        if ($IsWindows) {
            Set-Clipboard -Value ""
        }
        else {
            if (Get-Command pbcopy -ErrorAction SilentlyContinue) {
                printf "" | pbcopy
            }
            elseif (Get-Command xclip -ErrorAction SilentlyContinue) {
                printf "" | xclip -selection clipboard
            }
            elseif (Get-Command xsel -ErrorAction SilentlyContinue) {
                printf "" | xsel --clipboard --input
            }
            else {
                Write-Verbose "Aucun utilitaire de clipboard disponible pour effacer le contenu."
            }
        }
    }
    catch {
        Write-Verbose "Impossible d'effacer le presse-papier : $($_.Exception.Message)"
    }
}
