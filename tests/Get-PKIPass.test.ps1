Describe "Get-PKIPass" {

    BeforeAll {
        # Mock clipboard to avoid platform issues
        Mock -CommandName Set-ClipboardSafe { }
        Mock -CommandName Clear-ClipboardSafe { }
    }

    Context "Defaults" {

        It "returns a 32-char password by default" {
            $result = Get-PKIPass
            $result.Length | Should -Be 32
        }

        It "returns a string by default (not SecureString)" {
            $result = Get-PKIPass
            $result | Should -BeOfType "System.String"
        }
    }

    Context "Password mode" {

        It "accepts -Length and forwards to Get-PassWord" {
            Mock -CommandName Get-PassWord { "X" * 48 }

            $result = Get-PKIPass -Type Password -Length 48

            Assert-MockCalled Get-PassWord -Times 1 -ParameterFilter {
                $Len -eq 48
            }

            $result.Length | Should -Be 48
        }
    }

    Context "Passphrase mode" {

        It "accepts -Words and -Len and forwards to Get-PassPhrase" {
            Mock -CommandName Get-PassPhrase { "aaa-bbb-ccc" }

            $result = Get-PKIPass -Type Passphrase -Words 3 -Len 3

            Assert-MockCalled Get-PassPhrase -Times 1 -ParameterFilter {
                $Words -eq 3 -and $Len -eq 3
            }

            $result | Should -Be "aaa-bbb-ccc"
        }

        It "supports positional parameters (Type Words Len)" {
            Mock -CommandName Get-PassPhrase { "x-y-z" }

            $result = Get-PKIPass Passphrase 3 1

            Assert-MockCalled Get-PassPhrase -Times 1 -ParameterFilter {
                $Words -eq 3 -and $Len -eq 1
            }
        }
    }

    Context "SecureString output" {

        It "returns a SecureString when -AsSecureString is used" {
            $result = Get-PKIPass -AsSecureString
            $result | Should -BeOfType "System.Security.SecureString"
        }
    }

    Context "Clipboard behavior" {

        It "does not call clipboard when -NoClipboard is used" {
            Get-PKIPass -NoClipboard

            Assert-MockCalled Set-ClipboardSafe -Times 0
        }
    }
}