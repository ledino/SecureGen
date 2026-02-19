Describe "Internal-RandomString" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    Context "Basic behavior" {

        It "Génère une chaîne de la longueur demandée" {
            $str = Internal-RandomString -Length 32 -Charset "abc"
            $str.Length | Should -Be 32
        }

        It "N’explose pas avec un charset simple" {
            { Internal-RandomString -Length 10 -Charset "abc" } | Should -NotThrow
        }

        It "Ne pollue pas le pipeline" {
            $result = Internal-RandomString -Length 10 -Charset "abc"
            $result | Should -BeOfType 'System.String'
        }
    }

    Context "Charset behavior" {

        It "Utilise uniquement les caractères du charset" {
            $charset = "abcXYZ123"
            $str = Internal-RandomString -Length 50 -Charset $charset

            ($str.ToCharArray() | ForEach-Object { $charset.Contains($_) }) -notcontains $false |
                Should -BeTrue
        }

        It "Fonctionne avec un charset d’un seul caractère" {
            $str = Internal-RandomString -Length 20 -Charset "x"
            $str | Should -Be "x" * 20
        }

        It "Jette une erreur si le charset est vide" {
            { Internal-RandomString -Length 10 -Charset "" } | Should -Throw
        }
    }

    Context "Integration with Get-CryptoIndex" {

        It "Appelle Get-CryptoIndex pour chaque caractère" {
            Mock -CommandName Get-CryptoIndex -MockWith { 0 }

            $null = Internal-RandomString -Length 12 -Charset "abc"

            Assert-MockCalled Get-CryptoIndex -Times 12
        }

        It "Utilise l’index retourné par Get-CryptoIndex" {
            Mock -CommandName Get-CryptoIndex -MockWith { 2 }

            $str = Internal-RandomString -Length 5 -Charset "abc"

            $str | Should -Be "c" * 5
        }
    }

    Context "Distribution minimale" {

        It "Produit des valeurs variées (test statistique simple)" {
            $charset = "abcd"
            $values = 1..200 | ForEach-Object { Internal-RandomString -Length 1 -Charset $charset }

            ($values | Select-Object -Unique).Count | Should -BeGreaterThan 2
        }
    }

    Context "Edge cases" {

        It "Accepte Length = 1" {
            $str = Internal-RandomString -Length 1 -Charset "abc"
            $str.Length | Should -Be 1
        }

        It "Accepte Length = 0 et retourne une chaîne vide" {
            $str = Internal-RandomString -Length 0 -Charset "abc"
            $str | Should -Be ""
        }
    }
}