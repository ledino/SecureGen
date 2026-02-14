#requires -Module Pester

Describe "Get-PKIPass" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    Context "Mode Password" {
        It "Génère un mot de passe PKI de 32 caractères" {
            $pass = Get-PKIPass -Type Password -NoClipboard
            $pass | Should -BeOfType 'System.String'
            $pass.Length | Should -Be 32
        }
    }

    Context "Mode Passphrase" {
        It "Génère une passphrase de 5 mots" {
            $phrase = Get-PKIPass -Type Passphrase -NoClipboard
            $phrase | Should -BeOfType 'System.String'
            ($phrase -split ' ').Count | Should -Be 5
        }
    }

    Context "Mode SecureString" {
        It "Retourne un SecureString quand -AsSecureString est utilisé" {
            $sec = Get-PKIPass -AsSecureString -NoClipboard
            $sec | Should -BeOfType 'System.Security.SecureString'
        }
    }

    Context "Paramètres combinés" {
        It "Accepte -Type Passphrase et -AsSecureString ensemble" {
            $sec = Get-PKIPass -Type Passphrase -AsSecureString -NoClipboard
            $sec | Should -BeOfType 'System.Security.SecureString'
        }
    }

    Context "Alias sgpki" {
        It "L’alias sgpki pointe vers Get-PKIPass" {
            (Get-Command sgpki).Source | Should -Be "SecureGen"
            (Get-Command sgpki).Name   | Should -Be "sgpki"
            (Get-Command sgpki).Definition | Should -Be "Get-PKIPass"
        }
    }
}
