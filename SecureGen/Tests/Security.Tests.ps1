Describe "SecureGen - Security and Safety Rules" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1"

        # Neutralise clipboard
        Mock -CommandName Set-ClipboardSafe { }
        Mock -CommandName Clear-ClipboardSafe { }
    }

    Context "Password length enforcement" {

        It "Corrige automatiquement une longueur trop faible (8 → 16)" {
            $pw = Get-PassWord -Length 8 -Quiet -NoClipboard
            $pw.Length | Should -Be 16
        }

        It "Corrige automatiquement une longueur trop grande (300 → 256)" {
            $pw = Get-PassWord -Length 300 -Quiet -NoClipboard
            $pw.Length | Should -Be 256
        }
    }

    Context "Passphrase safety rules" {

        It "Corrige Words trop faible (1 → 2)" {
            $pp = Get-PassPhrase -Words 1 -Letters 5 -Quiet -NoClipboard
            ($pp -split ' ').Count | Should -Be 2
        }

        It "Corrige Letters trop faible (1 → 2)" {
            $pp = Get-PassPhrase -Words 4 -Letters 1 -Quiet -NoClipboard
            foreach ($mot in $pp -split ' ') {
                $mot.Length | Should -Be 2
            }
        }
    }

    Context "RequireAllTypes enforcement" {

        It "Inclut au moins une minuscule, majuscule, chiffre et spécial" {
            $pw = Get-PassWord -Length 40 -RequireAllTypes -Quiet -NoClipboard

            ($pw -match '[a-z]') | Should -BeTrue
            ($pw -match '[A-Z]') | Should -BeTrue
            ($pw -match '\d')   | Should -BeTrue
            ($pw -match '[!@#$%^&*()_\-=\[\]{};:,.<>/?]') | Should -BeTrue
        }
    }

    Context "Charset safety" {

        It "N’utilise pas de caractères hors charset personnalisé" {
            $charset = "abc123"
            $pw = Get-PassWord -Length 50 -Charset $charset -Quiet -NoClipboard

            ($pw.ToCharArray() | ForEach-Object { $charset.Contains($_) }) -notcontains $false |
                Should -BeTrue
        }

        It "N’utilise pas de caractères spéciaux quand -UseSpecial:$false" {
            $pw = Get-PassWord -Length 40 -UseSpecial:$false -Quiet -NoClipboard
            ($pw -match '[!@#$%^&*()_\-=\[\]{};:,.<>/?]') | Should -BeFalse
        }
    }

    Context "Pipeline safety" {

        It "Les messages Info ne polluent jamais le pipeline (Password)" {
            $len = (Get-PassWord -Length 260 -Quiet -NoClipboard).Length
            $len | Should -Be 256
        }

        It "Les messages Info ne polluent jamais le pipeline (PassPhrase)" {
            $words = (Get-PassPhrase -Words 1 -Letters 1 -Quiet -NoClipboard) -split ' '
            $words.Count | Should -Be 2
        }
    }

    Context "Clipboard safety" {

        It "Ne touche jamais au clipboard quand -NoClipboard est utilisé" {
            Get-PassWord -NoClipboard -Quiet

            Assert-MockCalled Set-ClipboardSafe -Times 0
            Assert-MockCalled Clear-ClipboardSafe -Times 0
        }

        It "Efface le clipboard après usage (mode normal)" {
            Mock -CommandName Set-ClipboardSafe { }
            Mock -CommandName Clear-ClipboardSafe { }

            Get-PassWord

            Assert-MockCalled Clear-ClipboardSafe -Times 1
        }
    }

    Context "SecureString safety" {

        It "Retourne un SecureString quand -AsSecureString est utilisé" {
            $sec = Get-PassWord -AsSecureString -NoClipboard
            $sec | Should -BeOfType "System.Security.SecureString"
        }

        It "Ne retourne jamais de SecureString sans -AsSecureString" {
            $pw = Get-PassWord -NoClipboard
            $pw | Should -BeOfType "System.String"
        }
    }

    Context "Entropy consistency" {

        It "Produit des valeurs variées (test statistique simple)" {
            $values = 1..200 | ForEach-Object { Get-PassWord -Length 1 -Quiet -NoClipboard }
            ($values | Select-Object -Unique).Count | Should -BeGreaterThan 5
        }
    }
}