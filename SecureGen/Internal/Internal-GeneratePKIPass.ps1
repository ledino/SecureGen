function Internal-GeneratePKIPass {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Password','Passphrase')]
        [string]$Type,

        [Parameter(Mandatory)]
        [int]$Length,

        [Parameter(Mandatory)]
        [int]$Words,

        [Parameter(Mandatory)]
        [int]$Letters,

        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent
    )

    if ($Type -eq 'Password') {
        $secret = Get-PassWord `
            -Length $Length `
            -UseSpecial `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear `
            -Silent:$Silent
    }
    else {
        $secret = Get-PassPhrase `
            -Words $Words `
            -Letters $Letters `
            -NoClipboard:$NoClipboard `
            -NoClear:$NoClear `
            -Silent:$Silent
    }

    return $secret
}
