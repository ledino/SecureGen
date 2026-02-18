function Internal-Beep {
    [CmdletBinding()]
    param(
        [int]$Frequency = 800,
        [int]$Duration  = 200
    )

    try {
        if ($IsWindows) {
            [Console]::Beep($Frequency, $Duration)
        }
        else {
            # Caractère BEL compatible Linux/macOS
            printf "`a" 2>$null
        }
    }
    catch {
        Write-Verbose "Impossible d'émettre un bip sur ce terminal."
    }
}
