Describe "Invoke-Beep" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../SecureGen.psd1"
    }

    Context "Basic behavior" {

        It "Accepte Frequency et Duration sans erreur" {
            { Invoke-Beep -Frequency 800 -Duration 100 } | Should -NotThrow
        }

        It "Ne pollue pas le pipeline" {
            $result = Invoke-Beep -Frequency 500 -Duration 50
            $result | Should -BeNullOrEmpty
        }
    }

    Context "Validation" {

        It "Accepte une fréquence minimale (37 Hz)" {
            { Invoke-Beep -Frequency 37 -Duration 100 } | Should -NotThrow
        }

        It "Accepte une fréquence maximale (32767 Hz)" {
            { Invoke-Beep -Frequency 32767 -Duration 100 } | Should -NotThrow
        }

        It "Accepte une durée minimale (1 ms)" {
            { Invoke-Beep -Frequency 800 -Duration 1 } | Should -NotThrow
        }

        It "Accepte une durée élevée (5000 ms)" {
            { Invoke-Beep -Frequency 800 -Duration 5000 } | Should -NotThrow
        }
    }

    Context "Cross-platform behavior" {

        It "Ne jette pas d’erreur sur plateformes sans Console.Beep()" {
            # Simulation d’un environnement sans Beep()
            Mock -CommandName Internal-Beep -MockWith { throw "Not supported" }

            { Invoke-Beep -Frequency 800 -Duration 100 } | Should -NotThrow
        }
    }

    Context "Parameter validation" {

        It "Jette une erreur si Frequency est négative" {
            { Invoke-Beep -Frequency -10 -Duration 100 } | Should -Throw
        }

        It "Jette une erreur si Duration est négative" {
            { Invoke-Beep -Frequency 800 -Duration -1 } | Should -Throw
        }
    }
}