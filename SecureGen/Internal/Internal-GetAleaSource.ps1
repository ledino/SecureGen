function Internal-GetAleaSource {
    [CmdletBinding()]
    param()

    if ($PSVersionTable.PSVersion.Major -ge 7) {
        return "Conforme NIST SP 800-90 (modules cryptographiques modernes)"
    }
    else {
        return "Non conforme NIST SP 800-90 mais sûr pour usage classique"
    }
}
