Describe "Get-PassPhrase" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force

        # Mock clipboard to avoid platform issues
        Mock -CommandName Set-ClipboardSafe { }
        Mock -CommandName Clear-ClipboardSafe { }
    }

    Context "Basic behavior" {

        It "Génère une passphrase avec le bon nombre de mots" {
            $pp = Get-PassPhrase -Words 5 -Letters 4 -Quiet
            ($pp -split ' ').Count | Should -Be 5
        }

        It "Chaque mot a la bonne longueur" {
            $pp = Get-PassPhrase -Words 4 -Letters 6 -Quiet
            foreach ($mot in $pp -split ' ') {
                $mot.Length | Should -Be 6
            }
        }

        It "Retourne une string en mode normal" {
            $pp = Get-PassPhrase -NoClipboard
            $pp | Should -BeOfType 'System.String'
        }

        It "N’explose pas avec -NoClipboard" {
            { Get-PassPhrase -NoClipboard } | Should -NotThrow
        }
    }

    Context "Validation & corrections automatiques" {

        It "Corrige Words trop faible (1 → 2)" {
            $pp = Get-PassPhrase -Words 1 -Letters 5 -Quiet
            ($pp -split ' ').Count | Should -Be 2
        }

        It "Corrige Letters trop faible (1 → 2)" {
            $pp = Get-PassPhrase -Words 4 -Letters 1 -Quiet
            foreach ($mot in $pp -split ' ') {
                $mot.Length | Should -Be 2
            }
        }
    }

    Context "Charset & Separator" {

        It "Utilise le séparateur personnalisé" {
            $pp = Get-PassPhrase -Words 3 -Letters 4 -Separator '-' -Quiet
            $pp | Should -Match '^[a-zA-Z]{4}-[a-zA-Z]{4}-[a-zA-Z]{4}$'
        }

        It "Utilise un charset personnalisé" {
            $pp = Get-PassPhrase -Words 3 -Letters 4 -Charset 'abc' -Quiet
            ($pp -replace ' ', '') -match '^[abc]+$' | Should -BeTrue
        }
    }

    Context "Modes UX (Quiet / Raw / Silent)" {

        It "Quiet retourne uniquement la passphrase" {
            $pp = Get-PassPhrase -Words 4 -Letters 4 -Quiet
            $pp | Should -BeOfType 'System.String'
        }

        It "Raw retourne uniquement la passphrase" {
            $pp = Get-PassPhrase -Words 4 -Letters 4 -Raw
            $pp | Should -BeOfType 'System.String'
        }

        It "Silent retourne uniquement la passphrase" {
            $pp = Get-PassPhrase -Words 4 -Letters 4 -Silent
            $pp | Should -BeOfType 'System.String'
        }
    }

    Context "Pipeline behavior" {

        It "Ne pollue pas le pipeline en mode Quiet" {
            $count = (Get-PassPhrase -Words 5 -Letters 4 -Quiet -NoClipboard -NoClear -Silent:$false) -split ' '
            $count.Count | Should -Be 5
        }

        It "Ne pollue pas le pipeline en mode Raw" {
            $count = (Get-PassPhrase -Words 6 -Letters 3 -Raw) -split ' '
            $count.Count | Should -Be 6
        }

        It "Ne pollue pas le pipeline en mode Silent" {
            $count = (Get-PassPhrase -Words 7 -Letters 2 -Silent) -split ' '
            $count.Count | Should -Be 7
        }
    }
}