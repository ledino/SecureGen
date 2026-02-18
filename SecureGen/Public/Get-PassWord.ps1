function Get-PassWord {
    [CmdletBinding()]
    param(
        [int]$Length = 20,
        [string]$SpecialChars = '!@#$%^&*()_+-=[]{}<>/\|;~',
        [bool]$UseSpecial = $true,
        [switch]$RequireAllTypes,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    return Internal-GeneratePassword `
        -Length $Length `
        -SpecialChars $SpecialChars `
        -UseSpecial:$UseSpecial `
        -RequireAllTypes:$RequireAllTypes `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent
}
