Describe "Internal-GeneratePassword" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1"
    }

    Context "Basic behavior" {

        It "Génère un mot de passe de la longueur demandée" {
            $pw = Internal-GeneratePassword -Length 32
            $pw.Length | Should -Be 32
        }

        It "Retourne une string" {
            $pw = Internal-GeneratePassword -Length 20
            $pw | Should -BeOfType 'System.String'
        }

        It "Ne jette pas d’erreur" {
            { Internal-GeneratePassword -Length 20 } | Should -NotThrow
        }
    }

    Context "Validation & corrections automatiques" {

        It "Corrige une longueur trop faible (8 → 16)" {
            $pw = Internal-GeneratePassword -Length 8
            $pw.Length | Should -Be 16
        }

        It "Corrige une longueur trop grande (300 → 256)" {
            $pw = Internal-GeneratePassword -Length 300
            $pw.Length | Should -Be 256
        }
    }

    Context "Charset behavior" {

        It "Utilise uniquement les caractères du charset" {
            $charset = "abcXYZ123"
            $pw = Internal-GeneratePassword -Length 50 -Charset $charset

            ($pw.ToCharArray() | ForEach-Object { $charset.Contains($_) }) -notcontains $false |
                Should -BeTrue
        }

        It "N’inclut pas de caractères spéciaux quand -UseSpecial:$false" {
            $pw = Internal-GeneratePassword -Length 40 -UseSpecial:$false
            ($pw -match '[!@#$%^&*()_\-=\[\]{};:,.<>/?]') | Should -BeFalse
        }

        It "Inclut des caractères spéciaux quand -UseSpecial" {
            $pw = Internal-GeneratePassword -Length 40 -UseSpecial
            ($pw -match '[!@#$%^&*()_\-=\[\]{};:,.<>/?]') | Should -BeTrue
        }
    }

    Context "RequireAllTypes" {

        It "Inclut au moins une minuscule, majuscule, chiffre et spécial" {
            $pw = Internal-GeneratePassword -Length 40 -RequireAllTypes

            ($pw -match '[a-z]') | Should -BeTrue
            ($pw -match '[A-Z]') | Should -BeTrue
            ($pw -match '\d')   | Should -BeTrue
            ($pw -match '[!@#$%^&*()_\-=\[\]{};:,.<>/?]') | Should -BeTrue
        }
    }

    Context "Integration with Internal-RandomString" {

        It "Appelle Internal-RandomString pour la génération principale" {
            Mock -CommandName Internal-RandomString -MockWith { "A" * 10 }

            $pw = Internal-GeneratePassword -Length 10

            Assert-MockCalled Internal-RandomString -Times 1
            $pw | Should -Be "A" * 10
        }
    }

    Context "Pipeline behavior" {

        It "Ne pollue pas le pipeline" {
            $len = (Internal-GeneratePassword -Length 25).Length
            $len | Should -Be 25
        }
    }

    Context "Distribution minimale" {

        It "Produit des valeurs variées (test statistique simple)" {
            $values = 1..200 | ForEach-Object { Internal-GeneratePassword -Length 1 }
            ($values | Select-Object -Unique).Count | Should -BeGreaterThan 5
        }
    }

    Context "Edge cases" {

        It "Accepte Length = 16 (minimum)" {
            $pw = Internal-GeneratePassword -Length 16
            $pw.Length | Should -Be 16
        }

        It "Accepte Length = 256 (maximum)" {
            $pw = Internal-GeneratePassword -Length 256
            $pw.Length | Should -Be 256
        }
    }
}