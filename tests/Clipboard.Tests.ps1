Describe "Clipboard functions" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    It "Set-ClipboardSafe appelle la bonne méthode interne" {
        Mock -CommandName Set-Clipboard -MockWith { param($v) $script:clip = $v }

        Set-ClipboardSafe "test123"

        $script:clip | Should -Be "test123"
    }

    It "Clear-ClipboardSafe appelle la bonne méthode interne" {
        Mock -CommandName Set-Clipboard -MockWith { param($v) $script:clip = $v }
        Mock -CommandName Clear-Clipboard -MockWith { $script:clip = "" }

        Set-ClipboardSafe "abc"
        Clear-ClipboardSafe

        $script:clip | Should -BeNullOrEmpty
    }

    It "Les fonctions ne jettent pas d’erreur" {
        { Set-ClipboardSafe "hello" } | Should -NotThrow
        { Clear-ClipboardSafe } | Should -NotThrow
    }
}