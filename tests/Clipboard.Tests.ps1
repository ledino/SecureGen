Describe "Clipboard functions" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    It "Set-ClipboardSafe place du texte dans le presse-papier" {
        Set-ClipboardSafe "test123"
        $clip = Get-Clipboard
        $clip | Should -Be "test123"
    }

    It "Clear-ClipboardSafe efface le presse-papier" {
        Set-ClipboardSafe "abc"
        Clear-ClipboardSafe
        $clip = Get-Clipboard
        $clip | Should -BeNullOrEmpty
    }

    It "Les fonctions ne jettent pas d’erreur" {
        { Set-ClipboardSafe "hello" } | Should -NotThrow
        { Clear-ClipboardSafe } | Should -NotThrow
    }
}
