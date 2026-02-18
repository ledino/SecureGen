# Tests/Get-PassWord.Tests.ps1

Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force

Describe "Get-PassWord" {

    Context "Génération basique" {
        It "génère un mot de passe de longueur par défaut (20)" {
            $pw = Get-PassWord -Silent -NoClipboard
            $pw.Length | Should -Be 20
        }

        It "génère un mot de passe de longueur personnalisée" {
            $pw = Get-PassWord -Length 32 -Silent -NoClipboard
            $pw.Length | Should -Be 32
        }
    }

    Context "Caractères spéciaux" {
        It "inclut des caractères spéciaux quand -UseSpecial est activé" {
            $pw = Get-PassWord -UseSpecial -Silent -NoClipboard
            $pw | Should -Match '[!@#$%^&*()_+\-\[\]{}<>\/\\|;~]'
        }

        It "n'inclut pas de caractères spéciaux quand -UseSpecial est désactivé" {
            $pw = Get-PassWord -UseSpecial:$false -Silent -NoClipboard
            $pw | Should -Not -Match '[!@#$%^&*()_+\-\[\]{}<>\/\\|;~]'
        }
    }

    Context "RequireAllTypes" {
        It "contient au moins une minuscule, majuscule, chiffre et spécial" {
            $pw = Get-PassWord -RequireAllTypes -UseSpecial -Silent -NoClipboard
            $pw | Should -Match '[a-z]'
            $pw | Should -Match '[A-Z]'
            $pw | Should -Match '\d'
            $pw | Should -Match '[!@#$%^&*()_+\-\[\]{}<>\/\\|;~]'
        }
    }

    Context "Options d'affichage" {
        It "ne copie pas dans le presse-papier avec -NoClipboard" {
            $pw = Get-PassWord -NoClipboard -Silent
            # On ne peut pas tester le clipboard directement, mais on vérifie que ça ne plante pas
            $pw | Should -Not -BeNullOrEmpty
        }

        It "fonctionne en mode Silent" {
            $pw = Get-PassWord -Silent -NoClipboard
            $pw | Should -Not -BeNullOrEmpty
        }
    }
}