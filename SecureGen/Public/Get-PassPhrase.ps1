function Get-PassPhrase {
    [CmdletBinding()]
    param(
        [int]$Words   = 7,
        [int]$Letters = 6,
        [string]$Separator = '-',
        [string]$Charset   = 'abcdefghijklmnopqrstuvwxyz',

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    return Internal-GeneratePassPhrase `
        -Words $Words `
        -Letters $Letters `
        -Separator $Separator `
        -Charset $Charset `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent
}
