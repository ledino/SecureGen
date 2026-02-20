# 1) Import du module AVANT la discovery
BeforeAll {
    $moduleRoot = Split-Path -Parent $PSScriptRoot
    $modulePath = Join-Path $moduleRoot "SecureGen.psd1"

    Remove-Module SecureGen -ErrorAction SilentlyContinue
    Import-Module $modulePath -Force -ErrorAction Stop

    (Get-Module SecureGen).Path | Should -Match 'SecureGen.psm1'
}

# Write-Host "DEBUG: Internal-SetClipboardSafe loaded from: $((Get-Command Internal-SetClipboardSafe).ScriptBlock.File)"

# 2) InModuleScope englobe TOUT le Describe
InModuleScope SecureGen {

    Describe "Clipboard functions" -Tag "Unit", "Clipboard" {

        BeforeAll {
            $script:mockClipboard = $null
            $script:verboseCalled = $false
        }

        Context "Set-ClipboardSafe" {
            It "Copie texte Windows avec Set-Clipboard" {
                Mock Set-Clipboard -MockWith { param($Value) $script:mockClipboard = $Value }
                Set-ClipboardSafe "test123"
                $script:mockClipboard | Should -Be "test123"
            }

            It "Ignore erreur Set-Clipboard sans throw" {
                Mock Set-Clipboard -MockWith { throw "Clipboard chou" }
                { Set-ClipboardSafe "hello" } | Should -Not -Throw
            }

            It "Ne retourne rien (pipeline clean)" {
                $result = Set-ClipboardSafe "abc"
                $result | Should -BeNullOrEmpty
            }

            It "Utilise pbcopy sur macOS" {
                Mock Get-Command -MockWith {
                    param($cmd)
                    if ($cmd -eq 'pbcopy') { return [PSCustomObject]@{Name='pbcopy'} }
                    return $null
                }
                { Set-ClipboardSafe "mac-test" } | Should -Not -Throw
            }
        }

        Context "Clear-ClipboardSafe" {
            It "Vide clipboard Windows" {
                $script:mockClipboard = "abc123"
                Mock Set-Clipboard -MockWith { param($Value) $script:mockClipboard = $Value }
                Clear-ClipboardSafe
                $script:mockClipboard | Should -BeNullOrEmpty
            }

            It "Ignore erreur Clear-Clipboard" {
                Mock Set-Clipboard -MockWith { throw "Clear chou" }
                { Clear-ClipboardSafe } | Should -Not -Throw
            }

            It "Ne pollue pas pipeline" {
                $result = Clear-ClipboardSafe
                $result | Should -BeNullOrEmpty
            }

            It "Utilise xclip sur Linux" {
                Mock Get-Command -MockWith {
                    param($cmd)
                    if ($cmd -eq 'xclip') { return [PSCustomObject]@{Name='xclip'} }
                    return $null
                }
                { Clear-ClipboardSafe } | Should -Not -Throw
            }
        }

        Context "Cross-platform resilience" {

            It "Résiste sans aucun clipboard tool" {
                Mock Get-Command { return $null }
                { Set-ClipboardSafe "no-tools" } | Should -Not -Throw
                { Clear-ClipboardSafe } | Should -Not -Throw
            }

            It 'Verbose logging si pas de tools' {
                Mock Get-Command { return $null }
                $VerbosePreference = 'Continue'
                
                # Sur Windows : mock Set-Clipboard pour forcer catch verbose
                if ($IsWindows) {
                    Mock Set-Clipboard { throw "Test clipboard fail" }
                }
                
                $verboseOutput = Set-ClipboardSafe 'test' 4>&1
                $verboseOutput | Should -Match 'clipboard|tool|failure'
            }
        }
      
        Context "Edge cases" {

            It "Gère chaîne vide" {
                Mock Set-Clipboard -MockWith { param($Value) $script:mockClipboard = $Value }
                { Set-ClipboardSafe "" } | Should -Not -Throw
                $script:mockClipboard | Should -Be ""
            }

            It "Gère chaînes très longues (1MB)" {
                $longText = 'A' * 2000000
                Mock Set-Clipboard { }
                { Set-ClipboardSafe $longText } | Should -Not -Throw
            }
        }
    }
}