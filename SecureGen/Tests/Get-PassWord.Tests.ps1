Describe "Get-PassWord" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force

        # Mock clipboard to avoid platform issues
        Mock -CommandName Set-ClipboardSafe { }
        Mock -CommandName Clear-ClipboardSafe { }
    }

    Context "Basic behavior" {

        It "Génère un mot de passe de la longueur demandée" {
            $pw = Get-PassWord -Length 20 -NoClipboard
            $pw.Length | Should -Be 20
        }

        It "Retourne une string en mode normal" {
            $pw = Get-PassWord -NoClipboard
            $pw | Should -BeOfType 'System.String'
        }

        It "N’explose pas avec -NoClipboard" {
            { Get-PassWord -NoClipboard } | Should -NotThrow
        }
    }

    Context "Validation & corrections automatiques" {

        It "Corrige une longueur trop faible (8 → 16)" {
            $pw = Get-PassWord -Length 8 -Quiet
            $pw.Length | Should -Be 16
        }

        It "Corrige une longueur trop grande (300 → 256)" {
            $pw = Get-PassWord -Length 300 -Quiet
            $pw.Length | Should -Be 256
        }
    }

    Context "Caractères spéciaux" {

        It "Inclut des caractères spéciaux quand -UseSpecial est activé" {
            $pw = Get-PassWord -UseSpecial -Length 40 -Quiet
            ($pw -match '[!@#$%^&*()_\-=\[\]{};:,.<>/?]') | Should -BeTrue
        }

        It "N’inclut pas de caractères spéciaux quand -UseSpecial:$false" {
            $pw = Get-PassWord -UseSpecial:$false -Length 40 -Quiet
            ($pw -match '[!@#$%^&*()_\-=\[\]{};:,.<>/?]') | Should -BeFalse
        }
    }

    Context "Modes UX (Quiet / Raw / Silent)" {

        It "Quiet retourne uniquement le mot de passe" {
            $pw = Get-PassWord -Length 32 -Quiet
            $pw | Should -BeOfType 'System.String'
            $pw.Length | Should -Be 32
        }

        It "Raw retourne uniquement le mot de passe" {
            $pw = Get-PassWord -Length 32 -Raw
            $pw | Should -BeOfType 'System.String'
            $pw.Length | Should -Be 32
        }

        It "Silent retourne uniquement le mot de passe" {
            $pw = Get-PassWord -Length 32 -Silent
            $pw | Should -BeOfType 'System.String'
            $pw.Length | Should -Be 32
        }
    }

    Context "Pipeline behavior" {

        It "Ne pollue pas le pipeline en mode Quiet" {
            $len = (Get-PassWord -Length 40 -Quiet).Length
            $len | Should -Be 40
        }

        It "Ne pollue pas le pipeline en mode Raw" {
            $len = (Get-PassWord -Length 50 -Raw).Length
            $len | Should -Be 50
        }

        It "Ne pollue pas le pipeline en mode Silent" {
            $len = (Get-PassWord -Length 60 -Silent).Length
            $len | Should -Be 60
        }
    }

    Context "RequireAllTypes" {

        It "Inclut au moins une minuscule, majuscule, chiffre et spécial" {
            $pw = Get-PassWord -Length 40 -RequireAllTypes -Quiet

            ($pw -match '[a-z]') | Should -BeTrue
            ($pw -match '[A-Z]') | Should -BeTrue
            ($pw -match '\d')   | Should -BeTrue
            ($pw -match '[!@#$%^&*()_\-=\[\]{};:,.<>/?]') | Should -BeTrue
        }
    }
}