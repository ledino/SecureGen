# Tests/Get-PkiPass.Tests.ps1

Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force

Describe "Get-PkiPass" {

    Context "Mode Password" {
        It "génère un SecureString par défaut" {
            $secret = Get-PkiPass -Type Password -Silent -NoClipboard
            $secret | Should -BeOfType System.Security.SecureString
        }

        It "génère un mot de passe de longueur personnalisée en mode texte" {
            $secret = Get-PkiPass -Type Password -Length 40 -AsPlainText -Silent -NoClipboard
            $secret.Length | Should -Be 40
        }
    }

    Context "Mode Passphrase" {
        It "génère une passphrase sous forme de SecureString par défaut" {
            $secret = Get-PkiPass -Type Passphrase -Silent -NoClipboard
            $secret | Should -BeOfType System.Security.SecureString
        }

        It "génère une passphrase en clair avec -AsPlainText" {
            $secret = Get-PkiPass -Type Passphrase -AsPlainText -Silent -NoClipboard
            $secret | Should -BeOfType System.String
        }

        It "génère une passphrase avec le bon nombre de mots" {
            $secret = Get-PkiPass -Type Passphrase -Words 8 -AsPlainText -Silent -NoClipboard
            ($secret -split '-') | Should -HaveCount 8
        }
    }

    Context "Délégation correcte" {
        It "délègue à Get-PassWord en mode Password" {
            $secret = Get-PkiPass -Type Password -AsPlainText -Silent -NoClipboard
            # Vérification structurelle : un mot de passe n'a pas de séparateur
            $secret | Should -Not -Match '-'
        }

        It "délègue à Get-PassPhrase en mode Passphrase" {
            $secret = Get-PkiPass -Type Passphrase -AsPlainText -Silent -NoClipboard
            # Vérification structurelle : une passphrase contient des séparateurs
            $secret | Should -Match '-'
        }
    }

    Context "Options d'affichage" {
        It "ne copie pas dans le presse-papier avec -NoClipboard" {
            $secret = Get-PkiPass -NoClipboard -Silent
            $secret | Should -Not -BeNullOrEmpty
        }

        It "fonctionne en mode Silent" {
            $secret = Get-PkiPass -Silent -NoClipboard
            $secret | Should -Not -BeNullOrEmpty
        }
    }
}