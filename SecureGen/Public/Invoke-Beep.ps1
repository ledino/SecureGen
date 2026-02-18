function Invoke-Beep {
    [CmdletBinding()]
    param(
        [int]$Frequency = 800,
        [int]$Duration  = 200
    )

    Internal-Beep -Frequency $Frequency -Duration $Duration
}
