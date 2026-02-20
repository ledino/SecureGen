function Internal-SetClipboardSafe {
    param([string]$Text)

    if ($IsWindows) {
        try {
            Set-Clipboard -Value $Text
        }
        catch {
            Write-Verbose "No clipboard tool available (Windows clipboard failure)."
        }
        return
    }

    if (Get-Command pbcopy -ErrorAction SilentlyContinue) {
        $Text | pbcopy
        return
    }

    if (Get-Command xclip -ErrorAction SilentlyContinue) {
        $Text | xclip -selection clipboard
        return
    }

    if (Get-Command xsel -ErrorAction SilentlyContinue) {
        $Text | xsel --clipboard --input
        return
    }

    Write-Verbose "No clipboard tool available (pbcopy/xclip/xsel)."
}