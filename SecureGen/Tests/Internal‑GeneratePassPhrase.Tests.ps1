Describe "Internal-GeneratePassPhrase" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1"
    }

    Context "Basic behavior" {

        It "Génère une passphrase avec le bon nombre de mots" {
            $pp = Internal-GeneratePassPhrase -Words 5 -Letters 4
            ($pp -split ' ').Count | Should -Be 5
        }

        It "Chaque mot a la bonne longueur" {
            $pp = Internal-GeneratePassPhrase -Words 4 -Letters 6
            foreach ($mot in $pp -split ' ') {
                $mot.Length | Should -Be 6
            }
        }

        It "Retourne une string" {
            $pp = Internal-GeneratePassPhrase -Words 3 -Letters 4
            $pp | Should -BeOfType 'System.String'
        }

        It "Ne jette pas d’erreur" {
            { Internal-GeneratePassPhrase -Words 3 -Letters 4 } | Should -NotThrow
        }
    }

    Context "Validation & corrections automatiques" {

        It "Corrige Words trop faible (1 → 2)" {
            $pp = Internal-GeneratePassPhrase -Words 1 -Letters 5
            ($pp -split ' ').Count | Should -Be 2
        }

        It "Corrige Letters trop faible (1 → 2)" {
            $pp = Internal-GeneratePassPhrase -Words 4 -Letters 1
            foreach ($mot in $pp -split ' ') {
                $mot.Length | Should -Be 2
            }
        }
    }

    Context "Charset & Separator" {

        It "Utilise le séparateur personnalisé" {
            $pp = Internal-GeneratePassPhrase -Words 3 -Letters 4 -Separator '-'
            $pp | Should -Match '^[a-zA-Z]{4}-[a-zA-Z]{4}-[a-zA-Z]{4}$'
        }

        It "Utilise un charset personnalisé" {
            $pp = Internal-GeneratePassPhrase -Words 3 -Letters 4 -Charset 'abc'
            ($pp -replace '[^abc]', '') | Should -Match '^[abc]+$'
        }
    }

    Context "Integration with Internal-RandomString" {

        It "Appelle Internal-RandomString pour chaque mot" {
            Mock -CommandName Internal-RandomString -MockWith { "xxxx" }

            $null = Internal-GeneratePassPhrase -Words 5 -Letters 4

            Assert-MockCalled Internal-RandomString -Times 5
        }

        It "Utilise la valeur retournée par Internal-RandomString" {
            Mock -CommandName Internal-RandomString -MockWith { "zzzz" }

            $pp = Internal-GeneratePassPhrase -Words 3 -Letters 4

            $pp | Should -Be "zzzz zzzz zzzz"
        }
    }

    Context "Pipeline behavior" {

        It "Ne pollue pas le pipeline" {
            $count = (Internal-GeneratePassPhrase -Words 4 -Letters 4) -split ' '
            $count.Count | Should -Be 4
        }
    }

    Context "Distribution minimale" {

        It "Produit des valeurs variées (test statistique simple)" {
            $values = 1..200 | ForEach-Object { Internal-GeneratePassPhrase -Words 1 -Letters 3 }
            ($values | Select-Object -Unique).Count | Should -BeGreaterThan 5
        }
    }

    Context "Edge cases" {

        It "Accepte Words = 2 (minimum)" {
            $pp = Internal-GeneratePassPhrase -Words 2 -Letters 4
            ($pp -split ' ').Count | Should -Be 2
        }

        It "Accepte Letters = 2 (minimum)" {
            $pp = Internal-GeneratePassPhrase -Words 3 -Letters 2
            foreach ($mot in $pp -split ' ') {
                $mot.Length | Should -Be 2
            }
        }
    }
}