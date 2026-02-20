Describe "Pipeline behavior for SecureGen" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1"

        # On neutralise le clipboard pour tous les tests pipeline
        Mock -CommandName Set-ClipboardSafe { }
        Mock -CommandName Clear-ClipboardSafe { }
    }

    Context "Get-PassWord in pipeline" {

        It "Retourne une string exploitable dans un pipeline (Quiet)" {
            $len = (Get-PassWord -Length 24 -Quiet -NoClipboard).Length
            $len | Should -Be 24
        }

        It "Retourne une string exploitable dans un pipeline (Raw)" {
            $len = (Get-PassWord -Length 30 -Raw -NoClipboard).Length
            $len | Should -Be 30
        }

        It "Retourne une string exploitable dans un pipeline (Silent)" {
            $len = (Get-PassWord -Length 40 -Silent -NoClipboard).Length
            $len | Should -Be 40
        }

        It "Les messages Info ne polluent pas le pipeline" {
            $len = (Get-PassWord -Length 260 -Quiet -NoClipboard).Length
            $len | Should -Be 256
        }
    }

    Context "Get-PassPhrase in pipeline" {

        It "Retourne une passphrase exploitable dans un pipeline (Quiet)" {
            $words = (Get-PassPhrase -Words 5 -Letters 4 -Quiet -NoClipboard) -split ' '
            $words.Count | Should -Be 5
        }

        It "Retourne une passphrase exploitable dans un pipeline (Raw)" {
            $words = (Get-PassPhrase -Words 6 -Letters 3 -Raw -NoClipboard) -split ' '
            $words.Count | Should -Be 6
        }

        It "Retourne une passphrase exploitable dans un pipeline (Silent)" {
            $words = (Get-PassPhrase -Words 7 -Letters 2 -Silent -NoClipboard) -split ' '
            $words.Count | Should -Be 7
        }

        It "Les corrections automatiques ne polluent pas le pipeline" {
            $words = (Get-PassPhrase -Words 1 -Letters 1 -Quiet -NoClipboard) -split ' '
            $words.Count | Should -Be 2
        }
    }

    Context "Get-PKIPass in pipeline" {

        It "Retourne un secret exploitable dans un pipeline (default)" {
            $len = (Get-PKIPass -NoClipboard).Length
            $len | Should -Be 32
        }

        It "Retourne un secret exploitable dans un pipeline (Quiet)" {
            $result = Get-PKIPass -Quiet -NoClipboard
            $result | Should -BeOfType 'System.String'
        }

        It "Retourne un secret exploitable dans un pipeline (Silent)" {
            $result = Get-PKIPass -Silent -NoClipboard
            $result | Should -BeOfType 'System.String'
        }

        It "Retourne un secret exploitable dans un pipeline (Raw)" {
            $result = Get-PKIPass -Raw -NoClipboard
            $result | Should -BeOfType 'System.String'
        }
    }

    Context "Chaining with other cmdlets" {

        It "Permet de mesurer la longueur via Measure-Object" {
            $len = (Get-PassWord -Length 32 -Quiet -NoClipboard |
                Measure-Object -Character).Count

            $len | Should -Be 32
        }

        It "Permet de compter les mots d’une passphrase" {
            $count = (Get-PassPhrase -Words 5 -Letters 4 -Quiet -NoClipboard |
                ForEach-Object { $_ -split ' ' } |
                Measure-Object).Count

            $count | Should -Be 5
        }
    }
}