function Internal-ClearClipboardSafe {
    [CmdletBinding()]
    param()

    if ($IsWindows) {
        try {
            Set-Clipboard -Value ""
        }
        catch {
            Write-Verbose "No clipboard tool available (Windows clipboard failure)."
        }
        return
    }

    if (Get-Command pbcopy -ErrorAction SilentlyContinue) {
        printf "" | pbcopy
        return
    }

    if (Get-Command xclip -ErrorAction SilentlyContinue) {
        printf "" | xclip -selection clipboard
        return
    }

    if (Get-Command xsel -ErrorAction SilentlyContinue) {
        printf "" | xsel --clipboard --input
        return
    }

    # 🔥 Aucun outil trouvé → verbose
    Write-Verbose "No clipboard tool available (pbcopy/xclip/xsel)."
}