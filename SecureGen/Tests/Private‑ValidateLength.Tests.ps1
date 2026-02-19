Describe "Private-ValidateLength" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    Context "Valid lengths" {

        It "Retourne $true pour une longueur valide" {
            $len = 32
            $result = Private-ValidateLength -Length ([ref]$len)
            $result | Should -BeTrue
            $len    | Should -Be 32
        }
    }

    Context "Automatic corrections" {

        It "Corrige une longueur trop faible (8 → 16)" {
            $len = 8
            $result = Private-ValidateLength -Length ([ref]$len)

            $result | Should -BeFalse
            $len    | Should -Be 16
        }

        It "Corrige une longueur trop grande (300 → 256)" {
            $len = 300
            $result = Private-ValidateLength -Length ([ref]$len)

            $result | Should -BeFalse
            $len    | Should -Be 256
        }
    }

    Context "Pipeline behavior" {

        It "Ne pollue pas le pipeline" {
            $len = 20
            $result = Private-ValidateLength -Length ([ref]$len)

            $result | Should -BeOfType 'System.Boolean'
        }
    }

    Context "Write-Host behavior" {

        It "Affiche un message Info quand la valeur est corrigée" {
            $len = 5

            Mock -CommandName Write-Host

            $null = Private-ValidateLength -Length ([ref]$len)

            Assert-MockCalled Write-Host -TimesGreaterThan 0
        }

        It "N'affiche rien quand la valeur est valide" {
            $len = 32

            Mock -CommandName Write-Host

            $null = Private-ValidateLength -Length ([ref]$len)

            Assert-MockCalled Write-Host -Times 0
        }
    }

    Context "Edge cases" {

        It "Accepte la longueur minimale (16)" {
            $len = 16
            $result = Private-ValidateLength -Length ([ref]$len)

            $result | Should -BeTrue
            $len    | Should -Be 16
        }

        It "Accepte la longueur maximale (256)" {
            $len = 256
            $result = Private-ValidateLength -Length ([ref]$len)

            $result | Should -BeTrue
            $len    | Should -Be 256
        }
    }
}