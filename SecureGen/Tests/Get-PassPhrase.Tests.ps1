Describe 'Get-PassPhrase' {
    BeforeAll {
        Remove-Module SecureGen -ErrorAction SilentlyContinue
        Import-Module "$PSScriptRoot\..\SecureGen.psd1" -Force
    }

    Context 'Basic behavior' {
        # Tests sans Mock d'abord
        It 'Generates passphrase with correct word count' {
            $pp = Get-PassPhrase -Words 6 -Letters 6 -Quiet
            ($pp -split '-').Count | Should -Be 6
        }

        It 'Each word has correct length' {
            $pp = Get-PassPhrase -Words 6 -Letters 6 -Quiet
            foreach ($mot in $pp -split '-') { $mot.Length | Should -Be 6 }
        }

        It 'Returns string in Quiet mode' {
            $pp = Get-PassPhrase -Quiet
            $pp | Should -BeOfType System.String
        }

        It 'Does not throw with NoClipboard' {
            { Get-PassPhrase -NoClipboard } | Should -Not -Throw
        }

        # Mocks apres
        Mock Set-ClipboardSafe -MockWith { }
        Mock Clear-ClipboardSafe -MockWith { }

        It 'Does not throw with NoClipboard Quiet' {
            { Get-PassPhrase -NoClipboard -Quiet } | Should -Not -Throw
        }
    }

    Context 'Validation auto-corrections' {
        Mock Set-ClipboardSafe -MockWith { }
        Mock Clear-ClipboardSafe -MockWith { }

        It 'Corrects too few Words to default' {
            $pp = Get-PassPhrase -Words 1 -Letters 6 -Quiet
            ($pp -split '-').Count | Should -Be 7
        }

        It 'Corrects too few Letters to default' {
            $pp = Get-PassPhrase -Words 6 -Letters 1 -Quiet
            foreach ($mot in $pp -split '-') { $mot.Length | Should -Be 6 }
        }

        It 'Corrects too short passphrase' {
            $pp = Get-PassPhrase -Words 3 -Letters 4 -Quiet
            ($pp -split '-').Count | Should -Be 7
        }
    }

    Context 'Separators' {
        Mock Set-ClipboardSafe -MockWith { }
        Mock Clear-ClipboardSafe -MockWith { }

        It 'Accepts valid separator' {
            $pp = Get-PassPhrase -Words 6 -Letters 6 -Separator '.' -Quiet
            $pp | Should -Match '^[a-z0-9]+(\.[a-z0-9]+){5}$'
        }

        It 'Corrects invalid separator' {
            $pp = Get-PassPhrase -Words 6 -Letters 6 -Separator ';' -Quiet
            $pp | Should -Match '^[a-z0-9-]+$'  # Default to '-'
        }
    }

    Context 'Charset enrichment' {
        Mock Set-ClipboardSafe -MockWith { }
        Mock Clear-ClipboardSafe -MockWith { }

        It 'Includes uppercase with Uppercase' {
            $pp = Get-PassPhrase -Words 6 -Letters 6 -Uppercase -Quiet
            ($pp -replace '-', '') -match '[A-Z]' | Should -BeTrue
        }

        It 'Includes digits with Digits' {
            $pp = Get-PassPhrase -Words 6 -Letters 6 -Digits -Quiet
            ($pp -replace '-', '') -match '[0-9]' | Should -BeTrue
        }
    }

    Context 'Modes UX' {
        Mock Set-ClipboardSafe -MockWith { }
        Mock Clear-ClipboardSafe -MockWith { }

        It 'Quiet returns only passphrase' { 
            Get-PassPhrase -Quiet | Should -BeOfType System.String 
        }

        It 'Raw returns only passphrase' { 
            Get-PassPhrase -Raw | Should -BeOfType System.String 
        }

        It 'Silent returns only passphrase' { 
            Get-PassPhrase -Silent | Should -BeOfType System.String 
        }
    }
}
