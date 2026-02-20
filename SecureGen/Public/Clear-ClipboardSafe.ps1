function Clear-ClipboardSafe {
    [CmdletBinding()]
    param()

    process {
        Internal-ClearClipboardSafe
    }
}