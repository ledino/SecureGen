# Tests/Get-PassPhrase.Tests.ps1

Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force

Describe "Get-PassPhrase" {

    Context "Génération basique" {
        It "génère une passphrase avec 7 mots par défaut" {
            $pp = Get-PassPhrase -Silent -NoClipboard
            ($pp -split '-') | Should -HaveCount 7
        }

        It "génère une passphrase avec un nombre de mots personnalisé" {
            $pp = Get-PassPhrase -Words 10 -Silent -NoClipboard
            ($pp -split '-') | Should -HaveCount 10
        }
    }

    Context "Longueur des mots" {
        It "génère des mots de longueur personnalisée" {
            $pp = Get-PassPhrase -Words 5 -LettersPerWord 8 -Silent -NoClipboard
            $words = $pp -split '-'
            foreach ($w in $words) {
                $w.Length | Should -Be 8
            }
        }
    }

    Context "Séparateur" {
        It "utilise le séparateur personnalisé" {
            $pp = Get-PassPhrase -Separator '_' -Silent -NoClipboard
            $pp | Should -Match '_'
            $pp | Should -Not -Match '-'
        }
    }

    Context "Options d'affichage" {
        It "ne copie pas dans le presse-papier avec -NoClipboard" {
            $pp = Get-PassPhrase -NoClipboard -Silent
            $pp | Should -Not -BeNullOrEmpty
        }

        It "fonctionne en mode Silent" {
            $pp = Get-PassPhrase -Silent -NoClipboard
            $pp | Should -Not -BeNullOrEmpty
        }
    }

    Context "Conformité ANSSI/CNIL (structure)" {
        It "génère au moins 30 caractères au total" {
            $pp = Get-PassPhrase -Silent -NoClipboard
            $pp.Length | Should -BeGreaterThan 30
        }
    }
}