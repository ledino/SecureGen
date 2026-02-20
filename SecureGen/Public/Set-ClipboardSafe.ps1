function Set-ClipboardSafe {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string]$Text
    )

    process {
        Internal-SetClipboardSafe -Text $Text
    }
}