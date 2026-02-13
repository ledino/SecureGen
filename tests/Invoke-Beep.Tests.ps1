Describe "Invoke-Beep" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1" -Force
    }

    It "Accepte Frequency et Duration sans erreur" {
        { Invoke-Beep -Frequency 800 -Duration 100 } | Should -NotThrow
    }
}
