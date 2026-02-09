@{
    # Module metadata
    RootModule        = 'SecureGen.psm1'
    ModuleVersion = '1.3.2'
    GUID              = 'b4f7c2c3-1c9e-4e4d-9f8a-9e2a4c1d7a31'
    Author            = 'Saddek'
    CompanyName       = 'SecureGen Project'
    Copyright         = '(c) 2026'
    Description       = 'Module PowerShell moderne pour gÃ©nÃ©rer des mots de passe, passphrases et clÃ©s sÃ©curisÃ©es. Compatible PowerShell 5 et 7, avec clipboard cross-platform et ergonomie soignÃ©e.'

    # PowerShell compatibility
    PowerShellVersion = '5.1'
    CompatiblePSEditions = @('Desktop','Core')

    # Files
    ScriptsToProcess  = @()
    TypesToProcess    = @()
    FormatsToProcess  = @()
    NestedModules     = @()

    # Functions & Aliases
    FunctionsToExport = @(
        'Get-PassWord',
        'Get-PassPhrase',
        'Get-CryptoIndex',
        'Invoke-Beep',
        'Set-ClipboardSafe',
        'Clear-ClipboardSafe'
    )

    AliasesToExport = @(
        'sgp',
        'sgw'
    )

    CmdletsToExport   = @()
    VariablesToExport = '*'

    # Private data
    PrivateData = @{
        PSData = @{
            Tags = @(
                'Security',
                'Password',
                'Passphrase',
                'Clipboard',
                'PowerShell',
                'CrossPlatform',
                'Crypto'
            )

            LicenseUri = 'https://opensource.org/licenses/MIT'
            ProjectUri = 'https://github.com/<ton-user>/SecureGen'
            IconUri    = 'https://raw.githubusercontent.com/<ton-user>/SecureGen/main/assets/logo.png'

            ReleaseNotes = @"
Version 1.3.1 :
- CompatibilitÃ© PowerShell 5 & 7
- Clipboard cross-platform avec warnings propres
- Beep encapsulÃ©
- Nettoyage du code et robustesse accrue
"@
        }
    }

    # Misc
    HelpInfoURI = ''
}
