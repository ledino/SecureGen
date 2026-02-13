Describe "Get-CryptoIndex" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    It "Retourne un entier dans la plage" {
        $i = Get-CryptoIndex -Max 10
        $i | Should -BeOfType 'System.Int32'
        $i | Should -BeLessThan 10
        $i | Should -BeGreaterOrEqual 0
    }

    It "Ne jette pas d’erreur" {
        { Get-CryptoIndex -Max 50 } | Should -NotThrow
    }
}
