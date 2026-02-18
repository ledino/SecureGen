# Tests/Internal.Tests.ps1

Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force

Describe "Fonctions internes de SecureGen" {

    # ----------------------------------------------------------------------
    # Internal-RandomString
    # ----------------------------------------------------------------------
    Context "Internal-RandomString" {
        It "génère une chaîne de la longueur demandée" {
            $s = Internal-RandomString -Length 50 -Charset 'abc'
            $s.Length | Should -Be 50
        }

        It "n'utilise que les caractères du charset" {
            $charset = 'abcXYZ123'
            $s = Internal-RandomString -Length 100 -Charset $charset
            ($s.ToCharArray() | ForEach-Object { $_ -in $charset }) |
                Should -Not -Contain $false
        }
    }

    # ----------------------------------------------------------------------
    # Internal-RandomPassPhrase
    # ----------------------------------------------------------------------
    Context "Internal-RandomPassPhrase" {
        It "génère le bon nombre de mots" {
            $pp = Internal-RandomPassPhrase -Words 6 -Letters 5 -Charset 'abc' -Separator '-'
            ($pp -split '-') | Should -HaveCount 6
        }

        It "génère des mots de la bonne longueur" {
            $pp = Internal-RandomPassPhrase -Words 4 -Letters 8 -Charset 'abc' -Separator '-'
            foreach ($w in ($pp -split '-')) {
                $w.Length | Should -Be 8
            }
        }
    }

    # ----------------------------------------------------------------------
    # Internal-ComputeEntropy
    # ----------------------------------------------------------------------
    Context "Internal-ComputeEntropy" {
        It "calcule une entropie positive" {
            $entropy = Internal-ComputeEntropy -SymbolCount 20 -CharsetSize 62
            $entropy | Should -BeGreaterThan 0
        }

        It "augmente avec le nombre de symboles" {
            $e1 = Internal-ComputeEntropy -SymbolCount 10 -CharsetSize 62
            $e2 = Internal-ComputeEntropy -SymbolCount 20 -CharsetSize 62
            $e2 | Should -BeGreaterThan $e1
        }
    }

    # ----------------------------------------------------------------------
    # Internal-GetAleaSource
    # ----------------------------------------------------------------------
    Context "Internal-GetAleaSource" {
        It "retourne une chaîne non vide" {
            $src = Internal-GetAleaSource
            $src | Should -Not -BeNullOrEmpty
        }
    }

    # ----------------------------------------------------------------------
    # Validations internes
    # ----------------------------------------------------------------------
    Context "Private-ValidateLength" {
        It "accepte une longueur valide" {
            { Private-ValidateLength -Length 20 -Min 16 -Max 256 } |
                Should -Not -Throw
        }

        It "rejette une longueur trop petite" {
            { Private-ValidateLength -Length 3 -Min 16 -Max 256 } |
                Should -Throw
        }
    }

    Context "Private-ValidatePassphrase" {
        It "accepte une passphrase conforme ANSSI/CNIL" {
            { Private-ValidatePassphrase -Words 7 -Letters 6 } |
                Should -Not -Throw
        }

        It "rejette une passphrase trop courte" {
            { Private-ValidatePassphrase -Words 3 -Letters 4 } |
                Should -Throw
        }
    }

    # ----------------------------------------------------------------------
    # Convert-ToSecureStringSafe
    # ----------------------------------------------------------------------
    Context "Convert-ToSecureStringSafe" {
        It "convertit une chaîne en SecureString" {
            $sec = Convert-ToSecureStringSafe "test123"
            $sec | Should -BeOfType System.Security.SecureString
        }
    }
}