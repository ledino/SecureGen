Describe "Get-PKIPass" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1"

        # Mock clipboard to avoid platform issues
        Mock -CommandName Set-ClipboardSafe { }
        Mock -CommandName Clear-ClipboardSafe { }
    }

    Context "Defaults" {

        It "returns a 32-char password by default" {
            $result = Get-PKIPass -NoClipboard
            $result.Length | Should -Be 32
        }

        It "returns a string by default (not SecureString)" {
            $result = Get-PKIPass -NoClipboard
            $result | Should -BeOfType "System.String"
        }
    }

    Context "Password mode" {

        It "forwards -Length to Get-PassWord" {
            Mock -CommandName Get-PassWord { "X" * 48 }

            $result = Get-PKIPass -Password -Length 48 -NoClipboard

            Assert-MockCalled Get-PassWord -Times 1 -ParameterFilter {
                $Length -eq 48
            }

            $result.Length | Should -Be 48
        }

        It "uses default length 32 when none is provided" {
            Mock -CommandName Get-PassWord { "Y" * 32 }

            $result = Get-PKIPass -Password -NoClipboard

            Assert-MockCalled Get-PassWord -Times 1 -ParameterFilter {
                $Length -eq 32
            }
        }
    }

    Context "Passphrase mode" {

        It "forwards Words and Letters to Get-PassPhrase" {
            Mock -CommandName Get-PassPhrase { "aaa-bbb-ccc" }

            $result = Get-PKIPass -Passphrase -Words 3 -Letters 3 -NoClipboard

            Assert-MockCalled Get-PassPhrase -Times 1 -ParameterFilter {
                $Words -eq 3 -and $Letters -eq 3
            }

            $result | Should -Be "aaa-bbb-ccc"
        }

        It "uses default Words=7 and Letters=6 when none are provided" {
            Mock -CommandName Get-PassPhrase { "x y z" }

            $result = Get-PKIPass -Passphrase -NoClipboard

            Assert-MockCalled Get-PassPhrase -Times 1 -ParameterFilter {
                $Words -eq 7 -and $Letters -eq 6
            }
        }

        It "supports positional parameters (Type Words Letters)" {
            Mock -CommandName Get-PassPhrase { "x-y-z" }

            $result = Get-PKIPass Passphrase 3 1 -NoClipboard

            Assert-MockCalled Get-PassPhrase -Times 1 -ParameterFilter {
                $Words -eq 3 -and $Letters -eq 1
            }
        }
    }

    Context "SecureString output" {

        It "returns a SecureString when -AsSecureString is used" {
            $result = Get-PKIPass -AsSecureString -NoClipboard
            $result | Should -BeOfType "System.Security.SecureString"
        }
    }

    Context "Clipboard behavior" {

        It "does not call clipboard when -NoClipboard is used" {
            Get-PKIPass -NoClipboard

            Assert-MockCalled Set-ClipboardSafe -Times 0
            Assert-MockCalled Clear-ClipboardSafe -Times 0
        }
    }

    Context "Pipeline behavior" {

        It "Quiet returns only the secret" {
            $result = Get-PKIPass -Quiet -NoClipboard
            $result | Should -BeOfType "System.String"
        }

        It "Silent returns only the secret" {
            $result = Get-PKIPass -Silent -NoClipboard
            $result | Should -BeOfType "System.String"
        }

        It "Raw returns only the secret" {
            $result = Get-PKIPass -Raw -NoClipboard
            $result | Should -BeOfType "System.String"
        }
    }
}