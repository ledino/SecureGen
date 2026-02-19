Describe "Clipboard functions" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    Context "Set-ClipboardSafe" {

        It "Appelle Set-Clipboard avec la bonne valeur" {
            Mock -CommandName Set-Clipboard -MockWith { param($v) $script:clip = $v }

            Set-ClipboardSafe "test123"

            $script:clip | Should -Be "test123"
        }

        It "Ne jette pas d’erreur même si Set-Clipboard échoue" {
            Mock -CommandName Set-Clipboard -MockWith { throw "Clipboard error" }

            { Set-ClipboardSafe "hello" } | Should -NotThrow
        }

        It "Ne pollue pas le pipeline" {
            $result = Set-ClipboardSafe "abc"
            $result | Should -BeNullOrEmpty
        }
    }

    Context "Clear-ClipboardSafe" {

        It "Appelle Clear-Clipboard correctement" {
            Mock -CommandName Clear-Clipboard -MockWith { $script:clip = "" }
            Mock -CommandName Set-Clipboard -MockWith { param($v) $script:clip = $v }

            Set-ClipboardSafe "abc"
            Clear-ClipboardSafe

            $script:clip | Should -BeNullOrEmpty
        }

        It "Ne jette pas d’erreur même si Clear-Clipboard échoue" {
            Mock -CommandName Clear-Clipboard -MockWith { throw "Clipboard error" }

            { Clear-ClipboardSafe } | Should -NotThrow
        }

        It "Ne pollue pas le pipeline" {
            $result = Clear-ClipboardSafe
            $result | Should -BeNullOrEmpty
        }
    }

    Context "Cross-platform behavior" {

        It "Ne jette pas d’erreur sur plateformes sans clipboard" {
            # Simulation d’un environnement sans clipboard
            Mock -CommandName Set-Clipboard -MockWith { throw "Not supported" }
            Mock -CommandName Clear-Clipboard -MockWith { throw "Not supported" }

            { Set-ClipboardSafe "x" } | Should -NotThrow
            { Clear-ClipboardSafe }   | Should -NotThrow
        }
    }
}