Describe "Private-ValidatePassphrase" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    Context "Valid values" {

        It "Retourne $true pour Words et Letters valides" {
            $words = 5
            $letters = 6

            $result = Private-ValidatePassphrase -Words ([ref]$words) -Letters ([ref]$letters)

            $result | Should -BeTrue
            $words  | Should -Be 5
            $letters | Should -Be 6
        }
    }

    Context "Automatic corrections" {

        It "Corrige Words trop faible (1 → 2)" {
            $words = 1
            $letters = 6

            $result = Private-ValidatePassphrase -Words ([ref]$words) -Letters ([ref]$letters)

            $result | Should -BeFalse
            $words  | Should -Be 2
        }

        It "Corrige Letters trop faible (1 → 2)" {
            $words = 4
            $letters = 1

            $result = Private-ValidatePassphrase -Words ([ref]$words) -Letters ([ref]$letters)

            $result | Should -BeFalse
            $letters | Should -Be 2
        }

        It "Corrige Words et Letters simultanément si nécessaire" {
            $words = 1
            $letters = 1

            $result = Private-ValidatePassphrase -Words ([ref]$words) -Letters ([ref]$letters)

            $result | Should -BeFalse
            $words  | Should -Be 2
            $letters | Should -Be 2
        }
    }

    Context "Write-Host behavior" {

        It "Affiche un message Info quand une correction est faite" {
            $words = 1
            $letters = 5

            Mock -CommandName Write-Host

            $null = Private-ValidatePassphrase -Words ([ref]$words) -Letters ([ref]$letters)

            Assert-MockCalled Write-Host -TimesGreaterThan 0
        }

        It "N'affiche rien quand les valeurs sont valides" {
            $words = 4
            $letters = 6

            Mock -CommandName Write-Host

            $null = Private-ValidatePassphrase -Words ([ref]$words) -Letters ([ref]$letters)

            Assert-MockCalled Write-Host -Times 0
        }
    }

    Context "Pipeline behavior" {

        It "Ne pollue pas le pipeline" {
            $words = 3
            $letters = 4

            $result = Private-ValidatePassphrase -Words ([ref]$words) -Letters ([ref]$letters)

            $result | Should -BeOfType 'System.Boolean'
        }
    }

    Context "Edge cases" {

        It "Accepte Words = 2 (minimum)" {
            $words = 2
            $letters = 5

            $result = Private-ValidatePassphrase -Words ([ref]$words) -Letters ([ref]$letters)

            $result | Should -BeTrue
            $words  | Should -Be 2
        }

        It "Accepte Letters = 2 (minimum)" {
            $words = 4
            $letters = 2

            $result = Private-ValidatePassphrase -Words ([ref]$words) -Letters ([ref]$letters)

            $result | Should -BeTrue
            $letters | Should -Be 2
        }
    }
}