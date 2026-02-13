Describe "Get-PassPhrase" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    It "Génère une passphrase avec le bon nombre de mots" {
        $pp = Get-PassPhrase -MotsParBloc 5 -LettresParMot 4 -NoClipboard
        ($pp -split ' ').Count | Should -Be 5
    }

    It "Chaque mot a la bonne longueur" {
        $pp = Get-PassPhrase -MotsParBloc 4 -LettresParMot 6 -NoClipboard
        foreach ($mot in $pp -split ' ') {
            $mot.Length | Should -Be 6
        }
    }

    It "Retourne une string" {
        $pp = Get-PassPhrase -NoClipboard
        $pp | Should -BeOfType 'System.String'
    }
}
