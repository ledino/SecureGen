Describe "Get-CryptoIndex" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1"
    }

    Context "Basic behavior" {

        It "Retourne un entier dans la plage [0..Max-1]" {
            $i = Get-CryptoIndex -Max 10
            $i | Should -BeOfType 'System.Int32'
            $i | Should -BeGreaterOrEqual 0
            $i | Should -BeLessThan 10
        }

        It "Ne jette pas d’erreur avec une valeur valide" {
            { Get-CryptoIndex -Max 50 } | Should -NotThrow
        }
    }

    Context "Validation" {

        It "Jette une erreur si Max est 0" {
            { Get-CryptoIndex -Max 0 } | Should -Throw
        }

        It "Jette une erreur si Max est négatif" {
            { Get-CryptoIndex -Max -5 } | Should -Throw
        }
    }

    Context "Compatibilité PowerShell 5 / 7" {

        It "Utilise le backend moderne si PS >= 7" -Skip:( $PSVersionTable.PSVersion.Major -lt 7 ) {
            Mock -CommandName Internal-GetSecureRandomInt { 3 }

            $i = Get-CryptoIndex -Max 10

            Assert-MockCalled Internal-GetSecureRandomInt -Times 1
            $i | Should -Be 3
        }

        It "Utilise le backend legacy si PS < 7" -Skip:( $PSVersionTable.PSVersion.Major -ge 7 ) {
            Mock -CommandName Internal-GetLegacyRandomInt { 4 }

            $i = Get-CryptoIndex -Max 10

            Assert-MockCalled Internal-GetLegacyRandomInt -Times 1
            $i | Should -Be 4
        }
    }

    Context "Pipeline behavior" {

        It "Ne pollue pas le pipeline" {
            $value = (Get-CryptoIndex -Max 100)
            $value | Should -BeOfType 'System.Int32'
        }
    }

    Context "Distribution minimale" {

        It "Produit des valeurs variées (test statistique simple)" {
            $values = 1..200 | ForEach-Object { Get-CryptoIndex -Max 10 }
            ($values | Select-Object -Unique).Count | Should -BeGreaterThan 5
        }
    }
}