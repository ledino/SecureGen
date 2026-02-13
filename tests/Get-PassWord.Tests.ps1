Describe "Get-PassWord" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    It "Génère un mot de passe de la longueur demandée" {
        $pw = Get-PassWord -Len 20 -NoClipboard
        $pw.Length | Should -Be 20
    }

    It "Retourne une string" {
        $pw = Get-PassWord -NoClipboard
        $pw | Should -BeOfType 'System.String'
    }

    It "Inclut des caractères spéciaux quand -UseSpecial est activé" {
        $pw = Get-PassWord -UseSpecial -NoClipboard
        $pw -match '[!@#$%^&*()_\-=

\[\]

{};:,.<>/?]' | Should -BeTrue
    }

    It "N’explose pas avec -NoClipboard" {
        { Get-PassWord -NoClipboard } | Should -NotThrow
    }
}
